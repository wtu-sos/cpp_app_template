#!/bin/bash

echo "=========================================="
echo "  Self-contained CMake+Ninja+vcpkg Setup"
echo "=========================================="

echo
echo "Initializing project..."

# Check required tools
echo "Checking required tools..."

if ! command -v cmake &> /dev/null; then
    echo "[ERROR] CMake not found, please install CMake first"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "[ERROR] Git not found, please install Git first"
    exit 1
fi

echo "[✓] CMake installed"
echo "[✓] Git installed"

# Set directories
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TOOLS_DIR="$PROJECT_ROOT/tools"
VCPKG_DIR="$TOOLS_DIR/vcpkg"
NINJA_DIR="$TOOLS_DIR/ninja"

echo
echo "Creating tools directory..."
mkdir -p "$TOOLS_DIR"
mkdir -p "$NINJA_DIR"

# Download vcpkg
echo
if [ ! -f "$VCPKG_DIR/vcpkg" ]; then
    echo "Downloading vcpkg..."
    git clone https://github.com/Microsoft/vcpkg.git "$VCPKG_DIR"
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to download vcpkg"
        exit 1
    fi
    
    echo "Building vcpkg..."
    cd "$VCPKG_DIR"
    ./bootstrap-vcpkg.sh
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to build vcpkg"
        exit 1
    fi
    cd "$PROJECT_ROOT"
    echo "[✓] vcpkg installation completed"
else
    echo "[✓] vcpkg already exists"
fi

# Download ninja
echo
if [ ! -f "$NINJA_DIR/ninja" ]; then
    echo "Downloading ninja..."
    
    # Detect OS
    if [[ "$OSTYPE" == "darwin"* ]]; then
        NINJA_URL="https://github.com/ninja-build/ninja/releases/latest/download/ninja-mac.zip"
        NINJA_ARCHIVE="$NINJA_DIR/ninja-mac.zip"
    else
        NINJA_URL="https://github.com/ninja-build/ninja/releases/latest/download/ninja-linux.zip"
        NINJA_ARCHIVE="$NINJA_DIR/ninja-linux.zip"
    fi
    
    curl -L -o "$NINJA_ARCHIVE" "$NINJA_URL"
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to download ninja"
        exit 1
    fi
    
    echo "Extracting ninja..."
    cd "$NINJA_DIR"
    unzip -o "$NINJA_ARCHIVE"
    if [ $? -ne 0 ]; then
        echo "[ERROR] Failed to extract ninja"
        exit 1
    fi
    
    rm "$NINJA_ARCHIVE"
    chmod +x ninja
    cd "$PROJECT_ROOT"
    echo "[✓] ninja installation completed"
else
    echo "[✓] ninja already exists"
fi

echo
echo "=========================================="
echo "           Setup Complete!"
echo "=========================================="
echo
echo "You can now build the project with these commands:"
echo
echo "  1. Configure project:"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "     cmake --preset=default-linux"
else
    echo "     cmake --preset=default-linux"
fi
echo
echo "  2. Build project:"
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "     cmake --build --preset=default-linux"
else
    echo "     cmake --build --preset=default-linux"
fi
echo
echo "  3. Run program:"
echo "     ./build/Release/MyApp"
echo
echo "=========================================="