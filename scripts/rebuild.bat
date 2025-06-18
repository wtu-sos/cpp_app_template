@echo off
setlocal EnableDelayedExpansion

echo 🧹 开始清理项目...

:: 删除构建目录
if exist "build" (
    echo 删除 build 目录...
    rmdir /S /Q "build"
)

:: 删除 CMake 缓存文件
if exist "CMakeCache.txt" del "CMakeCache.txt"
if exist "cmake_install.cmake" del "cmake_install.cmake"

echo ✅ 清理完成！

echo 🔨 开始重新构建...

:: 配置项目
echo 配置项目...
cmake --preset=default
if !ERRORLEVEL! neq 0 (
    echo [ERROR] CMake 配置失败
    pause
    exit /b 1
)

:: 构建项目
echo 构建项目...
cmake --build --preset=default
if !ERRORLEVEL! neq 0 (
    echo [ERROR] 构建失败
    pause
    exit /b 1
)

echo ✅ 构建成功！

:: 运行程序
echo 🚀 运行程序...
echo.
"build\Release\MyApp.exe"

echo.
echo ✨ 完成！
pause