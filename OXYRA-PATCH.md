# Oxyra Source Code Patch

To make the blockchain explorer work with Oxyra, you need to add friend declarations to two Oxyra source files.

## Required Changes

### 1. Edit `/home/oxyrax/src/cryptonote_core/blockchain.h`

Find the line with the private constructor (around line 1260):
```cpp
  private:
    Blockchain(tx_memory_pool& tx_pool);
```

Add this line RIGHT BEFORE the `private:` section:
```cpp
    friend class xmreg::MicroCore;
  private:
    Blockchain(tx_memory_pool& tx_pool);
```

### 2. Edit `/home/oxyrax/src/cryptonote_core/tx_pool.h`

Find the line with the private constructor (around line 512):
```cpp
  private:
    tx_memory_pool(Blockchain& bchs);
```

Add this line RIGHT BEFORE the `private:` section:
```cpp
    friend class xmreg::MicroCore;
  private:
    tx_memory_pool(Blockchain& bchs);
```

## Apply the Changes

Run these commands on your server:

```bash
# Backup the original files
cp /home/oxyrax/src/cryptonote_core/blockchain.h /home/oxyrax/src/cryptonote_core/blockchain.h.backup
cp /home/oxyrax/src/cryptonote_core/tx_pool.h /home/oxyrax/src/cryptonote_core/tx_pool.h.backup

# Edit blockchain.h
sed -i '/^  private:$/i\    friend class xmreg::MicroCore;' /home/oxyrax/src/cryptonote_core/blockchain.h

# Edit tx_pool.h  
sed -i '/^  private:$/i\    friend class xmreg::MicroCore;' /home/oxyrax/src/cryptonote_core/tx_pool.h
```

Or apply manually using a text editor.

## Then Rebuild the Explorer

```bash
cd /home/monero-blockchain-explorer
./build-oxyra.sh
```

This is the cleanest solution - it allows the MicroCore class to access the private constructors without breaking standard library headers.
