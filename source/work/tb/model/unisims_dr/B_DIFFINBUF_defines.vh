// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Wed Feb 13 14:45:11 2013
//    Bundle:       HRIO
//    Architecture: olympus
//    Snapshot Dir: /tmp/a1MdrmkDvi
// Environment Variables:
//    XILENV="/build/xfndry/HEAD/env"
//    MYXILENV=""
//

`ifdef B_DIFFINBUF_DEFINES_VH
`else
`define B_DIFFINBUF_DEFINES_VH

// Look-up table parameters
//

`define DIFFINBUF_ADDR_N  10
`define DIFFINBUF_ADDR_SZ 32
`define DIFFINBUF_DATA_SZ 192

// Attribute addresses
//

`define DIFFINBUF__CAPACITANCE   	32'h0000	// Type=STRING; Values=DONT_CARE,LOW,NORMAL
`define DIFFINBUF__CAPACITANCE_SZ	72

`define DIFFINBUF__DIFF_TERM   	32'h0001	// Type=BOOLSTRING; Values=FALSE,TRUE
`define DIFFINBUF__DIFF_TERM_SZ	40

`define DIFFINBUF__DQS_BIAS   	32'h0002	// Type=BOOLSTRING; Values=FALSE,TRUE
`define DIFFINBUF__DQS_BIAS_SZ	40

`define DIFFINBUF__IBUF_DELAY_VALUE   	32'h0003	// Type=STRING; Values=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
`define DIFFINBUF__IBUF_DELAY_VALUE_SZ	16

`define DIFFINBUF__IBUF_LOW_PWR   	32'h0004	// Type=BOOLSTRING; Values=TRUE,FALSE
`define DIFFINBUF__IBUF_LOW_PWR_SZ	40

`define DIFFINBUF__IFD_DELAY_VALUE   	32'h0005	// Type=STRING; Values=AUTO,0,1,2,3,4,5,6,7,8
`define DIFFINBUF__IFD_DELAY_VALUE_SZ	32

`define DIFFINBUF__IOB_TYPE   	32'h0006	// Type=STRING; Values=MASTER,SLAVE
`define DIFFINBUF__IOB_TYPE_SZ	48

`define DIFFINBUF__IO_TYPE   	32'h0007	// Type=STRING; Values=OFF_TYPE,BIDIR,INPUT,IPAD,OUTPUT,REFIO,SYSMON_AUX,VR,VREF,VRN,VRP
`define DIFFINBUF__IO_TYPE_SZ	80

`define DIFFINBUF__IPROGRAMMING   	32'h0008	// Type=BINARY; Min=9'b000000000, Max=9'b111111111
`define DIFFINBUF__IPROGRAMMING_SZ	9

`define DIFFINBUF__ISTANDARD   	32'h0009	// Type=STRING; Min=, Max=
`define DIFFINBUF__ISTANDARD_SZ	192

`endif  // B_DIFFINBUF_DEFINES_VH
