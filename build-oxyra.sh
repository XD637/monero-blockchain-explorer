#!/bin/bash
# Build script for Oxyra Blockchain Explorer (Linux)

echo "=================================="
echo "Oxyra Blockchain Explorer Builder"
echo "=================================="
echo ""

# Configuration - UPDATE THESE PATHS
OXYRA_SOURCE_DIR="/home/oxyrax"  # Oxyra source directory on server
OXYRA_BUILD_DIR="/home/oxyrax/build"  # Oxyra build directory on server
BUILD_DIR="build"
DAEMON_ADDRESS="103.214.169.20:17081"

echo "Configuration:"
echo "  Oxyra Source: $OXYRA_SOURCE_DIR"
echo "  Oxyra Build: $OXYRA_BUILD_DIR"
echo "  Daemon Address: $DAEMON_ADDRESS"
echo ""

# Check if Oxyra source directory exists
if [ ! -d "$OXYRA_SOURCE_DIR" ]; then
    echo "ERROR: Oxyra source directory not found at: $OXYRA_SOURCE_DIR"
    echo "Please edit this script and set the correct OXYRA_SOURCE_DIR path"
    echo ""
    echo "Searching for possible Oxyra directories..."
    find ~ -maxdepth 3 -type d -name "*oxyra*" 2>/dev/null || true
    find /mnt -maxdepth 3 -type d -name "*oxyra*" 2>/dev/null || true
    exit 1
fi

# Check if Oxyra build directory exists
if [ ! -d "$OXYRA_BUILD_DIR" ]; then
    echo "WARNING: Oxyra build directory not found at: $OXYRA_BUILD_DIR"
    echo "Common build locations:"
    echo "  - $OXYRA_SOURCE_DIR/build/release"
    echo "  - $OXYRA_SOURCE_DIR/build/Linux/master/release"
    echo ""
    echo "Please edit this script and set the correct OXYRA_BUILD_DIR path"
    exit 1
fi

echo "Creating build directory..."
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

echo "Running CMake configuration..."
echo ""

cmake .. \
    -DMONERO_DIR="$OXYRA_SOURCE_DIR" \
    -DMONERO_SOURCE_DIR="$OXYRA_SOURCE_DIR" \
    -DMONERO_BUILD_DIR="$OXYRA_BUILD_DIR" \
    -DCMAKE_BUILD_TYPE=Release

if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: CMake configuration failed!"
    echo ""
    echo "Common issues:"
    echo "  1. Verify Oxyra paths are correct"
    echo "  2. Make sure Boost libraries are installed: sudo apt-get install libboost-all-dev"
    echo "  3. Install other dependencies: sudo apt-get install build-essential libssl-dev pkg-config"
    echo ""
    cd ..
    exit 1
fi

echo ""
echo "Building the explorer (this may take a while)..."
echo ""

make -j$(nproc)

if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: Build failed!"
    cd ..
    exit 1
fi

cd ..

echo ""
echo "=================================="
echo "Build completed successfully!"
echo "=================================="
echo ""
echo "Executable location: $BUILD_DIR/xmrblocks"
echo ""
echo "To run the explorer:"
echo "  ./$BUILD_DIR/xmrblocks --daemon-url $DAEMON_ADDRESS"
echo ""
echo "The explorer will be available at: http://localhost:8081"
echo ""
