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

`ifdef B_DSP_C_DATA_DEFINES_VH
`else
`define B_DSP_C_DATA_DEFINES_VH

// Look-up table parameters
//

`define DSP_C_DATA_ADDR_N  3
`define DSP_C_DATA_ADDR_SZ 32
`define DSP_C_DATA_DATA_SZ 32

// Attribute addresses
//

`define DSP_C_DATA__CREG   	32'h0000	// Type=DECIMAL; Values=1,0
`define DSP_C_DATA__CREG_SZ	32

`define DSP_C_DATA__IS_CLK_INVERTED   	32'h0001	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_C_DATA__IS_CLK_INVERTED_SZ	1

`define DSP_C_DATA__IS_RSTC_INVERTED   	32'h0002	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_C_DATA__IS_RSTC_INVERTED_SZ	1

`endif  // B_DSP_C_DATA_DEFINES_VH