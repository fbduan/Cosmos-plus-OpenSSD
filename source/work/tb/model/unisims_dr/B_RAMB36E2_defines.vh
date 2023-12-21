// BLH dynamic attribute configuration look-up table addresses
//
// Build Summary:
//    Built By:     mk_defines_vh 3.0001
//    Built On:     Mon Jan 14 10:06:59 2013
//    Bundle:       RAMBFIFO36E2
//    Architecture: olympus
//    Snapshot Dir: /group/unified/robh/devl/ymls/olympus/BLH/snapshot
// Environment Variables:
//    XILENV="/build/xfndry/HEAD/env"
//    MYXILENV=""
//

`ifdef B_RAMB36E2_DEFINES_VH
`else
`define B_RAMB36E2_DEFINES_VH

// Look-up table parameters
//

`define RAMB36E2_ADDR_N  180
`define RAMB36E2_ADDR_SZ 32
`define RAMB36E2_DATA_SZ 256

// Attribute addresses
//

`define RAMB36E2__CASCADE_ORDER_A   	32'h0000	// Type=STRING; Values=NONE,FIRST,LAST,MIDDLE
`define RAMB36E2__CASCADE_ORDER_A_SZ	64

`define RAMB36E2__CASCADE_ORDER_B   	32'h0001	// Type=STRING; Values=NONE,FIRST,LAST,MIDDLE
`define RAMB36E2__CASCADE_ORDER_B_SZ	64

`define RAMB36E2__CLOCK_DOMAINS   	32'h0002	// Type=STRING; Values=INDEPENDENT,COMMON
`define RAMB36E2__CLOCK_DOMAINS_SZ	88

`define RAMB36E2__DOA_REG   	32'h0003	// Type=DECIMAL; Values=1,0
`define RAMB36E2__DOA_REG_SZ	32

`define RAMB36E2__DOB_REG   	32'h0004	// Type=DECIMAL; Values=1,0
`define RAMB36E2__DOB_REG_SZ	32

`define RAMB36E2__ENADDRENA   	32'h0005	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB36E2__ENADDRENA_SZ	40

`define RAMB36E2__ENADDRENB   	32'h0006	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB36E2__ENADDRENB_SZ	40

`define RAMB36E2__EN_ECC_PIPE   	32'h0007	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB36E2__EN_ECC_PIPE_SZ	40

`define RAMB36E2__EN_ECC_READ   	32'h0008	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB36E2__EN_ECC_READ_SZ	40

`define RAMB36E2__EN_ECC_WRITE   	32'h0009	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB36E2__EN_ECC_WRITE_SZ	40

`define RAMB36E2__INITP_00   	32'h000a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_00_SZ	256

`define RAMB36E2__INITP_01   	32'h000b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_01_SZ	256

`define RAMB36E2__INITP_02   	32'h000c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_02_SZ	256

`define RAMB36E2__INITP_03   	32'h000d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_03_SZ	256

`define RAMB36E2__INITP_04   	32'h000e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_04_SZ	256

`define RAMB36E2__INITP_05   	32'h000f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_05_SZ	256

`define RAMB36E2__INITP_06   	32'h0010	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_06_SZ	256

`define RAMB36E2__INITP_07   	32'h0011	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_07_SZ	256

`define RAMB36E2__INITP_08   	32'h0012	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_08_SZ	256

`define RAMB36E2__INITP_09   	32'h0013	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_09_SZ	256

`define RAMB36E2__INITP_0A   	32'h0014	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_0A_SZ	256

`define RAMB36E2__INITP_0B   	32'h0015	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_0B_SZ	256

`define RAMB36E2__INITP_0C   	32'h0016	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_0C_SZ	256

`define RAMB36E2__INITP_0D   	32'h0017	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_0D_SZ	256

`define RAMB36E2__INITP_0E   	32'h0018	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_0E_SZ	256

`define RAMB36E2__INITP_0F   	32'h0019	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INITP_0F_SZ	256

`define RAMB36E2__INIT_00   	32'h001a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_00_SZ	256

