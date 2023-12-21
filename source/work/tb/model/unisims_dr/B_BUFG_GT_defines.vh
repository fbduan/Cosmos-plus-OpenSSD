// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Fri Apr 12 15:36:51 2013
//    Bundle:       BUFG_GT
//    Architecture: olympus
//    Snapshot Dir: /tmp/a3bChY6MpN
// Environment Variables:
//    XILENV="/proj/xbuilds/env.ids_14.2_latest"
//    MYXILENV=""
//

`ifdef B_BUFG_GT_DEFINES_VH
`else
`define B_BUFG_GT_DEFINES_VH

// Look-up table parameters
//

`define BUFG_GT_ADDR_N  1
`define BUFG_GT_ADDR_SZ 32
`define BUFG_GT_DATA_SZ 1

// Attribute addresses
//

`define BUFG_GT__IS_CLR_INVERTED   	32'h0000	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFG_GT__IS_CLR_INVERTED_SZ	1

`endif  // B_BUFG_GT_DEFINES_VH
