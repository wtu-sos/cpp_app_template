#!/bin/bash

echo "Cleaning all project files and tools..."

if [ -d "build" ]; then
    echo "Removing build directory..."
    rm -rf "build"
fi

if [ -d "tools/vcpkg" ]; then
    echo "Removing vcpkg..."
    rm -rf "tools/vcpkg"
fi

if [ -d "tools/ninja" ]; then
    echo "Removing ninja..."
    rm -rf "tools/ninja"
fi

echo "Complete cleanup finished!"