`define RAMB36E2__INIT_01   	32'h001b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_01_SZ	256

`define RAMB36E2__INIT_02   	32'h001c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_02_SZ	256

`define RAMB36E2__INIT_03   	32'h001d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_03_SZ	256

`define RAMB36E2__INIT_04   	32'h001e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_04_SZ	256

`define RAMB36E2__INIT_05   	32'h001f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_05_SZ	256

`define RAMB36E2__INIT_06   	32'h0020	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_06_SZ	256

`define RAMB36E2__INIT_07   	32'h0021	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_07_SZ	256

`define RAMB36E2__INIT_08   	32'h0022	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_08_SZ	256

`define RAMB36E2__INIT_09   	32'h0023	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_09_SZ	256

`define RAMB36E2__INIT_0A   	32'h0024	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_0A_SZ	256

`define RAMB36E2__INIT_0B   	32'h0025	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_0B_SZ	256

`define RAMB36E2__INIT_0C   	32'h0026	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_0C_SZ	256

`define RAMB36E2__INIT_0D   	32'h0027	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_0D_SZ	256

`define RAMB36E2__INIT_0E   	32'h0028	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_0E_SZ	256

`define RAMB36E2__INIT_0F   	32'h0029	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_0F_SZ	256

`define RAMB36E2__INIT_10   	32'h002a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_10_SZ	256

`define RAMB36E2__INIT_11   	32'h002b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_11_SZ	256

`define RAMB36E2__INIT_12   	32'h002c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_12_SZ	256

`define RAMB36E2__INIT_13   	32'h002d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_13_SZ	256

`define RAMB36E2__INIT_14   	32'h002e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_14_SZ	256

`define RAMB36E2__INIT_15   	32'h002f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_15_SZ	256

`define RAMB36E2__INIT_16   	32'h0030	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_16_SZ	256

`define RAMB36E2__INIT_17   	32'h0031	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_17_SZ	256

`define RAMB36E2__INIT_18   	32'h0032	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_18_SZ	256

`define RAMB36E2__INIT_19   	32'h0033	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_19_SZ	256

`define RAMB36E2__INIT_1A   	32'h0034	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_1A_SZ	256

`define RAMB36E2__INIT_1B   	32'h0035	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_1B_SZ	256

`define RAMB36E2__INIT_1C   	32'h0036	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_1C_SZ	256

`define RAMB36E2__INIT_1D   	32'h0037	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_1D_SZ	256

`define RAMB36E2__INIT_1E   	32'h0038	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_1E_SZ	256

`define RAMB36E2__INIT_1F   	32'h0039	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_1F_SZ	256

`define RAMB36E2__INIT_20   	32'h003a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_20_SZ	256

`define RAMB36E2__INIT_21   	32'h003b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_21_SZ	256

`define RAMB36E2__INIT_22   	32'h003c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_22_SZ	256

`define RAMB36E2__INIT_23   	32'h003d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_23_SZ	256

`define RAMB36E2__INIT_24   	32'h003e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_24_SZ	256

`define RAMB36E2__INIT_25   	32'h003f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_25_SZ	256

`define RAMB36E2__INIT_26   	32'h0040	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_26_SZ	256

`define RAMB36E2__INIT_27   	32'h0041	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_27_SZ	256

`define RAMB36E2__INIT_28   	32'h0042	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_28_SZ	256

`define RAMB36E2__INIT_29   	32'h0043	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_29_SZ	256

`define RAMB36E2__INIT_2A   	32'h0044	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_2A_SZ	256

`define RAMB36E2__INIT_2B   	32'h0045	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_2B_SZ	256

`define RAMB36E2__INIT_2C   	32'h0046	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_2C_SZ	256

`define RAMB36E2__INIT_2D   	32'h0047	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_2D_SZ	256

`define RAMB36E2__INIT_2E   	32'h0048	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_2E_SZ	256

