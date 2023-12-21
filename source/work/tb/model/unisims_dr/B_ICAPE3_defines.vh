// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Mon Oct 29 15:27:24 2012
//    Bundle:       CFG
//    Architecture: olympus
//    Snapshot Dir: /tmp/UqIKYm52NI
// Environment Variables:
//    XILENV="/build/sjxfndry/HEAD/env"
//    MYXILENV=""
//

`ifdef ICAPE3_DEFINES_VH
`else
`define ICAPE3_DEFINES_VH

// Look-up table parameters
//

`define ICAPE3_ADDR_N  3
`define ICAPE3_ADDR_SZ 32
`define ICAPE3_DATA_SZ 24

// Attribute addresses
//

`define ICAPE3__DEVICE_ID   	32'h0000	// Type=HEX; Values=26'h3628093,26'h3627093
`define ICAPE3__DEVICE_ID_SZ	1

`define ICAPE3__ICAP_WIDTH   	32'h0001	// Type=STRING; Values=X32,X8,X16
`define ICAPE3__ICAP_WIDTH_SZ	24

`define ICAPE3__SIM_CFG_FILE_NAME   	32'h0002	// Type=STRING; Min=, Max=
`define ICAPE3__SIM_CFG_FILE_NAME_SZ	0

`endif  // ICAPE3_DEFINES_VH
