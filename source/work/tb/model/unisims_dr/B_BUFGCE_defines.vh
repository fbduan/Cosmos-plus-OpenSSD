// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Fri Apr 12 15:36:46 2013
//    Bundle:       BUFCE
//    Architecture: olympus
//    Snapshot Dir: /tmp/htHiJxUWIJ
// Environment Variables:
//    XILENV="/proj/xbuilds/env.ids_14.2_latest"
//    MYXILENV=""
//

`ifdef B_BUFGCE_DEFINES_VH
`else
`define B_BUFGCE_DEFINES_VH

// Look-up table parameters
//

`define BUFGCE_ADDR_N  3
`define BUFGCE_ADDR_SZ 32
`define BUFGCE_DATA_SZ 40

// Attribute addresses
//

`define BUFGCE__CE_TYPE   	32'h0000	// Type=STRING; Values=SYNC,ASYNC
`define BUFGCE__CE_TYPE_SZ	40

`define BUFGCE__IS_CE_INVERTED   	32'h0001	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCE__IS_CE_INVERTED_SZ	1

`define BUFGCE__IS_I_INVERTED   	32'h0002	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCE__IS_I_INVERTED_SZ	1

`endif  // B_BUFGCE_DEFINES_VH
