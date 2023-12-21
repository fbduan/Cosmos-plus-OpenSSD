// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Wed Apr 17 17:24:09 2013
//    Bundle:       DSP48E2
//    Architecture: olympus
//    Snapshot Dir: /tmp/H238lm9sMS
// Environment Variables:
//    XILENV="/build/xfndry/HEAD/env"
//    MYXILENV=""
//

`ifdef B_DSP_MULTIPLIER_DEFINES_VH
`else
`define B_DSP_MULTIPLIER_DEFINES_VH

// Look-up table parameters
//

`define DSP_MULTIPLIER_ADDR_N  3
`define DSP_MULTIPLIER_ADDR_SZ 32
`define DSP_MULTIPLIER_DATA_SZ 64

// Attribute addresses
//

`define DSP_MULTIPLIER__AMULTSEL   	32'h0000	// Type=STRING; Values=A,AD
`define DSP_MULTIPLIER__AMULTSEL_SZ	16

`define DSP_MULTIPLIER__BMULTSEL   	32'h0001	// Type=STRING; Values=B,AD
`define DSP_MULTIPLIER__BMULTSEL_SZ	16

`define DSP_MULTIPLIER__USE_MULT   	32'h0002	// Type=STRING; Values=MULTIPLY,DYNAMIC,NONE
`define DSP_MULTIPLIER__USE_MULT_SZ	64

`endif  // B_DSP_MULTIPLIER_DEFINES_VH
