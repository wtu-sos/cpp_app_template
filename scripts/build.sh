#!/bin/bash

echo "=========================================="
echo "  Building Self-contained CMake Project"
echo "=========================================="

echo
echo "Detecting platform and setting up environment..."

# Detect platform
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    PLATFORM="Linux"
    PRESET="default-linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macOS"
    PRESET="default-linux"
else
    echo "[ERROR] Unsupported platform: $OSTYPE"
    exit 1
fi

echo "[✓] Platform detected: $PLATFORM"

# Check required tools
if ! command -v cmake &> /dev/null; then
    echo "[ERROR] CMake not found, please install CMake first"
    exit 1
fi

if ! command -v g++ &> /dev/null && ! command -v clang++ &> /dev/null; then
    echo "[ERROR] No C++ compiler found, please install g++ or clang++"
    exit 1
fi

# Detect compiler
if command -v clang++ &> /dev/null; then
    COMPILER="clang++"
    export CC=clang
    export CXX=clang++
elif command -v g++ &> /dev/null; then
    COMPILER="g++"
    export CC=gcc
    export CXX=g++
fi

echo "[✓] Using compiler: $COMPILER"

# Check if tools are available
if [ ! -f "tools/vcpkg/vcpkg" ]; then
    echo "[INFO] vcpkg not found, running setup..."
    ./scripts/setup.sh
fi

if [ ! -f "tools/ninja/ninja" ]; then
    echo "[INFO] ninja not found, running setup..."
    ./scripts/setup.sh
fi

echo
echo "Configuring project..."
cmake --preset=$PRESET
if [ $? -ne 0 ]; then
    echo "[ERROR] CMake configuration failed"
    exit 1
fi

echo
echo "Building project..."
cmake --build --preset=$PRESET
if [ $? -ne 0 ]; then
    echo "[ERROR] Build failed"
    exit 1
fi

echo
echo "=========================================="
echo "           Build Complete!"
echo "=========================================="
echo
echo "Running the program:"
echo
./build/Release/MyApp

echo
echo "Build successful on $PLATFORM!"