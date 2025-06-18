@echo off
chcp 65001 >nul
echo Cleaning all project files and tools...

if exist "build" (
    echo Removing build directory...
    rmdir /s /q "build"
)

if exist "tools\vcpkg" (
    echo Removing vcpkg...
    rmdir /s /q "tools\vcpkg"
)

if exist "tools\ninja" (
    echo Removing ninja...
    rmdir /s /q "tools\ninja"
)

echo Complete cleanup finished!
pause