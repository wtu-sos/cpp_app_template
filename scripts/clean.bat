@echo off
chcp 65001 >nul
echo Cleaning project...

if exist "build" (
    echo Removing build directory...
    rmdir /s /q "build"
    echo [✓] Build directory removed
) else (
    echo [i] No build directory found
)

REM 清理 vcpkg 缓存文件（但保留 vcpkg 工具本身）
if exist "tools\vcpkg\.vcpkg-root" (
    if exist "tools\vcpkg\buildtrees" (
        echo Removing vcpkg build cache...
        rmdir /s /q "tools\vcpkg\buildtrees"
    )
    if exist "tools\vcpkg\downloads" (
        echo Removing vcpkg download cache...
        rmdir /s /q "tools\vcpkg\downloads"
    )
    if exist "tools\vcpkg\packages" (
        echo Removing vcpkg package cache...
        rmdir /s /q "tools\vcpkg\packages"
    )
    echo [✓] vcpkg cache cleared
)

REM 清理 CMake 缓存文件
if exist "CMakeCache.txt" (
    echo Removing CMake cache...
    del /q "CMakeCache.txt"
)

if exist "cmake_install.cmake" (
    del /q "cmake_install.cmake"
)

echo.
echo [✓] Build cleanup completed!
echo [i] Tools (vcpkg/ninja) are preserved for next build
pause