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

`ifdef B_DSP_ALU_DEFINES_VH
`else
`define B_DSP_ALU_DEFINES_VH

// Look-up table parameters
//

`define DSP_ALU_ADDR_N  16
`define DSP_ALU_ADDR_SZ 32
`define DSP_ALU_DATA_SZ 88

// Attribute addresses
//

`define DSP_ALU__ALUMODEREG   	32'h0000	// Type=DECIMAL; Values=1,0
`define DSP_ALU__ALUMODEREG_SZ	32

`define DSP_ALU__CARRYINREG   	32'h0001	// Type=DECIMAL; Values=1,0
`define DSP_ALU__CARRYINREG_SZ	32

`define DSP_ALU__CARRYINSELREG   	32'h0002	// Type=DECIMAL; Values=1,0
`define DSP_ALU__CARRYINSELREG_SZ	32

`define DSP_ALU__IS_ALUMODE_INVERTED   	32'h0003	// Type=BINARY; Min=4'b0000, Max=4'b1111
`define DSP_ALU__IS_ALUMODE_INVERTED_SZ	4

`define DSP_ALU__IS_CARRYIN_INVERTED   	32'h0004	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_ALU__IS_CARRYIN_INVERTED_SZ	1

`define DSP_ALU__IS_CLK_INVERTED   	32'h0005	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_ALU__IS_CLK_INVERTED_SZ	1

`define DSP_ALU__IS_OPMODE_INVERTED   	32'h0006	// Type=BINARY; Min=9'b000000000, Max=9'b111111111
`define DSP_ALU__IS_OPMODE_INVERTED_SZ	9

`define DSP_ALU__IS_RSTALLCARRYIN_INVERTED   	32'h0007	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_ALU__IS_RSTALLCARRYIN_INVERTED_SZ	1

`define DSP_ALU__IS_RSTALUMODE_INVERTED   	32'h0008	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_ALU__IS_RSTALUMODE_INVERTED_SZ	1

`define DSP_ALU__IS_RSTCTRL_INVERTED   	32'h0009	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_ALU__IS_RSTCTRL_INVERTED_SZ	1

`define DSP_ALU__MREG   	32'h000a	// Type=DECIMAL; Values=1,0
`define DSP_ALU__MREG_SZ	32

`define DSP_ALU__OPMODEREG   	32'h000b	// Type=DECIMAL; Values=1,0
`define DSP_ALU__OPMODEREG_SZ	32

`define DSP_ALU__RND   	32'h000c	// Type=HEX; Min=48'h000000000000, Max=48'hffffffffffff
`define DSP_ALU__RND_SZ	48

`define DSP_ALU__USE_SIMD   	32'h000d	// Type=STRING; Values=ONE48,FOUR12,TWO24
`define DSP_ALU__USE_SIMD_SZ	48

`define DSP_ALU__USE_WIDEXOR   	32'h000e	// Type=BOOLSTRING; Values=FALSE,TRUE
`define DSP_ALU__USE_WIDEXOR_SZ	40

`define DSP_ALU__XORSIMD   	32'h000f	// Type=STRING; Values=XOR24_48_96,XOR12
`define DSP_ALU__XORSIMD_SZ	88

`endif  // B_DSP_ALU_DEFINES_VH
