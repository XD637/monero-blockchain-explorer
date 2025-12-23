# Oxyra Blockchain Explorer

This is a blockchain explorer configured for the Oxyra blockchain network.

## Daemon Configuration

- **Daemon Address**: 103.214.169.20:17081
- **Network**: Oxyra Mainnet

## Prerequisites

Before building, you need:

1. **CMake** (version 3.5.2 or higher)
2. **C++ Compiler** (MinGW on Windows, GCC/Clang on Linux)
3. **Boost Libraries** (system, filesystem, thread, date_time, chrono, regex, serialization, program_options)
4. **Oxyra Source Code** - Built and compiled

## Build Instructions

### Windows

1. **Edit the build script** with your Oxyra paths:
   ```powershell
   notepad build-oxyra.ps1
   ```
   
   Update these variables:
   - `$OXYRA_SOURCE_DIR` - Path to your Oxyra source directory (e.g., `D:\oxyra`)
   - `$OXYRA_BUILD_DIR` - Path to your Oxyra build directory (e.g., `D:\oxyra\build\release`)

2. **Run the build script**:
   ```powershell
   .\build-oxyra.ps1
   ```

### Linux/Mac

1. **Create build directory**:
   ```bash
   mkdir -p build && cd build
   ```

2. **Run CMake** (adjust paths to your Oxyra installation):
   ```bash
   cmake .. \
     -DMONERO_DIR=/path/to/oxyra \
     -DMONERO_SOURCE_DIR=/path/to/oxyra \
     -DMONERO_BUILD_DIR=/path/to/oxyra/build/release
   ```

3. **Build**:
   ```bash
   make -j$(nproc)
   ```

## Running the Explorer

### Using the Run Script (Windows)

```powershell
.\run-oxyra-explorer.ps1
```

The explorer will start at: **http://localhost:8081**

### Manual Execution

```bash
./build/xmrblocks --daemon-url 103.214.169.20:17081 --port 8081 --enable-json-api
```

## Command Line Options

- `--daemon-url` - Oxyra daemon address (default: 103.214.169.20:17081)
- `--port` - Explorer web interface port (default: 8081)
- `--bindaddr` - Bind address (default: 0.0.0.0)
- `--enable-json-api` - Enable JSON REST API
- `--enable-pusher` - Enable transaction pusher
- `--enable-autorefresh-option` - Enable auto-refresh on index page
- `--enable-key-image-checker` - Enable key image checker
- `--enable-output-key-checker` - Enable output key checker
- `--enable-mixin-details` - Enable mixin details

## Features

- No JavaScript required
- No cookies or tracking
- Open source
- Shows transaction details
- Shows block information
- Transaction pusher
- JSON API
- Mempool monitoring
- Ring signature analysis

## Troubleshooting

### Build Errors

1. **CMake can't find Oxyra libraries**:
   - Verify `OXYRA_SOURCE_DIR` and `OXYRA_BUILD_DIR` paths are correct
   - Make sure Oxyra is built successfully

2. **Missing Boost libraries**:
   - Install Boost development packages
   - Windows: Download from https://www.boost.org/
   - Linux: `sudo apt-get install libboost-all-dev`

3. **Compiler errors**:
   - Make sure you have C++17 compatible compiler
   - Windows: Install MinGW or Visual Studio
   - Linux: Install g++ 7 or higher

### Runtime Errors

1. **Can't connect to daemon**:
   - Verify daemon at 103.214.169.20:17081 is accessible
   - Check firewall settings
   - Try: `telnet 103.214.169.20 17081`

2. **Port already in use**:
   - Change the port: `--port 8082`

## Support

For issues specific to Oxyra blockchain, contact the Oxyra development team.
For issues with the explorer codebase, check the original project: https://github.com/moneroexamples/onion-monero-blockchain-explorer
