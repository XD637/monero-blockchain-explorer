# Run script for Oxyra Blockchain Explorer
# This script starts the Oxyra blockchain explorer

Write-Host "==============================" -ForegroundColor Green
Write-Host "Oxyra Blockchain Explorer" -ForegroundColor Green
Write-Host "==============================" -ForegroundColor Green
Write-Host ""

# Configuration
$DAEMON_ADDRESS = "103.214.169.20:17081"
$EXPLORER_PORT = "8081"
$BIND_ADDRESS = "0.0.0.0"
$BLOCKCHAIN_PATH = ""  # Leave empty if not using local blockchain data

$EXECUTABLE = "build\xmrblocks.exe"

# Check if executable exists
if (-not (Test-Path $EXECUTABLE)) {
    Write-Host "ERROR: Explorer executable not found at: $EXECUTABLE" -ForegroundColor Red
    Write-Host "Please build the explorer first using build-oxyra.ps1" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "Starting Oxyra Blockchain Explorer..." -ForegroundColor Cyan
Write-Host ""
Write-Host "Configuration:" -ForegroundColor Cyan
Write-Host "  Daemon Address: $DAEMON_ADDRESS" -ForegroundColor Yellow
Write-Host "  Explorer Port: $EXPLORER_PORT" -ForegroundColor Yellow
Write-Host "  Bind Address: $BIND_ADDRESS" -ForegroundColor Yellow
Write-Host ""
Write-Host "Access the explorer at: http://localhost:$EXPLORER_PORT" -ForegroundColor Green
Write-Host ""
Write-Host "Press Ctrl+C to stop the explorer" -ForegroundColor Yellow
Write-Host ""
Write-Host "=============================" -ForegroundColor Cyan
Write-Host ""

# Build command line arguments
$args = @(
    "--daemon-url", $DAEMON_ADDRESS,
    "--port", $EXPLORER_PORT,
    "--bindaddr", $BIND_ADDRESS,
    "--enable-json-api",
    "--enable-pusher",
    "--enable-autorefresh-option",
    "--enable-key-image-checker",
    "--enable-output-key-checker",
    "--enable-mixin-details"
)

# Add blockchain path if specified
if ($BLOCKCHAIN_PATH -ne "") {
    if (Test-Path $BLOCKCHAIN_PATH) {
        $args += @("--bc-path", $BLOCKCHAIN_PATH)
        Write-Host "Using blockchain path: $BLOCKCHAIN_PATH" -ForegroundColor Cyan
    } else {
        Write-Host "WARNING: Blockchain path not found: $BLOCKCHAIN_PATH" -ForegroundColor Yellow
        Write-Host "Running without local blockchain data" -ForegroundColor Yellow
    }
}

# Run the explorer
& $EXECUTABLE $args
