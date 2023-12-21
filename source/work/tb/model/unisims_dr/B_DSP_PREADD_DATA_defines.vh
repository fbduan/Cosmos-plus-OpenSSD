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

`ifdef B_DSP_PREADD_DATA_DEFINES_VH
`else
`define B_DSP_PREADD_DATA_DEFINES_VH

// Look-up table parameters
//

`define DSP_PREADD_DATA_ADDR_N  11
`define DSP_PREADD_DATA_ADDR_SZ 32
`define DSP_PREADD_DATA_DATA_SZ 64

// Attribute addresses
//

`define DSP_PREADD_DATA__ADREG   	32'h0000	// Type=DECIMAL; Values=1,0
`define DSP_PREADD_DATA__ADREG_SZ	32

`define DSP_PREADD_DATA__AMULTSEL   	32'h0001	// Type=STRING; Values=A,AD
`define DSP_PREADD_DATA__AMULTSEL_SZ	16

`define DSP_PREADD_DATA__BMULTSEL   	32'h0002	// Type=STRING; Values=B,AD
`define DSP_PREADD_DATA__BMULTSEL_SZ	16

`define DSP_PREADD_DATA__DREG   	32'h0003	// Type=DECIMAL; Values=1,0
`define DSP_PREADD_DATA__DREG_SZ	32

`define DSP_PREADD_DATA__INMODEREG   	32'h0004	// Type=DECIMAL; Values=1,0
`define DSP_PREADD_DATA__INMODEREG_SZ	32

`define DSP_PREADD_DATA__IS_CLK_INVERTED   	32'h0005	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_PREADD_DATA__IS_CLK_INVERTED_SZ	1

`define DSP_PREADD_DATA__IS_INMODE_INVERTED   	32'h0006	// Type=BINARY; Min=5'b00000, Max=5'b11111
`define DSP_PREADD_DATA__IS_INMODE_INVERTED_SZ	5

`define DSP_PREADD_DATA__IS_RSTD_INVERTED   	32'h0007	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_PREADD_DATA__IS_RSTD_INVERTED_SZ	1

`define DSP_PREADD_DATA__IS_RSTINMODE_INVERTED   	32'h0008	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_PREADD_DATA__IS_RSTINMODE_INVERTED_SZ	1

`define DSP_PREADD_DATA__PREADDINSEL   	32'h0009	// Type=STRING; Values=A,B
`define DSP_PREADD_DATA__PREADDINSEL_SZ	8

`define DSP_PREADD_DATA__USE_MULT   	32'h000a	// Type=STRING; Values=MULTIPLY,DYNAMIC,NONE
`define DSP_PREADD_DATA__USE_MULT_SZ	64

`endif  // B_DSP_PREADD_DATA_DEFINES_VH
