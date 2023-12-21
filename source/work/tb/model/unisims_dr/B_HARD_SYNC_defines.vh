// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Tue May 28 09:07:23 2013
//    Bundle:       HARD_SYNC
//    Architecture: olympus
//    Snapshot Dir: /tmp/oGUlxi1xMP
// Environment Variables:
//    XILENV="/build/xfndry/P.last/env"
//    MYXILENV=""
//

`ifdef B_HARD_SYNC_DEFINES_VH
`else
`define B_HARD_SYNC_DEFINES_VH

// Look-up table parameters
//

`define HARD_SYNC_ADDR_N  3
`define HARD_SYNC_ADDR_SZ 32
`define HARD_SYNC_DATA_SZ 32

// Attribute addresses
//

`define HARD_SYNC__INIT   	32'h0000	// Type=BINARY; Values=1'b0,1'b1
`define HARD_SYNC__INIT_SZ	1

`define HARD_SYNC__IS_CLK_INVERTED   	32'h0001	// Type=BINARY; Min=1'b0, Max=1'b1
`define HARD_SYNC__IS_CLK_INVERTED_SZ	1

`define HARD_SYNC__LATENCY   	32'h0002	// Type=DECIMAL; Values=2,3
`define HARD_SYNC__LATENCY_SZ	32

`endif  // B_HARD_SYNC_DEFINES_VH
