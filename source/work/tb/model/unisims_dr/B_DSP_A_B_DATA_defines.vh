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

`ifdef B_DSP_A_B_DATA_DEFINES_VH
`else
`define B_DSP_A_B_DATA_DEFINES_VH

// Look-up table parameters
//

`define DSP_A_B_DATA_ADDR_N  9
`define DSP_A_B_DATA_ADDR_SZ 32
`define DSP_A_B_DATA_DATA_SZ 56

// Attribute addresses
//

`define DSP_A_B_DATA__ACASCREG   	32'h0000	// Type=DECIMAL; Values=1,0,2
`define DSP_A_B_DATA__ACASCREG_SZ	32

`define DSP_A_B_DATA__AREG   	32'h0001	// Type=DECIMAL; Values=1,0,2
`define DSP_A_B_DATA__AREG_SZ	32

`define DSP_A_B_DATA__A_INPUT   	32'h0002	// Type=STRING; Values=DIRECT,CASCADE
`define DSP_A_B_DATA__A_INPUT_SZ	56

`define DSP_A_B_DATA__BCASCREG   	32'h0003	// Type=DECIMAL; Values=1,0,2
`define DSP_A_B_DATA__BCASCREG_SZ	32

`define DSP_A_B_DATA__BREG   	32'h0004	// Type=DECIMAL; Values=1,0,2
`define DSP_A_B_DATA__BREG_SZ	32

`define DSP_A_B_DATA__B_INPUT   	32'h0005	// Type=STRING; Values=DIRECT,CASCADE
`define DSP_A_B_DATA__B_INPUT_SZ	56

`define DSP_A_B_DATA__IS_CLK_INVERTED   	32'h0006	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_A_B_DATA__IS_CLK_INVERTED_SZ	1

`define DSP_A_B_DATA__IS_RSTA_INVERTED   	32'h0007	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_A_B_DATA__IS_RSTA_INVERTED_SZ	1

`define DSP_A_B_DATA__IS_RSTB_INVERTED   	32'h0008	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_A_B_DATA__IS_RSTB_INVERTED_SZ	1

`endif  // B_DSP_A_B_DATA_DEFINES_VH
