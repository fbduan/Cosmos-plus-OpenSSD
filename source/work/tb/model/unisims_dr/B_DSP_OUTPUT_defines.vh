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

`ifdef B_DSP_OUTPUT_DEFINES_VH
`else
`define B_DSP_OUTPUT_DEFINES_VH

// Look-up table parameters
//

`define DSP_OUTPUT_ADDR_N  10
`define DSP_OUTPUT_ADDR_SZ 32
`define DSP_OUTPUT_DATA_SZ 120

// Attribute addresses
//

`define DSP_OUTPUT__AUTORESET_PATDET   	32'h0000	// Type=STRING; Values=NO_RESET,RESET_MATCH,RESET_NOT_MATCH
`define DSP_OUTPUT__AUTORESET_PATDET_SZ	120

`define DSP_OUTPUT__AUTORESET_PRIORITY   	32'h0001	// Type=STRING; Values=RESET,CEP
`define DSP_OUTPUT__AUTORESET_PRIORITY_SZ	40

`define DSP_OUTPUT__IS_CLK_INVERTED   	32'h0002	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_OUTPUT__IS_CLK_INVERTED_SZ	1

`define DSP_OUTPUT__IS_RSTP_INVERTED   	32'h0003	// Type=BINARY; Min=1'b0, Max=1'b1
`define DSP_OUTPUT__IS_RSTP_INVERTED_SZ	1

`define DSP_OUTPUT__MASK   	32'h0004	// Type=HEX; Min=48'h000000000000, Max=48'hffffffffffff
`define DSP_OUTPUT__MASK_SZ	48

`define DSP_OUTPUT__PATTERN   	32'h0005	// Type=HEX; Min=48'h000000000000, Max=48'hffffffffffff
`define DSP_OUTPUT__PATTERN_SZ	48

`define DSP_OUTPUT__PREG   	32'h0006	// Type=DECIMAL; Values=1,0
`define DSP_OUTPUT__PREG_SZ	32

`define DSP_OUTPUT__SEL_MASK   	32'h0007	// Type=STRING; Values=MASK,C,ROUNDING_MODE1,ROUNDING_MODE2
`define DSP_OUTPUT__SEL_MASK_SZ	112

`define DSP_OUTPUT__SEL_PATTERN   	32'h0008	// Type=STRING; Values=PATTERN,C
`define DSP_OUTPUT__SEL_PATTERN_SZ	56

`define DSP_OUTPUT__USE_PATTERN_DETECT   	32'h0009	// Type=STRING; Values=NO_PATDET,PATDET
`define DSP_OUTPUT__USE_PATTERN_DETECT_SZ	72

`endif  // B_DSP_OUTPUT_DEFINES_VH
