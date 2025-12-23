# Build script for Oxyra Blockchain Explorer
# This script configures and builds the Oxyra blockchain explorer

Write-Host "==================================" -ForegroundColor Green
Write-Host "Oxyra Blockchain Explorer Builder" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green
Write-Host ""

# Configuration
$OXYRA_SOURCE_DIR = "D:\oxyra"  # Change this to your Oxyra source directory
$OXYRA_BUILD_DIR = "$OXYRA_SOURCE_DIR\build\release"  # Change if your build is elsewhere
$BUILD_DIR = "build"
$DAEMON_ADDRESS = "103.214.169.20:17081"

Write-Host "Configuration:" -ForegroundColor Cyan
Write-Host "  Oxyra Source: $OXYRA_SOURCE_DIR" -ForegroundColor Yellow
Write-Host "  Oxyra Build: $OXYRA_BUILD_DIR" -ForegroundColor Yellow
Write-Host "  Daemon Address: $DAEMON_ADDRESS" -ForegroundColor Yellow
Write-Host ""

# Check if Oxyra source directory exists
if (-not (Test-Path $OXYRA_SOURCE_DIR)) {
    Write-Host "ERROR: Oxyra source directory not found at: $OXYRA_SOURCE_DIR" -ForegroundColor Red
    Write-Host "Please edit this script and set the correct OXYRA_SOURCE_DIR path" -ForegroundColor Red
    Write-Host ""
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

# Check if Oxyra build directory exists
if (-not (Test-Path $OXYRA_BUILD_DIR)) {
    Write-Host "WARNING: Oxyra build directory not found at: $OXYRA_BUILD_DIR" -ForegroundColor Yellow
    Write-Host "Common build locations:" -ForegroundColor Yellow
    Write-Host "  - $OXYRA_SOURCE_DIR\build\release" -ForegroundColor Yellow
    Write-Host "  - $OXYRA_SOURCE_DIR\build\Windows\master\release" -ForegroundColor Yellow
    Write-Host "  - $OXYRA_SOURCE_DIR\build\Linux\master\release" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please edit this script and set the correct OXYRA_BUILD_DIR path" -ForegroundColor Red
    Write-Host ""
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "Creating build directory..." -ForegroundColor Cyan
if (-not (Test-Path $BUILD_DIR)) {
    New-Item -ItemType Directory -Path $BUILD_DIR | Out-Null
}
Set-Location $BUILD_DIR

Write-Host "Running CMake configuration..." -ForegroundColor Cyan
Write-Host ""

cmake .. `
    -DMONERO_DIR="$OXYRA_SOURCE_DIR" `
    -DMONERO_SOURCE_DIR="$OXYRA_SOURCE_DIR" `
    -DMONERO_BUILD_DIR="$OXYRA_BUILD_DIR" `
    -G "MinGW Makefiles"

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: CMake configuration failed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Common issues:" -ForegroundColor Yellow
    Write-Host "  1. Make sure CMake is installed and in PATH" -ForegroundColor Yellow
    Write-Host "  2. Verify Oxyra paths are correct" -ForegroundColor Yellow
    Write-Host "  3. Make sure MinGW or Visual Studio is installed" -ForegroundColor Yellow
    Write-Host ""
    Set-Location ..
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host ""
Write-Host "Building the explorer..." -ForegroundColor Cyan
Write-Host ""

cmake --build . --config Release

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Build failed!" -ForegroundColor Red
    Set-Location ..
    Write-Host ""
    Write-Host "Press any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Set-Location ..

Write-Host ""
Write-Host "==================================" -ForegroundColor Green
Write-Host "Build completed successfully!" -ForegroundColor Green
Write-Host "==================================" -ForegroundColor Green
Write-Host ""
Write-Host "Executable location: $BUILD_DIR\xmrblocks.exe" -ForegroundColor Cyan
Write-Host ""
Write-Host "To run the explorer:" -ForegroundColor Cyan
Write-Host "  $BUILD_DIR\xmrblocks.exe --daemon-url $DAEMON_ADDRESS" -ForegroundColor Yellow
Write-Host ""
Write-Host "The explorer will be available at: http://localhost:8081" -ForegroundColor Cyan
Write-Host ""
