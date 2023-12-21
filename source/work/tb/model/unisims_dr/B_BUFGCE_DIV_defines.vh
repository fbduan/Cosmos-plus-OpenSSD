// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Fri Apr 12 15:36:44 2013
//    Bundle:       BUFGCE_DIV
//    Architecture: olympus
//    Snapshot Dir: /tmp/sqBrZndhue
// Environment Variables:
//    XILENV="/proj/xbuilds/env.ids_14.2_latest"
//    MYXILENV=""
//

`ifdef B_BUFGCE_DIV_DEFINES_VH
`else
`define B_BUFGCE_DIV_DEFINES_VH

// Look-up table parameters
//

`define BUFGCE_DIV_ADDR_N  4
`define BUFGCE_DIV_ADDR_SZ 32
`define BUFGCE_DIV_DATA_SZ 32

// Attribute addresses
//

`define BUFGCE_DIV__BUFGCE_DIVIDE   	32'h0000	// Type=DECIMAL; Values=1,2,3,4,5,6,7,8
`define BUFGCE_DIV__BUFGCE_DIVIDE_SZ	32

`define BUFGCE_DIV__IS_CE_INVERTED   	32'h0001	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCE_DIV__IS_CE_INVERTED_SZ	1

`define BUFGCE_DIV__IS_CLR_INVERTED   	32'h0002	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCE_DIV__IS_CLR_INVERTED_SZ	1

`define BUFGCE_DIV__IS_I_INVERTED   	32'h0003	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCE_DIV__IS_I_INVERTED_SZ	1

`endif  // B_BUFGCE_DIV_DEFINES_VH
