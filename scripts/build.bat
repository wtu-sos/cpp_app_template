@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo ==========================================
echo   Building Self-contained CMake Project
echo ==========================================

echo.
echo Setting up Visual Studio environment...

REM Try to find and setup Visual Studio environment
set "VS_FOUND=0"

REM Check for VS 2022
if exist "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" (
    call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
    set "VS_FOUND=1"
) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat" (
    call "C:\Program Files\Microsoft Visual Studio\2022\Professional\VC\Auxiliary\Build\vcvars64.bat"
    set "VS_FOUND=1"
) else if exist "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat" (
    call "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
    set "VS_FOUND=1"
)

REM Check for VS 2019 if 2022 not found
if !VS_FOUND! equ 0 (
    if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"
        set "VS_FOUND=1"
    ) else if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\VC\Auxiliary\Build\vcvars64.bat"
        set "VS_FOUND=1"
    ) else if exist "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat" (
        call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvars64.bat"
        set "VS_FOUND=1"
    )
)

if !VS_FOUND! equ 0 (
    echo [ERROR] Visual Studio not found!
    echo Please install Visual Studio 2019/2022 with C++ development tools.
    pause
    exit /b 1
)

echo [✓] Visual Studio environment loaded

echo.
echo Configuring project...
cmake --preset=default
if !errorlevel! neq 0 (
    echo [ERROR] CMake configuration failed
    pause
    exit /b 1
)

echo.
echo Building project...
cmake --build --preset=default
if !errorlevel! neq 0 (
    echo [ERROR] Build failed
    pause
    exit /b 1
)

echo.
echo ==========================================
echo           Build Complete!
echo ==========================================
echo.
echo Running the program:
echo.
.\build\Release\MyApp.exe

pause