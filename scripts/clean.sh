#!/bin/bash

echo "Cleaning build files..."

if [ -d "build" ]; then
    echo "Removing build directory..."
    rm -rf "build"
    echo "[✓] Build directory removed"
else
    echo "[i] No build directory found"
fi

# 清理 vcpkg 缓存文件（但保留 vcpkg 工具本身）
if [ -f "tools/vcpkg/.vcpkg-root" ]; then
    if [ -d "tools/vcpkg/buildtrees" ]; then
        echo "Removing vcpkg build cache..."
        rm -rf "tools/vcpkg/buildtrees"
    fi
    if [ -d "tools/vcpkg/downloads" ]; then
        echo "Removing vcpkg download cache..."
        rm -rf "tools/vcpkg/downloads"
    fi
    if [ -d "tools/vcpkg/packages" ]; then
        echo "Removing vcpkg package cache..."
        rm -rf "tools/vcpkg/packages"
    fi
    echo "[✓] vcpkg cache cleared"
fi

# 清理 CMake 缓存文件
if [ -f "CMakeCache.txt" ]; then
    echo "Removing CMake cache..."
    rm -f "CMakeCache.txt"
fi

if [ -f "cmake_install.cmake" ]; then
    rm -f "cmake_install.cmake"
fi

echo
echo "[✓] Build cleanup completed!"
echo "[i] Tools (vcpkg/ninja) are preserved for next build"