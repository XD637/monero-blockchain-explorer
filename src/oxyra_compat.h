// Oxyra compatibility patch
// This file adds friend declarations to allow MicroCore to access private constructors

#ifndef OXYRA_COMPAT_H
#define OXYRA_COMPAT_H

// Add this to the Oxyra source files if needed:
// In blockchain.h, add: friend class xmreg::MicroCore;
// In tx_pool.h, add: friend class xmreg::MicroCore;

// Alternatively, we can use a macro hack to bypass access control
// WARNING: This is a workaround and should be used carefully

#define private public
#define protected public

#include "monero_headers.h"

#undef private  
#undef protected

#endif // OXYRA_COMPAT_H
