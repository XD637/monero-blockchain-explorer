#!/bin/bash
# Script to automatically patch Oxyra source for blockchain explorer compatibility

OXYRA_DIR="/home/oxyrax"
BLOCKCHAIN_H="$OXYRA_DIR/src/cryptonote_core/blockchain.h"
TX_POOL_H="$OXYRA_DIR/src/cryptonote_core/tx_pool.h"

echo "========================================"
echo "Oxyra Source Patcher for Explorer"
echo "========================================"
echo ""

# Check if files exist
if [ ! -f "$BLOCKCHAIN_H" ]; then
    echo "ERROR: blockchain.h not found at: $BLOCKCHAIN_H"
    echo "Please update OXYRA_DIR in this script"
    exit 1
fi

if [ ! -f "$TX_POOL_H" ]; then
    echo "ERROR: tx_pool.h not found at: $TX_POOL_H"
    echo "Please update OXYRA_DIR in this script"
    exit 1
fi

echo "Found Oxyra source files:"
echo "  - $BLOCKCHAIN_H"
echo "  - $TX_POOL_H"
echo ""

# Create backups
echo "Creating backups..."
cp "$BLOCKCHAIN_H" "$BLOCKCHAIN_H.backup.$(date +%Y%m%d_%H%M%S)"
cp "$TX_POOL_H" "$TX_POOL_H.backup.$(date +%Y%m%d_%H%M%S)"
echo "✓ Backups created"
echo ""

# Check if already patched
if grep -q "friend class xmreg::MicroCore" "$BLOCKCHAIN_H"; then
    echo "✓ blockchain.h is already patched"
else
    echo "Patching blockchain.h..."
    # Find the first occurrence of "  private:" and add friend declaration before it
    sed -i '0,/^  private:$/s//    friend class xmreg::MicroCore;\n  private:/' "$BLOCKCHAIN_H"
    if grep -q "friend class xmreg::MicroCore" "$BLOCKCHAIN_H"; then
        echo "✓ blockchain.h patched successfully"
    else
        echo "✗ Failed to patch blockchain.h - please apply manually"
    fi
fi
echo ""

if grep -q "friend class xmreg::MicroCore" "$TX_POOL_H"; then
    echo "✓ tx_pool.h is already patched"
else
    echo "Patching tx_pool.h..."
    sed -i '0,/^  private:$/s//    friend class xmreg::MicroCore;\n  private:/' "$TX_POOL_H"
    if grep -q "friend class xmreg::MicroCore" "$TX_POOL_H"; then
        echo "✓ tx_pool.h patched successfully"
    else
        echo "✗ Failed to patch tx_pool.h - please apply manually"
    fi
fi

echo ""
echo "========================================"
echo "Patching complete!"
echo "========================================"
echo ""
echo "You can now build the explorer:"
echo "  ./build-oxyra.sh"
echo ""