`define RAMB36E2__INIT_2F   	32'h0049	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_2F_SZ	256

`define RAMB36E2__INIT_30   	32'h004a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_30_SZ	256

`define RAMB36E2__INIT_31   	32'h004b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_31_SZ	256

`define RAMB36E2__INIT_32   	32'h004c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_32_SZ	256

`define RAMB36E2__INIT_33   	32'h004d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_33_SZ	256

`define RAMB36E2__INIT_34   	32'h004e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_34_SZ	256

`define RAMB36E2__INIT_35   	32'h004f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_35_SZ	256

`define RAMB36E2__INIT_36   	32'h0050	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_36_SZ	256

`define RAMB36E2__INIT_37   	32'h0051	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_37_SZ	256

`define RAMB36E2__INIT_38   	32'h0052	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_38_SZ	256

`define RAMB36E2__INIT_39   	32'h0053	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_39_SZ	256

`define RAMB36E2__INIT_3A   	32'h0054	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_3A_SZ	256

`define RAMB36E2__INIT_3B   	32'h0055	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_3B_SZ	256

`define RAMB36E2__INIT_3C   	32'h0056	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_3C_SZ	256

`define RAMB36E2__INIT_3D   	32'h0057	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_3D_SZ	256

`define RAMB36E2__INIT_3E   	32'h0058	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_3E_SZ	256

`define RAMB36E2__INIT_3F   	32'h0059	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_3F_SZ	256

`define RAMB36E2__INIT_40   	32'h005a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_40_SZ	256

`define RAMB36E2__INIT_41   	32'h005b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_41_SZ	256

`define RAMB36E2__INIT_42   	32'h005c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_42_SZ	256

`define RAMB36E2__INIT_43   	32'h005d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_43_SZ	256

`define RAMB36E2__INIT_44   	32'h005e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_44_SZ	256

`define RAMB36E2__INIT_45   	32'h005f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_45_SZ	256

`define RAMB36E2__INIT_46   	32'h0060	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_46_SZ	256

`define RAMB36E2__INIT_47   	32'h0061	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_47_SZ	256

`define RAMB36E2__INIT_48   	32'h0062	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_48_SZ	256

`define RAMB36E2__INIT_49   	32'h0063	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_49_SZ	256

`define RAMB36E2__INIT_4A   	32'h0064	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_4A_SZ	256

`define RAMB36E2__INIT_4B   	32'h0065	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_4B_SZ	256

`define RAMB36E2__INIT_4C   	32'h0066	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_4C_SZ	256

`define RAMB36E2__INIT_4D   	32'h0067	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_4D_SZ	256

`define RAMB36E2__INIT_4E   	32'h0068	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_4E_SZ	256

`define RAMB36E2__INIT_4F   	32'h0069	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_4F_SZ	256

`define RAMB36E2__INIT_50   	32'h006a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_50_SZ	256

`define RAMB36E2__INIT_51   	32'h006b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_51_SZ	256

`define RAMB36E2__INIT_52   	32'h006c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_52_SZ	256

`define RAMB36E2__INIT_53   	32'h006d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_53_SZ	256

`define RAMB36E2__INIT_54   	32'h006e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_54_SZ	256

`define RAMB36E2__INIT_55   	32'h006f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_55_SZ	256

`define RAMB36E2__INIT_56   	32'h0070	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_56_SZ	256

`define RAMB36E2__INIT_57   	32'h0071	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_57_SZ	256

`define RAMB36E2__INIT_58   	32'h0072	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_58_SZ	256

`define RAMB36E2__INIT_59   	32'h0073	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_59_SZ	256

`define RAMB36E2__INIT_5A   	32'h0074	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_5A_SZ	256

`define RAMB36E2__INIT_5B   	32'h0075	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_5B_SZ	256

`define RAMB36E2__INIT_5C   	32'h0076	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_5C_SZ	256

`define RAMB36E2__INIT_5D   	32'h0077	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_5D_SZ	256

`define RAMB36E2__INIT_5E   	32'h0078	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_5E_SZ	256

