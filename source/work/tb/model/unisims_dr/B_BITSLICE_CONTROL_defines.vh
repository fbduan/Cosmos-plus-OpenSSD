// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Tue Feb  4 11:52:00 2014
//    Bundle:       XIPHY
//    Architecture: olympus
//    Snapshot Dir: /tmp/5e_29D6xXh
// Environment Variables:
//    XILENV="/build/xfndry/HEAD/env"
//    MYXILENV=""
//

`ifdef B_BITSLICE_CONTROL_DEFINES_VH
`else
`define B_BITSLICE_CONTROL_DEFINES_VH

// Look-up table parameters
//

`define BITSLICE_CONTROL_ADDR_N  23
`define BITSLICE_CONTROL_ADDR_SZ 32
`define BITSLICE_CONTROL_DATA_SZ 64

// Attribute addresses
//

`define BITSLICE_CONTROL__CTRL_CLK   	32'h0000	// Type=STRING; Values=EXTERNAL,INTERNAL
`define BITSLICE_CONTROL__CTRL_CLK_SZ	64

`define BITSLICE_CONTROL__DIV_MODE   	32'h0001	// Type=STRING; Values=DIV2,DIV4
`define BITSLICE_CONTROL__DIV_MODE_SZ	32

`define BITSLICE_CONTROL__EN_CLK_TO_EXT_NORTH   	32'h0002	// Type=STRING; Values=DISABLE,ENABLE
`define BITSLICE_CONTROL__EN_CLK_TO_EXT_NORTH_SZ	56

`define BITSLICE_CONTROL__EN_CLK_TO_EXT_SOUTH   	32'h0003	// Type=STRING; Values=DISABLE,ENABLE
`define BITSLICE_CONTROL__EN_CLK_TO_EXT_SOUTH_SZ	56

`define BITSLICE_CONTROL__EN_DYN_ODLY_MODE   	32'h0004	// Type=BOOLSTRING; Values=FALSE,TRUE
`define BITSLICE_CONTROL__EN_DYN_ODLY_MODE_SZ	40

`define BITSLICE_CONTROL__EN_OTHER_NCLK   	32'h0005	// Type=BOOLSTRING; Values=FALSE,TRUE
`define BITSLICE_CONTROL__EN_OTHER_NCLK_SZ	40

`define BITSLICE_CONTROL__EN_OTHER_PCLK   	32'h0006	// Type=BOOLSTRING; Values=FALSE,TRUE
`define BITSLICE_CONTROL__EN_OTHER_PCLK_SZ	40

`define BITSLICE_CONTROL__IDLY_VT_TRACK   	32'h0007	// Type=BOOLSTRING; Values=TRUE,FALSE
`define BITSLICE_CONTROL__IDLY_VT_TRACK_SZ	40

`define BITSLICE_CONTROL__INV_RXCLK   	32'h0008	// Type=BOOLSTRING; Values=FALSE,TRUE
`define BITSLICE_CONTROL__INV_RXCLK_SZ	40

`define BITSLICE_CONTROL__ODLY_VT_TRACK   	32'h0009	// Type=BOOLSTRING; Values=TRUE,FALSE
`define BITSLICE_CONTROL__ODLY_VT_TRACK_SZ	40

`define BITSLICE_CONTROL__QDLY_VT_TRACK   	32'h000a	// Type=BOOLSTRING; Values=TRUE,FALSE
`define BITSLICE_CONTROL__QDLY_VT_TRACK_SZ	40

`define BITSLICE_CONTROL__READ_IDLE_COUNT   	32'h000b	// Type=HEX; Min=6'h00, Max=6'h3f
`define BITSLICE_CONTROL__READ_IDLE_COUNT_SZ	6

`define BITSLICE_CONTROL__REFCLK_SRC   	32'h000c	// Type=STRING; Values=PLLCLK,REFCLK
`define BITSLICE_CONTROL__REFCLK_SRC_SZ	48

`define BITSLICE_CONTROL__ROUNDING_FACTOR   	32'h000d	// Type=DECIMAL; Values=16,2,4,8,32,64,128
`define BITSLICE_CONTROL__ROUNDING_FACTOR_SZ	32

`define BITSLICE_CONTROL__RXGATE_EXTEND   	32'h000e	// Type=BOOLSTRING; Values=FALSE,TRUE
`define BITSLICE_CONTROL__RXGATE_EXTEND_SZ	40

`define BITSLICE_CONTROL__RX_CLK_PHASE_N   	32'h000f	// Type=STRING; Values=SHIFT_0,SHIFT_90
`define BITSLICE_CONTROL__RX_CLK_PHASE_N_SZ	64

`define BITSLICE_CONTROL__RX_CLK_PHASE_P   	32'h0010	// Type=STRING; Values=SHIFT_0,SHIFT_90
`define BITSLICE_CONTROL__RX_CLK_PHASE_P_SZ	64

`define BITSLICE_CONTROL__RX_GATING   	32'h0011	// Type=STRING; Values=DISABLE,ENABLE
`define BITSLICE_CONTROL__RX_GATING_SZ	56

`define BITSLICE_CONTROL__SELF_CALIBRATE   	32'h0012	// Type=STRING; Values=ENABLE,DISABLE
`define BITSLICE_CONTROL__SELF_CALIBRATE_SZ	56

`define BITSLICE_CONTROL__SERIAL_MODE   	32'h0013	// Type=BOOLSTRING; Values=FALSE,TRUE
`define BITSLICE_CONTROL__SERIAL_MODE_SZ	40

`define BITSLICE_CONTROL__SIM_SPEEDUP   	32'h0014	// Type=STRING; Values=FAST,SLOW
`define BITSLICE_CONTROL__SIM_SPEEDUP_SZ	32

`define BITSLICE_CONTROL__SIM_VERSION   	32'h0015	// Type=FLOAT; Values=2.0,1.0
`define BITSLICE_CONTROL__SIM_VERSION_SZ	64

`define BITSLICE_CONTROL__TX_GATING   	32'h0016	// Type=STRING; Values=DISABLE,ENABLE
`define BITSLICE_CONTROL__TX_GATING_SZ	56

`endif  // B_BITSLICE_CONTROL_DEFINES_VH