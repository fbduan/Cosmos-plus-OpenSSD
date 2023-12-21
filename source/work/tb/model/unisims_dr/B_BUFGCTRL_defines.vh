// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Tue May 28 08:53:30 2013
//    Bundle:       BUFGCTRL
//    Architecture: olympus
//    Snapshot Dir: /tmp/GulKnz49J5
// Environment Variables:
//    XILENV="/build/xfndry/P.last/env"
//    MYXILENV=""
//

`ifdef B_BUFGCTRL_DEFINES_VH
`else
`define B_BUFGCTRL_DEFINES_VH

// Look-up table parameters
//

`define BUFGCTRL_ADDR_N  11
`define BUFGCTRL_ADDR_SZ 32
`define BUFGCTRL_DATA_SZ 40

// Attribute addresses
//

`define BUFGCTRL__INIT_OUT   	32'h0000	// Type=DECIMAL; Values=0,1
`define BUFGCTRL__INIT_OUT_SZ	32

`define BUFGCTRL__IS_CE0_INVERTED   	32'h0001	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCTRL__IS_CE0_INVERTED_SZ	1

`define BUFGCTRL__IS_CE1_INVERTED   	32'h0002	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCTRL__IS_CE1_INVERTED_SZ	1

`define BUFGCTRL__IS_I0_INVERTED   	32'h0003	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCTRL__IS_I0_INVERTED_SZ	1

`define BUFGCTRL__IS_I1_INVERTED   	32'h0004	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCTRL__IS_I1_INVERTED_SZ	1

`define BUFGCTRL__IS_IGNORE0_INVERTED   	32'h0005	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCTRL__IS_IGNORE0_INVERTED_SZ	1

`define BUFGCTRL__IS_IGNORE1_INVERTED   	32'h0006	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCTRL__IS_IGNORE1_INVERTED_SZ	1

`define BUFGCTRL__IS_S0_INVERTED   	32'h0007	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCTRL__IS_S0_INVERTED_SZ	1

`define BUFGCTRL__IS_S1_INVERTED   	32'h0008	// Type=BINARY; Min=1'b0, Max=1'b1
`define BUFGCTRL__IS_S1_INVERTED_SZ	1

`define BUFGCTRL__PRESELECT_I0   	32'h0009	// Type=BOOLSTRING; Values=FALSE,TRUE
`define BUFGCTRL__PRESELECT_I0_SZ	40

`define BUFGCTRL__PRESELECT_I1   	32'h000a	// Type=BOOLSTRING; Values=FALSE,TRUE
`define BUFGCTRL__PRESELECT_I1_SZ	40

`endif  // B_BUFGCTRL_DEFINES_VH