`define RAMB36E2__INIT_5F   	32'h0079	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_5F_SZ	256

`define RAMB36E2__INIT_60   	32'h007a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_60_SZ	256

`define RAMB36E2__INIT_61   	32'h007b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_61_SZ	256

`define RAMB36E2__INIT_62   	32'h007c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_62_SZ	256

`define RAMB36E2__INIT_63   	32'h007d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_63_SZ	256

`define RAMB36E2__INIT_64   	32'h007e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_64_SZ	256

`define RAMB36E2__INIT_65   	32'h007f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_65_SZ	256

`define RAMB36E2__INIT_66   	32'h0080	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_66_SZ	256

`define RAMB36E2__INIT_67   	32'h0081	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_67_SZ	256

`define RAMB36E2__INIT_68   	32'h0082	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_68_SZ	256

`define RAMB36E2__INIT_69   	32'h0083	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_69_SZ	256

`define RAMB36E2__INIT_6A   	32'h0084	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_6A_SZ	256

`define RAMB36E2__INIT_6B   	32'h0085	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_6B_SZ	256

`define RAMB36E2__INIT_6C   	32'h0086	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_6C_SZ	256

`define RAMB36E2__INIT_6D   	32'h0087	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_6D_SZ	256

`define RAMB36E2__INIT_6E   	32'h0088	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_6E_SZ	256

`define RAMB36E2__INIT_6F   	32'h0089	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_6F_SZ	256

`define RAMB36E2__INIT_70   	32'h008a	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_70_SZ	256

`define RAMB36E2__INIT_71   	32'h008b	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_71_SZ	256

`define RAMB36E2__INIT_72   	32'h008c	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_72_SZ	256

`define RAMB36E2__INIT_73   	32'h008d	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_73_SZ	256

`define RAMB36E2__INIT_74   	32'h008e	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_74_SZ	256

`define RAMB36E2__INIT_75   	32'h008f	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_75_SZ	256

`define RAMB36E2__INIT_76   	32'h0090	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_76_SZ	256

`define RAMB36E2__INIT_77   	32'h0091	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_77_SZ	256

`define RAMB36E2__INIT_78   	32'h0092	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_78_SZ	256

`define RAMB36E2__INIT_79   	32'h0093	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_79_SZ	256

`define RAMB36E2__INIT_7A   	32'h0094	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_7A_SZ	256

`define RAMB36E2__INIT_7B   	32'h0095	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_7B_SZ	256

`define RAMB36E2__INIT_7C   	32'h0096	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_7C_SZ	256

`define RAMB36E2__INIT_7D   	32'h0097	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_7D_SZ	256

`define RAMB36E2__INIT_7E   	32'h0098	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_7E_SZ	256

`define RAMB36E2__INIT_7F   	32'h0099	// Type=HEX; Min=256'h0000000000000000000000000000000000000000000000000000000000000000, Max=256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
`define RAMB36E2__INIT_7F_SZ	256

`define RAMB36E2__INIT_A   	32'h009a	// Type=HEX; Min=36'h000000000, Max=36'hfffffffff
`define RAMB36E2__INIT_A_SZ	36

`define RAMB36E2__INIT_B   	32'h009b	// Type=HEX; Min=36'h000000000, Max=36'hfffffffff
`define RAMB36E2__INIT_B_SZ	36

`define RAMB36E2__INIT_FILE   	32'h009c	// Type=STRING; Min=, Max=
`define RAMB36E2__INIT_FILE_SZ	32

`define RAMB36E2__IS_CLKARDCLK_INVERTED   	32'h00ac	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB36E2__IS_CLKARDCLK_INVERTED_SZ	1

`define RAMB36E2__IS_CLKBWRCLK_INVERTED   	32'h00ad	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB36E2__IS_CLKBWRCLK_INVERTED_SZ	1

