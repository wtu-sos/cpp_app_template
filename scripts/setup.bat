@echo off
chcp 65001 >nul
setlocal EnableDelayedExpansion

echo ==========================================
echo   Self-contained CMake+Ninja+vcpkg Project Setup
echo ==========================================

echo.
echo Initializing project...

REM Check required tools
echo Checking required tools...

where cmake >nul 2>nul
if !errorlevel! neq 0 (
    echo [ERROR] CMake not found, please install CMake first
    pause
    exit /b 1
)

where git >nul 2>nul  
if !errorlevel! neq 0 (
    echo [ERROR] Git not found, please install Git first
    pause
    exit /b 1
)

echo [✓] CMake installed
echo [✓] Git installed

REM Set directories
set "PROJECT_ROOT=%~dp0.."
set "TOOLS_DIR=%PROJECT_ROOT%\tools"
set "VCPKG_DIR=%TOOLS_DIR%\vcpkg"
set "NINJA_DIR=%TOOLS_DIR%\ninja"

echo.
echo Creating tools directory...
if not exist "%TOOLS_DIR%" mkdir "%TOOLS_DIR%"
if not exist "%NINJA_DIR%" mkdir "%NINJA_DIR%"

REM Download vcpkg
echo.
if not exist "%VCPKG_DIR%\vcpkg.exe" (
    echo Downloading vcpkg...
    git clone https://github.com/Microsoft/vcpkg.git "%VCPKG_DIR%"
    if !errorlevel! neq 0 (
        echo [ERROR] Failed to download vcpkg
        pause
        exit /b 1
    )
    
    echo Building vcpkg...
    call "%VCPKG_DIR%\bootstrap-vcpkg.bat"
    if !errorlevel! neq 0 (
        echo [ERROR] Failed to build vcpkg
        pause  
        exit /b 1
    )
    echo [✓] vcpkg installation completed
) else (
    echo [✓] vcpkg already exists
)

REM Download ninja
echo.
if not exist "%NINJA_DIR%\ninja.exe" (
    echo Downloading ninja...
    powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/ninja-build/ninja/releases/latest/download/ninja-win.zip' -OutFile '%NINJA_DIR%\ninja-win.zip'}"
    if !errorlevel! neq 0 (
        echo [ERROR] Failed to download ninja
        pause
        exit /b 1
    )
    
    echo Extracting ninja...
    powershell -Command "& {Expand-Archive -Path '%NINJA_DIR%\ninja-win.zip' -DestinationPath '%NINJA_DIR%' -Force}"
    if !errorlevel! neq 0 (
        echo [ERROR] Failed to extract ninja
        pause
        exit /b 1
    )
    
    del "%NINJA_DIR%\ninja-win.zip"
    echo [✓] ninja installation completed
) else (
    echo [✓] ninja already exists
)

echo.
echo ==========================================
echo           Setup Complete!
echo ==========================================
echo.
echo You can now build the project with these commands:
echo.
echo   1. Configure project:
echo      cmake --preset=default
echo.  
echo   2. Build project:
echo      cmake --build --preset=default
echo.
echo   3. Run program:
echo      .\build\Release\MyApp.exe
echo.
echo ==========================================

pause