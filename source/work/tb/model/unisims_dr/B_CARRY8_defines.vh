// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Tue May 28 08:53:39 2013
//    Bundle:       CLB
//    Architecture: olympus
//    Snapshot Dir: /tmp/dFzPtHJJy8
// Environment Variables:
//    XILENV="/build/xfndry/P.last/env"
//    MYXILENV=""
//

`ifdef B_CARRY8_DEFINES_VH
`else
`define B_CARRY8_DEFINES_VH

// Look-up table parameters
//

`define CARRY8_ADDR_N  1
`define CARRY8_ADDR_SZ 32
`define CARRY8_DATA_SZ 80

// Attribute addresses
//

`define CARRY8__CARRY_TYPE   	32'h0000	// Type=STRING; Values=SINGLE_CY8,DUAL_CY4
`define CARRY8__CARRY_TYPE_SZ	80

`endif  // B_CARRY8_DEFINES_VH