`define RAMB36E2__IS_ENARDEN_INVERTED   	32'h00ae	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB36E2__IS_ENARDEN_INVERTED_SZ	1

`define RAMB36E2__IS_ENBWREN_INVERTED   	32'h00af	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB36E2__IS_ENBWREN_INVERTED_SZ	1

`define RAMB36E2__IS_RSTRAMARSTRAM_INVERTED   	32'h00b0	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB36E2__IS_RSTRAMARSTRAM_INVERTED_SZ	1

`define RAMB36E2__IS_RSTRAMB_INVERTED   	32'h00b1	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB36E2__IS_RSTRAMB_INVERTED_SZ	1

`define RAMB36E2__IS_RSTREGARSTREG_INVERTED   	32'h00b2	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB36E2__IS_RSTREGARSTREG_INVERTED_SZ	1

`define RAMB36E2__IS_RSTREGB_INVERTED   	32'h00b3	// Type=BINARY; Min=1'b0, Max=1'b1
`define RAMB36E2__IS_RSTREGB_INVERTED_SZ	1

`define RAMB36E2__RDADDRCHANGEA   	32'h009d	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB36E2__RDADDRCHANGEA_SZ	40

`define RAMB36E2__RDADDRCHANGEB   	32'h009e	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB36E2__RDADDRCHANGEB_SZ	40

`define RAMB36E2__READ_WIDTH_A   	32'h00a0	// Type=DECIMAL; Values=0,1,2,4,9,18,36,72
`define RAMB36E2__READ_WIDTH_A_SZ	32

`define RAMB36E2__READ_WIDTH_B   	32'h00a1	// Type=DECIMAL; Values=0,1,2,4,9,18,36
`define RAMB36E2__READ_WIDTH_B_SZ	32

`define RAMB36E2__RSTREG_PRIORITY_A   	32'h00a2	// Type=STRING; Values=RSTREG,REGCE
`define RAMB36E2__RSTREG_PRIORITY_A_SZ	48

`define RAMB36E2__RSTREG_PRIORITY_B   	32'h00a3	// Type=STRING; Values=RSTREG,REGCE
`define RAMB36E2__RSTREG_PRIORITY_B_SZ	48

`define RAMB36E2__SIM_COLLISION_CHECK   	32'h00a4	// Type=STRING; Values=ALL,GENERATE_X_ONLY,NONE,WARNING_ONLY
`define RAMB36E2__SIM_COLLISION_CHECK_SZ	120

`define RAMB36E2__SLEEP_ASYNC   	32'h00a5	// Type=BOOLSTRING; Values=FALSE,TRUE
`define RAMB36E2__SLEEP_ASYNC_SZ	40

`define RAMB36E2__SRVAL_A   	32'h00a6	// Type=HEX; Min=36'h000000000, Max=36'hfffffffff
`define RAMB36E2__SRVAL_A_SZ	36

`define RAMB36E2__SRVAL_B   	32'h00a7	// Type=HEX; Min=36'h000000000, Max=36'hfffffffff
`define RAMB36E2__SRVAL_B_SZ	36

`define RAMB36E2__WRITE_MODE_A   	32'h00a8	// Type=STRING; Values=NO_CHANGE,READ_FIRST,WRITE_FIRST
`define RAMB36E2__WRITE_MODE_A_SZ	88

`define RAMB36E2__WRITE_MODE_B   	32'h00a9	// Type=STRING; Values=NO_CHANGE,READ_FIRST,WRITE_FIRST
`define RAMB36E2__WRITE_MODE_B_SZ	88

`define RAMB36E2__WRITE_WIDTH_A   	32'h00aa	// Type=DECIMAL; Values=0,1,2,4,9,18,36
`define RAMB36E2__WRITE_WIDTH_A_SZ	32

`define RAMB36E2__WRITE_WIDTH_B   	32'h00ab	// Type=DECIMAL; Values=0,1,2,4,9,18,36,72
`define RAMB36E2__WRITE_WIDTH_B_SZ	32

`endif  // B_RAMB36E2_DEFINES_VH
