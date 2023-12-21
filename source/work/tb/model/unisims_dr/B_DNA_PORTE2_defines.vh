// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Tue May 28 08:53:33 2013
//    Bundle:       CFG
//    Architecture: olympus
//    Snapshot Dir: /tmp/iLhpSMVcfI
// Environment Variables:
//    XILENV="/build/xfndry/P.last/env"
//    MYXILENV=""
//

`ifdef B_DNA_PORTE2_DEFINES_VH
`else
`define B_DNA_PORTE2_DEFINES_VH

// Look-up table parameters
//

`define DNA_PORTE2_ADDR_N  1
`define DNA_PORTE2_ADDR_SZ 32
`define DNA_PORTE2_DATA_SZ 96

// Attribute addresses
//

`define DNA_PORTE2__SIM_DNA_VALUE   	32'h0000	// Type=HEX; Min=96'h000000000000000000000000, Max=96'hfffffffffffffffffffffffd
`define DNA_PORTE2__SIM_DNA_VALUE_SZ	96

`endif  // B_DNA_PORTE2_DEFINES_VH
