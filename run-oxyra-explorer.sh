#!/bin/bash
# Run script for Oxyra Blockchain Explorer (Linux)

echo "=============================="
echo "Oxyra Blockchain Explorer"
echo "=============================="
echo ""

# Configuration
DAEMON_ADDRESS="103.214.169.20:17081"
EXPLORER_PORT="8081"
BIND_ADDRESS="0.0.0.0"
BLOCKCHAIN_PATH=""  # Leave empty if not using local blockchain data

EXECUTABLE="build/xmrblocks"

# Check if executable exists
if [ ! -f "$EXECUTABLE" ]; then
    echo "ERROR: Explorer executable not found at: $EXECUTABLE"
    echo "Please build the explorer first using ./build-oxyra.sh"
    exit 1
fi

echo "Starting Oxyra Blockchain Explorer..."
echo ""
echo "Configuration:"
echo "  Daemon Address: $DAEMON_ADDRESS"
echo "  Explorer Port: $EXPLORER_PORT"
echo "  Bind Address: $BIND_ADDRESS"
echo ""
echo "Access the explorer at: http://localhost:$EXPLORER_PORT"
echo ""
echo "Press Ctrl+C to stop the explorer"
echo ""
echo "============================="
echo ""

# Build command line arguments
ARGS=(
    "--daemon-url" "$DAEMON_ADDRESS"
    "--port" "$EXPLORER_PORT"
    "--bindaddr" "$BIND_ADDRESS"
    "--enable-json-api"
    "--enable-pusher"
    "--enable-autorefresh-option"
    "--enable-key-image-checker"
    "--enable-output-key-checker"
    "--enable-mixin-details"
)

# Add blockchain path if specified
if [ -n "$BLOCKCHAIN_PATH" ] && [ -d "$BLOCKCHAIN_PATH" ]; then
    ARGS+=("--bc-path" "$BLOCKCHAIN_PATH")
    echo "Using blockchain path: $BLOCKCHAIN_PATH"
fi

# Run the explorer
"$EXECUTABLE" "${ARGS[@]}"
