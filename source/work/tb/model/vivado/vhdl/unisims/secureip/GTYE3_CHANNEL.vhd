-----------------------------------------------------------------------------
--  Copyright (c) 2013 Xilinx Inc.
--  All Right Reserved.
-----------------------------------------------------------------------------
--
--   ____  ____
--  /   /\/   /
-- /___/  \  /     Vendor      : Xilinx 
-- \   \   \/      Version     : 2012.2 
--  \   \          Description : Xilinx Functional Simulation Library Component
--  /   /                      
-- /___/   /\      Filename    : GTYE3_CHANNEL.vhd
-- \   \  /  \
--  \__ \/\__ \
--
-----------------------------------------------------------------------------
--  Revision:
--
--  End Revision:
-----------------------------------------------------------------------------

----- CELL GTYE3_CHANNEL -----

library IEEE;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_1164.all;

library STD;
use STD.TEXTIO.all;

library UNISIM;
use UNISIM.VPKG.all;
use UNISIM.VCOMPONENTS.all;

library SECUREIP;
use SECUREIP.all;

entity GTYE3_CHANNEL is
  generic (
    ACJTAG_DEBUG_MODE : bit := '0';
    ACJTAG_MODE : bit := '0';
    ACJTAG_RESET : bit := '0';
    ADAPT_CFG0 : std_logic_vector(15 downto 0) := X"9200";
    ADAPT_CFG1 : std_logic_vector(15 downto 0) := X"801C";
    ADAPT_CFG2 : std_logic_vector(15 downto 0) := "0000000000000000";
    ALIGN_COMMA_DOUBLE : string := "FALSE";
    ALIGN_COMMA_ENABLE : std_logic_vector(9 downto 0) := "0001111111";
    ALIGN_COMMA_WORD : integer := 1;
    ALIGN_MCOMMA_DET : string := "TRUE";
    ALIGN_MCOMMA_VALUE : std_logic_vector(9 downto 0) := "1010000011";
    ALIGN_PCOMMA_DET : string := "TRUE";
    ALIGN_PCOMMA_VALUE : std_logic_vector(9 downto 0) := "0101111100";
    AUTO_BW_SEL_BYPASS : bit := '0';
    A_RXOSCALRESET : bit := '0';
    A_RXPROGDIVRESET : bit := '0';
    A_TXDIFFCTRL : std_logic_vector(4 downto 0) := "01100";
    A_TXPROGDIVRESET : bit := '0';
    CAPBYPASS_FORCE : bit := '0';
    CBCC_DATA_SOURCE_SEL : string := "DECODED";
    CDR_SWAP_MODE_EN : bit := '0';
    CHAN_BOND_KEEP_ALIGN : string := "FALSE";
    CHAN_BOND_MAX_SKEW : integer := 7;
    CHAN_BOND_SEQ_1_1 : std_logic_vector(9 downto 0) := "0101111100";
    CHAN_BOND_SEQ_1_2 : std_logic_vector(9 downto 0) := "0000000000";
    CHAN_BOND_SEQ_1_3 : std_logic_vector(9 downto 0) := "0000000000";
    CHAN_BOND_SEQ_1_4 : std_logic_vector(9 downto 0) := "0000000000";
    CHAN_BOND_SEQ_1_ENABLE : std_logic_vector(3 downto 0) := "1111";
    CHAN_BOND_SEQ_2_1 : std_logic_vector(9 downto 0) := "0100000000";
    CHAN_BOND_SEQ_2_2 : std_logic_vector(9 downto 0) := "0100000000";
    CHAN_BOND_SEQ_2_3 : std_logic_vector(9 downto 0) := "0100000000";
    CHAN_BOND_SEQ_2_4 : std_logic_vector(9 downto 0) := "0100000000";
    CHAN_BOND_SEQ_2_ENABLE : std_logic_vector(3 downto 0) := "1111";
    CHAN_BOND_SEQ_2_USE : string := "FALSE";
    CHAN_BOND_SEQ_LEN : integer := 2;
    CH_HSPMUX : std_logic_vector(15 downto 0) := X"0000";
    CKCAL1_CFG_0 : std_logic_vector(15 downto 0) := "0000000000000000";
    CKCAL1_CFG_1 : std_logic_vector(15 downto 0) := "0000000000000000";
    CKCAL1_CFG_2 : std_logic_vector(15 downto 0) := "0000000000000000";
    CKCAL1_CFG_3 : std_logic_vector(15 downto 0) := "0000000000000000";
    CKCAL2_CFG_0 : std_logic_vector(15 downto 0) := "0000000000000000";
    CKCAL2_CFG_1 : std_logic_vector(15 downto 0) := "0000000000000000";
    CKCAL2_CFG_2 : std_logic_vector(15 downto 0) := "0000000000000000";
    CKCAL2_CFG_3 : std_logic_vector(15 downto 0) := "0000000000000000";
    CKCAL2_CFG_4 : std_logic_vector(15 downto 0) := "0000000000000000";
    CKCAL_RSVD0 : std_logic_vector(15 downto 0) := X"0000";
    CKCAL_RSVD1 : std_logic_vector(15 downto 0) := X"0000";
    CLK_CORRECT_USE : string := "TRUE";
    CLK_COR_KEEP_IDLE : string := "FALSE";
    CLK_COR_MAX_LAT : integer := 20;
    CLK_COR_MIN_LAT : integer := 18;
    CLK_COR_PRECEDENCE : string := "TRUE";
    CLK_COR_REPEAT_WAIT : integer := 0;
    CLK_COR_SEQ_1_1 : std_logic_vector(9 downto 0) := "0100011100";
    CLK_COR_SEQ_1_2 : std_logic_vector(9 downto 0) := "0000000000";
    CLK_COR_SEQ_1_3 : std_logic_vector(9 downto 0) := "0000000000";
    CLK_COR_SEQ_1_4 : std_logic_vector(9 downto 0) := "0000000000";
    CLK_COR_SEQ_1_ENABLE : std_logic_vector(3 downto 0) := "1111";
    CLK_COR_SEQ_2_1 : std_logic_vector(9 downto 0) := "0100000000";
    CLK_COR_SEQ_2_2 : std_logic_vector(9 downto 0) := "0100000000";
    CLK_COR_SEQ_2_3 : std_logic_vector(9 downto 0) := "0100000000";
    CLK_COR_SEQ_2_4 : std_logic_vector(9 downto 0) := "0100000000";
    CLK_COR_SEQ_2_ENABLE : std_logic_vector(3 downto 0) := "1111";
    CLK_COR_SEQ_2_USE : string := "FALSE";
    CLK_COR_SEQ_LEN : integer := 2;
    CPLL_CFG0 : std_logic_vector(15 downto 0) := X"20F8";
    CPLL_CFG1 : std_logic_vector(15 downto 0) := X"A494";
    CPLL_CFG2 : std_logic_vector(15 downto 0) := X"F001";
    CPLL_CFG3 : std_logic_vector(5 downto 0) := "00" & X"0";
    CPLL_FBDIV : integer := 4;
    CPLL_FBDIV_45 : integer := 4;
    CPLL_INIT_CFG0 : std_logic_vector(15 downto 0) := X"001E";
    CPLL_INIT_CFG1 : std_logic_vector(7 downto 0) := X"00";
    CPLL_LOCK_CFG : std_logic_vector(15 downto 0) := X"01E8";
    CPLL_REFCLK_DIV : integer := 1;
    CTLE3_OCAP_EXT_CTRL : std_logic_vector(2 downto 0) := "000";
    CTLE3_OCAP_EXT_EN : bit := '0';
    DDI_CTRL : std_logic_vector(1 downto 0) := "00";
    DDI_REALIGN_WAIT : integer := 15;
    DEC_MCOMMA_DETECT : string := "TRUE";
    DEC_PCOMMA_DETECT : string := "TRUE";
    DEC_VALID_COMMA_ONLY : string := "TRUE";
    DFE_D_X_REL_POS : bit := '0';
    DFE_VCM_COMP_EN : bit := '0';
    DMONITOR_CFG0 : std_logic_vector(9 downto 0) := "00" & X"00";
    DMONITOR_CFG1 : std_logic_vector(7 downto 0) := X"00";
    ES_CLK_PHASE_SEL : bit := '0';
    ES_CONTROL : std_logic_vector(5 downto 0) := "000000";
    ES_ERRDET_EN : string := "FALSE";
    ES_EYE_SCAN_EN : string := "FALSE";
    ES_HORZ_OFFSET : std_logic_vector(11 downto 0) := X"000";
    ES_PMA_CFG : std_logic_vector(9 downto 0) := "0000000000";
    ES_PRESCALE : std_logic_vector(4 downto 0) := "00000";
    ES_QUALIFIER0 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUALIFIER1 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUALIFIER2 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUALIFIER3 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUALIFIER4 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUALIFIER5 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUALIFIER6 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUALIFIER7 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUALIFIER8 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUALIFIER9 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK0 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK1 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK2 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK3 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK4 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK5 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK6 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK7 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK8 : std_logic_vector(15 downto 0) := X"0000";
    ES_QUAL_MASK9 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK0 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK1 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK2 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK3 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK4 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK5 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK6 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK7 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK8 : std_logic_vector(15 downto 0) := X"0000";
    ES_SDATA_MASK9 : std_logic_vector(15 downto 0) := X"0000";
    EVODD_PHI_CFG : std_logic_vector(10 downto 0) := "00000000000";
    EYE_SCAN_SWAP_EN : bit := '0';
    FTS_DESKEW_SEQ_ENABLE : std_logic_vector(3 downto 0) := "1111";
    FTS_LANE_DESKEW_CFG : std_logic_vector(3 downto 0) := "1111";
    FTS_LANE_DESKEW_EN : string := "FALSE";
    GEARBOX_MODE : std_logic_vector(4 downto 0) := "00000";
    GM_BIAS_SELECT : bit := '0';
    ISCAN_CK_PH_SEL2 : bit := '0';
    LOCAL_MASTER : bit := '0';
    LOOP0_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP10_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP11_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP12_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP13_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP1_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP2_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP3_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP4_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP5_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP6_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP7_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP8_CFG : std_logic_vector(15 downto 0) := X"0000";
    LOOP9_CFG : std_logic_vector(15 downto 0) := X"0000";
    LPBK_BIAS_CTRL : std_logic_vector(2 downto 0) := "000";
    LPBK_EN_RCAL_B : bit := '0';
    LPBK_EXT_RCAL : std_logic_vector(3 downto 0) := "0000";
    LPBK_RG_CTRL : std_logic_vector(3 downto 0) := "0000";
    OOBDIVCTL : std_logic_vector(1 downto 0) := "00";
    OOB_PWRUP : bit := '0';
    PCI3_AUTO_REALIGN : string := "FRST_SMPL";
    PCI3_PIPE_RX_ELECIDLE : bit := '1';
    PCI3_RX_ASYNC_EBUF_BYPASS : std_logic_vector(1 downto 0) := "00";
    PCI3_RX_ELECIDLE_EI2_ENABLE : bit := '0';
    PCI3_RX_ELECIDLE_H2L_COUNT : std_logic_vector(5 downto 0) := "000000";
    PCI3_RX_ELECIDLE_H2L_DISABLE : std_logic_vector(2 downto 0) := "000";
    PCI3_RX_ELECIDLE_HI_COUNT : std_logic_vector(5 downto 0) := "000000";
    PCI3_RX_ELECIDLE_LP4_DISABLE : bit := '0';
    PCI3_RX_FIFO_DISABLE : bit := '0';
    PCIE_BUFG_DIV_CTRL : std_logic_vector(15 downto 0) := X"0000";
    PCIE_RXPCS_CFG_GEN3 : std_logic_vector(15 downto 0) := X"0000";
    PCIE_RXPMA_CFG : std_logic_vector(15 downto 0) := X"0000";
    PCIE_TXPCS_CFG_GEN3 : std_logic_vector(15 downto 0) := X"0000";
    PCIE_TXPMA_CFG : std_logic_vector(15 downto 0) := X"0000";
    PCS_PCIE_EN : string := "FALSE";
    PCS_RSVD0 : std_logic_vector(15 downto 0) := "0000000000000000";
    PCS_RSVD1 : std_logic_vector(2 downto 0) := "000";
    PD_TRANS_TIME_FROM_P2 : std_logic_vector(11 downto 0) := X"03C";
    PD_TRANS_TIME_NONE_P2 : std_logic_vector(7 downto 0) := X"19";
    PD_TRANS_TIME_TO_P2 : std_logic_vector(7 downto 0) := X"64";
    PLL_SEL_MODE_GEN12 : std_logic_vector(1 downto 0) := "00";
    PLL_SEL_MODE_GEN3 : std_logic_vector(1 downto 0) := "00";
    PMA_RSV0 : std_logic_vector(15 downto 0) := X"0000";
    PMA_RSV1 : std_logic_vector(15 downto 0) := X"0000";
    PREIQ_FREQ_BST : integer := 0;
    PROCESS_PAR : std_logic_vector(2 downto 0) := "010";
    RATE_SW_USE_DRP : bit := '0';
    RESET_POWERSAVE_DISABLE : bit := '0';
    RXBUFRESET_TIME : std_logic_vector(4 downto 0) := "00001";
    RXBUF_ADDR_MODE : string := "FULL";
    RXBUF_EIDLE_HI_CNT : std_logic_vector(3 downto 0) := "1000";
    RXBUF_EIDLE_LO_CNT : std_logic_vector(3 downto 0) := "0000";
    RXBUF_EN : string := "TRUE";
    RXBUF_RESET_ON_CB_CHANGE : string := "TRUE";
    RXBUF_RESET_ON_COMMAALIGN : string := "FALSE";
    RXBUF_RESET_ON_EIDLE : string := "FALSE";
    RXBUF_RESET_ON_RATE_CHANGE : string := "TRUE";
    RXBUF_THRESH_OVFLW : integer := 0;
    RXBUF_THRESH_OVRD : string := "FALSE";
    RXBUF_THRESH_UNDFLW : integer := 4;
    RXCDRFREQRESET_TIME : std_logic_vector(4 downto 0) := "00001";
    RXCDRPHRESET_TIME : std_logic_vector(4 downto 0) := "00001";
    RXCDR_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXCDR_CFG0_GEN3 : std_logic_vector(15 downto 0) := X"0000";
    RXCDR_CFG1 : std_logic_vector(15 downto 0) := X"0300";
    RXCDR_CFG1_GEN3 : std_logic_vector(15 downto 0) := X"0300";
    RXCDR_CFG2 : std_logic_vector(15 downto 0) := X"0060";
    RXCDR_CFG2_GEN3 : std_logic_vector(15 downto 0) := X"0060";
    RXCDR_CFG3 : std_logic_vector(15 downto 0) := X"0000";
    RXCDR_CFG3_GEN3 : std_logic_vector(15 downto 0) := X"0000";
    RXCDR_CFG4 : std_logic_vector(15 downto 0) := X"0002";
    RXCDR_CFG4_GEN3 : std_logic_vector(15 downto 0) := X"0002";
    RXCDR_CFG5 : std_logic_vector(15 downto 0) := X"0000";
    RXCDR_CFG5_GEN3 : std_logic_vector(15 downto 0) := X"0000";
    RXCDR_FR_RESET_ON_EIDLE : bit := '0';
    RXCDR_HOLD_DURING_EIDLE : bit := '0';
    RXCDR_LOCK_CFG0 : std_logic_vector(15 downto 0) := X"0001";
    RXCDR_LOCK_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    RXCDR_LOCK_CFG2 : std_logic_vector(15 downto 0) := X"0000";
    RXCDR_LOCK_CFG3 : std_logic_vector(15 downto 0) := X"0000";
    RXCDR_PH_RESET_ON_EIDLE : bit := '0';
    RXCFOKDONE_SRC : std_logic_vector(1 downto 0) := "00";
    RXCFOK_CFG0 : std_logic_vector(15 downto 0) := X"3E00";
    RXCFOK_CFG1 : std_logic_vector(15 downto 0) := X"0042";
    RXCFOK_CFG2 : std_logic_vector(15 downto 0) := X"002D";
    RXDFELPMRESET_TIME : std_logic_vector(6 downto 0) := "0001111";
    RXDFELPM_KL_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFELPM_KL_CFG1 : std_logic_vector(15 downto 0) := X"0022";
    RXDFELPM_KL_CFG2 : std_logic_vector(15 downto 0) := X"0100";
    RXDFE_CFG0 : std_logic_vector(15 downto 0) := X"4C00";
    RXDFE_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_GC_CFG0 : std_logic_vector(15 downto 0) := X"1E00";
    RXDFE_GC_CFG1 : std_logic_vector(15 downto 0) := X"1900";
    RXDFE_GC_CFG2 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_H2_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_H2_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_H3_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_H3_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_H4_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_H4_CFG1 : std_logic_vector(15 downto 0) := X"0003";
    RXDFE_H5_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_H5_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_H6_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_H6_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_H7_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_H7_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_H8_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_H8_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_H9_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_H9_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_HA_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_HA_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_HB_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_HB_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_HC_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_HC_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_HD_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_HD_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_HE_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_HE_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_HF_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_HF_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_OS_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_OS_CFG1 : std_logic_vector(15 downto 0) := X"0200";
    RXDFE_PWR_SAVING : bit := '0';
    RXDFE_UT_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_UT_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXDFE_VP_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXDFE_VP_CFG1 : std_logic_vector(15 downto 0) := X"0022";
    RXDLY_CFG : std_logic_vector(15 downto 0) := X"001F";
    RXDLY_LCFG : std_logic_vector(15 downto 0) := X"0030";
    RXELECIDLE_CFG : string := "SIGCFG_4";
    RXGBOX_FIFO_INIT_RD_ADDR : integer := 4;
    RXGEARBOX_EN : string := "FALSE";
    RXISCANRESET_TIME : std_logic_vector(4 downto 0) := "00001";
    RXLPM_CFG : std_logic_vector(15 downto 0) := X"0000";
    RXLPM_GC_CFG : std_logic_vector(15 downto 0) := X"0200";
    RXLPM_KH_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    RXLPM_KH_CFG1 : std_logic_vector(15 downto 0) := X"0002";
    RXLPM_OS_CFG0 : std_logic_vector(15 downto 0) := X"0400";
    RXLPM_OS_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    RXOOB_CFG : std_logic_vector(8 downto 0) := "000000110";
    RXOOB_CLK_CFG : string := "PMA";
    RXOSCALRESET_TIME : std_logic_vector(4 downto 0) := "00011";
    RXOUT_DIV : integer := 4;
    RXPCSRESET_TIME : std_logic_vector(4 downto 0) := "00001";
    RXPHBEACON_CFG : std_logic_vector(15 downto 0) := X"0000";
    RXPHDLY_CFG : std_logic_vector(15 downto 0) := X"2020";
    RXPHSAMP_CFG : std_logic_vector(15 downto 0) := X"2100";
    RXPHSLIP_CFG : std_logic_vector(15 downto 0) := X"9933";
    RXPH_MONITOR_SEL : std_logic_vector(4 downto 0) := "00000";
    RXPI_AUTO_BW_SEL_BYPASS : bit := '0';
    RXPI_CFG : std_logic_vector(15 downto 0) := X"0100";
    RXPI_LPM : bit := '0';
    RXPI_RSV0 : std_logic_vector(15 downto 0) := X"0000";
    RXPI_SEL_LC : std_logic_vector(1 downto 0) := "00";
    RXPI_STARTCODE : std_logic_vector(1 downto 0) := "00";
    RXPI_VREFSEL : bit := '0';
    RXPMACLK_SEL : string := "DATA";
    RXPMARESET_TIME : std_logic_vector(4 downto 0) := "00001";
    RXPRBS_ERR_LOOPBACK : bit := '0';
    RXPRBS_LINKACQ_CNT : integer := 15;
    RXSLIDE_AUTO_WAIT : integer := 7;
    RXSLIDE_MODE : string := "OFF";
    RXSYNC_MULTILANE : bit := '0';
    RXSYNC_OVRD : bit := '0';
    RXSYNC_SKIP_DA : bit := '0';
    RX_AFE_CM_EN : bit := '0';
    RX_BIAS_CFG0 : std_logic_vector(15 downto 0) := X"1534";
    RX_BUFFER_CFG : std_logic_vector(5 downto 0) := "000000";
    RX_CAPFF_SARC_ENB : bit := '0';
    RX_CLK25_DIV : integer := 8;
    RX_CLKMUX_EN : bit := '1';
    RX_CLK_SLIP_OVRD : std_logic_vector(4 downto 0) := "00000";
    RX_CM_BUF_CFG : std_logic_vector(3 downto 0) := "1010";
    RX_CM_BUF_PD : bit := '0';
    RX_CM_SEL : integer := 3;
    RX_CM_TRIM : integer := 10;
    RX_CTLE1_KHKL : bit := '0';
    RX_CTLE2_KHKL : bit := '0';
    RX_CTLE3_AGC : bit := '0';
    RX_DATA_WIDTH : integer := 20;
    RX_DDI_SEL : std_logic_vector(5 downto 0) := "000000";
    RX_DEFER_RESET_BUF_EN : string := "TRUE";
    RX_DEGEN_CTRL : std_logic_vector(2 downto 0) := "010";
    RX_DFELPM_CFG0 : integer := 6;
    RX_DFELPM_CFG1 : bit := '0';
    RX_DFELPM_KLKH_AGC_STUP_EN : bit := '1';
    RX_DFE_AGC_CFG0 : std_logic_vector(1 downto 0) := "00";
    RX_DFE_AGC_CFG1 : integer := 4;
    RX_DFE_KL_LPM_KH_CFG0 : integer := 1;
    RX_DFE_KL_LPM_KH_CFG1 : integer := 2;
    RX_DFE_KL_LPM_KL_CFG0 : std_logic_vector(1 downto 0) := "01";
    RX_DFE_KL_LPM_KL_CFG1 : std_logic_vector(2 downto 0) := "010";
    RX_DFE_LPM_HOLD_DURING_EIDLE : bit := '0';
    RX_DISPERR_SEQ_MATCH : string := "TRUE";
    RX_DIV2_MODE_B : bit := '0';
    RX_DIVRESET_TIME : std_logic_vector(4 downto 0) := "00001";
    RX_EN_CTLE_RCAL_B : bit := '0';
    RX_EN_HI_LR : bit := '0';
    RX_EXT_RL_CTRL : std_logic_vector(8 downto 0) := "000000000";
    RX_EYESCAN_VS_CODE : std_logic_vector(6 downto 0) := "0000000";
    RX_EYESCAN_VS_NEG_DIR : bit := '0';
    RX_EYESCAN_VS_RANGE : std_logic_vector(1 downto 0) := "00";
    RX_EYESCAN_VS_UT_SIGN : bit := '0';
    RX_FABINT_USRCLK_FLOP : bit := '0';
    RX_INT_DATAWIDTH : integer := 1;
    RX_PMA_POWER_SAVE : bit := '0';
    RX_PROGDIV_CFG : real := 0.0;
    RX_PROGDIV_RATE : std_logic_vector(15 downto 0) := X"0001";
    RX_RESLOAD_CTRL : std_logic_vector(3 downto 0) := "0000";
    RX_RESLOAD_OVRD : bit := '0';
    RX_SAMPLE_PERIOD : std_logic_vector(2 downto 0) := "101";
    RX_SIG_VALID_DLY : integer := 11;
    RX_SUM_DFETAPREP_EN : bit := '0';
    RX_SUM_IREF_TUNE : std_logic_vector(3 downto 0) := "0000";
    RX_SUM_VCMTUNE : std_logic_vector(3 downto 0) := "1000";
    RX_SUM_VCM_OVWR : bit := '0';
    RX_SUM_VREF_TUNE : std_logic_vector(2 downto 0) := "100";
    RX_TUNE_AFE_OS : std_logic_vector(1 downto 0) := "00";
    RX_VREG_CTRL : std_logic_vector(2 downto 0) := "101";
    RX_VREG_PDB : bit := '1';
    RX_WIDEMODE_CDR : std_logic_vector(1 downto 0) := "01";
    RX_XCLK_SEL : string := "RXDES";
    RX_XMODE_SEL : bit := '0';
    SAS_MAX_COM : integer := 64;
    SAS_MIN_COM : integer := 36;
    SATA_BURST_SEQ_LEN : std_logic_vector(3 downto 0) := "1111";
    SATA_BURST_VAL : std_logic_vector(2 downto 0) := "100";
    SATA_CPLL_CFG : string := "VCO_3000MHZ";
    SATA_EIDLE_VAL : std_logic_vector(2 downto 0) := "100";
    SATA_MAX_BURST : integer := 8;
    SATA_MAX_INIT : integer := 21;
    SATA_MAX_WAKE : integer := 7;
    SATA_MIN_BURST : integer := 4;
    SATA_MIN_INIT : integer := 12;
    SATA_MIN_WAKE : integer := 4;
    SHOW_REALIGN_COMMA : string := "TRUE";
    SIM_RECEIVER_DETECT_PASS : string := "TRUE";
    SIM_RESET_SPEEDUP : string := "TRUE";
    SIM_TX_EIDLE_DRIVE_LEVEL : bit := '0';
    SIM_VERSION : real := 1.0;
    TAPDLY_SET_TX : std_logic_vector(1 downto 0) := "00";
    TEMPERATURE_PAR : std_logic_vector(3 downto 0) := "0010";
    TERM_RCAL_CFG : std_logic_vector(14 downto 0) := "100001000010000";
    TERM_RCAL_OVRD : std_logic_vector(2 downto 0) := "000";
    TRANS_TIME_RATE : std_logic_vector(7 downto 0) := X"0E";
    TST_RSV0 : std_logic_vector(7 downto 0) := X"00";
    TST_RSV1 : std_logic_vector(7 downto 0) := X"00";
    TXBUF_EN : string := "TRUE";
    TXBUF_RESET_ON_RATE_CHANGE : string := "FALSE";
    TXDLY_CFG : std_logic_vector(15 downto 0) := X"001F";
    TXDLY_LCFG : std_logic_vector(15 downto 0) := X"0030";
    TXFIFO_ADDR_CFG : string := "LOW";
    TXGBOX_FIFO_INIT_RD_ADDR : integer := 4;
    TXGEARBOX_EN : string := "FALSE";
    TXOUT_DIV : integer := 4;
    TXPCSRESET_TIME : std_logic_vector(4 downto 0) := "00001";
    TXPHDLY_CFG0 : std_logic_vector(15 downto 0) := X"2020";
    TXPHDLY_CFG1 : std_logic_vector(15 downto 0) := X"0001";
    TXPH_CFG : std_logic_vector(15 downto 0) := X"0123";
    TXPH_CFG2 : std_logic_vector(15 downto 0) := X"0000";
    TXPH_MONITOR_SEL : std_logic_vector(4 downto 0) := "00000";
    TXPI_CFG0 : std_logic_vector(1 downto 0) := "00";
    TXPI_CFG1 : std_logic_vector(1 downto 0) := "00";
    TXPI_CFG2 : std_logic_vector(1 downto 0) := "00";
    TXPI_CFG3 : bit := '0';
    TXPI_CFG4 : bit := '1';
    TXPI_CFG5 : std_logic_vector(2 downto 0) := "000";
    TXPI_GRAY_SEL : bit := '0';
    TXPI_INVSTROBE_SEL : bit := '0';
    TXPI_LPM : bit := '0';
    TXPI_PPMCLK_SEL : string := "TXUSRCLK2";
    TXPI_PPM_CFG : std_logic_vector(7 downto 0) := "00000000";
    TXPI_RSV0 : std_logic_vector(15 downto 0) := X"0000";
    TXPI_SYNFREQ_PPM : std_logic_vector(2 downto 0) := "000";
    TXPI_VREFSEL : bit := '0';
    TXPMARESET_TIME : std_logic_vector(4 downto 0) := "00001";
    TXSYNC_MULTILANE : bit := '0';
    TXSYNC_OVRD : bit := '0';
    TXSYNC_SKIP_DA : bit := '0';
    TX_CLK25_DIV : integer := 8;
    TX_CLKMUX_EN : bit := '1';
    TX_CLKREG_PDB : bit := '0';
    TX_CLKREG_SET : std_logic_vector(2 downto 0) := "000";
    TX_DATA_WIDTH : integer := 20;
    TX_DCD_CFG : std_logic_vector(5 downto 0) := "000010";
    TX_DCD_EN : bit := '0';
    TX_DEEMPH0 : std_logic_vector(5 downto 0) := "000000";
    TX_DEEMPH1 : std_logic_vector(5 downto 0) := "000000";
    TX_DIVRESET_TIME : std_logic_vector(4 downto 0) := "00001";
    TX_DRIVE_MODE : string := "DIRECT";
    TX_DRVMUX_CTRL : integer := 2;
    TX_EIDLE_ASSERT_DELAY : std_logic_vector(2 downto 0) := "110";
    TX_EIDLE_DEASSERT_DELAY : std_logic_vector(2 downto 0) := "100";
    TX_EML_PHI_TUNE : bit := '0';
    TX_FABINT_USRCLK_FLOP : bit := '0';
    TX_FIFO_BYP_EN : bit := '0';
    TX_IDLE_DATA_ZERO : bit := '0';
    TX_INT_DATAWIDTH : integer := 1;
    TX_LOOPBACK_DRIVE_HIZ : string := "FALSE";
    TX_MAINCURSOR_SEL : bit := '0';
    TX_MARGIN_FULL_0 : std_logic_vector(6 downto 0) := "1001110";
    TX_MARGIN_FULL_1 : std_logic_vector(6 downto 0) := "1001001";
    TX_MARGIN_FULL_2 : std_logic_vector(6 downto 0) := "1000101";
    TX_MARGIN_FULL_3 : std_logic_vector(6 downto 0) := "1000010";
    TX_MARGIN_FULL_4 : std_logic_vector(6 downto 0) := "1000000";
    TX_MARGIN_LOW_0 : std_logic_vector(6 downto 0) := "1000110";
    TX_MARGIN_LOW_1 : std_logic_vector(6 downto 0) := "1000100";
    TX_MARGIN_LOW_2 : std_logic_vector(6 downto 0) := "1000010";
    TX_MARGIN_LOW_3 : std_logic_vector(6 downto 0) := "1000000";
    TX_MARGIN_LOW_4 : std_logic_vector(6 downto 0) := "1000000";
    TX_MODE_SEL : std_logic_vector(2 downto 0) := "000";
    TX_PHICAL_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    TX_PHICAL_CFG1 : std_logic_vector(15 downto 0) := X"7E00";
    TX_PHICAL_CFG2 : std_logic_vector(15 downto 0) := X"0000";
    TX_PI_BIASSET : integer := 0;
    TX_PI_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    TX_PI_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    TX_PI_DIV2_MODE_B : bit := '0';
    TX_PI_SEL_QPLL0 : bit := '0';
    TX_PI_SEL_QPLL1 : bit := '0';
    TX_PMADATA_OPT : bit := '0';
    TX_PMA_POWER_SAVE : bit := '0';
    TX_PREDRV_CTRL : integer := 2;
    TX_PROGCLK_SEL : string := "POSTPI";
    TX_PROGDIV_CFG : real := 0.0;
    TX_PROGDIV_RATE : std_logic_vector(15 downto 0) := X"0001";
    TX_RXDETECT_CFG : std_logic_vector(13 downto 0) := "00" & X"032";
    TX_RXDETECT_REF : integer := 4;
    TX_SAMPLE_PERIOD : std_logic_vector(2 downto 0) := "101";
    TX_SARC_LPBK_ENB : bit := '0';
    TX_XCLK_SEL : string := "TXOUT";
    USE_PCS_CLK_PHASE_SEL : bit := '0'
  );

  port (
    BUFGTCE              : out std_logic_vector(2 downto 0);
    BUFGTCEMASK          : out std_logic_vector(2 downto 0);
    BUFGTDIV             : out std_logic_vector(8 downto 0);
    BUFGTRESET           : out std_logic_vector(2 downto 0);
    BUFGTRSTMASK         : out std_logic_vector(2 downto 0);
    CPLLFBCLKLOST        : out std_ulogic;
    CPLLLOCK             : out std_ulogic;
    CPLLREFCLKLOST       : out std_ulogic;
    DMONITOROUT          : out std_logic_vector(16 downto 0);
    DRPDO                : out std_logic_vector(15 downto 0);
    DRPRDY               : out std_ulogic;
    EYESCANDATAERROR     : out std_ulogic;
    GTPOWERGOOD          : out std_ulogic;
    GTREFCLKMONITOR      : out std_ulogic;
    GTYTXN               : out std_ulogic;
    GTYTXP               : out std_ulogic;
    PCIERATEGEN3         : out std_ulogic;
    PCIERATEIDLE         : out std_ulogic;
    PCIERATEQPLLPD       : out std_logic_vector(1 downto 0);
    PCIERATEQPLLRESET    : out std_logic_vector(1 downto 0);
    PCIESYNCTXSYNCDONE   : out std_ulogic;
    PCIEUSERGEN3RDY      : out std_ulogic;
    PCIEUSERPHYSTATUSRST : out std_ulogic;
    PCIEUSERRATESTART    : out std_ulogic;
    PCSRSVDOUT           : out std_logic_vector(15 downto 0);
    PHYSTATUS            : out std_ulogic;
    PINRSRVDAS           : out std_logic_vector(7 downto 0);
    RESETEXCEPTION       : out std_ulogic;
    RXBUFSTATUS          : out std_logic_vector(2 downto 0);
    RXBYTEISALIGNED      : out std_ulogic;
    RXBYTEREALIGN        : out std_ulogic;
    RXCDRLOCK            : out std_ulogic;
    RXCDRPHDONE          : out std_ulogic;
    RXCHANBONDSEQ        : out std_ulogic;
    RXCHANISALIGNED      : out std_ulogic;
    RXCHANREALIGN        : out std_ulogic;
    RXCHBONDO            : out std_logic_vector(4 downto 0);
    RXCKCALDONE          : out std_ulogic;
    RXCLKCORCNT          : out std_logic_vector(1 downto 0);
    RXCOMINITDET         : out std_ulogic;
    RXCOMMADET           : out std_ulogic;
    RXCOMSASDET          : out std_ulogic;
    RXCOMWAKEDET         : out std_ulogic;
    RXCTRL0              : out std_logic_vector(15 downto 0);
    RXCTRL1              : out std_logic_vector(15 downto 0);
    RXCTRL2              : out std_logic_vector(7 downto 0);
    RXCTRL3              : out std_logic_vector(7 downto 0);
    RXDATA               : out std_logic_vector(127 downto 0);
    RXDATAEXTENDRSVD     : out std_logic_vector(7 downto 0);
    RXDATAVALID          : out std_logic_vector(1 downto 0);
    RXDLYSRESETDONE      : out std_ulogic;
    RXELECIDLE           : out std_ulogic;
    RXHEADER             : out std_logic_vector(5 downto 0);
    RXHEADERVALID        : out std_logic_vector(1 downto 0);
    RXMONITOROUT         : out std_logic_vector(6 downto 0);
    RXOSINTDONE          : out std_ulogic;
    RXOSINTSTARTED       : out std_ulogic;
    RXOSINTSTROBEDONE    : out std_ulogic;
    RXOSINTSTROBESTARTED : out std_ulogic;
    RXOUTCLK             : out std_ulogic;
    RXOUTCLKFABRIC       : out std_ulogic;
    RXOUTCLKPCS          : out std_ulogic;
    RXPHALIGNDONE        : out std_ulogic;
    RXPHALIGNERR         : out std_ulogic;
    RXPMARESETDONE       : out std_ulogic;
    RXPRBSERR            : out std_ulogic;
    RXPRBSLOCKED         : out std_ulogic;
    RXPRGDIVRESETDONE    : out std_ulogic;
    RXRATEDONE           : out std_ulogic;
    RXRECCLKOUT          : out std_ulogic;
    RXRESETDONE          : out std_ulogic;
    RXSLIDERDY           : out std_ulogic;
    RXSLIPDONE           : out std_ulogic;
    RXSLIPOUTCLKRDY      : out std_ulogic;
    RXSLIPPMARDY         : out std_ulogic;
    RXSTARTOFSEQ         : out std_logic_vector(1 downto 0);
    RXSTATUS             : out std_logic_vector(2 downto 0);
    RXSYNCDONE           : out std_ulogic;
    RXSYNCOUT            : out std_ulogic;
    RXVALID              : out std_ulogic;
    TXBUFSTATUS          : out std_logic_vector(1 downto 0);
    TXCOMFINISH          : out std_ulogic;
    TXDCCDONE            : out std_ulogic;
    TXDLYSRESETDONE      : out std_ulogic;
    TXOUTCLK             : out std_ulogic;
    TXOUTCLKFABRIC       : out std_ulogic;
    TXOUTCLKPCS          : out std_ulogic;
    TXPHALIGNDONE        : out std_ulogic;
    TXPHINITDONE         : out std_ulogic;
    TXPMARESETDONE       : out std_ulogic;
    TXPRGDIVRESETDONE    : out std_ulogic;
    TXRATEDONE           : out std_ulogic;
    TXRESETDONE          : out std_ulogic;
    TXSYNCDONE           : out std_ulogic;
    TXSYNCOUT            : out std_ulogic;
    CDRSTEPDIR           : in std_ulogic;
    CDRSTEPSQ            : in std_ulogic;
    CDRSTEPSX            : in std_ulogic;
    CFGRESET             : in std_ulogic;
    CLKRSVD0             : in std_ulogic;
    CLKRSVD1             : in std_ulogic;
    CPLLLOCKDETCLK       : in std_ulogic;
    CPLLLOCKEN           : in std_ulogic;
    CPLLPD               : in std_ulogic;
    CPLLREFCLKSEL        : in std_logic_vector(2 downto 0);
    CPLLRESET            : in std_ulogic;
    DMONFIFORESET        : in std_ulogic;
    DMONITORCLK          : in std_ulogic;
    DRPADDR              : in std_logic_vector(9 downto 0);
    DRPCLK               : in std_ulogic;
    DRPDI                : in std_logic_vector(15 downto 0);
    DRPEN                : in std_ulogic;
    DRPWE                : in std_ulogic;
    ELPCALDVORWREN       : in std_ulogic;
    ELPCALPAORWREN       : in std_ulogic;
    EVODDPHICALDONE      : in std_ulogic;
    EVODDPHICALSTART     : in std_ulogic;
    EVODDPHIDRDEN        : in std_ulogic;
    EVODDPHIDWREN        : in std_ulogic;
    EVODDPHIXRDEN        : in std_ulogic;
    EVODDPHIXWREN        : in std_ulogic;
    EYESCANMODE          : in std_ulogic;
    EYESCANRESET         : in std_ulogic;
    EYESCANTRIGGER       : in std_ulogic;
    GTGREFCLK            : in std_ulogic;
    GTNORTHREFCLK0       : in std_ulogic;
    GTNORTHREFCLK1       : in std_ulogic;
    GTREFCLK0            : in std_ulogic;
    GTREFCLK1            : in std_ulogic;
    GTRESETSEL           : in std_ulogic;
    GTRSVD               : in std_logic_vector(15 downto 0);
    GTRXRESET            : in std_ulogic;
    GTSOUTHREFCLK0       : in std_ulogic;
    GTSOUTHREFCLK1       : in std_ulogic;
    GTTXRESET            : in std_ulogic;
    GTYRXN               : in std_ulogic;
    GTYRXP               : in std_ulogic;
    LOOPBACK             : in std_logic_vector(2 downto 0);
    LOOPRSVD             : in std_logic_vector(15 downto 0);
    LPBKRXTXSEREN        : in std_ulogic;
    LPBKTXRXSEREN        : in std_ulogic;
    PCIEEQRXEQADAPTDONE  : in std_ulogic;
    PCIERSTIDLE          : in std_ulogic;
    PCIERSTTXSYNCSTART   : in std_ulogic;
    PCIEUSERRATEDONE     : in std_ulogic;
    PCSRSVDIN            : in std_logic_vector(15 downto 0);
    PCSRSVDIN2           : in std_logic_vector(4 downto 0);
    PMARSVDIN            : in std_logic_vector(4 downto 0);
    QPLL0CLK             : in std_ulogic;
    QPLL0REFCLK          : in std_ulogic;
    QPLL1CLK             : in std_ulogic;
    QPLL1REFCLK          : in std_ulogic;
    RESETOVRD            : in std_ulogic;
    RSTCLKENTX           : in std_ulogic;
    RX8B10BEN            : in std_ulogic;
    RXBUFRESET           : in std_ulogic;
    RXCDRFREQRESET       : in std_ulogic;
    RXCDRHOLD            : in std_ulogic;
    RXCDROVRDEN          : in std_ulogic;
    RXCDRRESET           : in std_ulogic;
    RXCDRRESETRSV        : in std_ulogic;
    RXCHBONDEN           : in std_ulogic;
    RXCHBONDI            : in std_logic_vector(4 downto 0);
    RXCHBONDLEVEL        : in std_logic_vector(2 downto 0);
    RXCHBONDMASTER       : in std_ulogic;
    RXCHBONDSLAVE        : in std_ulogic;
    RXCKCALRESET         : in std_ulogic;
    RXCOMMADETEN         : in std_ulogic;
    RXDCCFORCESTART      : in std_ulogic;
    RXDFEAGCHOLD         : in std_ulogic;
    RXDFEAGCOVRDEN       : in std_ulogic;
    RXDFELFHOLD          : in std_ulogic;
    RXDFELFOVRDEN        : in std_ulogic;
    RXDFELPMRESET        : in std_ulogic;
    RXDFETAP10HOLD       : in std_ulogic;
    RXDFETAP10OVRDEN     : in std_ulogic;
    RXDFETAP11HOLD       : in std_ulogic;
    RXDFETAP11OVRDEN     : in std_ulogic;
    RXDFETAP12HOLD       : in std_ulogic;
    RXDFETAP12OVRDEN     : in std_ulogic;
    RXDFETAP13HOLD       : in std_ulogic;
    RXDFETAP13OVRDEN     : in std_ulogic;
    RXDFETAP14HOLD       : in std_ulogic;
    RXDFETAP14OVRDEN     : in std_ulogic;
    RXDFETAP15HOLD       : in std_ulogic;
    RXDFETAP15OVRDEN     : in std_ulogic;
    RXDFETAP2HOLD        : in std_ulogic;
    RXDFETAP2OVRDEN      : in std_ulogic;
    RXDFETAP3HOLD        : in std_ulogic;
    RXDFETAP3OVRDEN      : in std_ulogic;
    RXDFETAP4HOLD        : in std_ulogic;
    RXDFETAP4OVRDEN      : in std_ulogic;
    RXDFETAP5HOLD        : in std_ulogic;
    RXDFETAP5OVRDEN      : in std_ulogic;
    RXDFETAP6HOLD        : in std_ulogic;
    RXDFETAP6OVRDEN      : in std_ulogic;
    RXDFETAP7HOLD        : in std_ulogic;
    RXDFETAP7OVRDEN      : in std_ulogic;
    RXDFETAP8HOLD        : in std_ulogic;
    RXDFETAP8OVRDEN      : in std_ulogic;
    RXDFETAP9HOLD        : in std_ulogic;
    RXDFETAP9OVRDEN      : in std_ulogic;
    RXDFEUTHOLD          : in std_ulogic;
    RXDFEUTOVRDEN        : in std_ulogic;
    RXDFEVPHOLD          : in std_ulogic;
    RXDFEVPOVRDEN        : in std_ulogic;
    RXDFEVSEN            : in std_ulogic;
    RXDFEXYDEN           : in std_ulogic;
    RXDLYBYPASS          : in std_ulogic;
    RXDLYEN              : in std_ulogic;
    RXDLYOVRDEN          : in std_ulogic;
    RXDLYSRESET          : in std_ulogic;
    RXELECIDLEMODE       : in std_logic_vector(1 downto 0);
    RXGEARBOXSLIP        : in std_ulogic;
    RXLATCLK             : in std_ulogic;
    RXLPMEN              : in std_ulogic;
    RXLPMGCHOLD          : in std_ulogic;
    RXLPMGCOVRDEN        : in std_ulogic;
    RXLPMHFHOLD          : in std_ulogic;
    RXLPMHFOVRDEN        : in std_ulogic;
    RXLPMLFHOLD          : in std_ulogic;
    RXLPMLFKLOVRDEN      : in std_ulogic;
    RXLPMOSHOLD          : in std_ulogic;
    RXLPMOSOVRDEN        : in std_ulogic;
    RXMCOMMAALIGNEN      : in std_ulogic;
    RXMONITORSEL         : in std_logic_vector(1 downto 0);
    RXOOBRESET           : in std_ulogic;
    RXOSCALRESET         : in std_ulogic;
    RXOSHOLD             : in std_ulogic;
    RXOSINTCFG           : in std_logic_vector(3 downto 0);
    RXOSINTEN            : in std_ulogic;
    RXOSINTHOLD          : in std_ulogic;
    RXOSINTOVRDEN        : in std_ulogic;
    RXOSINTSTROBE        : in std_ulogic;
    RXOSINTTESTOVRDEN    : in std_ulogic;
    RXOSOVRDEN           : in std_ulogic;
    RXOUTCLKSEL          : in std_logic_vector(2 downto 0);
    RXPCOMMAALIGNEN      : in std_ulogic;
    RXPCSRESET           : in std_ulogic;
    RXPD                 : in std_logic_vector(1 downto 0);
    RXPHALIGN            : in std_ulogic;
    RXPHALIGNEN          : in std_ulogic;
    RXPHDLYPD            : in std_ulogic;
    RXPHDLYRESET         : in std_ulogic;
    RXPHOVRDEN           : in std_ulogic;
    RXPLLCLKSEL          : in std_logic_vector(1 downto 0);
    RXPMARESET           : in std_ulogic;
    RXPOLARITY           : in std_ulogic;
    RXPRBSCNTRESET       : in std_ulogic;
    RXPRBSSEL            : in std_logic_vector(3 downto 0);
    RXPROGDIVRESET       : in std_ulogic;
    RXRATE               : in std_logic_vector(2 downto 0);
    RXRATEMODE           : in std_ulogic;
    RXSLIDE              : in std_ulogic;
    RXSLIPOUTCLK         : in std_ulogic;
    RXSLIPPMA            : in std_ulogic;
    RXSYNCALLIN          : in std_ulogic;
    RXSYNCIN             : in std_ulogic;
    RXSYNCMODE           : in std_ulogic;
    RXSYSCLKSEL          : in std_logic_vector(1 downto 0);
    RXUSERRDY            : in std_ulogic;
    RXUSRCLK             : in std_ulogic;
    RXUSRCLK2            : in std_ulogic;
    SIGVALIDCLK          : in std_ulogic;
    TSTIN                : in std_logic_vector(19 downto 0);
    TX8B10BBYPASS        : in std_logic_vector(7 downto 0);
    TX8B10BEN            : in std_ulogic;
    TXBUFDIFFCTRL        : in std_logic_vector(2 downto 0);
    TXCOMINIT            : in std_ulogic;
    TXCOMSAS             : in std_ulogic;
    TXCOMWAKE            : in std_ulogic;
    TXCTRL0              : in std_logic_vector(15 downto 0);
    TXCTRL1              : in std_logic_vector(15 downto 0);
    TXCTRL2              : in std_logic_vector(7 downto 0);
    TXDATA               : in std_logic_vector(127 downto 0);
    TXDATAEXTENDRSVD     : in std_logic_vector(7 downto 0);
    TXDCCFORCESTART      : in std_ulogic;
    TXDCCRESET           : in std_ulogic;
    TXDEEMPH             : in std_ulogic;
    TXDETECTRX           : in std_ulogic;
    TXDIFFCTRL           : in std_logic_vector(4 downto 0);
    TXDIFFPD             : in std_ulogic;
    TXDLYBYPASS          : in std_ulogic;
    TXDLYEN              : in std_ulogic;
    TXDLYHOLD            : in std_ulogic;
    TXDLYOVRDEN          : in std_ulogic;
    TXDLYSRESET          : in std_ulogic;
    TXDLYUPDOWN          : in std_ulogic;
    TXELECIDLE           : in std_ulogic;
    TXELFORCESTART       : in std_ulogic;
    TXHEADER             : in std_logic_vector(5 downto 0);
    TXINHIBIT            : in std_ulogic;
    TXLATCLK             : in std_ulogic;
    TXMAINCURSOR         : in std_logic_vector(6 downto 0);
    TXMARGIN             : in std_logic_vector(2 downto 0);
    TXOUTCLKSEL          : in std_logic_vector(2 downto 0);
    TXPCSRESET           : in std_ulogic;
    TXPD                 : in std_logic_vector(1 downto 0);
    TXPDELECIDLEMODE     : in std_ulogic;
    TXPHALIGN            : in std_ulogic;
    TXPHALIGNEN          : in std_ulogic;
    TXPHDLYPD            : in std_ulogic;
    TXPHDLYRESET         : in std_ulogic;
    TXPHDLYTSTCLK        : in std_ulogic;
    TXPHINIT             : in std_ulogic;
    TXPHOVRDEN           : in std_ulogic;
    TXPIPPMEN            : in std_ulogic;
    TXPIPPMOVRDEN        : in std_ulogic;
    TXPIPPMPD            : in std_ulogic;
    TXPIPPMSEL           : in std_ulogic;
    TXPIPPMSTEPSIZE      : in std_logic_vector(4 downto 0);
    TXPISOPD             : in std_ulogic;
    TXPLLCLKSEL          : in std_logic_vector(1 downto 0);
    TXPMARESET           : in std_ulogic;
    TXPOLARITY           : in std_ulogic;
    TXPOSTCURSOR         : in std_logic_vector(4 downto 0);
    TXPRBSFORCEERR       : in std_ulogic;
    TXPRBSSEL            : in std_logic_vector(3 downto 0);
    TXPRECURSOR          : in std_logic_vector(4 downto 0);
    TXPROGDIVRESET       : in std_ulogic;
    TXRATE               : in std_logic_vector(2 downto 0);
    TXRATEMODE           : in std_ulogic;
    TXSEQUENCE           : in std_logic_vector(6 downto 0);
    TXSWING              : in std_ulogic;
    TXSYNCALLIN          : in std_ulogic;
    TXSYNCIN             : in std_ulogic;
    TXSYNCMODE           : in std_ulogic;
    TXSYSCLKSEL          : in std_logic_vector(1 downto 0);
    TXUSERRDY            : in std_ulogic;
    TXUSRCLK             : in std_ulogic;
    TXUSRCLK2            : in std_ulogic    
  );
end GTYE3_CHANNEL;

architecture GTYE3_CHANNEL_V of GTYE3_CHANNEL is
  component SIP_GTYE3_CHANNEL
    
    port (
        ACJTAG_DEBUG_MODE    : in std_logic_vector(0 downto 0);
        ACJTAG_MODE          : in std_logic_vector(0 downto 0);
        ACJTAG_RESET         : in std_logic_vector(0 downto 0);
        ADAPT_CFG0           : in std_logic_vector(15 downto 0);
        ADAPT_CFG1           : in std_logic_vector(15 downto 0);
        ADAPT_CFG2           : in std_logic_vector(15 downto 0);
        AEN_CDRSTEPSEL       : in std_logic_vector(0 downto 0);
        AEN_CPLL             : in std_logic_vector(0 downto 0);
        AEN_ELPCAL           : in std_logic_vector(0 downto 0);
        AEN_EYESCAN          : in std_logic_vector(0 downto 0);
        AEN_LOOPBACK         : in std_logic_vector(0 downto 0);
        AEN_MASTER           : in std_logic_vector(0 downto 0);
        AEN_MUXDCD           : in std_logic_vector(0 downto 0);
        AEN_PD_AND_EIDLE     : in std_logic_vector(0 downto 0);
        AEN_POLARITY         : in std_logic_vector(0 downto 0);
        AEN_PRBS             : in std_logic_vector(0 downto 0);
        AEN_RESET            : in std_logic_vector(0 downto 0);
        AEN_RXCDR            : in std_logic_vector(0 downto 0);
        AEN_RXDFE            : in std_logic_vector(0 downto 0);
        AEN_RXDFELPM         : in std_logic_vector(0 downto 0);
        AEN_RXOUTCLK_SEL     : in std_logic_vector(0 downto 0);
        AEN_RXPHDLY          : in std_logic_vector(0 downto 0);
        AEN_RXPLLCLK_SEL     : in std_logic_vector(0 downto 0);
        AEN_RXSYSCLK_SEL     : in std_logic_vector(0 downto 0);
        AEN_TXOUTCLK_SEL     : in std_logic_vector(0 downto 0);
        AEN_TXPHDLY          : in std_logic_vector(0 downto 0);
        AEN_TXPI_PPM         : in std_logic_vector(0 downto 0);
        AEN_TXPLLCLK_SEL     : in std_logic_vector(0 downto 0);
        AEN_TXSYSCLK_SEL     : in std_logic_vector(0 downto 0);
        AEN_TX_DRIVE_MODE    : in std_logic_vector(0 downto 0);
        ALIGN_COMMA_DOUBLE   : in std_logic_vector(39 downto 0);
        ALIGN_COMMA_ENABLE   : in std_logic_vector(9 downto 0);
        ALIGN_COMMA_WORD     : in std_logic_vector(2 downto 0);
        ALIGN_MCOMMA_DET     : in std_logic_vector(39 downto 0);
        ALIGN_MCOMMA_VALUE   : in std_logic_vector(9 downto 0);
        ALIGN_PCOMMA_DET     : in std_logic_vector(39 downto 0);
        ALIGN_PCOMMA_VALUE   : in std_logic_vector(9 downto 0);
        AMONITOR_CFG         : in std_logic_vector(9 downto 0);
        AUTO_BW_SEL_BYPASS   : in std_logic_vector(0 downto 0);
        A_AFECFOKEN          : in std_logic_vector(0 downto 0);
        A_CPLLLOCKEN         : in std_logic_vector(0 downto 0);
        A_CPLLPD             : in std_logic_vector(0 downto 0);
        A_CPLLRESET          : in std_logic_vector(0 downto 0);
        A_DFECFOKFCDAC       : in std_logic_vector(5 downto 0);
        A_DFECFOKFCNUM       : in std_logic_vector(3 downto 0);
        A_DFECFOKFPULSE      : in std_logic_vector(0 downto 0);
        A_DFECFOKHOLD        : in std_logic_vector(0 downto 0);
        A_DFECFOKOVREN       : in std_logic_vector(0 downto 0);
        A_ELPCALDVORWREN     : in std_logic_vector(0 downto 0);
        A_ELPCALPAORWREN     : in std_logic_vector(0 downto 0);
        A_EYESCANMODE        : in std_logic_vector(0 downto 0);
        A_EYESCANRESET       : in std_logic_vector(0 downto 0);
        A_GTRESETSEL         : in std_logic_vector(0 downto 0);
        A_GTRXRESET          : in std_logic_vector(0 downto 0);
        A_GTTXRESET          : in std_logic_vector(0 downto 0);
        A_LOOPBACK           : in std_logic_vector(79 downto 0);
        A_LPMGCHOLD          : in std_logic_vector(0 downto 0);
        A_LPMGCOVREN         : in std_logic_vector(0 downto 0);
        A_LPMOSHOLD          : in std_logic_vector(0 downto 0);
        A_LPMOSOVREN         : in std_logic_vector(0 downto 0);
        A_MUXDCDEXHOLD       : in std_logic_vector(0 downto 0);
        A_MUXDCDORWREN       : in std_logic_vector(0 downto 0);
        A_RXBUFRESET         : in std_logic_vector(0 downto 0);
        A_RXCDRFREQRESET     : in std_logic_vector(0 downto 0);
        A_RXCDRHOLD          : in std_logic_vector(0 downto 0);
        A_RXCDROVRDEN        : in std_logic_vector(0 downto 0);
        A_RXCDRRESET         : in std_logic_vector(0 downto 0);
        A_RXDFEAGCHOLD       : in std_logic_vector(0 downto 0);
        A_RXDFEAGCOVRDEN     : in std_logic_vector(0 downto 0);
        A_RXDFECFOKFEN       : in std_logic_vector(0 downto 0);
        A_RXDFELFHOLD        : in std_logic_vector(0 downto 0);
        A_RXDFELFOVRDEN      : in std_logic_vector(0 downto 0);
        A_RXDFELPMRESET      : in std_logic_vector(0 downto 0);
        A_RXDFETAP10HOLD     : in std_logic_vector(0 downto 0);
        A_RXDFETAP10OVRDEN   : in std_logic_vector(0 downto 0);
        A_RXDFETAP11HOLD     : in std_logic_vector(0 downto 0);
        A_RXDFETAP11OVRDEN   : in std_logic_vector(0 downto 0);
        A_RXDFETAP12HOLD     : in std_logic_vector(0 downto 0);
        A_RXDFETAP12OVRDEN   : in std_logic_vector(0 downto 0);
        A_RXDFETAP13HOLD     : in std_logic_vector(0 downto 0);
        A_RXDFETAP13OVRDEN   : in std_logic_vector(0 downto 0);
        A_RXDFETAP14HOLD     : in std_logic_vector(0 downto 0);
        A_RXDFETAP14OVRDEN   : in std_logic_vector(0 downto 0);
        A_RXDFETAP15HOLD     : in std_logic_vector(0 downto 0);
        A_RXDFETAP15OVRDEN   : in std_logic_vector(0 downto 0);
        A_RXDFETAP2HOLD      : in std_logic_vector(0 downto 0);
        A_RXDFETAP2OVRDEN    : in std_logic_vector(0 downto 0);
        A_RXDFETAP3HOLD      : in std_logic_vector(0 downto 0);
        A_RXDFETAP3OVRDEN    : in std_logic_vector(0 downto 0);
        A_RXDFETAP4HOLD      : in std_logic_vector(0 downto 0);
        A_RXDFETAP4OVRDEN    : in std_logic_vector(0 downto 0);
        A_RXDFETAP5HOLD      : in std_logic_vector(0 downto 0);
        A_RXDFETAP5OVRDEN    : in std_logic_vector(0 downto 0);
        A_RXDFETAP6HOLD      : in std_logic_vector(0 downto 0);
        A_RXDFETAP6OVRDEN    : in std_logic_vector(0 downto 0);
        A_RXDFETAP7HOLD      : in std_logic_vector(0 downto 0);
        A_RXDFETAP7OVRDEN    : in std_logic_vector(0 downto 0);
        A_RXDFETAP8HOLD      : in std_logic_vector(0 downto 0);
        A_RXDFETAP8OVRDEN    : in std_logic_vector(0 downto 0);
        A_RXDFETAP9HOLD      : in std_logic_vector(0 downto 0);
        A_RXDFETAP9OVRDEN    : in std_logic_vector(0 downto 0);
        A_RXDFEUTHOLD        : in std_logic_vector(0 downto 0);
        A_RXDFEUTOVRDEN      : in std_logic_vector(0 downto 0);
        A_RXDFEVPHOLD        : in std_logic_vector(0 downto 0);
        A_RXDFEVPOVRDEN      : in std_logic_vector(0 downto 0);
        A_RXDFEVSEN          : in std_logic_vector(0 downto 0);
        A_RXDFEXYDEN         : in std_logic_vector(0 downto 0);
        A_RXDLYBYPASS        : in std_logic_vector(0 downto 0);
        A_RXDLYEN            : in std_logic_vector(0 downto 0);
        A_RXDLYOVRDEN        : in std_logic_vector(0 downto 0);
        A_RXDLYSRESET        : in std_logic_vector(0 downto 0);
        A_RXLPMEN            : in std_logic_vector(0 downto 0);
        A_RXLPMHFHOLD        : in std_logic_vector(0 downto 0);
        A_RXLPMHFOVRDEN      : in std_logic_vector(0 downto 0);
        A_RXLPMLFHOLD        : in std_logic_vector(0 downto 0);
        A_RXLPMLFKLOVRDEN    : in std_logic_vector(0 downto 0);
        A_RXMONITORSEL       : in std_logic_vector(1 downto 0);
        A_RXOOBRESET         : in std_logic_vector(0 downto 0);
        A_RXOSCALRESET       : in std_logic_vector(0 downto 0);
        A_RXOSHOLD           : in std_logic_vector(0 downto 0);
        A_RXOSOVRDEN         : in std_logic_vector(0 downto 0);
        A_RXOUTCLKSEL        : in std_logic_vector(127 downto 0);
        A_RXPCSRESET         : in std_logic_vector(0 downto 0);
        A_RXPD               : in std_logic_vector(23 downto 0);
        A_RXPHALIGN          : in std_logic_vector(0 downto 0);
        A_RXPHALIGNEN        : in std_logic_vector(0 downto 0);
        A_RXPHDLYPD          : in std_logic_vector(0 downto 0);
        A_RXPHDLYRESET       : in std_logic_vector(0 downto 0);
        A_RXPHOVRDEN         : in std_logic_vector(0 downto 0);
        A_RXPLLCLKSEL        : in std_logic_vector(63 downto 0);
        A_RXPMARESET         : in std_logic_vector(0 downto 0);
        A_RXPOLARITY         : in std_logic_vector(0 downto 0);
        A_RXPRBSCNTRESET     : in std_logic_vector(0 downto 0);
        A_RXPRBSSEL          : in std_logic_vector(47 downto 0);
        A_RXPROGDIVRESET     : in std_logic_vector(0 downto 0);
        A_RXSYSCLKSEL        : in std_logic_vector(87 downto 0);
        A_TXBUFDIFFCTRL      : in std_logic_vector(2 downto 0);
        A_TXDEEMPH           : in std_logic_vector(0 downto 0);
        A_TXDIFFCTRL         : in std_logic_vector(4 downto 0);
        A_TXDLYBYPASS        : in std_logic_vector(0 downto 0);
        A_TXDLYEN            : in std_logic_vector(0 downto 0);
        A_TXDLYOVRDEN        : in std_logic_vector(0 downto 0);
        A_TXDLYSRESET        : in std_logic_vector(0 downto 0);
        A_TXELECIDLE         : in std_logic_vector(0 downto 0);
        A_TXINHIBIT          : in std_logic_vector(0 downto 0);
        A_TXMAINCURSOR       : in std_logic_vector(6 downto 0);
        A_TXMARGIN           : in std_logic_vector(2 downto 0);
        A_TXOUTCLKSEL        : in std_logic_vector(127 downto 0);
        A_TXPCSRESET         : in std_logic_vector(0 downto 0);
        A_TXPD               : in std_logic_vector(23 downto 0);
        A_TXPHALIGN          : in std_logic_vector(0 downto 0);
        A_TXPHALIGNEN        : in std_logic_vector(0 downto 0);
        A_TXPHDLYPD          : in std_logic_vector(0 downto 0);
        A_TXPHDLYRESET       : in std_logic_vector(0 downto 0);
        A_TXPHINIT           : in std_logic_vector(0 downto 0);
        A_TXPHOVRDEN         : in std_logic_vector(0 downto 0);
        A_TXPIPPMOVRDEN      : in std_logic_vector(0 downto 0);
        A_TXPIPPMPD          : in std_logic_vector(0 downto 0);
        A_TXPIPPMSEL         : in std_logic_vector(0 downto 0);
        A_TXPLLCLKSEL        : in std_logic_vector(63 downto 0);
        A_TXPMARESET         : in std_logic_vector(0 downto 0);
        A_TXPOLARITY         : in std_logic_vector(0 downto 0);
        A_TXPOSTCURSOR       : in std_logic_vector(4 downto 0);
        A_TXPRBSFORCEERR     : in std_logic_vector(0 downto 0);
        A_TXPRBSSEL          : in std_logic_vector(95 downto 0);
        A_TXPRECURSOR        : in std_logic_vector(4 downto 0);
        A_TXPROGDIVRESET     : in std_logic_vector(0 downto 0);
        A_TXSWING            : in std_logic_vector(0 downto 0);
        A_TXSYSCLKSEL        : in std_logic_vector(87 downto 0);
        CAPBYPASS_FORCE      : in std_logic_vector(0 downto 0);
        CBCC_DATA_SOURCE_SEL : in std_logic_vector(55 downto 0);
        CDR_SWAP_MODE_EN     : in std_logic_vector(0 downto 0);
        CHAN_BOND_KEEP_ALIGN : in std_logic_vector(39 downto 0);
        CHAN_BOND_MAX_SKEW   : in std_logic_vector(3 downto 0);
        CHAN_BOND_SEQ_1_1    : in std_logic_vector(9 downto 0);
        CHAN_BOND_SEQ_1_2    : in std_logic_vector(9 downto 0);
        CHAN_BOND_SEQ_1_3    : in std_logic_vector(9 downto 0);
        CHAN_BOND_SEQ_1_4    : in std_logic_vector(9 downto 0);
        CHAN_BOND_SEQ_1_ENABLE : in std_logic_vector(3 downto 0);
        CHAN_BOND_SEQ_2_1    : in std_logic_vector(9 downto 0);
        CHAN_BOND_SEQ_2_2    : in std_logic_vector(9 downto 0);
        CHAN_BOND_SEQ_2_3    : in std_logic_vector(9 downto 0);
        CHAN_BOND_SEQ_2_4    : in std_logic_vector(9 downto 0);
        CHAN_BOND_SEQ_2_ENABLE : in std_logic_vector(3 downto 0);
        CHAN_BOND_SEQ_2_USE  : in std_logic_vector(39 downto 0);
        CHAN_BOND_SEQ_LEN    : in std_logic_vector(2 downto 0);
        CH_HSPMUX            : in std_logic_vector(15 downto 0);
        CKCAL1_CFG_0         : in std_logic_vector(15 downto 0);
        CKCAL1_CFG_1         : in std_logic_vector(15 downto 0);
        CKCAL1_CFG_2         : in std_logic_vector(15 downto 0);
        CKCAL1_CFG_3         : in std_logic_vector(15 downto 0);
        CKCAL2_CFG_0         : in std_logic_vector(15 downto 0);
        CKCAL2_CFG_1         : in std_logic_vector(15 downto 0);
        CKCAL2_CFG_2         : in std_logic_vector(15 downto 0);
        CKCAL2_CFG_3         : in std_logic_vector(15 downto 0);
        CKCAL2_CFG_4         : in std_logic_vector(15 downto 0);
        CKCAL_RSVD0          : in std_logic_vector(15 downto 0);
        CKCAL_RSVD1          : in std_logic_vector(15 downto 0);
        CLK_CORRECT_USE      : in std_logic_vector(39 downto 0);
        CLK_COR_KEEP_IDLE    : in std_logic_vector(39 downto 0);
        CLK_COR_MAX_LAT      : in std_logic_vector(5 downto 0);
        CLK_COR_MIN_LAT      : in std_logic_vector(5 downto 0);
        CLK_COR_PRECEDENCE   : in std_logic_vector(39 downto 0);
        CLK_COR_REPEAT_WAIT  : in std_logic_vector(4 downto 0);
        CLK_COR_SEQ_1_1      : in std_logic_vector(9 downto 0);
        CLK_COR_SEQ_1_2      : in std_logic_vector(9 downto 0);
        CLK_COR_SEQ_1_3      : in std_logic_vector(9 downto 0);
        CLK_COR_SEQ_1_4      : in std_logic_vector(9 downto 0);
        CLK_COR_SEQ_1_ENABLE : in std_logic_vector(3 downto 0);
        CLK_COR_SEQ_2_1      : in std_logic_vector(9 downto 0);
        CLK_COR_SEQ_2_2      : in std_logic_vector(9 downto 0);
        CLK_COR_SEQ_2_3      : in std_logic_vector(9 downto 0);
        CLK_COR_SEQ_2_4      : in std_logic_vector(9 downto 0);
        CLK_COR_SEQ_2_ENABLE : in std_logic_vector(3 downto 0);
        CLK_COR_SEQ_2_USE    : in std_logic_vector(39 downto 0);
        CLK_COR_SEQ_LEN      : in std_logic_vector(2 downto 0);
        CPLL_CFG0            : in std_logic_vector(15 downto 0);
        CPLL_CFG1            : in std_logic_vector(15 downto 0);
        CPLL_CFG2            : in std_logic_vector(15 downto 0);
        CPLL_CFG3            : in std_logic_vector(5 downto 0);
        CPLL_FBDIV           : in std_logic_vector(4 downto 0);
        CPLL_FBDIV_45        : in std_logic_vector(2 downto 0);
        CPLL_INIT_CFG0       : in std_logic_vector(15 downto 0);
        CPLL_INIT_CFG1       : in std_logic_vector(7 downto 0);
        CPLL_LOCK_CFG        : in std_logic_vector(15 downto 0);
        CPLL_REFCLK_DIV      : in std_logic_vector(4 downto 0);
        CTLE3_OCAP_EXT_CTRL  : in std_logic_vector(2 downto 0);
        CTLE3_OCAP_EXT_EN    : in std_logic_vector(0 downto 0);
        DDI_CTRL             : in std_logic_vector(1 downto 0);
        DDI_REALIGN_WAIT     : in std_logic_vector(4 downto 0);
        DEC_MCOMMA_DETECT    : in std_logic_vector(39 downto 0);
        DEC_PCOMMA_DETECT    : in std_logic_vector(39 downto 0);
        DEC_VALID_COMMA_ONLY : in std_logic_vector(39 downto 0);
        DFE_D_X_REL_POS      : in std_logic_vector(0 downto 0);
        DFE_VCM_COMP_EN      : in std_logic_vector(0 downto 0);
        DMONITOR_CFG0        : in std_logic_vector(9 downto 0);
        DMONITOR_CFG1        : in std_logic_vector(7 downto 0);
        ES_CLK_PHASE_SEL     : in std_logic_vector(0 downto 0);
        ES_CONTROL           : in std_logic_vector(5 downto 0);
        ES_ERRDET_EN         : in std_logic_vector(39 downto 0);
        ES_EYE_SCAN_EN       : in std_logic_vector(39 downto 0);
        ES_HORZ_OFFSET       : in std_logic_vector(11 downto 0);
        ES_PMA_CFG           : in std_logic_vector(9 downto 0);
        ES_PRESCALE          : in std_logic_vector(4 downto 0);
        ES_QUALIFIER0        : in std_logic_vector(15 downto 0);
        ES_QUALIFIER1        : in std_logic_vector(15 downto 0);
        ES_QUALIFIER2        : in std_logic_vector(15 downto 0);
        ES_QUALIFIER3        : in std_logic_vector(15 downto 0);
        ES_QUALIFIER4        : in std_logic_vector(15 downto 0);
        ES_QUALIFIER5        : in std_logic_vector(15 downto 0);
        ES_QUALIFIER6        : in std_logic_vector(15 downto 0);
        ES_QUALIFIER7        : in std_logic_vector(15 downto 0);
        ES_QUALIFIER8        : in std_logic_vector(15 downto 0);
        ES_QUALIFIER9        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK0        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK1        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK2        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK3        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK4        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK5        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK6        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK7        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK8        : in std_logic_vector(15 downto 0);
        ES_QUAL_MASK9        : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK0       : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK1       : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK2       : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK3       : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK4       : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK5       : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK6       : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK7       : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK8       : in std_logic_vector(15 downto 0);
        ES_SDATA_MASK9       : in std_logic_vector(15 downto 0);
        EVODD_PHI_CFG        : in std_logic_vector(10 downto 0);
        EYE_SCAN_SWAP_EN     : in std_logic_vector(0 downto 0);
        FTS_DESKEW_SEQ_ENABLE : in std_logic_vector(3 downto 0);
        FTS_LANE_DESKEW_CFG  : in std_logic_vector(3 downto 0);
        FTS_LANE_DESKEW_EN   : in std_logic_vector(39 downto 0);
        GEARBOX_MODE         : in std_logic_vector(4 downto 0);
        GEN_RXUSRCLK         : in std_logic_vector(39 downto 0);
        GEN_TXUSRCLK         : in std_logic_vector(39 downto 0);
        GM_BIAS_SELECT       : in std_logic_vector(0 downto 0);
        GT_INSTANTIATED      : in std_logic_vector(0 downto 0);
        ISCAN_CK_PH_SEL2     : in std_logic_vector(0 downto 0);
        LOCAL_MASTER         : in std_logic_vector(0 downto 0);
        LOOP0_CFG            : in std_logic_vector(15 downto 0);
        LOOP10_CFG           : in std_logic_vector(15 downto 0);
        LOOP11_CFG           : in std_logic_vector(15 downto 0);
        LOOP12_CFG           : in std_logic_vector(15 downto 0);
        LOOP13_CFG           : in std_logic_vector(15 downto 0);
        LOOP1_CFG            : in std_logic_vector(15 downto 0);
        LOOP2_CFG            : in std_logic_vector(15 downto 0);
        LOOP3_CFG            : in std_logic_vector(15 downto 0);
        LOOP4_CFG            : in std_logic_vector(15 downto 0);
        LOOP5_CFG            : in std_logic_vector(15 downto 0);
        LOOP6_CFG            : in std_logic_vector(15 downto 0);
        LOOP7_CFG            : in std_logic_vector(15 downto 0);
        LOOP8_CFG            : in std_logic_vector(15 downto 0);
        LOOP9_CFG            : in std_logic_vector(15 downto 0);
        LPBK_BIAS_CTRL       : in std_logic_vector(2 downto 0);
        LPBK_EN_RCAL_B       : in std_logic_vector(0 downto 0);
        LPBK_EXT_RCAL        : in std_logic_vector(3 downto 0);
        LPBK_RG_CTRL         : in std_logic_vector(3 downto 0);
        OOBDIVCTL            : in std_logic_vector(1 downto 0);
        OOB_PWRUP            : in std_logic_vector(0 downto 0);
        PCI3_AUTO_REALIGN    : in std_logic_vector(79 downto 0);
        PCI3_PIPE_RX_ELECIDLE : in std_logic_vector(0 downto 0);
        PCI3_RX_ASYNC_EBUF_BYPASS : in std_logic_vector(1 downto 0);
        PCI3_RX_ELECIDLE_EI2_ENABLE : in std_logic_vector(0 downto 0);
        PCI3_RX_ELECIDLE_H2L_COUNT : in std_logic_vector(5 downto 0);
        PCI3_RX_ELECIDLE_H2L_DISABLE : in std_logic_vector(2 downto 0);
        PCI3_RX_ELECIDLE_HI_COUNT : in std_logic_vector(5 downto 0);
        PCI3_RX_ELECIDLE_LP4_DISABLE : in std_logic_vector(0 downto 0);
        PCI3_RX_FIFO_DISABLE : in std_logic_vector(0 downto 0);
        PCIE_BUFG_DIV_CTRL   : in std_logic_vector(15 downto 0);
        PCIE_RXPCS_CFG_GEN3  : in std_logic_vector(15 downto 0);
        PCIE_RXPMA_CFG       : in std_logic_vector(15 downto 0);
        PCIE_TXPCS_CFG_GEN3  : in std_logic_vector(15 downto 0);
        PCIE_TXPMA_CFG       : in std_logic_vector(15 downto 0);
        PCS_PCIE_EN          : in std_logic_vector(39 downto 0);
        PCS_RSVD0            : in std_logic_vector(15 downto 0);
        PCS_RSVD1            : in std_logic_vector(2 downto 0);
        PD_TRANS_TIME_FROM_P2 : in std_logic_vector(11 downto 0);
        PD_TRANS_TIME_NONE_P2 : in std_logic_vector(7 downto 0);
        PD_TRANS_TIME_TO_P2  : in std_logic_vector(7 downto 0);
        PLL_SEL_MODE_GEN12   : in std_logic_vector(1 downto 0);
        PLL_SEL_MODE_GEN3    : in std_logic_vector(1 downto 0);
        PMA_RSV0             : in std_logic_vector(15 downto 0);
        PMA_RSV1             : in std_logic_vector(15 downto 0);
        PREIQ_FREQ_BST       : in std_logic_vector(1 downto 0);
        PROCESS_PAR          : in std_logic_vector(2 downto 0);
        RATE_SW_USE_DRP      : in std_logic_vector(0 downto 0);
        RESET_POWERSAVE_DISABLE : in std_logic_vector(0 downto 0);
        RXBUFRESET_TIME      : in std_logic_vector(4 downto 0);
        RXBUF_ADDR_MODE      : in std_logic_vector(31 downto 0);
        RXBUF_EIDLE_HI_CNT   : in std_logic_vector(3 downto 0);
        RXBUF_EIDLE_LO_CNT   : in std_logic_vector(3 downto 0);
        RXBUF_EN             : in std_logic_vector(39 downto 0);
        RXBUF_RESET_ON_CB_CHANGE : in std_logic_vector(39 downto 0);
        RXBUF_RESET_ON_COMMAALIGN : in std_logic_vector(39 downto 0);
        RXBUF_RESET_ON_EIDLE : in std_logic_vector(39 downto 0);
        RXBUF_RESET_ON_RATE_CHANGE : in std_logic_vector(39 downto 0);
        RXBUF_THRESH_OVFLW   : in std_logic_vector(5 downto 0);
        RXBUF_THRESH_OVRD    : in std_logic_vector(39 downto 0);
        RXBUF_THRESH_UNDFLW  : in std_logic_vector(5 downto 0);
        RXCDRFREQRESET_TIME  : in std_logic_vector(4 downto 0);
        RXCDRPHRESET_TIME    : in std_logic_vector(4 downto 0);
        RXCDR_CFG0           : in std_logic_vector(15 downto 0);
        RXCDR_CFG0_GEN3      : in std_logic_vector(15 downto 0);
        RXCDR_CFG1           : in std_logic_vector(15 downto 0);
        RXCDR_CFG1_GEN3      : in std_logic_vector(15 downto 0);
        RXCDR_CFG2           : in std_logic_vector(15 downto 0);
        RXCDR_CFG2_GEN3      : in std_logic_vector(15 downto 0);
        RXCDR_CFG3           : in std_logic_vector(15 downto 0);
        RXCDR_CFG3_GEN3      : in std_logic_vector(15 downto 0);
        RXCDR_CFG4           : in std_logic_vector(15 downto 0);
        RXCDR_CFG4_GEN3      : in std_logic_vector(15 downto 0);
        RXCDR_CFG5           : in std_logic_vector(15 downto 0);
        RXCDR_CFG5_GEN3      : in std_logic_vector(15 downto 0);
        RXCDR_FR_RESET_ON_EIDLE : in std_logic_vector(0 downto 0);
        RXCDR_HOLD_DURING_EIDLE : in std_logic_vector(0 downto 0);
        RXCDR_LOCK_CFG0      : in std_logic_vector(15 downto 0);
        RXCDR_LOCK_CFG1      : in std_logic_vector(15 downto 0);
        RXCDR_LOCK_CFG2      : in std_logic_vector(15 downto 0);
        RXCDR_LOCK_CFG3      : in std_logic_vector(15 downto 0);
        RXCDR_PH_RESET_ON_EIDLE : in std_logic_vector(0 downto 0);
        RXCFOKDONE_SRC       : in std_logic_vector(1 downto 0);
        RXCFOK_CFG0          : in std_logic_vector(15 downto 0);
        RXCFOK_CFG1          : in std_logic_vector(15 downto 0);
        RXCFOK_CFG2          : in std_logic_vector(15 downto 0);
        RXDFELPMRESET_TIME   : in std_logic_vector(6 downto 0);
        RXDFELPM_KL_CFG0     : in std_logic_vector(15 downto 0);
        RXDFELPM_KL_CFG1     : in std_logic_vector(15 downto 0);
        RXDFELPM_KL_CFG2     : in std_logic_vector(15 downto 0);
        RXDFE_CFG0           : in std_logic_vector(15 downto 0);
        RXDFE_CFG1           : in std_logic_vector(15 downto 0);
        RXDFE_GC_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_GC_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_GC_CFG2        : in std_logic_vector(15 downto 0);
        RXDFE_H2_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_H2_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_H3_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_H3_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_H4_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_H4_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_H5_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_H5_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_H6_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_H6_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_H7_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_H7_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_H8_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_H8_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_H9_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_H9_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_HA_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_HA_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_HB_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_HB_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_HC_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_HC_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_HD_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_HD_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_HE_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_HE_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_HF_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_HF_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_OS_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_OS_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_PWR_SAVING     : in std_logic_vector(0 downto 0);
        RXDFE_UT_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_UT_CFG1        : in std_logic_vector(15 downto 0);
        RXDFE_VP_CFG0        : in std_logic_vector(15 downto 0);
        RXDFE_VP_CFG1        : in std_logic_vector(15 downto 0);
        RXDLY_CFG            : in std_logic_vector(15 downto 0);
        RXDLY_LCFG           : in std_logic_vector(15 downto 0);
        RXELECIDLE_CFG       : in std_logic_vector(71 downto 0);
        RXGBOX_FIFO_INIT_RD_ADDR : in std_logic_vector(2 downto 0);
        RXGEARBOX_EN         : in std_logic_vector(39 downto 0);
        RXISCANRESET_TIME    : in std_logic_vector(4 downto 0);
        RXLPM_CFG            : in std_logic_vector(15 downto 0);
        RXLPM_GC_CFG         : in std_logic_vector(15 downto 0);
        RXLPM_KH_CFG0        : in std_logic_vector(15 downto 0);
        RXLPM_KH_CFG1        : in std_logic_vector(15 downto 0);
        RXLPM_OS_CFG0        : in std_logic_vector(15 downto 0);
        RXLPM_OS_CFG1        : in std_logic_vector(15 downto 0);
        RXOOB_CFG            : in std_logic_vector(8 downto 0);
        RXOOB_CLK_CFG        : in std_logic_vector(47 downto 0);
        RXOSCALRESET_TIME    : in std_logic_vector(4 downto 0);
        RXOUT_DIV            : in std_logic_vector(5 downto 0);
        RXPCSRESET_TIME      : in std_logic_vector(4 downto 0);
        RXPHBEACON_CFG       : in std_logic_vector(15 downto 0);
        RXPHDLY_CFG          : in std_logic_vector(15 downto 0);
        RXPHSAMP_CFG         : in std_logic_vector(15 downto 0);
        RXPHSLIP_CFG         : in std_logic_vector(15 downto 0);
        RXPH_MONITOR_SEL     : in std_logic_vector(4 downto 0);
        RXPI_AUTO_BW_SEL_BYPASS : in std_logic_vector(0 downto 0);
        RXPI_CFG             : in std_logic_vector(15 downto 0);
        RXPI_LPM             : in std_logic_vector(0 downto 0);
        RXPI_RSV0            : in std_logic_vector(15 downto 0);
        RXPI_SEL_LC          : in std_logic_vector(1 downto 0);
        RXPI_STARTCODE       : in std_logic_vector(1 downto 0);
        RXPI_VREFSEL         : in std_logic_vector(0 downto 0);
        RXPLL_SEL            : in std_logic_vector(39 downto 0);
        RXPMACLK_SEL         : in std_logic_vector(63 downto 0);
        RXPMARESET_TIME      : in std_logic_vector(4 downto 0);
        RXPRBS_ERR_LOOPBACK  : in std_logic_vector(0 downto 0);
        RXPRBS_LINKACQ_CNT   : in std_logic_vector(7 downto 0);
        RXSLIDE_AUTO_WAIT    : in std_logic_vector(3 downto 0);
        RXSLIDE_MODE         : in std_logic_vector(31 downto 0);
        RXSYNC_MULTILANE     : in std_logic_vector(0 downto 0);
        RXSYNC_OVRD          : in std_logic_vector(0 downto 0);
        RXSYNC_SKIP_DA       : in std_logic_vector(0 downto 0);
        RX_AFE_CM_EN         : in std_logic_vector(0 downto 0);
        RX_BIAS_CFG0         : in std_logic_vector(15 downto 0);
        RX_BUFFER_CFG        : in std_logic_vector(5 downto 0);
        RX_CAPFF_SARC_ENB    : in std_logic_vector(0 downto 0);
        RX_CLK25_DIV         : in std_logic_vector(5 downto 0);
        RX_CLKMUX_EN         : in std_logic_vector(0 downto 0);
        RX_CLK_SLIP_OVRD     : in std_logic_vector(4 downto 0);
        RX_CM_BUF_CFG        : in std_logic_vector(3 downto 0);
        RX_CM_BUF_PD         : in std_logic_vector(0 downto 0);
        RX_CM_SEL            : in std_logic_vector(1 downto 0);
        RX_CM_TRIM           : in std_logic_vector(3 downto 0);
        RX_CTLE1_KHKL        : in std_logic_vector(0 downto 0);
        RX_CTLE2_KHKL        : in std_logic_vector(0 downto 0);
        RX_CTLE3_AGC         : in std_logic_vector(0 downto 0);
        RX_DATA_WIDTH        : in std_logic_vector(7 downto 0);
        RX_DDI_SEL           : in std_logic_vector(5 downto 0);
        RX_DEFER_RESET_BUF_EN : in std_logic_vector(39 downto 0);
        RX_DEGEN_CTRL        : in std_logic_vector(2 downto 0);
        RX_DFELPM_CFG0       : in std_logic_vector(2 downto 0);
        RX_DFELPM_CFG1       : in std_logic_vector(0 downto 0);
        RX_DFELPM_KLKH_AGC_STUP_EN : in std_logic_vector(0 downto 0);
        RX_DFE_AGC_CFG0      : in std_logic_vector(1 downto 0);
        RX_DFE_AGC_CFG1      : in std_logic_vector(2 downto 0);
        RX_DFE_KL_LPM_KH_CFG0 : in std_logic_vector(1 downto 0);
        RX_DFE_KL_LPM_KH_CFG1 : in std_logic_vector(2 downto 0);
        RX_DFE_KL_LPM_KL_CFG0 : in std_logic_vector(1 downto 0);
        RX_DFE_KL_LPM_KL_CFG1 : in std_logic_vector(2 downto 0);
        RX_DFE_LPM_HOLD_DURING_EIDLE : in std_logic_vector(0 downto 0);
        RX_DISPERR_SEQ_MATCH : in std_logic_vector(39 downto 0);
        RX_DIV2_MODE_B       : in std_logic_vector(0 downto 0);
        RX_DIVRESET_TIME     : in std_logic_vector(4 downto 0);
        RX_EN_CTLE_RCAL_B    : in std_logic_vector(0 downto 0);
        RX_EN_HI_LR          : in std_logic_vector(0 downto 0);
        RX_EXT_RL_CTRL       : in std_logic_vector(8 downto 0);
        RX_EYESCAN_VS_CODE   : in std_logic_vector(6 downto 0);
        RX_EYESCAN_VS_NEG_DIR : in std_logic_vector(0 downto 0);
        RX_EYESCAN_VS_RANGE  : in std_logic_vector(1 downto 0);
        RX_EYESCAN_VS_UT_SIGN : in std_logic_vector(0 downto 0);
        RX_FABINT_USRCLK_FLOP : in std_logic_vector(0 downto 0);
        RX_INT_DATAWIDTH     : in std_logic_vector(1 downto 0);
        RX_PMA_POWER_SAVE    : in std_logic_vector(0 downto 0);
        RX_PROGDIV_CFG       : in std_logic_vector(63 downto 0);
        RX_PROGDIV_RATE      : in std_logic_vector(15 downto 0);
        RX_RESLOAD_CTRL      : in std_logic_vector(3 downto 0);
        RX_RESLOAD_OVRD      : in std_logic_vector(0 downto 0);
        RX_SAMPLE_PERIOD     : in std_logic_vector(2 downto 0);
        RX_SIG_VALID_DLY     : in std_logic_vector(5 downto 0);
        RX_SUM_DFETAPREP_EN  : in std_logic_vector(0 downto 0);
        RX_SUM_IREF_TUNE     : in std_logic_vector(3 downto 0);
        RX_SUM_VCMTUNE       : in std_logic_vector(3 downto 0);
        RX_SUM_VCM_OVWR      : in std_logic_vector(0 downto 0);
        RX_SUM_VREF_TUNE     : in std_logic_vector(2 downto 0);
        RX_TUNE_AFE_OS       : in std_logic_vector(1 downto 0);
        RX_VREG_CTRL         : in std_logic_vector(2 downto 0);
        RX_VREG_PDB          : in std_logic_vector(0 downto 0);
        RX_WIDEMODE_CDR      : in std_logic_vector(1 downto 0);
        RX_XCLK_SEL          : in std_logic_vector(39 downto 0);
        RX_XMODE_SEL         : in std_logic_vector(0 downto 0);
        SAS_MAX_COM          : in std_logic_vector(6 downto 0);
        SAS_MIN_COM          : in std_logic_vector(5 downto 0);
        SATA_BURST_SEQ_LEN   : in std_logic_vector(3 downto 0);
        SATA_BURST_VAL       : in std_logic_vector(2 downto 0);
        SATA_CPLL_CFG        : in std_logic_vector(87 downto 0);
        SATA_EIDLE_VAL       : in std_logic_vector(2 downto 0);
        SATA_MAX_BURST       : in std_logic_vector(5 downto 0);
        SATA_MAX_INIT        : in std_logic_vector(5 downto 0);
        SATA_MAX_WAKE        : in std_logic_vector(5 downto 0);
        SATA_MIN_BURST       : in std_logic_vector(5 downto 0);
        SATA_MIN_INIT        : in std_logic_vector(5 downto 0);
        SATA_MIN_WAKE        : in std_logic_vector(5 downto 0);
        SHOW_REALIGN_COMMA   : in std_logic_vector(39 downto 0);
        TAPDLY_SET_TX        : in std_logic_vector(1 downto 0);
        TEMPERATURE_PAR      : in std_logic_vector(3 downto 0);
        TERM_RCAL_CFG        : in std_logic_vector(14 downto 0);
        TERM_RCAL_OVRD       : in std_logic_vector(2 downto 0);
        TRANS_TIME_RATE      : in std_logic_vector(7 downto 0);
        TST_RSV0             : in std_logic_vector(7 downto 0);
        TST_RSV1             : in std_logic_vector(7 downto 0);
        TXBUF_EN             : in std_logic_vector(39 downto 0);
        TXBUF_RESET_ON_RATE_CHANGE : in std_logic_vector(39 downto 0);
        TXDLY_CFG            : in std_logic_vector(15 downto 0);
        TXDLY_LCFG           : in std_logic_vector(15 downto 0);
        TXFIFO_ADDR_CFG      : in std_logic_vector(31 downto 0);
        TXGBOX_FIFO_INIT_RD_ADDR : in std_logic_vector(2 downto 0);
        TXGEARBOX_EN         : in std_logic_vector(39 downto 0);
        TXOUTCLKPCS_SEL      : in std_logic_vector(0 downto 0);
        TXOUT_DIV            : in std_logic_vector(5 downto 0);
        TXPCSRESET_TIME      : in std_logic_vector(4 downto 0);
        TXPHDLY_CFG0         : in std_logic_vector(15 downto 0);
        TXPHDLY_CFG1         : in std_logic_vector(15 downto 0);
        TXPH_CFG             : in std_logic_vector(15 downto 0);
        TXPH_CFG2            : in std_logic_vector(15 downto 0);
        TXPH_MONITOR_SEL     : in std_logic_vector(4 downto 0);
        TXPI_CFG0            : in std_logic_vector(1 downto 0);
        TXPI_CFG1            : in std_logic_vector(1 downto 0);
        TXPI_CFG2            : in std_logic_vector(1 downto 0);
        TXPI_CFG3            : in std_logic_vector(0 downto 0);
        TXPI_CFG4            : in std_logic_vector(0 downto 0);
        TXPI_CFG5            : in std_logic_vector(2 downto 0);
        TXPI_GRAY_SEL        : in std_logic_vector(0 downto 0);
        TXPI_INVSTROBE_SEL   : in std_logic_vector(0 downto 0);
        TXPI_LPM             : in std_logic_vector(0 downto 0);
        TXPI_PPMCLK_SEL      : in std_logic_vector(71 downto 0);
        TXPI_PPM_CFG         : in std_logic_vector(7 downto 0);
        TXPI_RSV0            : in std_logic_vector(15 downto 0);
        TXPI_SYNFREQ_PPM     : in std_logic_vector(2 downto 0);
        TXPI_VREFSEL         : in std_logic_vector(0 downto 0);
        TXPMARESET_TIME      : in std_logic_vector(4 downto 0);
        TXSYNC_MULTILANE     : in std_logic_vector(0 downto 0);
        TXSYNC_OVRD          : in std_logic_vector(0 downto 0);
        TXSYNC_SKIP_DA       : in std_logic_vector(0 downto 0);
        TX_CLK25_DIV         : in std_logic_vector(5 downto 0);
        TX_CLKMUX_EN         : in std_logic_vector(0 downto 0);
        TX_CLKREG_PDB        : in std_logic_vector(0 downto 0);
        TX_CLKREG_SET        : in std_logic_vector(2 downto 0);
        TX_DATA_WIDTH        : in std_logic_vector(7 downto 0);
        TX_DCD_CFG           : in std_logic_vector(5 downto 0);
        TX_DCD_EN            : in std_logic_vector(0 downto 0);
        TX_DEEMPH0           : in std_logic_vector(5 downto 0);
        TX_DEEMPH1           : in std_logic_vector(5 downto 0);
        TX_DIVRESET_TIME     : in std_logic_vector(4 downto 0);
        TX_DRIVE_MODE        : in std_logic_vector(63 downto 0);
        TX_DRVMUX_CTRL       : in std_logic_vector(1 downto 0);
        TX_EIDLE_ASSERT_DELAY : in std_logic_vector(2 downto 0);
        TX_EIDLE_DEASSERT_DELAY : in std_logic_vector(2 downto 0);
        TX_EML_PHI_TUNE      : in std_logic_vector(0 downto 0);
        TX_FABINT_USRCLK_FLOP : in std_logic_vector(0 downto 0);
        TX_FIFO_BYP_EN       : in std_logic_vector(0 downto 0);
        TX_IDLE_DATA_ZERO    : in std_logic_vector(0 downto 0);
        TX_INT_DATAWIDTH     : in std_logic_vector(1 downto 0);
        TX_LOOPBACK_DRIVE_HIZ : in std_logic_vector(39 downto 0);
        TX_MAINCURSOR_SEL    : in std_logic_vector(0 downto 0);
        TX_MARGIN_FULL_0     : in std_logic_vector(6 downto 0);
        TX_MARGIN_FULL_1     : in std_logic_vector(6 downto 0);
        TX_MARGIN_FULL_2     : in std_logic_vector(6 downto 0);
        TX_MARGIN_FULL_3     : in std_logic_vector(6 downto 0);
        TX_MARGIN_FULL_4     : in std_logic_vector(6 downto 0);
        TX_MARGIN_LOW_0      : in std_logic_vector(6 downto 0);
        TX_MARGIN_LOW_1      : in std_logic_vector(6 downto 0);
        TX_MARGIN_LOW_2      : in std_logic_vector(6 downto 0);
        TX_MARGIN_LOW_3      : in std_logic_vector(6 downto 0);
        TX_MARGIN_LOW_4      : in std_logic_vector(6 downto 0);
        TX_MODE_SEL          : in std_logic_vector(2 downto 0);
        TX_PHICAL_CFG0       : in std_logic_vector(15 downto 0);
        TX_PHICAL_CFG1       : in std_logic_vector(15 downto 0);
        TX_PHICAL_CFG2       : in std_logic_vector(15 downto 0);
        TX_PI_BIASSET        : in std_logic_vector(1 downto 0);
        TX_PI_CFG0           : in std_logic_vector(15 downto 0);
        TX_PI_CFG1           : in std_logic_vector(15 downto 0);
        TX_PI_DIV2_MODE_B    : in std_logic_vector(0 downto 0);
        TX_PI_SEL_QPLL0      : in std_logic_vector(0 downto 0);
        TX_PI_SEL_QPLL1      : in std_logic_vector(0 downto 0);
        TX_PMADATA_OPT       : in std_logic_vector(0 downto 0);
        TX_PMA_POWER_SAVE    : in std_logic_vector(0 downto 0);
        TX_PREDRV_CTRL       : in std_logic_vector(1 downto 0);
        TX_PROGCLK_SEL       : in std_logic_vector(47 downto 0);
        TX_PROGDIV_CFG       : in std_logic_vector(63 downto 0);
        TX_PROGDIV_RATE      : in std_logic_vector(15 downto 0);
        TX_RXDETECT_CFG      : in std_logic_vector(13 downto 0);
        TX_RXDETECT_REF      : in std_logic_vector(2 downto 0);
        TX_SAMPLE_PERIOD     : in std_logic_vector(2 downto 0);
        TX_SARC_LPBK_ENB     : in std_logic_vector(0 downto 0);
        TX_USERPATTERN_DATA0 : in std_logic_vector(9 downto 0);
        TX_USERPATTERN_DATA1 : in std_logic_vector(9 downto 0);
        TX_USERPATTERN_DATA2 : in std_logic_vector(9 downto 0);
        TX_USERPATTERN_DATA3 : in std_logic_vector(9 downto 0);
        TX_USERPATTERN_DATA4 : in std_logic_vector(9 downto 0);
        TX_USERPATTERN_DATA5 : in std_logic_vector(9 downto 0);
        TX_USERPATTERN_DATA6 : in std_logic_vector(9 downto 0);
        TX_USERPATTERN_DATA7 : in std_logic_vector(9 downto 0);
        TX_XCLK_SEL          : in std_logic_vector(39 downto 0);
        USE_PCS_CLK_PHASE_SEL : in std_logic_vector(0 downto 0);
        BUFGTCE              : out std_logic_vector(2 downto 0);
        BUFGTCEMASK          : out std_logic_vector(2 downto 0);
        BUFGTDIV             : out std_logic_vector(8 downto 0);
        BUFGTRESET           : out std_logic_vector(2 downto 0);
        BUFGTRSTMASK         : out std_logic_vector(2 downto 0);
        CPLLFBCLKLOST        : out std_ulogic;
        CPLLLOCK             : out std_ulogic;
        CPLLREFCLKLOST       : out std_ulogic;
        DMONITOROUT          : out std_logic_vector(16 downto 0);
        DRPDO                : out std_logic_vector(15 downto 0);
        DRPRDY               : out std_ulogic;
        EYESCANDATAERROR     : out std_ulogic;
        GTPOWERGOOD          : out std_ulogic;
        GTREFCLKMONITOR      : out std_ulogic;
        GTYTXN               : out std_ulogic;
        GTYTXP               : out std_ulogic;
        PCIERATEGEN3         : out std_ulogic;
        PCIERATEIDLE         : out std_ulogic;
        PCIERATEQPLLPD       : out std_logic_vector(1 downto 0);
        PCIERATEQPLLRESET    : out std_logic_vector(1 downto 0);
        PCIESYNCTXSYNCDONE   : out std_ulogic;
        PCIEUSERGEN3RDY      : out std_ulogic;
        PCIEUSERPHYSTATUSRST : out std_ulogic;
        PCIEUSERRATESTART    : out std_ulogic;
        PCSRSVDOUT           : out std_logic_vector(15 downto 0);
        PHYSTATUS            : out std_ulogic;
        PINRSRVDAS           : out std_logic_vector(7 downto 0);
        PMASCANOUT           : out std_logic_vector(11 downto 0);
        RESETEXCEPTION       : out std_ulogic;
        RXBUFSTATUS          : out std_logic_vector(2 downto 0);
        RXBYTEISALIGNED      : out std_ulogic;
        RXBYTEREALIGN        : out std_ulogic;
        RXCDRLOCK            : out std_ulogic;
        RXCDRPHDONE          : out std_ulogic;
        RXCHANBONDSEQ        : out std_ulogic;
        RXCHANISALIGNED      : out std_ulogic;
        RXCHANREALIGN        : out std_ulogic;
        RXCHBONDO            : out std_logic_vector(4 downto 0);
        RXCKCALDONE          : out std_ulogic;
        RXCLKCORCNT          : out std_logic_vector(1 downto 0);
        RXCOMINITDET         : out std_ulogic;
        RXCOMMADET           : out std_ulogic;
        RXCOMSASDET          : out std_ulogic;
        RXCOMWAKEDET         : out std_ulogic;
        RXCTRL0              : out std_logic_vector(15 downto 0);
        RXCTRL1              : out std_logic_vector(15 downto 0);
        RXCTRL2              : out std_logic_vector(7 downto 0);
        RXCTRL3              : out std_logic_vector(7 downto 0);
        RXDATA               : out std_logic_vector(127 downto 0);
        RXDATAEXTENDRSVD     : out std_logic_vector(7 downto 0);
        RXDATAVALID          : out std_logic_vector(1 downto 0);
        RXDLYSRESETDONE      : out std_ulogic;
        RXELECIDLE           : out std_ulogic;
        RXHEADER             : out std_logic_vector(5 downto 0);
        RXHEADERVALID        : out std_logic_vector(1 downto 0);
        RXMONITOROUT         : out std_logic_vector(6 downto 0);
        RXOSINTDONE          : out std_ulogic;
        RXOSINTSTARTED       : out std_ulogic;
        RXOSINTSTROBEDONE    : out std_ulogic;
        RXOSINTSTROBESTARTED : out std_ulogic;
        RXOUTCLK             : out std_ulogic;
        RXOUTCLKFABRIC       : out std_ulogic;
        RXOUTCLKPCS          : out std_ulogic;
        RXPHALIGNDONE        : out std_ulogic;
        RXPHALIGNERR         : out std_ulogic;
        RXPMARESETDONE       : out std_ulogic;
        RXPRBSERR            : out std_ulogic;
        RXPRBSLOCKED         : out std_ulogic;
        RXPRGDIVRESETDONE    : out std_ulogic;
        RXRATEDONE           : out std_ulogic;
        RXRECCLKOUT          : out std_ulogic;
        RXRESETDONE          : out std_ulogic;
        RXSLIDERDY           : out std_ulogic;
        RXSLIPDONE           : out std_ulogic;
        RXSLIPOUTCLKRDY      : out std_ulogic;
        RXSLIPPMARDY         : out std_ulogic;
        RXSTARTOFSEQ         : out std_logic_vector(1 downto 0);
        RXSTATUS             : out std_logic_vector(2 downto 0);
        RXSYNCDONE           : out std_ulogic;
        RXSYNCOUT            : out std_ulogic;
        RXVALID              : out std_ulogic;
        SCANOUT              : out std_logic_vector(18 downto 0);
        TXBUFSTATUS          : out std_logic_vector(1 downto 0);
        TXCOMFINISH          : out std_ulogic;
        TXDCCDONE            : out std_ulogic;
        TXDLYSRESETDONE      : out std_ulogic;
        TXOUTCLK             : out std_ulogic;
        TXOUTCLKFABRIC       : out std_ulogic;
        TXOUTCLKPCS          : out std_ulogic;
        TXPHALIGNDONE        : out std_ulogic;
        TXPHINITDONE         : out std_ulogic;
        TXPMARESETDONE       : out std_ulogic;
        TXPRGDIVRESETDONE    : out std_ulogic;
        TXRATEDONE           : out std_ulogic;
        TXRESETDONE          : out std_ulogic;
        TXSYNCDONE           : out std_ulogic;
        TXSYNCOUT            : out std_ulogic;
        CDRSTEPDIR           : in std_ulogic;
        CDRSTEPSQ            : in std_ulogic;
        CDRSTEPSX            : in std_ulogic;
        CFGRESET             : in std_ulogic;
        CLKRSVD0             : in std_ulogic;
        CLKRSVD1             : in std_ulogic;
        CPLLLOCKDETCLK       : in std_ulogic;
        CPLLLOCKEN           : in std_ulogic;
        CPLLPD               : in std_ulogic;
        CPLLREFCLKSEL        : in std_logic_vector(2 downto 0);
        CPLLRESET            : in std_ulogic;
        DMONFIFORESET        : in std_ulogic;
        DMONITORCLK          : in std_ulogic;
        DRPADDR              : in std_logic_vector(9 downto 0);
        DRPCLK               : in std_ulogic;
        DRPDI                : in std_logic_vector(15 downto 0);
        DRPEN                : in std_ulogic;
        DRPWE                : in std_ulogic;
        ELPCALDVORWREN       : in std_ulogic;
        ELPCALPAORWREN       : in std_ulogic;
        EVODDPHICALDONE      : in std_ulogic;
        EVODDPHICALSTART     : in std_ulogic;
        EVODDPHIDRDEN        : in std_ulogic;
        EVODDPHIDWREN        : in std_ulogic;
        EVODDPHIXRDEN        : in std_ulogic;
        EVODDPHIXWREN        : in std_ulogic;
        EYESCANMODE          : in std_ulogic;
        EYESCANRESET         : in std_ulogic;
        EYESCANTRIGGER       : in std_ulogic;
        GTGREFCLK            : in std_ulogic;
        GTNORTHREFCLK0       : in std_ulogic;
        GTNORTHREFCLK1       : in std_ulogic;
        GTREFCLK0            : in std_ulogic;
        GTREFCLK1            : in std_ulogic;
        GTRESETSEL           : in std_ulogic;
        GTRSVD               : in std_logic_vector(15 downto 0);
        GTRXRESET            : in std_ulogic;
        GTSOUTHREFCLK0       : in std_ulogic;
        GTSOUTHREFCLK1       : in std_ulogic;
        GTTXRESET            : in std_ulogic;
        GTYRXN               : in std_ulogic;
        GTYRXP               : in std_ulogic;
        LOOPBACK             : in std_logic_vector(2 downto 0);
        LOOPRSVD             : in std_logic_vector(15 downto 0);
        LPBKRXTXSEREN        : in std_ulogic;
        LPBKTXRXSEREN        : in std_ulogic;
        PCIEEQRXEQADAPTDONE  : in std_ulogic;
        PCIERSTIDLE          : in std_ulogic;
        PCIERSTTXSYNCSTART   : in std_ulogic;
        PCIEUSERRATEDONE     : in std_ulogic;
        PCSRSVDIN            : in std_logic_vector(15 downto 0);
        PCSRSVDIN2           : in std_logic_vector(4 downto 0);
        PMARSVDIN            : in std_logic_vector(4 downto 0);
        PMASCANCLK0          : in std_ulogic;
        PMASCANCLK1          : in std_ulogic;
        PMASCANCLK2          : in std_ulogic;
        PMASCANCLK3          : in std_ulogic;
        PMASCANCLK4          : in std_ulogic;
        PMASCANCLK5          : in std_ulogic;
        PMASCANENB           : in std_ulogic;
        PMASCANIN            : in std_logic_vector(11 downto 0);
        PMASCANMODEB         : in std_ulogic;
        PMASCANRSTEN         : in std_ulogic;
        QPLL0CLK             : in std_ulogic;
        QPLL0REFCLK          : in std_ulogic;
        QPLL1CLK             : in std_ulogic;
        QPLL1REFCLK          : in std_ulogic;
        RESETOVRD            : in std_ulogic;
        RSTCLKENTX           : in std_ulogic;
        RX8B10BEN            : in std_ulogic;
        RXBUFRESET           : in std_ulogic;
        RXCDRFREQRESET       : in std_ulogic;
        RXCDRHOLD            : in std_ulogic;
        RXCDROVRDEN          : in std_ulogic;
        RXCDRRESET           : in std_ulogic;
        RXCDRRESETRSV        : in std_ulogic;
        RXCHBONDEN           : in std_ulogic;
        RXCHBONDI            : in std_logic_vector(4 downto 0);
        RXCHBONDLEVEL        : in std_logic_vector(2 downto 0);
        RXCHBONDMASTER       : in std_ulogic;
        RXCHBONDSLAVE        : in std_ulogic;
        RXCKCALRESET         : in std_ulogic;
        RXCOMMADETEN         : in std_ulogic;
        RXDCCFORCESTART      : in std_ulogic;
        RXDFEAGCHOLD         : in std_ulogic;
        RXDFEAGCOVRDEN       : in std_ulogic;
        RXDFELFHOLD          : in std_ulogic;
        RXDFELFOVRDEN        : in std_ulogic;
        RXDFELPMRESET        : in std_ulogic;
        RXDFETAP10HOLD       : in std_ulogic;
        RXDFETAP10OVRDEN     : in std_ulogic;
        RXDFETAP11HOLD       : in std_ulogic;
        RXDFETAP11OVRDEN     : in std_ulogic;
        RXDFETAP12HOLD       : in std_ulogic;
        RXDFETAP12OVRDEN     : in std_ulogic;
        RXDFETAP13HOLD       : in std_ulogic;
        RXDFETAP13OVRDEN     : in std_ulogic;
        RXDFETAP14HOLD       : in std_ulogic;
        RXDFETAP14OVRDEN     : in std_ulogic;
        RXDFETAP15HOLD       : in std_ulogic;
        RXDFETAP15OVRDEN     : in std_ulogic;
        RXDFETAP2HOLD        : in std_ulogic;
        RXDFETAP2OVRDEN      : in std_ulogic;
        RXDFETAP3HOLD        : in std_ulogic;
        RXDFETAP3OVRDEN      : in std_ulogic;
        RXDFETAP4HOLD        : in std_ulogic;
        RXDFETAP4OVRDEN      : in std_ulogic;
        RXDFETAP5HOLD        : in std_ulogic;
        RXDFETAP5OVRDEN      : in std_ulogic;
        RXDFETAP6HOLD        : in std_ulogic;
        RXDFETAP6OVRDEN      : in std_ulogic;
        RXDFETAP7HOLD        : in std_ulogic;
        RXDFETAP7OVRDEN      : in std_ulogic;
        RXDFETAP8HOLD        : in std_ulogic;
        RXDFETAP8OVRDEN      : in std_ulogic;
        RXDFETAP9HOLD        : in std_ulogic;
        RXDFETAP9OVRDEN      : in std_ulogic;
        RXDFEUTHOLD          : in std_ulogic;
        RXDFEUTOVRDEN        : in std_ulogic;
        RXDFEVPHOLD          : in std_ulogic;
        RXDFEVPOVRDEN        : in std_ulogic;
        RXDFEVSEN            : in std_ulogic;
        RXDFEXYDEN           : in std_ulogic;
        RXDLYBYPASS          : in std_ulogic;
        RXDLYEN              : in std_ulogic;
        RXDLYOVRDEN          : in std_ulogic;
        RXDLYSRESET          : in std_ulogic;
        RXELECIDLEMODE       : in std_logic_vector(1 downto 0);
        RXGEARBOXSLIP        : in std_ulogic;
        RXLATCLK             : in std_ulogic;
        RXLPMEN              : in std_ulogic;
        RXLPMGCHOLD          : in std_ulogic;
        RXLPMGCOVRDEN        : in std_ulogic;
        RXLPMHFHOLD          : in std_ulogic;
        RXLPMHFOVRDEN        : in std_ulogic;
        RXLPMLFHOLD          : in std_ulogic;
        RXLPMLFKLOVRDEN      : in std_ulogic;
        RXLPMOSHOLD          : in std_ulogic;
        RXLPMOSOVRDEN        : in std_ulogic;
        RXMCOMMAALIGNEN      : in std_ulogic;
        RXMONITORSEL         : in std_logic_vector(1 downto 0);
        RXOOBRESET           : in std_ulogic;
        RXOSCALRESET         : in std_ulogic;
        RXOSHOLD             : in std_ulogic;
        RXOSINTCFG           : in std_logic_vector(3 downto 0);
        RXOSINTEN            : in std_ulogic;
        RXOSINTHOLD          : in std_ulogic;
        RXOSINTOVRDEN        : in std_ulogic;
        RXOSINTSTROBE        : in std_ulogic;
        RXOSINTTESTOVRDEN    : in std_ulogic;
        RXOSOVRDEN           : in std_ulogic;
        RXOUTCLKSEL          : in std_logic_vector(2 downto 0);
        RXPCOMMAALIGNEN      : in std_ulogic;
        RXPCSRESET           : in std_ulogic;
        RXPD                 : in std_logic_vector(1 downto 0);
        RXPHALIGN            : in std_ulogic;
        RXPHALIGNEN          : in std_ulogic;
        RXPHDLYPD            : in std_ulogic;
        RXPHDLYRESET         : in std_ulogic;
        RXPHOVRDEN           : in std_ulogic;
        RXPLLCLKSEL          : in std_logic_vector(1 downto 0);
        RXPMARESET           : in std_ulogic;
        RXPOLARITY           : in std_ulogic;
        RXPRBSCNTRESET       : in std_ulogic;
        RXPRBSSEL            : in std_logic_vector(3 downto 0);
        RXPROGDIVRESET       : in std_ulogic;
        RXRATE               : in std_logic_vector(2 downto 0);
        RXRATEMODE           : in std_ulogic;
        RXSLIDE              : in std_ulogic;
        RXSLIPOUTCLK         : in std_ulogic;
        RXSLIPPMA            : in std_ulogic;
        RXSYNCALLIN          : in std_ulogic;
        RXSYNCIN             : in std_ulogic;
        RXSYNCMODE           : in std_ulogic;
        RXSYSCLKSEL          : in std_logic_vector(1 downto 0);
        RXUSERRDY            : in std_ulogic;
        RXUSRCLK             : in std_ulogic;
        RXUSRCLK2            : in std_ulogic;
        SARCCLK              : in std_ulogic;
        SCANCLK              : in std_ulogic;
        SCANENB              : in std_ulogic;
        SCANIN               : in std_logic_vector(18 downto 0);
        SCANMODEB            : in std_ulogic;
        SIGVALIDCLK          : in std_ulogic;
        TSTCLK0              : in std_ulogic;
        TSTCLK1              : in std_ulogic;
        TSTIN                : in std_logic_vector(19 downto 0);
        TSTPD                : in std_logic_vector(4 downto 0);
        TSTPDOVRDB           : in std_ulogic;
        TX8B10BBYPASS        : in std_logic_vector(7 downto 0);
        TX8B10BEN            : in std_ulogic;
        TXBUFDIFFCTRL        : in std_logic_vector(2 downto 0);
        TXCOMINIT            : in std_ulogic;
        TXCOMSAS             : in std_ulogic;
        TXCOMWAKE            : in std_ulogic;
        TXCTRL0              : in std_logic_vector(15 downto 0);
        TXCTRL1              : in std_logic_vector(15 downto 0);
        TXCTRL2              : in std_logic_vector(7 downto 0);
        TXDATA               : in std_logic_vector(127 downto 0);
        TXDATAEXTENDRSVD     : in std_logic_vector(7 downto 0);
        TXDCCFORCESTART      : in std_ulogic;
        TXDCCRESET           : in std_ulogic;
        TXDEEMPH             : in std_ulogic;
        TXDETECTRX           : in std_ulogic;
        TXDIFFCTRL           : in std_logic_vector(4 downto 0);
        TXDIFFPD             : in std_ulogic;
        TXDLYBYPASS          : in std_ulogic;
        TXDLYEN              : in std_ulogic;
        TXDLYHOLD            : in std_ulogic;
        TXDLYOVRDEN          : in std_ulogic;
        TXDLYSRESET          : in std_ulogic;
        TXDLYUPDOWN          : in std_ulogic;
        TXELECIDLE           : in std_ulogic;
        TXELFORCESTART       : in std_ulogic;
        TXHEADER             : in std_logic_vector(5 downto 0);
        TXINHIBIT            : in std_ulogic;
        TXLATCLK             : in std_ulogic;
        TXMAINCURSOR         : in std_logic_vector(6 downto 0);
        TXMARGIN             : in std_logic_vector(2 downto 0);
        TXOUTCLKSEL          : in std_logic_vector(2 downto 0);
        TXPCSRESET           : in std_ulogic;
        TXPD                 : in std_logic_vector(1 downto 0);
        TXPDELECIDLEMODE     : in std_ulogic;
        TXPHALIGN            : in std_ulogic;
        TXPHALIGNEN          : in std_ulogic;
        TXPHDLYPD            : in std_ulogic;
        TXPHDLYRESET         : in std_ulogic;
        TXPHDLYTSTCLK        : in std_ulogic;
        TXPHINIT             : in std_ulogic;
        TXPHOVRDEN           : in std_ulogic;
        TXPIPPMEN            : in std_ulogic;
        TXPIPPMOVRDEN        : in std_ulogic;
        TXPIPPMPD            : in std_ulogic;
        TXPIPPMSEL           : in std_ulogic;
        TXPIPPMSTEPSIZE      : in std_logic_vector(4 downto 0);
        TXPISOPD             : in std_ulogic;
        TXPLLCLKSEL          : in std_logic_vector(1 downto 0);
        TXPMARESET           : in std_ulogic;
        TXPOLARITY           : in std_ulogic;
        TXPOSTCURSOR         : in std_logic_vector(4 downto 0);
        TXPRBSFORCEERR       : in std_ulogic;
        TXPRBSSEL            : in std_logic_vector(3 downto 0);
        TXPRECURSOR          : in std_logic_vector(4 downto 0);
        TXPROGDIVRESET       : in std_ulogic;
        TXRATE               : in std_logic_vector(2 downto 0);
        TXRATEMODE           : in std_ulogic;
        TXSEQUENCE           : in std_logic_vector(6 downto 0);
        TXSWING              : in std_ulogic;
        TXSYNCALLIN          : in std_ulogic;
        TXSYNCIN             : in std_ulogic;
        TXSYNCMODE           : in std_ulogic;
        TXSYSCLKSEL          : in std_logic_vector(1 downto 0);
        TXUSERRDY            : in std_ulogic;
        TXUSRCLK             : in std_ulogic;
        TXUSRCLK2            : in std_ulogic;
        GSR                  : in std_ulogic
      );
    end component;
    
    constant MODULE_NAME : string := "GTYE3_CHANNEL";
    constant IN_DELAY : time := 0 ps;
    constant OUT_DELAY : time := 0 ps;
    constant INCLK_DELAY : time := 0 ps;
    constant OUTCLK_DELAY : time := 0 ps;

  FUNCTION conv_string_to_slv(s: string; size: IN INTEGER) RETURN std_logic_vector IS
    CONSTANT ss: string(s'length downto 1) := s;
    VARIABLE y: std_logic_vector(size-1 downto 0) := (others => '0');
    VARIABLE p: integer;
  --- Variable to hold each character's ASCII code
    VARIABLE c: integer;
  BEGIN
    FOR i IN ss'RANGE LOOP --- scan the characters
      p := 8*i;
      c := character'pos(ss(i)); --- get the character's ASCII code
      y(p-1 downto p-8) := std_logic_vector(to_unsigned(c,8));
    end loop;
    return y;
  END conv_string_to_slv;

    -- Convert generic to signal
    constant ALIGN_COMMA_DOUBLE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(ALIGN_COMMA_DOUBLE,40);
    constant ALIGN_MCOMMA_DET_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(ALIGN_MCOMMA_DET,40);
    constant ALIGN_PCOMMA_DET_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(ALIGN_PCOMMA_DET,40);
    constant A_LOOPBACK_REG : std_logic_vector(79 downto 0) := conv_string_to_slv("NoLoopBack",80);
    constant A_RXOUTCLKSEL_REG : std_logic_vector(127 downto 0) := conv_string_to_slv("Disabled",128);
    constant A_RXPD_REG : std_logic_vector(23 downto 0) := conv_string_to_slv("P0",24);
    constant A_RXPLLCLKSEL_REG : std_logic_vector(63 downto 0) := conv_string_to_slv("CPLLCLK",64);
    constant A_RXPRBSSEL_REG : std_logic_vector(47 downto 0) := conv_string_to_slv("PRBS7",48);
    constant A_RXSYSCLKSEL_REG : std_logic_vector(87 downto 0) := conv_string_to_slv("CPLLREFCLK",88);
    constant A_TXOUTCLKSEL_REG : std_logic_vector(127 downto 0) := conv_string_to_slv("Disabled",128);
    constant A_TXPD_REG : std_logic_vector(23 downto 0) := conv_string_to_slv("P0",24);
    constant A_TXPLLCLKSEL_REG : std_logic_vector(63 downto 0) := conv_string_to_slv("CPLLCLK",64);
    constant A_TXPRBSSEL_REG : std_logic_vector(95 downto 0) := conv_string_to_slv("PRBS7",96);
    constant A_TXSYSCLKSEL_REG : std_logic_vector(87 downto 0) := conv_string_to_slv("CPLLREFCLK",88);
    constant CBCC_DATA_SOURCE_SEL_REG : std_logic_vector(55 downto 0) := conv_string_to_slv(CBCC_DATA_SOURCE_SEL,56);
    constant CHAN_BOND_KEEP_ALIGN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(CHAN_BOND_KEEP_ALIGN,40);
    constant CHAN_BOND_SEQ_2_USE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(CHAN_BOND_SEQ_2_USE,40);
    constant CLK_CORRECT_USE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(CLK_CORRECT_USE,40);
    constant CLK_COR_KEEP_IDLE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(CLK_COR_KEEP_IDLE,40);
    constant CLK_COR_PRECEDENCE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(CLK_COR_PRECEDENCE,40);
    constant CLK_COR_SEQ_2_USE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(CLK_COR_SEQ_2_USE,40);
    constant DEC_MCOMMA_DETECT_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(DEC_MCOMMA_DETECT,40);
    constant DEC_PCOMMA_DETECT_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(DEC_PCOMMA_DETECT,40);
    constant DEC_VALID_COMMA_ONLY_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(DEC_VALID_COMMA_ONLY,40);
    constant ES_ERRDET_EN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(ES_ERRDET_EN,40);
    constant ES_EYE_SCAN_EN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(ES_EYE_SCAN_EN,40);
    constant FTS_LANE_DESKEW_EN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(FTS_LANE_DESKEW_EN,40);
    constant GEN_RXUSRCLK_REG : std_logic_vector(39 downto 0) := conv_string_to_slv("TRUE",40);
    constant GEN_TXUSRCLK_REG : std_logic_vector(39 downto 0) := conv_string_to_slv("TRUE",40);
    constant PCI3_AUTO_REALIGN_REG : std_logic_vector(79 downto 0) := conv_string_to_slv(PCI3_AUTO_REALIGN,80);
    constant PCS_PCIE_EN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(PCS_PCIE_EN,40);
    constant RXBUF_ADDR_MODE_REG : std_logic_vector(31 downto 0) := conv_string_to_slv(RXBUF_ADDR_MODE,32);
    constant RXBUF_EN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RXBUF_EN,40);
    constant RXBUF_RESET_ON_CB_CHANGE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RXBUF_RESET_ON_CB_CHANGE,40);
    constant RXBUF_RESET_ON_COMMAALIGN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RXBUF_RESET_ON_COMMAALIGN,40);
    constant RXBUF_RESET_ON_EIDLE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RXBUF_RESET_ON_EIDLE,40);
    constant RXBUF_RESET_ON_RATE_CHANGE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RXBUF_RESET_ON_RATE_CHANGE,40);
    constant RXBUF_THRESH_OVRD_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RXBUF_THRESH_OVRD,40);
    constant RXELECIDLE_CFG_REG : std_logic_vector(71 downto 0) := conv_string_to_slv(RXELECIDLE_CFG,72);
    constant RXGEARBOX_EN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RXGEARBOX_EN,40);
    constant RXOOB_CLK_CFG_REG : std_logic_vector(47 downto 0) := conv_string_to_slv(RXOOB_CLK_CFG,48);
    constant RXPLL_SEL_REG : std_logic_vector(39 downto 0) := conv_string_to_slv("CPLL",40);
    constant RXPMACLK_SEL_REG : std_logic_vector(63 downto 0) := conv_string_to_slv(RXPMACLK_SEL,64);
    constant RXSLIDE_MODE_REG : std_logic_vector(31 downto 0) := conv_string_to_slv(RXSLIDE_MODE,32);
    constant RX_DEFER_RESET_BUF_EN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RX_DEFER_RESET_BUF_EN,40);
    constant RX_DISPERR_SEQ_MATCH_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RX_DISPERR_SEQ_MATCH,40);
    constant RX_XCLK_SEL_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(RX_XCLK_SEL,40);
    constant SATA_CPLL_CFG_REG : std_logic_vector(87 downto 0) := conv_string_to_slv(SATA_CPLL_CFG,88);
    constant SHOW_REALIGN_COMMA_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(SHOW_REALIGN_COMMA,40);
    constant TXBUF_EN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(TXBUF_EN,40);
    constant TXBUF_RESET_ON_RATE_CHANGE_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(TXBUF_RESET_ON_RATE_CHANGE,40);
    constant TXFIFO_ADDR_CFG_REG : std_logic_vector(31 downto 0) := conv_string_to_slv(TXFIFO_ADDR_CFG,32);
    constant TXGEARBOX_EN_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(TXGEARBOX_EN,40);
    constant TXPI_PPMCLK_SEL_REG : std_logic_vector(71 downto 0) := conv_string_to_slv(TXPI_PPMCLK_SEL,72);
    constant TX_DRIVE_MODE_REG : std_logic_vector(63 downto 0) := conv_string_to_slv(TX_DRIVE_MODE,64);
    constant TX_LOOPBACK_DRIVE_HIZ_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(TX_LOOPBACK_DRIVE_HIZ,40);
    constant TX_PROGCLK_SEL_REG : std_logic_vector(47 downto 0) := conv_string_to_slv(TX_PROGCLK_SEL,48);
    constant TX_XCLK_SEL_REG : std_logic_vector(39 downto 0) := conv_string_to_slv(TX_XCLK_SEL,40);
    
    constant ACJTAG_DEBUG_MODE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(ACJTAG_DEBUG_MODE));
    constant ACJTAG_MODE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(ACJTAG_MODE));
    constant ACJTAG_RESET_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(ACJTAG_RESET));
    constant ADAPT_CFG0_REG : std_logic_vector(15 downto 0) := ADAPT_CFG0;
    constant ADAPT_CFG1_REG : std_logic_vector(15 downto 0) := ADAPT_CFG1;
    constant ADAPT_CFG2_REG : std_logic_vector(15 downto 0) := ADAPT_CFG2;
    constant AEN_CDRSTEPSEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_CPLL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_ELPCAL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_EYESCAN_REG : std_logic_vector(0 downto 0) := (0=>'1');
    constant AEN_LOOPBACK_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_MASTER_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_MUXDCD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_PD_AND_EIDLE_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_POLARITY_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_PRBS_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RXCDR_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RXDFELPM_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RXDFE_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RXOUTCLK_SEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RXPHDLY_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RXPLLCLK_SEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RXSYSCLK_SEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_TXOUTCLK_SEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_TXPHDLY_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_TXPI_PPM_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_TXPLLCLK_SEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_TXSYSCLK_SEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_TX_DRIVE_MODE_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant ALIGN_COMMA_ENABLE_REG : std_logic_vector(9 downto 0) := ALIGN_COMMA_ENABLE;
    constant ALIGN_COMMA_WORD_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(ALIGN_COMMA_WORD,3));
    constant ALIGN_MCOMMA_VALUE_REG : std_logic_vector(9 downto 0) := ALIGN_MCOMMA_VALUE;
    constant ALIGN_PCOMMA_VALUE_REG : std_logic_vector(9 downto 0) := ALIGN_PCOMMA_VALUE;
    constant AMONITOR_CFG_REG : std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(1,10));
    constant AUTO_BW_SEL_BYPASS_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(AUTO_BW_SEL_BYPASS));
    constant A_AFECFOKEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_CPLLLOCKEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_CPLLPD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_CPLLRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_DFECFOKFCDAC_REG : std_logic_vector(5 downto 0) := "000000";
    constant A_DFECFOKFCNUM_REG : std_logic_vector(3 downto 0) := "0000";
    constant A_DFECFOKFPULSE_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_DFECFOKHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_DFECFOKOVREN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_ELPCALDVORWREN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_ELPCALPAORWREN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_EYESCANMODE_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_EYESCANRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_GTRESETSEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_GTRXRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_GTTXRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_LPMGCHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_LPMGCOVREN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_LPMOSHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_LPMOSOVREN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_MUXDCDEXHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_MUXDCDORWREN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXBUFRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXCDRFREQRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXCDRHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXCDROVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXCDRRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFEAGCHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFEAGCOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFECFOKFEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFELFHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFELFOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFELPMRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP10HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP10OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP11HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP11OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP12HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP12OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP13HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP13OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP14HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP14OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP15HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP15OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP2HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP2OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP3HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP3OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP4HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP4OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP5HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP5OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP6HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP6OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP7HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP7OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP8HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP8OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP9HOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFETAP9OVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFEUTHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFEUTOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFEVPHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFEVPOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFEVSEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDFEXYDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDLYBYPASS_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDLYEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDLYOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXDLYSRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXLPMEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXLPMHFHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXLPMHFOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXLPMLFHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXLPMLFKLOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXMONITORSEL_REG : std_logic_vector(1 downto 0) := "00";
    constant A_RXOOBRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXOSCALRESET_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(A_RXOSCALRESET));
    constant A_RXOSHOLD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXOSOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPCSRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPHALIGNEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPHALIGN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPHDLYPD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPHDLYRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPHOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPMARESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPOLARITY_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPRBSCNTRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_RXPROGDIVRESET_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(A_RXPROGDIVRESET));
    constant A_TXBUFDIFFCTRL_REG : std_logic_vector(2 downto 0) := "100";
    constant A_TXDEEMPH_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXDIFFCTRL_REG : std_logic_vector(4 downto 0) := A_TXDIFFCTRL;
    constant A_TXDLYBYPASS_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXDLYEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXDLYOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXDLYSRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXELECIDLE_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXINHIBIT_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXMAINCURSOR_REG : std_logic_vector(6 downto 0) := "0000000";
    constant A_TXMARGIN_REG : std_logic_vector(2 downto 0) := "000";
    constant A_TXPCSRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPHALIGNEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPHALIGN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPHDLYPD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPHDLYRESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPHINIT_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPHOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPIPPMOVRDEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPIPPMPD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPIPPMSEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPMARESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPOLARITY_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPOSTCURSOR_REG : std_logic_vector(4 downto 0) := "00000";
    constant A_TXPRBSFORCEERR_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_TXPRECURSOR_REG : std_logic_vector(4 downto 0) := "00000";
    constant A_TXPROGDIVRESET_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(A_TXPROGDIVRESET));
    constant A_TXSWING_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant CAPBYPASS_FORCE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(CAPBYPASS_FORCE));
    constant CDR_SWAP_MODE_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(CDR_SWAP_MODE_EN));
    constant CHAN_BOND_MAX_SKEW_REG : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(CHAN_BOND_MAX_SKEW,4));
    constant CHAN_BOND_SEQ_1_1_REG : std_logic_vector(9 downto 0) := CHAN_BOND_SEQ_1_1;
    constant CHAN_BOND_SEQ_1_2_REG : std_logic_vector(9 downto 0) := CHAN_BOND_SEQ_1_2;
    constant CHAN_BOND_SEQ_1_3_REG : std_logic_vector(9 downto 0) := CHAN_BOND_SEQ_1_3;
    constant CHAN_BOND_SEQ_1_4_REG : std_logic_vector(9 downto 0) := CHAN_BOND_SEQ_1_4;
    constant CHAN_BOND_SEQ_1_ENABLE_REG : std_logic_vector(3 downto 0) := CHAN_BOND_SEQ_1_ENABLE;
    constant CHAN_BOND_SEQ_2_1_REG : std_logic_vector(9 downto 0) := CHAN_BOND_SEQ_2_1;
    constant CHAN_BOND_SEQ_2_2_REG : std_logic_vector(9 downto 0) := CHAN_BOND_SEQ_2_2;
    constant CHAN_BOND_SEQ_2_3_REG : std_logic_vector(9 downto 0) := CHAN_BOND_SEQ_2_3;
    constant CHAN_BOND_SEQ_2_4_REG : std_logic_vector(9 downto 0) := CHAN_BOND_SEQ_2_4;
    constant CHAN_BOND_SEQ_2_ENABLE_REG : std_logic_vector(3 downto 0) := CHAN_BOND_SEQ_2_ENABLE;
    constant CHAN_BOND_SEQ_LEN_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(CHAN_BOND_SEQ_LEN,3));
    constant CH_HSPMUX_REG : std_logic_vector(15 downto 0) := CH_HSPMUX;
    constant CKCAL1_CFG_0_REG : std_logic_vector(15 downto 0) := CKCAL1_CFG_0;
    constant CKCAL1_CFG_1_REG : std_logic_vector(15 downto 0) := CKCAL1_CFG_1;
    constant CKCAL1_CFG_2_REG : std_logic_vector(15 downto 0) := CKCAL1_CFG_2;
    constant CKCAL1_CFG_3_REG : std_logic_vector(15 downto 0) := CKCAL1_CFG_3;
    constant CKCAL2_CFG_0_REG : std_logic_vector(15 downto 0) := CKCAL2_CFG_0;
    constant CKCAL2_CFG_1_REG : std_logic_vector(15 downto 0) := CKCAL2_CFG_1;
    constant CKCAL2_CFG_2_REG : std_logic_vector(15 downto 0) := CKCAL2_CFG_2;
    constant CKCAL2_CFG_3_REG : std_logic_vector(15 downto 0) := CKCAL2_CFG_3;
    constant CKCAL2_CFG_4_REG : std_logic_vector(15 downto 0) := CKCAL2_CFG_4;
    constant CKCAL_RSVD0_REG : std_logic_vector(15 downto 0) := CKCAL_RSVD0;
    constant CKCAL_RSVD1_REG : std_logic_vector(15 downto 0) := CKCAL_RSVD1;
    constant CLK_COR_MAX_LAT_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(CLK_COR_MAX_LAT,6));
    constant CLK_COR_MIN_LAT_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(CLK_COR_MIN_LAT,6));
    constant CLK_COR_REPEAT_WAIT_REG : std_logic_vector(4 downto 0) := std_logic_vector(to_unsigned(CLK_COR_REPEAT_WAIT,5));
    constant CLK_COR_SEQ_1_1_REG : std_logic_vector(9 downto 0) := CLK_COR_SEQ_1_1;
    constant CLK_COR_SEQ_1_2_REG : std_logic_vector(9 downto 0) := CLK_COR_SEQ_1_2;
    constant CLK_COR_SEQ_1_3_REG : std_logic_vector(9 downto 0) := CLK_COR_SEQ_1_3;
    constant CLK_COR_SEQ_1_4_REG : std_logic_vector(9 downto 0) := CLK_COR_SEQ_1_4;
    constant CLK_COR_SEQ_1_ENABLE_REG : std_logic_vector(3 downto 0) := CLK_COR_SEQ_1_ENABLE;
    constant CLK_COR_SEQ_2_1_REG : std_logic_vector(9 downto 0) := CLK_COR_SEQ_2_1;
    constant CLK_COR_SEQ_2_2_REG : std_logic_vector(9 downto 0) := CLK_COR_SEQ_2_2;
    constant CLK_COR_SEQ_2_3_REG : std_logic_vector(9 downto 0) := CLK_COR_SEQ_2_3;
    constant CLK_COR_SEQ_2_4_REG : std_logic_vector(9 downto 0) := CLK_COR_SEQ_2_4;
    constant CLK_COR_SEQ_2_ENABLE_REG : std_logic_vector(3 downto 0) := CLK_COR_SEQ_2_ENABLE;
    constant CLK_COR_SEQ_LEN_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(CLK_COR_SEQ_LEN,3));
    constant CPLL_CFG0_REG : std_logic_vector(15 downto 0) := CPLL_CFG0;
    constant CPLL_CFG1_REG : std_logic_vector(15 downto 0) := CPLL_CFG1;
    constant CPLL_CFG2_REG : std_logic_vector(15 downto 0) := CPLL_CFG2;
    constant CPLL_CFG3_REG : std_logic_vector(5 downto 0) := CPLL_CFG3;
    constant CPLL_FBDIV_45_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(CPLL_FBDIV_45,3));
    constant CPLL_FBDIV_REG : std_logic_vector(4 downto 0) := std_logic_vector(to_unsigned(CPLL_FBDIV,5));
    constant CPLL_INIT_CFG0_REG : std_logic_vector(15 downto 0) := CPLL_INIT_CFG0;
    constant CPLL_INIT_CFG1_REG : std_logic_vector(7 downto 0) := CPLL_INIT_CFG1;
    constant CPLL_LOCK_CFG_REG : std_logic_vector(15 downto 0) := CPLL_LOCK_CFG;
    constant CPLL_REFCLK_DIV_REG : std_logic_vector(4 downto 0) := std_logic_vector(to_unsigned(CPLL_REFCLK_DIV,5));
    constant CTLE3_OCAP_EXT_CTRL_REG : std_logic_vector(2 downto 0) := CTLE3_OCAP_EXT_CTRL;
    constant CTLE3_OCAP_EXT_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(CTLE3_OCAP_EXT_EN));
    constant DDI_CTRL_REG : std_logic_vector(1 downto 0) := DDI_CTRL;
    constant DDI_REALIGN_WAIT_REG : std_logic_vector(4 downto 0) := std_logic_vector(to_unsigned(DDI_REALIGN_WAIT,5));
    constant DFE_D_X_REL_POS_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(DFE_D_X_REL_POS));
    constant DFE_VCM_COMP_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(DFE_VCM_COMP_EN));
    constant DMONITOR_CFG0_REG : std_logic_vector(9 downto 0) := DMONITOR_CFG0;
    constant DMONITOR_CFG1_REG : std_logic_vector(7 downto 0) := DMONITOR_CFG1;
    constant ES_CLK_PHASE_SEL_REG : std_logic_vector(0 downto 0) :=  (0=>TO_X01(ES_CLK_PHASE_SEL));
    constant ES_CONTROL_REG : std_logic_vector(5 downto 0) := ES_CONTROL;
    constant ES_HORZ_OFFSET_REG : std_logic_vector(11 downto 0) := ES_HORZ_OFFSET;
    constant ES_PMA_CFG_REG : std_logic_vector(9 downto 0) := ES_PMA_CFG;
    constant ES_PRESCALE_REG : std_logic_vector(4 downto 0) := ES_PRESCALE;
    constant ES_QUALIFIER0_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER0;
    constant ES_QUALIFIER1_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER1;
    constant ES_QUALIFIER2_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER2;
    constant ES_QUALIFIER3_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER3;
    constant ES_QUALIFIER4_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER4;
    constant ES_QUALIFIER5_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER5;
    constant ES_QUALIFIER6_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER6;
    constant ES_QUALIFIER7_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER7;
    constant ES_QUALIFIER8_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER8;
    constant ES_QUALIFIER9_REG : std_logic_vector(15 downto 0) := ES_QUALIFIER9;
    constant ES_QUAL_MASK0_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK0;
    constant ES_QUAL_MASK1_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK1;
    constant ES_QUAL_MASK2_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK2;
    constant ES_QUAL_MASK3_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK3;
    constant ES_QUAL_MASK4_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK4;
    constant ES_QUAL_MASK5_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK5;
    constant ES_QUAL_MASK6_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK6;
    constant ES_QUAL_MASK7_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK7;
    constant ES_QUAL_MASK8_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK8;
    constant ES_QUAL_MASK9_REG : std_logic_vector(15 downto 0) := ES_QUAL_MASK9;
    constant ES_SDATA_MASK0_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK0;
    constant ES_SDATA_MASK1_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK1;
    constant ES_SDATA_MASK2_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK2;
    constant ES_SDATA_MASK3_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK3;
    constant ES_SDATA_MASK4_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK4;
    constant ES_SDATA_MASK5_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK5;
    constant ES_SDATA_MASK6_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK6;
    constant ES_SDATA_MASK7_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK7;
    constant ES_SDATA_MASK8_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK8;
    constant ES_SDATA_MASK9_REG : std_logic_vector(15 downto 0) := ES_SDATA_MASK9;
    constant EVODD_PHI_CFG_REG : std_logic_vector(10 downto 0) := EVODD_PHI_CFG;
    constant EYE_SCAN_SWAP_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(EYE_SCAN_SWAP_EN));
    constant FTS_DESKEW_SEQ_ENABLE_REG : std_logic_vector(3 downto 0) := FTS_DESKEW_SEQ_ENABLE;
    constant FTS_LANE_DESKEW_CFG_REG : std_logic_vector(3 downto 0) := FTS_LANE_DESKEW_CFG;
    constant GEARBOX_MODE_REG : std_logic_vector(4 downto 0) := GEARBOX_MODE;
    constant GM_BIAS_SELECT_REG : std_logic_vector(0 downto 0) :=  (0=>TO_X01(GM_BIAS_SELECT));
    constant GT_INSTANTIATED_REG : std_logic_vector(0 downto 0) := "1";
    constant ISCAN_CK_PH_SEL2_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(ISCAN_CK_PH_SEL2));
    constant LOCAL_MASTER_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(LOCAL_MASTER));
    constant LOOP0_CFG_REG : std_logic_vector(15 downto 0) := LOOP0_CFG;
    constant LOOP10_CFG_REG : std_logic_vector(15 downto 0) := LOOP10_CFG;
    constant LOOP11_CFG_REG : std_logic_vector(15 downto 0) := LOOP11_CFG;
    constant LOOP12_CFG_REG : std_logic_vector(15 downto 0) := LOOP12_CFG;
    constant LOOP13_CFG_REG : std_logic_vector(15 downto 0) := LOOP13_CFG;
    constant LOOP1_CFG_REG : std_logic_vector(15 downto 0) := LOOP1_CFG;
    constant LOOP2_CFG_REG : std_logic_vector(15 downto 0) := LOOP2_CFG;
    constant LOOP3_CFG_REG : std_logic_vector(15 downto 0) := LOOP3_CFG;
    constant LOOP4_CFG_REG : std_logic_vector(15 downto 0) := LOOP4_CFG;
    constant LOOP5_CFG_REG : std_logic_vector(15 downto 0) := LOOP5_CFG;
    constant LOOP6_CFG_REG : std_logic_vector(15 downto 0) := LOOP6_CFG;
    constant LOOP7_CFG_REG : std_logic_vector(15 downto 0) := LOOP7_CFG;
    constant LOOP8_CFG_REG : std_logic_vector(15 downto 0) := LOOP8_CFG;
    constant LOOP9_CFG_REG : std_logic_vector(15 downto 0) := LOOP9_CFG;
    constant LPBK_BIAS_CTRL_REG : std_logic_vector(2 downto 0) := LPBK_BIAS_CTRL;
    constant LPBK_EN_RCAL_B_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(LPBK_EN_RCAL_B));
    constant LPBK_EXT_RCAL_REG : std_logic_vector(3 downto 0) := LPBK_EXT_RCAL;
    constant LPBK_RG_CTRL_REG : std_logic_vector(3 downto 0) := LPBK_RG_CTRL;
    constant OOBDIVCTL_REG : std_logic_vector(1 downto 0) := OOBDIVCTL;
    constant OOB_PWRUP_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(OOB_PWRUP));
    constant PCI3_PIPE_RX_ELECIDLE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(PCI3_PIPE_RX_ELECIDLE));
    constant PCI3_RX_ASYNC_EBUF_BYPASS_REG : std_logic_vector(1 downto 0) := PCI3_RX_ASYNC_EBUF_BYPASS;
    constant PCI3_RX_ELECIDLE_EI2_ENABLE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(PCI3_RX_ELECIDLE_EI2_ENABLE));
    constant PCI3_RX_ELECIDLE_H2L_COUNT_REG : std_logic_vector(5 downto 0) := PCI3_RX_ELECIDLE_H2L_COUNT;
    constant PCI3_RX_ELECIDLE_H2L_DISABLE_REG : std_logic_vector(2 downto 0) := PCI3_RX_ELECIDLE_H2L_DISABLE;
    constant PCI3_RX_ELECIDLE_HI_COUNT_REG : std_logic_vector(5 downto 0) := PCI3_RX_ELECIDLE_HI_COUNT;
    constant PCI3_RX_ELECIDLE_LP4_DISABLE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(PCI3_RX_ELECIDLE_LP4_DISABLE));
    constant PCI3_RX_FIFO_DISABLE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(PCI3_RX_FIFO_DISABLE));
    constant PCIE_BUFG_DIV_CTRL_REG : std_logic_vector(15 downto 0) := PCIE_BUFG_DIV_CTRL;
    constant PCIE_RXPCS_CFG_GEN3_REG : std_logic_vector(15 downto 0) := PCIE_RXPCS_CFG_GEN3;
    constant PCIE_RXPMA_CFG_REG : std_logic_vector(15 downto 0) := PCIE_RXPMA_CFG;
    constant PCIE_TXPCS_CFG_GEN3_REG : std_logic_vector(15 downto 0) := PCIE_TXPCS_CFG_GEN3;
    constant PCIE_TXPMA_CFG_REG : std_logic_vector(15 downto 0) := PCIE_TXPMA_CFG;
    constant PCS_RSVD0_REG : std_logic_vector(15 downto 0) := PCS_RSVD0;
    constant PCS_RSVD1_REG : std_logic_vector(2 downto 0) := PCS_RSVD1;
    constant PD_TRANS_TIME_FROM_P2_REG : std_logic_vector(11 downto 0) := PD_TRANS_TIME_FROM_P2;
    constant PD_TRANS_TIME_NONE_P2_REG : std_logic_vector(7 downto 0) := PD_TRANS_TIME_NONE_P2;
    constant PD_TRANS_TIME_TO_P2_REG : std_logic_vector(7 downto 0) := PD_TRANS_TIME_TO_P2;
    constant PLL_SEL_MODE_GEN12_REG : std_logic_vector(1 downto 0) := PLL_SEL_MODE_GEN12;
    constant PLL_SEL_MODE_GEN3_REG : std_logic_vector(1 downto 0) := PLL_SEL_MODE_GEN3;
    constant PMA_RSV0_REG : std_logic_vector(15 downto 0) := PMA_RSV0;
    constant PMA_RSV1_REG : std_logic_vector(15 downto 0) := PMA_RSV1;
    constant PREIQ_FREQ_BST_REG : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(PREIQ_FREQ_BST,2));
    constant PROCESS_PAR_REG : std_logic_vector(2 downto 0) := PROCESS_PAR;
    constant RATE_SW_USE_DRP_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RATE_SW_USE_DRP));
    constant RESET_POWERSAVE_DISABLE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RESET_POWERSAVE_DISABLE));
    constant RXBUFRESET_TIME_REG : std_logic_vector(4 downto 0) := RXBUFRESET_TIME;
    constant RXBUF_EIDLE_HI_CNT_REG : std_logic_vector(3 downto 0) := RXBUF_EIDLE_HI_CNT;
    constant RXBUF_EIDLE_LO_CNT_REG : std_logic_vector(3 downto 0) := RXBUF_EIDLE_LO_CNT;
    constant RXBUF_THRESH_OVFLW_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(RXBUF_THRESH_OVFLW,6));
    constant RXBUF_THRESH_UNDFLW_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(RXBUF_THRESH_UNDFLW,6));
    constant RXCDRFREQRESET_TIME_REG : std_logic_vector(4 downto 0) := RXCDRFREQRESET_TIME;
    constant RXCDRPHRESET_TIME_REG : std_logic_vector(4 downto 0) := RXCDRPHRESET_TIME;
    constant RXCDR_CFG0_GEN3_REG : std_logic_vector(15 downto 0) := RXCDR_CFG0_GEN3;
    constant RXCDR_CFG0_REG : std_logic_vector(15 downto 0) := RXCDR_CFG0;
    constant RXCDR_CFG1_GEN3_REG : std_logic_vector(15 downto 0) := RXCDR_CFG1_GEN3;
    constant RXCDR_CFG1_REG : std_logic_vector(15 downto 0) := RXCDR_CFG1;
    constant RXCDR_CFG2_GEN3_REG : std_logic_vector(15 downto 0) := RXCDR_CFG2_GEN3;
    constant RXCDR_CFG2_REG : std_logic_vector(15 downto 0) := RXCDR_CFG2;
    constant RXCDR_CFG3_GEN3_REG : std_logic_vector(15 downto 0) := RXCDR_CFG3_GEN3;
    constant RXCDR_CFG3_REG : std_logic_vector(15 downto 0) := RXCDR_CFG3;
    constant RXCDR_CFG4_GEN3_REG : std_logic_vector(15 downto 0) := RXCDR_CFG4_GEN3;
    constant RXCDR_CFG4_REG : std_logic_vector(15 downto 0) := RXCDR_CFG4;
    constant RXCDR_CFG5_GEN3_REG : std_logic_vector(15 downto 0) := RXCDR_CFG5_GEN3;
    constant RXCDR_CFG5_REG : std_logic_vector(15 downto 0) := RXCDR_CFG5;
    constant RXCDR_FR_RESET_ON_EIDLE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RXCDR_FR_RESET_ON_EIDLE));
    constant RXCDR_HOLD_DURING_EIDLE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RXCDR_HOLD_DURING_EIDLE));
    constant RXCDR_LOCK_CFG0_REG : std_logic_vector(15 downto 0) := RXCDR_LOCK_CFG0;
    constant RXCDR_LOCK_CFG1_REG : std_logic_vector(15 downto 0) := RXCDR_LOCK_CFG1;
    constant RXCDR_LOCK_CFG2_REG : std_logic_vector(15 downto 0) := RXCDR_LOCK_CFG2;
    constant RXCDR_LOCK_CFG3_REG : std_logic_vector(15 downto 0) := RXCDR_LOCK_CFG3;
    constant RXCDR_PH_RESET_ON_EIDLE_REG : std_logic_vector(0 downto 0) :=  (0=>TO_X01(RXCDR_PH_RESET_ON_EIDLE));
    constant RXCFOKDONE_SRC_REG : std_logic_vector(1 downto 0) := RXCFOKDONE_SRC;
    constant RXCFOK_CFG0_REG : std_logic_vector(15 downto 0) := RXCFOK_CFG0;
    constant RXCFOK_CFG1_REG : std_logic_vector(15 downto 0) := RXCFOK_CFG1;
    constant RXCFOK_CFG2_REG : std_logic_vector(15 downto 0) := RXCFOK_CFG2;
    constant RXDFELPMRESET_TIME_REG : std_logic_vector(6 downto 0) := RXDFELPMRESET_TIME;
    constant RXDFELPM_KL_CFG0_REG : std_logic_vector(15 downto 0) := RXDFELPM_KL_CFG0;
    constant RXDFELPM_KL_CFG1_REG : std_logic_vector(15 downto 0) := RXDFELPM_KL_CFG1;
    constant RXDFELPM_KL_CFG2_REG : std_logic_vector(15 downto 0) := RXDFELPM_KL_CFG2;
    constant RXDFE_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_CFG0;
    constant RXDFE_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_CFG1;
    constant RXDFE_GC_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_GC_CFG0;
    constant RXDFE_GC_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_GC_CFG1;
    constant RXDFE_GC_CFG2_REG : std_logic_vector(15 downto 0) := RXDFE_GC_CFG2;
    constant RXDFE_H2_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_H2_CFG0;
    constant RXDFE_H2_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_H2_CFG1;
    constant RXDFE_H3_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_H3_CFG0;
    constant RXDFE_H3_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_H3_CFG1;
    constant RXDFE_H4_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_H4_CFG0;
    constant RXDFE_H4_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_H4_CFG1;
    constant RXDFE_H5_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_H5_CFG0;
    constant RXDFE_H5_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_H5_CFG1;
    constant RXDFE_H6_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_H6_CFG0;
    constant RXDFE_H6_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_H6_CFG1;
    constant RXDFE_H7_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_H7_CFG0;
    constant RXDFE_H7_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_H7_CFG1;
    constant RXDFE_H8_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_H8_CFG0;
    constant RXDFE_H8_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_H8_CFG1;
    constant RXDFE_H9_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_H9_CFG0;
    constant RXDFE_H9_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_H9_CFG1;
    constant RXDFE_HA_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_HA_CFG0;
    constant RXDFE_HA_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_HA_CFG1;
    constant RXDFE_HB_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_HB_CFG0;
    constant RXDFE_HB_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_HB_CFG1;
    constant RXDFE_HC_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_HC_CFG0;
    constant RXDFE_HC_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_HC_CFG1;
    constant RXDFE_HD_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_HD_CFG0;
    constant RXDFE_HD_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_HD_CFG1;
    constant RXDFE_HE_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_HE_CFG0;
    constant RXDFE_HE_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_HE_CFG1;
    constant RXDFE_HF_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_HF_CFG0;
    constant RXDFE_HF_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_HF_CFG1;
    constant RXDFE_OS_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_OS_CFG0;
    constant RXDFE_OS_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_OS_CFG1;
    constant RXDFE_PWR_SAVING_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RXDFE_PWR_SAVING));
    constant RXDFE_UT_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_UT_CFG0;
    constant RXDFE_UT_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_UT_CFG1;
    constant RXDFE_VP_CFG0_REG : std_logic_vector(15 downto 0) := RXDFE_VP_CFG0;
    constant RXDFE_VP_CFG1_REG : std_logic_vector(15 downto 0) := RXDFE_VP_CFG1;
    constant RXDLY_CFG_REG : std_logic_vector(15 downto 0) := RXDLY_CFG;
    constant RXDLY_LCFG_REG : std_logic_vector(15 downto 0) := RXDLY_LCFG;
    constant RXGBOX_FIFO_INIT_RD_ADDR_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(RXGBOX_FIFO_INIT_RD_ADDR,3));
    constant RXISCANRESET_TIME_REG : std_logic_vector(4 downto 0) := RXISCANRESET_TIME;
    constant RXLPM_CFG_REG : std_logic_vector(15 downto 0) := RXLPM_CFG;
    constant RXLPM_GC_CFG_REG : std_logic_vector(15 downto 0) := RXLPM_GC_CFG;
    constant RXLPM_KH_CFG0_REG : std_logic_vector(15 downto 0) := RXLPM_KH_CFG0;
    constant RXLPM_KH_CFG1_REG : std_logic_vector(15 downto 0) := RXLPM_KH_CFG1;
    constant RXLPM_OS_CFG0_REG : std_logic_vector(15 downto 0) := RXLPM_OS_CFG0;
    constant RXLPM_OS_CFG1_REG : std_logic_vector(15 downto 0) := RXLPM_OS_CFG1;
    constant RXOOB_CFG_REG : std_logic_vector(8 downto 0) := RXOOB_CFG;
    constant RXOSCALRESET_TIME_REG : std_logic_vector(4 downto 0) := RXOSCALRESET_TIME;
    constant RXOUT_DIV_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(RXOUT_DIV,6));
    constant RXPCSRESET_TIME_REG : std_logic_vector(4 downto 0) := RXPCSRESET_TIME;
    constant RXPHBEACON_CFG_REG : std_logic_vector(15 downto 0) := RXPHBEACON_CFG;
    constant RXPHDLY_CFG_REG : std_logic_vector(15 downto 0) := RXPHDLY_CFG;
    constant RXPHSAMP_CFG_REG : std_logic_vector(15 downto 0) := RXPHSAMP_CFG;
    constant RXPHSLIP_CFG_REG : std_logic_vector(15 downto 0) := RXPHSLIP_CFG;
    constant RXPH_MONITOR_SEL_REG : std_logic_vector(4 downto 0) := RXPH_MONITOR_SEL;
    constant RXPI_AUTO_BW_SEL_BYPASS_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RXPI_AUTO_BW_SEL_BYPASS));
    constant RXPI_CFG_REG : std_logic_vector(15 downto 0) := RXPI_CFG;
    constant RXPI_LPM_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RXPI_LPM));
    constant RXPI_RSV0_REG : std_logic_vector(15 downto 0) := RXPI_RSV0;
    constant RXPI_SEL_LC_REG : std_logic_vector(1 downto 0) := RXPI_SEL_LC;
    constant RXPI_STARTCODE_REG : std_logic_vector(1 downto 0) := RXPI_STARTCODE;
    constant RXPI_VREFSEL_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RXPI_VREFSEL));
    constant RXPMARESET_TIME_REG : std_logic_vector(4 downto 0) := RXPMARESET_TIME;
    constant RXPRBS_ERR_LOOPBACK_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RXPRBS_ERR_LOOPBACK));
    constant RXPRBS_LINKACQ_CNT_REG : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(RXPRBS_LINKACQ_CNT,8));
    constant RXSLIDE_AUTO_WAIT_REG : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(RXSLIDE_AUTO_WAIT,4));
    constant RXSYNC_MULTILANE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RXSYNC_MULTILANE));
    constant RXSYNC_OVRD_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RXSYNC_OVRD));
    constant RXSYNC_SKIP_DA_REG : std_logic_vector(0 downto 0) :=(0=>TO_X01(RXSYNC_SKIP_DA));
    constant RX_AFE_CM_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_AFE_CM_EN));
    constant RX_BIAS_CFG0_REG : std_logic_vector(15 downto 0) := RX_BIAS_CFG0;
    constant RX_BUFFER_CFG_REG : std_logic_vector(5 downto 0) := RX_BUFFER_CFG;
    constant RX_CAPFF_SARC_ENB_REG : std_logic_vector(0 downto 0) :=  (0=>TO_X01(RX_CAPFF_SARC_ENB));
    constant RX_CLK25_DIV_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(RX_CLK25_DIV,6));
    constant RX_CLKMUX_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_CLKMUX_EN));
    constant RX_CLK_SLIP_OVRD_REG : std_logic_vector(4 downto 0) := RX_CLK_SLIP_OVRD;
    constant RX_CM_BUF_CFG_REG : std_logic_vector(3 downto 0) := RX_CM_BUF_CFG;
    constant RX_CM_BUF_PD_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_CM_BUF_PD));
    constant RX_CM_SEL_REG : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(RX_CM_SEL,2));
    constant RX_CM_TRIM_REG : std_logic_vector(3 downto 0) := std_logic_vector(to_unsigned(RX_CM_TRIM,4));
    constant RX_CTLE1_KHKL_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_CTLE1_KHKL));
    constant RX_CTLE2_KHKL_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_CTLE2_KHKL));
    constant RX_CTLE3_AGC_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_CTLE3_AGC));
    constant RX_DATA_WIDTH_REG : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(RX_DATA_WIDTH,8));
    constant RX_DDI_SEL_REG : std_logic_vector(5 downto 0) := RX_DDI_SEL;
    constant RX_DEGEN_CTRL_REG : std_logic_vector(2 downto 0) := RX_DEGEN_CTRL;
    constant RX_DFELPM_CFG0_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(RX_DFELPM_CFG0,3));
    constant RX_DFELPM_CFG1_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_DFELPM_CFG1));
    constant RX_DFELPM_KLKH_AGC_STUP_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_DFELPM_KLKH_AGC_STUP_EN));
    constant RX_DFE_AGC_CFG0_REG : std_logic_vector(1 downto 0) := RX_DFE_AGC_CFG0;
    constant RX_DFE_AGC_CFG1_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(RX_DFE_AGC_CFG1,3));
    constant RX_DFE_KL_LPM_KH_CFG0_REG : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(RX_DFE_KL_LPM_KH_CFG0,2));
    constant RX_DFE_KL_LPM_KH_CFG1_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(RX_DFE_KL_LPM_KH_CFG1,3));
    constant RX_DFE_KL_LPM_KL_CFG0_REG : std_logic_vector(1 downto 0) := RX_DFE_KL_LPM_KL_CFG0;
    constant RX_DFE_KL_LPM_KL_CFG1_REG : std_logic_vector(2 downto 0) := RX_DFE_KL_LPM_KL_CFG1;
    constant RX_DFE_LPM_HOLD_DURING_EIDLE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_DFE_LPM_HOLD_DURING_EIDLE));
    constant RX_DIV2_MODE_B_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_DIV2_MODE_B));
    constant RX_DIVRESET_TIME_REG : std_logic_vector(4 downto 0) := RX_DIVRESET_TIME;
    constant RX_EN_CTLE_RCAL_B_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_EN_CTLE_RCAL_B));
    constant RX_EN_HI_LR_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_EN_HI_LR));
    constant RX_EXT_RL_CTRL_REG : std_logic_vector(8 downto 0) := RX_EXT_RL_CTRL;
    constant RX_EYESCAN_VS_CODE_REG : std_logic_vector(6 downto 0) := RX_EYESCAN_VS_CODE;
    constant RX_EYESCAN_VS_NEG_DIR_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_EYESCAN_VS_NEG_DIR));
    constant RX_EYESCAN_VS_RANGE_REG : std_logic_vector(1 downto 0) := RX_EYESCAN_VS_RANGE;
    constant RX_EYESCAN_VS_UT_SIGN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_EYESCAN_VS_UT_SIGN));
    constant RX_FABINT_USRCLK_FLOP_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_FABINT_USRCLK_FLOP));
    constant RX_INT_DATAWIDTH_REG : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(RX_INT_DATAWIDTH,2));
    constant RX_PMA_POWER_SAVE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_PMA_POWER_SAVE));
    constant RX_PROGDIV_CFG_INT : std_logic_vector (63 downto 0) := std_logic_vector(to_unsigned(integer(RX_PROGDIV_CFG * 1000.0),64));
    constant RX_PROGDIV_RATE_REG : std_logic_vector(15 downto 0) := RX_PROGDIV_RATE;
    constant RX_RESLOAD_CTRL_REG : std_logic_vector(3 downto 0) := RX_RESLOAD_CTRL;
    constant RX_RESLOAD_OVRD_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_RESLOAD_OVRD));
    constant RX_SAMPLE_PERIOD_REG : std_logic_vector(2 downto 0) := RX_SAMPLE_PERIOD;
    constant RX_SIG_VALID_DLY_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(RX_SIG_VALID_DLY,6));
    constant RX_SUM_DFETAPREP_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_SUM_DFETAPREP_EN));
    constant RX_SUM_IREF_TUNE_REG : std_logic_vector(3 downto 0) := RX_SUM_IREF_TUNE;
    constant RX_SUM_VCMTUNE_REG : std_logic_vector(3 downto 0) := RX_SUM_VCMTUNE;
    constant RX_SUM_VCM_OVWR_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_SUM_VCM_OVWR));
    constant RX_SUM_VREF_TUNE_REG : std_logic_vector(2 downto 0) := RX_SUM_VREF_TUNE;
    constant RX_TUNE_AFE_OS_REG : std_logic_vector(1 downto 0) := RX_TUNE_AFE_OS;
    constant RX_VREG_CTRL_REG : std_logic_vector(2 downto 0) := RX_VREG_CTRL;
    constant RX_VREG_PDB_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_VREG_PDB));
    constant RX_WIDEMODE_CDR_REG : std_logic_vector(1 downto 0) := RX_WIDEMODE_CDR;
    constant RX_XMODE_SEL_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(RX_XMODE_SEL));
    constant SAS_MAX_COM_REG : std_logic_vector(6 downto 0) := std_logic_vector(to_unsigned(SAS_MAX_COM,7));
    constant SAS_MIN_COM_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(SAS_MIN_COM,6));
    constant SATA_BURST_SEQ_LEN_REG : std_logic_vector(3 downto 0) := SATA_BURST_SEQ_LEN;
    constant SATA_BURST_VAL_REG : std_logic_vector(2 downto 0) := SATA_BURST_VAL;
    constant SATA_EIDLE_VAL_REG : std_logic_vector(2 downto 0) := SATA_EIDLE_VAL;
    constant SATA_MAX_BURST_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(SATA_MAX_BURST,6));
    constant SATA_MAX_INIT_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(SATA_MAX_INIT,6));
    constant SATA_MAX_WAKE_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(SATA_MAX_WAKE,6));
    constant SATA_MIN_BURST_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(SATA_MIN_BURST,6));
    constant SATA_MIN_INIT_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(SATA_MIN_INIT,6));
    constant SATA_MIN_WAKE_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(SATA_MIN_WAKE,6));
    constant TAPDLY_SET_TX_REG : std_logic_vector(1 downto 0) := TAPDLY_SET_TX;
    constant TEMPERATURE_PAR_REG : std_logic_vector(3 downto 0) := TEMPERATURE_PAR;
    constant TERM_RCAL_CFG_REG : std_logic_vector(14 downto 0) := TERM_RCAL_CFG;
    constant TERM_RCAL_OVRD_REG : std_logic_vector(2 downto 0) := TERM_RCAL_OVRD;
    constant TRANS_TIME_RATE_REG : std_logic_vector(7 downto 0) := TRANS_TIME_RATE;
    constant TST_RSV0_REG : std_logic_vector(7 downto 0) := TST_RSV0;
    constant TST_RSV1_REG : std_logic_vector(7 downto 0) := TST_RSV1;
    constant TXDLY_CFG_REG : std_logic_vector(15 downto 0) := TXDLY_CFG;
    constant TXDLY_LCFG_REG : std_logic_vector(15 downto 0) := TXDLY_LCFG;
    constant TXGBOX_FIFO_INIT_RD_ADDR_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(TXGBOX_FIFO_INIT_RD_ADDR,3));
    constant TXOUTCLKPCS_SEL_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant TXOUT_DIV_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(TXOUT_DIV,6));
    constant TXPCSRESET_TIME_REG : std_logic_vector(4 downto 0) := TXPCSRESET_TIME;
    constant TXPHDLY_CFG0_REG : std_logic_vector(15 downto 0) := TXPHDLY_CFG0;
    constant TXPHDLY_CFG1_REG : std_logic_vector(15 downto 0) := TXPHDLY_CFG1;
    constant TXPH_CFG2_REG : std_logic_vector(15 downto 0) := TXPH_CFG2;
    constant TXPH_CFG_REG : std_logic_vector(15 downto 0) := TXPH_CFG;
    constant TXPH_MONITOR_SEL_REG : std_logic_vector(4 downto 0) := TXPH_MONITOR_SEL;
    constant TXPI_CFG0_REG : std_logic_vector(1 downto 0) := TXPI_CFG0;
    constant TXPI_CFG1_REG : std_logic_vector(1 downto 0) := TXPI_CFG1;
    constant TXPI_CFG2_REG : std_logic_vector(1 downto 0) := TXPI_CFG2;
    constant TXPI_CFG3_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TXPI_CFG3));
    constant TXPI_CFG4_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TXPI_CFG4));
    constant TXPI_CFG5_REG : std_logic_vector(2 downto 0) := TXPI_CFG5;
    constant TXPI_GRAY_SEL_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TXPI_GRAY_SEL));
    constant TXPI_INVSTROBE_SEL_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TXPI_INVSTROBE_SEL));
    constant TXPI_LPM_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TXPI_LPM));
    constant TXPI_PPM_CFG_REG : std_logic_vector(7 downto 0) := TXPI_PPM_CFG;
    constant TXPI_RSV0_REG : std_logic_vector(15 downto 0) := TXPI_RSV0;
    constant TXPI_SYNFREQ_PPM_REG : std_logic_vector(2 downto 0) := TXPI_SYNFREQ_PPM;
    constant TXPI_VREFSEL_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TXPI_VREFSEL));
    constant TXPMARESET_TIME_REG : std_logic_vector(4 downto 0) := TXPMARESET_TIME;
    constant TXSYNC_MULTILANE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TXSYNC_MULTILANE));
    constant TXSYNC_OVRD_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TXSYNC_OVRD));
    constant TXSYNC_SKIP_DA_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TXSYNC_SKIP_DA));
    constant TX_CLK25_DIV_REG : std_logic_vector(5 downto 0) := std_logic_vector(to_unsigned(TX_CLK25_DIV,6));
    constant TX_CLKMUX_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_CLKMUX_EN));
    constant TX_CLKREG_PDB_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_CLKREG_PDB));
    constant TX_CLKREG_SET_REG : std_logic_vector(2 downto 0) := TX_CLKREG_SET;
    constant TX_DATA_WIDTH_REG : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(TX_DATA_WIDTH,8));
    constant TX_DCD_CFG_REG : std_logic_vector(5 downto 0) := TX_DCD_CFG;
    constant TX_DCD_EN_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_DCD_EN));
    constant TX_DEEMPH0_REG : std_logic_vector(5 downto 0) := TX_DEEMPH0;
    constant TX_DEEMPH1_REG : std_logic_vector(5 downto 0) := TX_DEEMPH1;
    constant TX_DIVRESET_TIME_REG : std_logic_vector(4 downto 0) := TX_DIVRESET_TIME;
    constant TX_DRVMUX_CTRL_REG : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(TX_DRVMUX_CTRL,2));
    constant TX_EIDLE_ASSERT_DELAY_REG : std_logic_vector(2 downto 0) := TX_EIDLE_ASSERT_DELAY;
    constant TX_EIDLE_DEASSERT_DELAY_REG : std_logic_vector(2 downto 0) := TX_EIDLE_DEASSERT_DELAY;
    constant TX_EML_PHI_TUNE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_EML_PHI_TUNE));
    constant TX_FABINT_USRCLK_FLOP_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_FABINT_USRCLK_FLOP));
    constant TX_FIFO_BYP_EN_REG : std_logic_vector(0 downto 0) :=  (0=>TO_X01(TX_FABINT_USRCLK_FLOP));
    constant TX_IDLE_DATA_ZERO_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_FIFO_BYP_EN));
    constant TX_INT_DATAWIDTH_REG : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(TX_INT_DATAWIDTH,2));
    constant TX_MAINCURSOR_SEL_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_MAINCURSOR_SEL));
    constant TX_MARGIN_FULL_0_REG : std_logic_vector(6 downto 0) := TX_MARGIN_FULL_0;
    constant TX_MARGIN_FULL_1_REG : std_logic_vector(6 downto 0) := TX_MARGIN_FULL_1;
    constant TX_MARGIN_FULL_2_REG : std_logic_vector(6 downto 0) := TX_MARGIN_FULL_2;
    constant TX_MARGIN_FULL_3_REG : std_logic_vector(6 downto 0) := TX_MARGIN_FULL_3;
    constant TX_MARGIN_FULL_4_REG : std_logic_vector(6 downto 0) := TX_MARGIN_FULL_4;
    constant TX_MARGIN_LOW_0_REG : std_logic_vector(6 downto 0) := TX_MARGIN_LOW_0;
    constant TX_MARGIN_LOW_1_REG : std_logic_vector(6 downto 0) := TX_MARGIN_LOW_1;
    constant TX_MARGIN_LOW_2_REG : std_logic_vector(6 downto 0) := TX_MARGIN_LOW_2;
    constant TX_MARGIN_LOW_3_REG : std_logic_vector(6 downto 0) := TX_MARGIN_LOW_3;
    constant TX_MARGIN_LOW_4_REG : std_logic_vector(6 downto 0) := TX_MARGIN_LOW_4;
    constant TX_MODE_SEL_REG : std_logic_vector(2 downto 0) := TX_MODE_SEL;
    constant TX_PHICAL_CFG0_REG : std_logic_vector(15 downto 0) := TX_PHICAL_CFG0;
    constant TX_PHICAL_CFG1_REG : std_logic_vector(15 downto 0) := TX_PHICAL_CFG1;
    constant TX_PHICAL_CFG2_REG : std_logic_vector(15 downto 0) := TX_PHICAL_CFG2;
    constant TX_PI_BIASSET_REG : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(TX_PI_BIASSET,2));
    constant TX_PI_CFG0_REG : std_logic_vector(15 downto 0) := TX_PI_CFG0;
    constant TX_PI_CFG1_REG : std_logic_vector(15 downto 0) := TX_PI_CFG1;
    constant TX_PI_DIV2_MODE_B_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_PI_DIV2_MODE_B));
    constant TX_PI_SEL_QPLL0_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_PI_SEL_QPLL0));
    constant TX_PI_SEL_QPLL1_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_PI_SEL_QPLL1));
    constant TX_PMADATA_OPT_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_PMADATA_OPT));
    constant TX_PMA_POWER_SAVE_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_PMA_POWER_SAVE));
    constant TX_PREDRV_CTRL_REG : std_logic_vector(1 downto 0) := std_logic_vector(to_unsigned(TX_PREDRV_CTRL,2));
    constant TX_PROGDIV_CFG_INT : std_logic_vector (63 downto 0) := std_logic_vector(to_unsigned(integer(TX_PROGDIV_CFG * 1000.0),64));
    constant TX_PROGDIV_RATE_REG : std_logic_vector(15 downto 0) := TX_PROGDIV_RATE;
    constant TX_RXDETECT_CFG_REG : std_logic_vector(13 downto 0) := TX_RXDETECT_CFG;
    constant TX_RXDETECT_REF_REG : std_logic_vector(2 downto 0) := std_logic_vector(to_unsigned(TX_RXDETECT_REF,3));
    constant TX_SAMPLE_PERIOD_REG : std_logic_vector(2 downto 0) := TX_SAMPLE_PERIOD;
    constant TX_SARC_LPBK_ENB_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(TX_SARC_LPBK_ENB));
    constant TX_USERPATTERN_DATA0_REG : std_logic_vector(9 downto 0) := "0101111100";
    constant TX_USERPATTERN_DATA1_REG : std_logic_vector(9 downto 0) := "0101010101";
    constant TX_USERPATTERN_DATA2_REG : std_logic_vector(9 downto 0) := "1010000011";
    constant TX_USERPATTERN_DATA3_REG : std_logic_vector(9 downto 0) := "1010101010";
    constant TX_USERPATTERN_DATA4_REG : std_logic_vector(9 downto 0) := "0101111100";
    constant TX_USERPATTERN_DATA5_REG : std_logic_vector(9 downto 0) := "0101010101";
    constant TX_USERPATTERN_DATA6_REG : std_logic_vector(9 downto 0) := "1010000011";
    constant TX_USERPATTERN_DATA7_REG : std_logic_vector(9 downto 0) := "1010101010";
    constant USE_PCS_CLK_PHASE_SEL_REG : std_logic_vector(0 downto 0) := (0=>TO_X01(USE_PCS_CLK_PHASE_SEL));
    
  -- Parameter encodings and registers

    signal glblGSR      : std_ulogic;
    signal xil_attr_test : boolean := false;
  
    signal attr_err     : std_ulogic := '0';
    
    signal BUFGTCEMASK_out : std_logic_vector(2 downto 0);
    signal BUFGTCE_out : std_logic_vector(2 downto 0);
    signal BUFGTDIV_out : std_logic_vector(8 downto 0);
    signal BUFGTRESET_out : std_logic_vector(2 downto 0);
    signal BUFGTRSTMASK_out : std_logic_vector(2 downto 0);
    signal CPLLFBCLKLOST_out : std_ulogic;
    signal CPLLLOCK_out : std_ulogic;
    signal CPLLREFCLKLOST_out : std_ulogic;
    signal DMONITOROUT_out : std_logic_vector(16 downto 0);
    signal DRPDO_out : std_logic_vector(15 downto 0);
    signal DRPRDY_out : std_ulogic;
    signal EYESCANDATAERROR_out : std_ulogic;
    signal GTPOWERGOOD_out : std_ulogic;
    signal GTREFCLKMONITOR_out : std_ulogic;
    signal GTYTXN_out : std_ulogic;
    signal GTYTXP_out : std_ulogic;
    signal PCIERATEGEN3_out : std_ulogic;
    signal PCIERATEIDLE_out : std_ulogic;
    signal PCIERATEQPLLPD_out : std_logic_vector(1 downto 0);
    signal PCIERATEQPLLRESET_out : std_logic_vector(1 downto 0);
    signal PCIESYNCTXSYNCDONE_out : std_ulogic;
    signal PCIEUSERGEN3RDY_out : std_ulogic;
    signal PCIEUSERPHYSTATUSRST_out : std_ulogic;
    signal PCIEUSERRATESTART_out : std_ulogic;
    signal PCSRSVDOUT_out : std_logic_vector(15 downto 0);
    signal PHYSTATUS_out : std_ulogic;
    signal PINRSRVDAS_out : std_logic_vector(7 downto 0);
    signal PMASCANOUT_out : std_logic_vector(11 downto 0);
    signal RESETEXCEPTION_out : std_ulogic;
    signal RXBUFSTATUS_out : std_logic_vector(2 downto 0);
    signal RXBYTEISALIGNED_out : std_ulogic;
    signal RXBYTEREALIGN_out : std_ulogic;
    signal RXCDRLOCK_out : std_ulogic;
    signal RXCDRPHDONE_out : std_ulogic;
    signal RXCHANBONDSEQ_out : std_ulogic;
    signal RXCHANISALIGNED_out : std_ulogic;
    signal RXCHANREALIGN_out : std_ulogic;
    signal RXCHBONDO_out : std_logic_vector(4 downto 0);
    signal RXCKCALDONE_out : std_ulogic;
    signal RXCLKCORCNT_out : std_logic_vector(1 downto 0);
    signal RXCOMINITDET_out : std_ulogic;
    signal RXCOMMADET_out : std_ulogic;
    signal RXCOMSASDET_out : std_ulogic;
    signal RXCOMWAKEDET_out : std_ulogic;
    signal RXCTRL0_out : std_logic_vector(15 downto 0);
    signal RXCTRL1_out : std_logic_vector(15 downto 0);
    signal RXCTRL2_out : std_logic_vector(7 downto 0);
    signal RXCTRL3_out : std_logic_vector(7 downto 0);
    signal RXDATAEXTENDRSVD_out : std_logic_vector(7 downto 0);
    signal RXDATAVALID_out : std_logic_vector(1 downto 0);
    signal RXDATA_out : std_logic_vector(127 downto 0);
    signal RXDLYSRESETDONE_out : std_ulogic;
    signal RXELECIDLE_out : std_ulogic;
    signal RXHEADERVALID_out : std_logic_vector(1 downto 0);
    signal RXHEADER_out : std_logic_vector(5 downto 0);
    signal RXMONITOROUT_out : std_logic_vector(6 downto 0);
    signal RXOSINTDONE_out : std_ulogic;
    signal RXOSINTSTARTED_out : std_ulogic;
    signal RXOSINTSTROBEDONE_out : std_ulogic;
    signal RXOSINTSTROBESTARTED_out : std_ulogic;
    signal RXOUTCLKFABRIC_out : std_ulogic;
    signal RXOUTCLKPCS_out : std_ulogic;
    signal RXOUTCLK_out : std_ulogic;
    signal RXPHALIGNDONE_out : std_ulogic;
    signal RXPHALIGNERR_out : std_ulogic;
    signal RXPMARESETDONE_out : std_ulogic;
    signal RXPRBSERR_out : std_ulogic;
    signal RXPRBSLOCKED_out : std_ulogic;
    signal RXPRGDIVRESETDONE_out : std_ulogic;
    signal RXRATEDONE_out : std_ulogic;
    signal RXRECCLKOUT_out : std_ulogic;
    signal RXRESETDONE_out : std_ulogic;
    signal RXSLIDERDY_out : std_ulogic;
    signal RXSLIPDONE_out : std_ulogic;
    signal RXSLIPOUTCLKRDY_out : std_ulogic;
    signal RXSLIPPMARDY_out : std_ulogic;
    signal RXSTARTOFSEQ_out : std_logic_vector(1 downto 0);
    signal RXSTATUS_out : std_logic_vector(2 downto 0);
    signal RXSYNCDONE_out : std_ulogic;
    signal RXSYNCOUT_out : std_ulogic;
    signal RXVALID_out : std_ulogic;
    signal SCANOUT_out : std_logic_vector(18 downto 0);
    signal TXBUFSTATUS_out : std_logic_vector(1 downto 0);
    signal TXCOMFINISH_out : std_ulogic;
    signal TXDCCDONE_out : std_ulogic;
    signal TXDLYSRESETDONE_out : std_ulogic;
    signal TXOUTCLKFABRIC_out : std_ulogic;
    signal TXOUTCLKPCS_out : std_ulogic;
    signal TXOUTCLK_out : std_ulogic;
    signal TXPHALIGNDONE_out : std_ulogic;
    signal TXPHINITDONE_out : std_ulogic;
    signal TXPMARESETDONE_out : std_ulogic;
    signal TXPRGDIVRESETDONE_out : std_ulogic;
    signal TXRATEDONE_out : std_ulogic;
    signal TXRESETDONE_out : std_ulogic;
    signal TXSYNCDONE_out : std_ulogic;
    signal TXSYNCOUT_out : std_ulogic;
    
    signal BUFGTCEMASK_delay : std_logic_vector(2 downto 0);
    signal BUFGTCE_delay : std_logic_vector(2 downto 0);
    signal BUFGTDIV_delay : std_logic_vector(8 downto 0);
    signal BUFGTRESET_delay : std_logic_vector(2 downto 0);
    signal BUFGTRSTMASK_delay : std_logic_vector(2 downto 0);
    signal CPLLFBCLKLOST_delay : std_ulogic;
    signal CPLLLOCK_delay : std_ulogic;
    signal CPLLREFCLKLOST_delay : std_ulogic;
    signal DMONITOROUT_delay : std_logic_vector(16 downto 0);
    signal DRPDO_delay : std_logic_vector(15 downto 0);
    signal DRPRDY_delay : std_ulogic;
    signal EYESCANDATAERROR_delay : std_ulogic;
    signal GTPOWERGOOD_delay : std_ulogic;
    signal GTREFCLKMONITOR_delay : std_ulogic;
    signal GTYTXN_delay : std_ulogic;
    signal GTYTXP_delay : std_ulogic;
    signal PCIERATEGEN3_delay : std_ulogic;
    signal PCIERATEIDLE_delay : std_ulogic;
    signal PCIERATEQPLLPD_delay : std_logic_vector(1 downto 0);
    signal PCIERATEQPLLRESET_delay : std_logic_vector(1 downto 0);
    signal PCIESYNCTXSYNCDONE_delay : std_ulogic;
    signal PCIEUSERGEN3RDY_delay : std_ulogic;
    signal PCIEUSERPHYSTATUSRST_delay : std_ulogic;
    signal PCIEUSERRATESTART_delay : std_ulogic;
    signal PCSRSVDOUT_delay : std_logic_vector(15 downto 0);
    signal PHYSTATUS_delay : std_ulogic;
    signal PINRSRVDAS_delay : std_logic_vector(7 downto 0);
    signal RESETEXCEPTION_delay : std_ulogic;
    signal RXBUFSTATUS_delay : std_logic_vector(2 downto 0);
    signal RXBYTEISALIGNED_delay : std_ulogic;
    signal RXBYTEREALIGN_delay : std_ulogic;
    signal RXCDRLOCK_delay : std_ulogic;
    signal RXCDRPHDONE_delay : std_ulogic;
    signal RXCHANBONDSEQ_delay : std_ulogic;
    signal RXCHANISALIGNED_delay : std_ulogic;
    signal RXCHANREALIGN_delay : std_ulogic;
    signal RXCHBONDO_delay : std_logic_vector(4 downto 0);
    signal RXCKCALDONE_delay : std_ulogic;
    signal RXCLKCORCNT_delay : std_logic_vector(1 downto 0);
    signal RXCOMINITDET_delay : std_ulogic;
    signal RXCOMMADET_delay : std_ulogic;
    signal RXCOMSASDET_delay : std_ulogic;
    signal RXCOMWAKEDET_delay : std_ulogic;
    signal RXCTRL0_delay : std_logic_vector(15 downto 0);
    signal RXCTRL1_delay : std_logic_vector(15 downto 0);
    signal RXCTRL2_delay : std_logic_vector(7 downto 0);
    signal RXCTRL3_delay : std_logic_vector(7 downto 0);
    signal RXDATAEXTENDRSVD_delay : std_logic_vector(7 downto 0);
    signal RXDATAVALID_delay : std_logic_vector(1 downto 0);
    signal RXDATA_delay : std_logic_vector(127 downto 0);
    signal RXDLYSRESETDONE_delay : std_ulogic;
    signal RXELECIDLE_delay : std_ulogic;
    signal RXHEADERVALID_delay : std_logic_vector(1 downto 0);
    signal RXHEADER_delay : std_logic_vector(5 downto 0);
    signal RXMONITOROUT_delay : std_logic_vector(6 downto 0);
    signal RXOSINTDONE_delay : std_ulogic;
    signal RXOSINTSTARTED_delay : std_ulogic;
    signal RXOSINTSTROBEDONE_delay : std_ulogic;
    signal RXOSINTSTROBESTARTED_delay : std_ulogic;
    signal RXOUTCLKFABRIC_delay : std_ulogic;
    signal RXOUTCLKPCS_delay : std_ulogic;
    signal RXOUTCLK_delay : std_ulogic;
    signal RXPHALIGNDONE_delay : std_ulogic;
    signal RXPHALIGNERR_delay : std_ulogic;
    signal RXPMARESETDONE_delay : std_ulogic;
    signal RXPRBSERR_delay : std_ulogic;
    signal RXPRBSLOCKED_delay : std_ulogic;
    signal RXPRGDIVRESETDONE_delay : std_ulogic;
    signal RXRATEDONE_delay : std_ulogic;
    signal RXRECCLKOUT_delay : std_ulogic;
    signal RXRESETDONE_delay : std_ulogic;
    signal RXSLIDERDY_delay : std_ulogic;
    signal RXSLIPDONE_delay : std_ulogic;
    signal RXSLIPOUTCLKRDY_delay : std_ulogic;
    signal RXSLIPPMARDY_delay : std_ulogic;
    signal RXSTARTOFSEQ_delay : std_logic_vector(1 downto 0);
    signal RXSTATUS_delay : std_logic_vector(2 downto 0);
    signal RXSYNCDONE_delay : std_ulogic;
    signal RXSYNCOUT_delay : std_ulogic;
    signal RXVALID_delay : std_ulogic;
    signal TXBUFSTATUS_delay : std_logic_vector(1 downto 0);
    signal TXCOMFINISH_delay : std_ulogic;
    signal TXDCCDONE_delay : std_ulogic;
    signal TXDLYSRESETDONE_delay : std_ulogic;
    signal TXOUTCLKFABRIC_delay : std_ulogic;
    signal TXOUTCLKPCS_delay : std_ulogic;
    signal TXOUTCLK_delay : std_ulogic;
    signal TXPHALIGNDONE_delay : std_ulogic;
    signal TXPHINITDONE_delay : std_ulogic;
    signal TXPMARESETDONE_delay : std_ulogic;
    signal TXPRGDIVRESETDONE_delay : std_ulogic;
    signal TXRATEDONE_delay : std_ulogic;
    signal TXRESETDONE_delay : std_ulogic;
    signal TXSYNCDONE_delay : std_ulogic;
    signal TXSYNCOUT_delay : std_ulogic;
    
    signal CDRSTEPDIR_delay : std_ulogic;
    signal CDRSTEPSQ_delay : std_ulogic;
    signal CDRSTEPSX_delay : std_ulogic;
    signal CFGRESET_delay : std_ulogic;
    signal CLKRSVD0_delay : std_ulogic;
    signal CLKRSVD1_delay : std_ulogic;
    signal CPLLLOCKDETCLK_delay : std_ulogic;
    signal CPLLLOCKEN_delay : std_ulogic;
    signal CPLLPD_delay : std_ulogic;
    signal CPLLREFCLKSEL_delay : std_logic_vector(2 downto 0);
    signal CPLLRESET_delay : std_ulogic;
    signal DMONFIFORESET_delay : std_ulogic;
    signal DMONITORCLK_delay : std_ulogic;
    signal DRPADDR_delay : std_logic_vector(9 downto 0);
    signal DRPCLK_delay : std_ulogic;
    signal DRPDI_delay : std_logic_vector(15 downto 0);
    signal DRPEN_delay : std_ulogic;
    signal DRPWE_delay : std_ulogic;
    signal ELPCALDVORWREN_delay : std_ulogic;
    signal ELPCALPAORWREN_delay : std_ulogic;
    signal EVODDPHICALDONE_delay : std_ulogic;
    signal EVODDPHICALSTART_delay : std_ulogic;
    signal EVODDPHIDRDEN_delay : std_ulogic;
    signal EVODDPHIDWREN_delay : std_ulogic;
    signal EVODDPHIXRDEN_delay : std_ulogic;
    signal EVODDPHIXWREN_delay : std_ulogic;
    signal EYESCANMODE_delay : std_ulogic;
    signal EYESCANRESET_delay : std_ulogic;
    signal EYESCANTRIGGER_delay : std_ulogic;
    signal GTGREFCLK_delay : std_ulogic;
    signal GTNORTHREFCLK0_delay : std_ulogic;
    signal GTNORTHREFCLK1_delay : std_ulogic;
    signal GTREFCLK0_delay : std_ulogic;
    signal GTREFCLK1_delay : std_ulogic;
    signal GTRESETSEL_delay : std_ulogic;
    signal GTRSVD_delay : std_logic_vector(15 downto 0);
    signal GTRXRESET_delay : std_ulogic;
    signal GTSOUTHREFCLK0_delay : std_ulogic;
    signal GTSOUTHREFCLK1_delay : std_ulogic;
    signal GTTXRESET_delay : std_ulogic;
    signal GTYRXN_delay : std_ulogic;
    signal GTYRXP_delay : std_ulogic;
    signal LOOPBACK_delay : std_logic_vector(2 downto 0);
    signal LOOPRSVD_delay : std_logic_vector(15 downto 0);
    signal LPBKRXTXSEREN_delay : std_ulogic;
    signal LPBKTXRXSEREN_delay : std_ulogic;
    signal PCIEEQRXEQADAPTDONE_delay : std_ulogic;
    signal PCIERSTIDLE_delay : std_ulogic;
    signal PCIERSTTXSYNCSTART_delay : std_ulogic;
    signal PCIEUSERRATEDONE_delay : std_ulogic;
    signal PCSRSVDIN2_delay : std_logic_vector(4 downto 0);
    signal PCSRSVDIN_delay : std_logic_vector(15 downto 0);
    signal PMARSVDIN_delay : std_logic_vector(4 downto 0);
    signal QPLL0CLK_delay : std_ulogic;
    signal QPLL0REFCLK_delay : std_ulogic;
    signal QPLL1CLK_delay : std_ulogic;
    signal QPLL1REFCLK_delay : std_ulogic;
    signal RESETOVRD_delay : std_ulogic;
    signal RSTCLKENTX_delay : std_ulogic;
    signal RX8B10BEN_delay : std_ulogic;
    signal RXBUFRESET_delay : std_ulogic;
    signal RXCDRFREQRESET_delay : std_ulogic;
    signal RXCDRHOLD_delay : std_ulogic;
    signal RXCDROVRDEN_delay : std_ulogic;
    signal RXCDRRESETRSV_delay : std_ulogic;
    signal RXCDRRESET_delay : std_ulogic;
    signal RXCHBONDEN_delay : std_ulogic;
    signal RXCHBONDI_delay : std_logic_vector(4 downto 0);
    signal RXCHBONDLEVEL_delay : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER_delay : std_ulogic;
    signal RXCHBONDSLAVE_delay : std_ulogic;
    signal RXCKCALRESET_delay : std_ulogic;
    signal RXCOMMADETEN_delay : std_ulogic;
    signal RXDCCFORCESTART_delay : std_ulogic;
    signal RXDFEAGCHOLD_delay : std_ulogic;
    signal RXDFEAGCOVRDEN_delay : std_ulogic;
    signal RXDFELFHOLD_delay : std_ulogic;
    signal RXDFELFOVRDEN_delay : std_ulogic;
    signal RXDFELPMRESET_delay : std_ulogic;
    signal RXDFETAP10HOLD_delay : std_ulogic;
    signal RXDFETAP10OVRDEN_delay : std_ulogic;
    signal RXDFETAP11HOLD_delay : std_ulogic;
    signal RXDFETAP11OVRDEN_delay : std_ulogic;
    signal RXDFETAP12HOLD_delay : std_ulogic;
    signal RXDFETAP12OVRDEN_delay : std_ulogic;
    signal RXDFETAP13HOLD_delay : std_ulogic;
    signal RXDFETAP13OVRDEN_delay : std_ulogic;
    signal RXDFETAP14HOLD_delay : std_ulogic;
    signal RXDFETAP14OVRDEN_delay : std_ulogic;
    signal RXDFETAP15HOLD_delay : std_ulogic;
    signal RXDFETAP15OVRDEN_delay : std_ulogic;
    signal RXDFETAP2HOLD_delay : std_ulogic;
    signal RXDFETAP2OVRDEN_delay : std_ulogic;
    signal RXDFETAP3HOLD_delay : std_ulogic;
    signal RXDFETAP3OVRDEN_delay : std_ulogic;
    signal RXDFETAP4HOLD_delay : std_ulogic;
    signal RXDFETAP4OVRDEN_delay : std_ulogic;
    signal RXDFETAP5HOLD_delay : std_ulogic;
    signal RXDFETAP5OVRDEN_delay : std_ulogic;
    signal RXDFETAP6HOLD_delay : std_ulogic;
    signal RXDFETAP6OVRDEN_delay : std_ulogic;
    signal RXDFETAP7HOLD_delay : std_ulogic;
    signal RXDFETAP7OVRDEN_delay : std_ulogic;
    signal RXDFETAP8HOLD_delay : std_ulogic;
    signal RXDFETAP8OVRDEN_delay : std_ulogic;
    signal RXDFETAP9HOLD_delay : std_ulogic;
    signal RXDFETAP9OVRDEN_delay : std_ulogic;
    signal RXDFEUTHOLD_delay : std_ulogic;
    signal RXDFEUTOVRDEN_delay : std_ulogic;
    signal RXDFEVPHOLD_delay : std_ulogic;
    signal RXDFEVPOVRDEN_delay : std_ulogic;
    signal RXDFEVSEN_delay : std_ulogic;
    signal RXDFEXYDEN_delay : std_ulogic;
    signal RXDLYBYPASS_delay : std_ulogic;
    signal RXDLYEN_delay : std_ulogic;
    signal RXDLYOVRDEN_delay : std_ulogic;
    signal RXDLYSRESET_delay : std_ulogic;
    signal RXELECIDLEMODE_delay : std_logic_vector(1 downto 0);
    signal RXGEARBOXSLIP_delay : std_ulogic;
    signal RXLATCLK_delay : std_ulogic;
    signal RXLPMEN_delay : std_ulogic;
    signal RXLPMGCHOLD_delay : std_ulogic;
    signal RXLPMGCOVRDEN_delay : std_ulogic;
    signal RXLPMHFHOLD_delay : std_ulogic;
    signal RXLPMHFOVRDEN_delay : std_ulogic;
    signal RXLPMLFHOLD_delay : std_ulogic;
    signal RXLPMLFKLOVRDEN_delay : std_ulogic;
    signal RXLPMOSHOLD_delay : std_ulogic;
    signal RXLPMOSOVRDEN_delay : std_ulogic;
    signal RXMCOMMAALIGNEN_delay : std_ulogic;
    signal RXMONITORSEL_delay : std_logic_vector(1 downto 0);
    signal RXOOBRESET_delay : std_ulogic;
    signal RXOSCALRESET_delay : std_ulogic;
    signal RXOSHOLD_delay : std_ulogic;
    signal RXOSINTCFG_delay : std_logic_vector(3 downto 0);
    signal RXOSINTEN_delay : std_ulogic;
    signal RXOSINTHOLD_delay : std_ulogic;
    signal RXOSINTOVRDEN_delay : std_ulogic;
    signal RXOSINTSTROBE_delay : std_ulogic;
    signal RXOSINTTESTOVRDEN_delay : std_ulogic;
    signal RXOSOVRDEN_delay : std_ulogic;
    signal RXOUTCLKSEL_delay : std_logic_vector(2 downto 0);
    signal RXPCOMMAALIGNEN_delay : std_ulogic;
    signal RXPCSRESET_delay : std_ulogic;
    signal RXPD_delay : std_logic_vector(1 downto 0);
    signal RXPHALIGNEN_delay : std_ulogic;
    signal RXPHALIGN_delay : std_ulogic;
    signal RXPHDLYPD_delay : std_ulogic;
    signal RXPHDLYRESET_delay : std_ulogic;
    signal RXPHOVRDEN_delay : std_ulogic;
    signal RXPLLCLKSEL_delay : std_logic_vector(1 downto 0);
    signal RXPMARESET_delay : std_ulogic;
    signal RXPOLARITY_delay : std_ulogic;
    signal RXPRBSCNTRESET_delay : std_ulogic;
    signal RXPRBSSEL_delay : std_logic_vector(3 downto 0);
    signal RXPROGDIVRESET_delay : std_ulogic;
    signal RXRATEMODE_delay : std_ulogic;
    signal RXRATE_delay : std_logic_vector(2 downto 0);
    signal RXSLIDE_delay : std_ulogic;
    signal RXSLIPOUTCLK_delay : std_ulogic;
    signal RXSLIPPMA_delay : std_ulogic;
    signal RXSYNCALLIN_delay : std_ulogic;
    signal RXSYNCIN_delay : std_ulogic;
    signal RXSYNCMODE_delay : std_ulogic;
    signal RXSYSCLKSEL_delay : std_logic_vector(1 downto 0);
    signal RXUSERRDY_delay : std_ulogic;
    signal RXUSRCLK2_delay : std_ulogic;
    signal RXUSRCLK_delay : std_ulogic;
    signal SIGVALIDCLK_delay : std_ulogic;
    signal TSTIN_delay : std_logic_vector(19 downto 0);
    signal TX8B10BBYPASS_delay : std_logic_vector(7 downto 0);
    signal TX8B10BEN_delay : std_ulogic;
    signal TXBUFDIFFCTRL_delay : std_logic_vector(2 downto 0);
    signal TXCOMINIT_delay : std_ulogic;
    signal TXCOMSAS_delay : std_ulogic;
    signal TXCOMWAKE_delay : std_ulogic;
    signal TXCTRL0_delay : std_logic_vector(15 downto 0);
    signal TXCTRL1_delay : std_logic_vector(15 downto 0);
    signal TXCTRL2_delay : std_logic_vector(7 downto 0);
    signal TXDATAEXTENDRSVD_delay : std_logic_vector(7 downto 0);
    signal TXDATA_delay : std_logic_vector(127 downto 0);
    signal TXDCCFORCESTART_delay : std_ulogic;
    signal TXDCCRESET_delay : std_ulogic;
    signal TXDEEMPH_delay : std_ulogic;
    signal TXDETECTRX_delay : std_ulogic;
    signal TXDIFFCTRL_delay : std_logic_vector(4 downto 0);
    signal TXDIFFPD_delay : std_ulogic;
    signal TXDLYBYPASS_delay : std_ulogic;
    signal TXDLYEN_delay : std_ulogic;
    signal TXDLYHOLD_delay : std_ulogic;
    signal TXDLYOVRDEN_delay : std_ulogic;
    signal TXDLYSRESET_delay : std_ulogic;
    signal TXDLYUPDOWN_delay : std_ulogic;
    signal TXELECIDLE_delay : std_ulogic;
    signal TXELFORCESTART_delay : std_ulogic;
    signal TXHEADER_delay : std_logic_vector(5 downto 0);
    signal TXINHIBIT_delay : std_ulogic;
    signal TXLATCLK_delay : std_ulogic;
    signal TXMAINCURSOR_delay : std_logic_vector(6 downto 0);
    signal TXMARGIN_delay : std_logic_vector(2 downto 0);
    signal TXOUTCLKSEL_delay : std_logic_vector(2 downto 0);
    signal TXPCSRESET_delay : std_ulogic;
    signal TXPDELECIDLEMODE_delay : std_ulogic;
    signal TXPD_delay : std_logic_vector(1 downto 0);
    signal TXPHALIGNEN_delay : std_ulogic;
    signal TXPHALIGN_delay : std_ulogic;
    signal TXPHDLYPD_delay : std_ulogic;
    signal TXPHDLYRESET_delay : std_ulogic;
    signal TXPHDLYTSTCLK_delay : std_ulogic;
    signal TXPHINIT_delay : std_ulogic;
    signal TXPHOVRDEN_delay : std_ulogic;
    signal TXPIPPMEN_delay : std_ulogic;
    signal TXPIPPMOVRDEN_delay : std_ulogic;
    signal TXPIPPMPD_delay : std_ulogic;
    signal TXPIPPMSEL_delay : std_ulogic;
    signal TXPIPPMSTEPSIZE_delay : std_logic_vector(4 downto 0);
    signal TXPISOPD_delay : std_ulogic;
    signal TXPLLCLKSEL_delay : std_logic_vector(1 downto 0);
    signal TXPMARESET_delay : std_ulogic;
    signal TXPOLARITY_delay : std_ulogic;
    signal TXPOSTCURSOR_delay : std_logic_vector(4 downto 0);
    signal TXPRBSFORCEERR_delay : std_ulogic;
    signal TXPRBSSEL_delay : std_logic_vector(3 downto 0);
    signal TXPRECURSOR_delay : std_logic_vector(4 downto 0);
    signal TXPROGDIVRESET_delay : std_ulogic;
    signal TXRATEMODE_delay : std_ulogic;
    signal TXRATE_delay : std_logic_vector(2 downto 0);
    signal TXSEQUENCE_delay : std_logic_vector(6 downto 0);
    signal TXSWING_delay : std_ulogic;
    signal TXSYNCALLIN_delay : std_ulogic;
    signal TXSYNCIN_delay : std_ulogic;
    signal TXSYNCMODE_delay : std_ulogic;
    signal TXSYSCLKSEL_delay : std_logic_vector(1 downto 0);
    signal TXUSERRDY_delay : std_ulogic;
    signal TXUSRCLK2_delay : std_ulogic;
    signal TXUSRCLK_delay : std_ulogic;
    
    signal CDRSTEPDIR_in : std_ulogic;
    signal CDRSTEPSQ_in : std_ulogic;
    signal CDRSTEPSX_in : std_ulogic;
    signal CFGRESET_in : std_ulogic;
    signal CLKRSVD0_in : std_ulogic;
    signal CLKRSVD1_in : std_ulogic;
    signal CPLLLOCKDETCLK_in : std_ulogic;
    signal CPLLLOCKEN_in : std_ulogic;
    signal CPLLPD_in : std_ulogic;
    signal CPLLREFCLKSEL_in : std_logic_vector(2 downto 0);
    signal CPLLRESET_in : std_ulogic;
    signal DMONFIFORESET_in : std_ulogic;
    signal DMONITORCLK_in : std_ulogic;
    signal DRPADDR_in : std_logic_vector(9 downto 0);
    signal DRPCLK_in : std_ulogic;
    signal DRPDI_in : std_logic_vector(15 downto 0);
    signal DRPEN_in : std_ulogic;
    signal DRPWE_in : std_ulogic;
    signal ELPCALDVORWREN_in : std_ulogic;
    signal ELPCALPAORWREN_in : std_ulogic;
    signal EVODDPHICALDONE_in : std_ulogic;
    signal EVODDPHICALSTART_in : std_ulogic;
    signal EVODDPHIDRDEN_in : std_ulogic;
    signal EVODDPHIDWREN_in : std_ulogic;
    signal EVODDPHIXRDEN_in : std_ulogic;
    signal EVODDPHIXWREN_in : std_ulogic;
    signal EYESCANMODE_in : std_ulogic;
    signal EYESCANRESET_in : std_ulogic;
    signal EYESCANTRIGGER_in : std_ulogic;
    signal GTGREFCLK_in : std_ulogic;
    signal GTNORTHREFCLK0_in : std_ulogic;
    signal GTNORTHREFCLK1_in : std_ulogic;
    signal GTREFCLK0_in : std_ulogic;
    signal GTREFCLK1_in : std_ulogic;
    signal GTRESETSEL_in : std_ulogic;
    signal GTRSVD_in : std_logic_vector(15 downto 0);
    signal GTRXRESET_in : std_ulogic;
    signal GTSOUTHREFCLK0_in : std_ulogic;
    signal GTSOUTHREFCLK1_in : std_ulogic;
    signal GTTXRESET_in : std_ulogic;
    signal GTYRXN_in : std_ulogic;
    signal GTYRXP_in : std_ulogic;
    signal LOOPBACK_in : std_logic_vector(2 downto 0);
    signal LOOPRSVD_in : std_logic_vector(15 downto 0);
    signal LPBKRXTXSEREN_in : std_ulogic;
    signal LPBKTXRXSEREN_in : std_ulogic;
    signal PCIEEQRXEQADAPTDONE_in : std_ulogic;
    signal PCIERSTIDLE_in : std_ulogic;
    signal PCIERSTTXSYNCSTART_in : std_ulogic;
    signal PCIEUSERRATEDONE_in : std_ulogic;
    signal PCSRSVDIN2_in : std_logic_vector(4 downto 0);
    signal PCSRSVDIN_in : std_logic_vector(15 downto 0);
    signal PMARSVDIN_in : std_logic_vector(4 downto 0);
    signal PMASCANCLK0_in : std_ulogic;
    signal PMASCANCLK1_in : std_ulogic;
    signal PMASCANCLK2_in : std_ulogic;
    signal PMASCANCLK3_in : std_ulogic;
    signal PMASCANCLK4_in : std_ulogic;
    signal PMASCANCLK5_in : std_ulogic;
    signal PMASCANENB_in : std_ulogic;
    signal PMASCANIN_in : std_logic_vector(11 downto 0);
    signal PMASCANMODEB_in : std_ulogic;
    signal PMASCANRSTEN_in : std_ulogic;
    signal QPLL0CLK_in : std_ulogic;
    signal QPLL0REFCLK_in : std_ulogic;
    signal QPLL1CLK_in : std_ulogic;
    signal QPLL1REFCLK_in : std_ulogic;
    signal RESETOVRD_in : std_ulogic;
    signal RSTCLKENTX_in : std_ulogic;
    signal RX8B10BEN_in : std_ulogic;
    signal RXBUFRESET_in : std_ulogic;
    signal RXCDRFREQRESET_in : std_ulogic;
    signal RXCDRHOLD_in : std_ulogic;
    signal RXCDROVRDEN_in : std_ulogic;
    signal RXCDRRESETRSV_in : std_ulogic;
    signal RXCDRRESET_in : std_ulogic;
    signal RXCHBONDEN_in : std_ulogic;
    signal RXCHBONDI_in : std_logic_vector(4 downto 0);
    signal RXCHBONDLEVEL_in : std_logic_vector(2 downto 0);
    signal RXCHBONDMASTER_in : std_ulogic;
    signal RXCHBONDSLAVE_in : std_ulogic;
    signal RXCKCALRESET_in : std_ulogic;
    signal RXCOMMADETEN_in : std_ulogic;
    signal RXDCCFORCESTART_in : std_ulogic;
    signal RXDFEAGCHOLD_in : std_ulogic;
    signal RXDFEAGCOVRDEN_in : std_ulogic;
    signal RXDFELFHOLD_in : std_ulogic;
    signal RXDFELFOVRDEN_in : std_ulogic;
    signal RXDFELPMRESET_in : std_ulogic;
    signal RXDFETAP10HOLD_in : std_ulogic;
    signal RXDFETAP10OVRDEN_in : std_ulogic;
    signal RXDFETAP11HOLD_in : std_ulogic;
    signal RXDFETAP11OVRDEN_in : std_ulogic;
    signal RXDFETAP12HOLD_in : std_ulogic;
    signal RXDFETAP12OVRDEN_in : std_ulogic;
    signal RXDFETAP13HOLD_in : std_ulogic;
    signal RXDFETAP13OVRDEN_in : std_ulogic;
    signal RXDFETAP14HOLD_in : std_ulogic;
    signal RXDFETAP14OVRDEN_in : std_ulogic;
    signal RXDFETAP15HOLD_in : std_ulogic;
    signal RXDFETAP15OVRDEN_in : std_ulogic;
    signal RXDFETAP2HOLD_in : std_ulogic;
    signal RXDFETAP2OVRDEN_in : std_ulogic;
    signal RXDFETAP3HOLD_in : std_ulogic;
    signal RXDFETAP3OVRDEN_in : std_ulogic;
    signal RXDFETAP4HOLD_in : std_ulogic;
    signal RXDFETAP4OVRDEN_in : std_ulogic;
    signal RXDFETAP5HOLD_in : std_ulogic;
    signal RXDFETAP5OVRDEN_in : std_ulogic;
    signal RXDFETAP6HOLD_in : std_ulogic;
    signal RXDFETAP6OVRDEN_in : std_ulogic;
    signal RXDFETAP7HOLD_in : std_ulogic;
    signal RXDFETAP7OVRDEN_in : std_ulogic;
    signal RXDFETAP8HOLD_in : std_ulogic;
    signal RXDFETAP8OVRDEN_in : std_ulogic;
    signal RXDFETAP9HOLD_in : std_ulogic;
    signal RXDFETAP9OVRDEN_in : std_ulogic;
    signal RXDFEUTHOLD_in : std_ulogic;
    signal RXDFEUTOVRDEN_in : std_ulogic;
    signal RXDFEVPHOLD_in : std_ulogic;
    signal RXDFEVPOVRDEN_in : std_ulogic;
    signal RXDFEVSEN_in : std_ulogic;
    signal RXDFEXYDEN_in : std_ulogic;
    signal RXDLYBYPASS_in : std_ulogic;
    signal RXDLYEN_in : std_ulogic;
    signal RXDLYOVRDEN_in : std_ulogic;
    signal RXDLYSRESET_in : std_ulogic;
    signal RXELECIDLEMODE_in : std_logic_vector(1 downto 0);
    signal RXGEARBOXSLIP_in : std_ulogic;
    signal RXLATCLK_in : std_ulogic;
    signal RXLPMEN_in : std_ulogic;
    signal RXLPMGCHOLD_in : std_ulogic;
    signal RXLPMGCOVRDEN_in : std_ulogic;
    signal RXLPMHFHOLD_in : std_ulogic;
    signal RXLPMHFOVRDEN_in : std_ulogic;
    signal RXLPMLFHOLD_in : std_ulogic;
    signal RXLPMLFKLOVRDEN_in : std_ulogic;
    signal RXLPMOSHOLD_in : std_ulogic;
    signal RXLPMOSOVRDEN_in : std_ulogic;
    signal RXMCOMMAALIGNEN_in : std_ulogic;
    signal RXMONITORSEL_in : std_logic_vector(1 downto 0);
    signal RXOOBRESET_in : std_ulogic;
    signal RXOSCALRESET_in : std_ulogic;
    signal RXOSHOLD_in : std_ulogic;
    signal RXOSINTCFG_in : std_logic_vector(3 downto 0);
    signal RXOSINTEN_in : std_ulogic;
    signal RXOSINTHOLD_in : std_ulogic;
    signal RXOSINTOVRDEN_in : std_ulogic;
    signal RXOSINTSTROBE_in : std_ulogic;
    signal RXOSINTTESTOVRDEN_in : std_ulogic;
    signal RXOSOVRDEN_in : std_ulogic;
    signal RXOUTCLKSEL_in : std_logic_vector(2 downto 0);
    signal RXPCOMMAALIGNEN_in : std_ulogic;
    signal RXPCSRESET_in : std_ulogic;
    signal RXPD_in : std_logic_vector(1 downto 0);
    signal RXPHALIGNEN_in : std_ulogic;
    signal RXPHALIGN_in : std_ulogic;
    signal RXPHDLYPD_in : std_ulogic;
    signal RXPHDLYRESET_in : std_ulogic;
    signal RXPHOVRDEN_in : std_ulogic;
    signal RXPLLCLKSEL_in : std_logic_vector(1 downto 0);
    signal RXPMARESET_in : std_ulogic;
    signal RXPOLARITY_in : std_ulogic;
    signal RXPRBSCNTRESET_in : std_ulogic;
    signal RXPRBSSEL_in : std_logic_vector(3 downto 0);
    signal RXPROGDIVRESET_in : std_ulogic;
    signal RXRATEMODE_in : std_ulogic;
    signal RXRATE_in : std_logic_vector(2 downto 0);
    signal RXSLIDE_in : std_ulogic;
    signal RXSLIPOUTCLK_in : std_ulogic;
    signal RXSLIPPMA_in : std_ulogic;
    signal RXSYNCALLIN_in : std_ulogic;
    signal RXSYNCIN_in : std_ulogic;
    signal RXSYNCMODE_in : std_ulogic;
    signal RXSYSCLKSEL_in : std_logic_vector(1 downto 0);
    signal RXUSERRDY_in : std_ulogic;
    signal RXUSRCLK2_in : std_ulogic;
    signal RXUSRCLK_in : std_ulogic;
    signal SARCCLK_in : std_ulogic;
    signal SCANCLK_in : std_ulogic;
    signal SCANENB_in : std_ulogic;
    signal SCANIN_in : std_logic_vector(18 downto 0);
    signal SCANMODEB_in : std_ulogic;
    signal SIGVALIDCLK_in : std_ulogic;
    signal TSTCLK0_in : std_ulogic;
    signal TSTCLK1_in : std_ulogic;
    signal TSTIN_in : std_logic_vector(19 downto 0);
    signal TSTPDOVRDB_in : std_ulogic;
    signal TSTPD_in : std_logic_vector(4 downto 0);
    signal TX8B10BBYPASS_in : std_logic_vector(7 downto 0);
    signal TX8B10BEN_in : std_ulogic;
    signal TXBUFDIFFCTRL_in : std_logic_vector(2 downto 0);
    signal TXCOMINIT_in : std_ulogic;
    signal TXCOMSAS_in : std_ulogic;
    signal TXCOMWAKE_in : std_ulogic;
    signal TXCTRL0_in : std_logic_vector(15 downto 0);
    signal TXCTRL1_in : std_logic_vector(15 downto 0);
    signal TXCTRL2_in : std_logic_vector(7 downto 0);
    signal TXDATAEXTENDRSVD_in : std_logic_vector(7 downto 0);
    signal TXDATA_in : std_logic_vector(127 downto 0);
    signal TXDCCFORCESTART_in : std_ulogic;
    signal TXDCCRESET_in : std_ulogic;
    signal TXDEEMPH_in : std_ulogic;
    signal TXDETECTRX_in : std_ulogic;
    signal TXDIFFCTRL_in : std_logic_vector(4 downto 0);
    signal TXDIFFPD_in : std_ulogic;
    signal TXDLYBYPASS_in : std_ulogic;
    signal TXDLYEN_in : std_ulogic;
    signal TXDLYHOLD_in : std_ulogic;
    signal TXDLYOVRDEN_in : std_ulogic;
    signal TXDLYSRESET_in : std_ulogic;
    signal TXDLYUPDOWN_in : std_ulogic;
    signal TXELECIDLE_in : std_ulogic;
    signal TXELFORCESTART_in : std_ulogic;
    signal TXHEADER_in : std_logic_vector(5 downto 0);
    signal TXINHIBIT_in : std_ulogic;
    signal TXLATCLK_in : std_ulogic;
    signal TXMAINCURSOR_in : std_logic_vector(6 downto 0);
    signal TXMARGIN_in : std_logic_vector(2 downto 0);
    signal TXOUTCLKSEL_in : std_logic_vector(2 downto 0);
    signal TXPCSRESET_in : std_ulogic;
    signal TXPDELECIDLEMODE_in : std_ulogic;
    signal TXPD_in : std_logic_vector(1 downto 0);
    signal TXPHALIGNEN_in : std_ulogic;
    signal TXPHALIGN_in : std_ulogic;
    signal TXPHDLYPD_in : std_ulogic;
    signal TXPHDLYRESET_in : std_ulogic;
    signal TXPHDLYTSTCLK_in : std_ulogic;
    signal TXPHINIT_in : std_ulogic;
    signal TXPHOVRDEN_in : std_ulogic;
    signal TXPIPPMEN_in : std_ulogic;
    signal TXPIPPMOVRDEN_in : std_ulogic;
    signal TXPIPPMPD_in : std_ulogic;
    signal TXPIPPMSEL_in : std_ulogic;
    signal TXPIPPMSTEPSIZE_in : std_logic_vector(4 downto 0);
    signal TXPISOPD_in : std_ulogic;
    signal TXPLLCLKSEL_in : std_logic_vector(1 downto 0);
    signal TXPMARESET_in : std_ulogic;
    signal TXPOLARITY_in : std_ulogic;
    signal TXPOSTCURSOR_in : std_logic_vector(4 downto 0);
    signal TXPRBSFORCEERR_in : std_ulogic;
    signal TXPRBSSEL_in : std_logic_vector(3 downto 0);
    signal TXPRECURSOR_in : std_logic_vector(4 downto 0);
    signal TXPROGDIVRESET_in : std_ulogic;
    signal TXRATEMODE_in : std_ulogic;
    signal TXRATE_in : std_logic_vector(2 downto 0);
    signal TXSEQUENCE_in : std_logic_vector(6 downto 0);
    signal TXSWING_in : std_ulogic;
    signal TXSYNCALLIN_in : std_ulogic;
    signal TXSYNCIN_in : std_ulogic;
    signal TXSYNCMODE_in : std_ulogic;
    signal TXSYSCLKSEL_in : std_logic_vector(1 downto 0);
    signal TXUSERRDY_in : std_ulogic;
    signal TXUSRCLK2_in : std_ulogic;
    signal TXUSRCLK_in : std_ulogic;
    
    begin
    glblGSR     <= TO_X01(GSR);
    BUFGTCE <= BUFGTCE_delay after OUT_DELAY;
    BUFGTCEMASK <= BUFGTCEMASK_delay after OUT_DELAY;
    BUFGTDIV <= BUFGTDIV_delay after OUT_DELAY;
    BUFGTRESET <= BUFGTRESET_delay after OUT_DELAY;
    BUFGTRSTMASK <= BUFGTRSTMASK_delay after OUT_DELAY;
    CPLLFBCLKLOST <= CPLLFBCLKLOST_delay after OUT_DELAY;
    CPLLLOCK <= CPLLLOCK_delay after OUT_DELAY;
    CPLLREFCLKLOST <= CPLLREFCLKLOST_delay after OUT_DELAY;
    DMONITOROUT <= DMONITOROUT_delay after OUT_DELAY;
    DRPDO <= DRPDO_delay after OUT_DELAY;
    DRPRDY <= DRPRDY_delay after OUT_DELAY;
    EYESCANDATAERROR <= EYESCANDATAERROR_delay after OUT_DELAY;
    GTPOWERGOOD <= GTPOWERGOOD_delay after OUT_DELAY;
    GTREFCLKMONITOR <= GTREFCLKMONITOR_delay after OUT_DELAY;
    GTYTXN <= GTYTXN_delay after OUT_DELAY;
    GTYTXP <= GTYTXP_delay after OUT_DELAY;
    PCIERATEGEN3 <= PCIERATEGEN3_delay after OUT_DELAY;
    PCIERATEIDLE <= PCIERATEIDLE_delay after OUT_DELAY;
    PCIERATEQPLLPD <= PCIERATEQPLLPD_delay after OUT_DELAY;
    PCIERATEQPLLRESET <= PCIERATEQPLLRESET_delay after OUT_DELAY;
    PCIESYNCTXSYNCDONE <= PCIESYNCTXSYNCDONE_delay after OUT_DELAY;
    PCIEUSERGEN3RDY <= PCIEUSERGEN3RDY_delay after OUT_DELAY;
    PCIEUSERPHYSTATUSRST <= PCIEUSERPHYSTATUSRST_delay after OUT_DELAY;
    PCIEUSERRATESTART <= PCIEUSERRATESTART_delay after OUT_DELAY;
    PCSRSVDOUT <= PCSRSVDOUT_delay after OUT_DELAY;
    PHYSTATUS <= PHYSTATUS_delay after OUT_DELAY;
    PINRSRVDAS <= PINRSRVDAS_delay after OUT_DELAY;
    RESETEXCEPTION <= RESETEXCEPTION_delay after OUT_DELAY;
    RXBUFSTATUS <= RXBUFSTATUS_delay after OUT_DELAY;
    RXBYTEISALIGNED <= RXBYTEISALIGNED_delay after OUT_DELAY;
    RXBYTEREALIGN <= RXBYTEREALIGN_delay after OUT_DELAY;
    RXCDRLOCK <= RXCDRLOCK_delay after OUT_DELAY;
    RXCDRPHDONE <= RXCDRPHDONE_delay after OUT_DELAY;
    RXCHANBONDSEQ <= RXCHANBONDSEQ_delay after OUT_DELAY;
    RXCHANISALIGNED <= RXCHANISALIGNED_delay after OUT_DELAY;
    RXCHANREALIGN <= RXCHANREALIGN_delay after OUT_DELAY;
    RXCHBONDO <= RXCHBONDO_delay after OUT_DELAY;
    RXCKCALDONE <= RXCKCALDONE_delay after OUT_DELAY;
    RXCLKCORCNT <= RXCLKCORCNT_delay after OUT_DELAY;
    RXCOMINITDET <= RXCOMINITDET_delay after OUT_DELAY;
    RXCOMMADET <= RXCOMMADET_delay after OUT_DELAY;
    RXCOMSASDET <= RXCOMSASDET_delay after OUT_DELAY;
    RXCOMWAKEDET <= RXCOMWAKEDET_delay after OUT_DELAY;
    RXCTRL0 <= RXCTRL0_delay after OUT_DELAY;
    RXCTRL1 <= RXCTRL1_delay after OUT_DELAY;
    RXCTRL2 <= RXCTRL2_delay after OUT_DELAY;
    RXCTRL3 <= RXCTRL3_delay after OUT_DELAY;
    RXDATA <= RXDATA_delay after OUT_DELAY;
    RXDATAEXTENDRSVD <= RXDATAEXTENDRSVD_delay after OUT_DELAY;
    RXDATAVALID <= RXDATAVALID_delay after OUT_DELAY;
    RXDLYSRESETDONE <= RXDLYSRESETDONE_delay after OUT_DELAY;
    RXELECIDLE <= RXELECIDLE_delay after OUT_DELAY;
    RXHEADER <= RXHEADER_delay after OUT_DELAY;
    RXHEADERVALID <= RXHEADERVALID_delay after OUT_DELAY;
    RXMONITOROUT <= RXMONITOROUT_delay after OUT_DELAY;
    RXOSINTDONE <= RXOSINTDONE_delay after OUT_DELAY;
    RXOSINTSTARTED <= RXOSINTSTARTED_delay after OUT_DELAY;
    RXOSINTSTROBEDONE <= RXOSINTSTROBEDONE_delay after OUT_DELAY;
    RXOSINTSTROBESTARTED <= RXOSINTSTROBESTARTED_delay after OUT_DELAY;
    RXOUTCLK <= RXOUTCLK_delay after OUT_DELAY;
    RXOUTCLKFABRIC <= RXOUTCLKFABRIC_delay after OUT_DELAY;
    RXOUTCLKPCS <= RXOUTCLKPCS_delay after OUT_DELAY;
    RXPHALIGNDONE <= RXPHALIGNDONE_delay after OUT_DELAY;
    RXPHALIGNERR <= RXPHALIGNERR_delay after OUT_DELAY;
    RXPMARESETDONE <= RXPMARESETDONE_delay after OUT_DELAY;
    RXPRBSERR <= RXPRBSERR_delay after OUT_DELAY;
    RXPRBSLOCKED <= RXPRBSLOCKED_delay after OUT_DELAY;
    RXPRGDIVRESETDONE <= RXPRGDIVRESETDONE_delay after OUT_DELAY;
    RXRATEDONE <= RXRATEDONE_delay after OUT_DELAY;
    RXRECCLKOUT <= RXRECCLKOUT_delay after OUT_DELAY;
    RXRESETDONE <= RXRESETDONE_delay after OUT_DELAY;
    RXSLIDERDY <= RXSLIDERDY_delay after OUT_DELAY;
    RXSLIPDONE <= RXSLIPDONE_delay after OUT_DELAY;
    RXSLIPOUTCLKRDY <= RXSLIPOUTCLKRDY_delay after OUT_DELAY;
    RXSLIPPMARDY <= RXSLIPPMARDY_delay after OUT_DELAY;
    RXSTARTOFSEQ <= RXSTARTOFSEQ_delay after OUT_DELAY;
    RXSTATUS <= RXSTATUS_delay after OUT_DELAY;
    RXSYNCDONE <= RXSYNCDONE_delay after OUT_DELAY;
    RXSYNCOUT <= RXSYNCOUT_delay after OUT_DELAY;
    RXVALID <= RXVALID_delay after OUT_DELAY;
    TXBUFSTATUS <= TXBUFSTATUS_delay after OUT_DELAY;
    TXCOMFINISH <= TXCOMFINISH_delay after OUT_DELAY;
    TXDCCDONE <= TXDCCDONE_delay after OUT_DELAY;
    TXDLYSRESETDONE <= TXDLYSRESETDONE_delay after OUT_DELAY;
    TXOUTCLK <= TXOUTCLK_delay after OUT_DELAY;
    TXOUTCLKFABRIC <= TXOUTCLKFABRIC_delay after OUT_DELAY;
    TXOUTCLKPCS <= TXOUTCLKPCS_delay after OUT_DELAY;
    TXPHALIGNDONE <= TXPHALIGNDONE_delay after OUT_DELAY;
    TXPHINITDONE <= TXPHINITDONE_delay after OUT_DELAY;
    TXPMARESETDONE <= TXPMARESETDONE_delay after OUT_DELAY;
    TXPRGDIVRESETDONE <= TXPRGDIVRESETDONE_delay after OUT_DELAY;
    TXRATEDONE <= TXRATEDONE_delay after OUT_DELAY;
    TXRESETDONE <= TXRESETDONE_delay after OUT_DELAY;
    TXSYNCDONE <= TXSYNCDONE_delay after OUT_DELAY;
    TXSYNCOUT <= TXSYNCOUT_delay after OUT_DELAY;
    
    BUFGTCEMASK_delay <= BUFGTCEMASK_out;
    BUFGTCE_delay <= BUFGTCE_out;
    BUFGTDIV_delay <= BUFGTDIV_out;
    BUFGTRESET_delay <= BUFGTRESET_out;
    BUFGTRSTMASK_delay <= BUFGTRSTMASK_out;
    CPLLFBCLKLOST_delay <= CPLLFBCLKLOST_out;
    CPLLLOCK_delay <= CPLLLOCK_out;
    CPLLREFCLKLOST_delay <= CPLLREFCLKLOST_out;
    DMONITOROUT_delay <= DMONITOROUT_out;
    DRPDO_delay <= DRPDO_out;
    DRPRDY_delay <= DRPRDY_out;
    EYESCANDATAERROR_delay <= EYESCANDATAERROR_out;
    GTPOWERGOOD_delay <= GTPOWERGOOD_out;
    GTREFCLKMONITOR_delay <= GTREFCLKMONITOR_out;
    GTYTXN_delay <= GTYTXN_out;
    GTYTXP_delay <= GTYTXP_out;
    PCIERATEGEN3_delay <= PCIERATEGEN3_out;
    PCIERATEIDLE_delay <= PCIERATEIDLE_out;
    PCIERATEQPLLPD_delay <= PCIERATEQPLLPD_out;
    PCIERATEQPLLRESET_delay <= PCIERATEQPLLRESET_out;
    PCIESYNCTXSYNCDONE_delay <= PCIESYNCTXSYNCDONE_out;
    PCIEUSERGEN3RDY_delay <= PCIEUSERGEN3RDY_out;
    PCIEUSERPHYSTATUSRST_delay <= PCIEUSERPHYSTATUSRST_out;
    PCIEUSERRATESTART_delay <= PCIEUSERRATESTART_out;
    PCSRSVDOUT_delay <= PCSRSVDOUT_out;
    PHYSTATUS_delay <= PHYSTATUS_out;
    PINRSRVDAS_delay <= PINRSRVDAS_out;
    RESETEXCEPTION_delay <= RESETEXCEPTION_out;
    RXBUFSTATUS_delay <= RXBUFSTATUS_out;
    RXBYTEISALIGNED_delay <= RXBYTEISALIGNED_out;
    RXBYTEREALIGN_delay <= RXBYTEREALIGN_out;
    RXCDRLOCK_delay <= RXCDRLOCK_out;
    RXCDRPHDONE_delay <= RXCDRPHDONE_out;
    RXCHANBONDSEQ_delay <= RXCHANBONDSEQ_out;
    RXCHANISALIGNED_delay <= RXCHANISALIGNED_out;
    RXCHANREALIGN_delay <= RXCHANREALIGN_out;
    RXCHBONDO_delay <= RXCHBONDO_out;
    RXCKCALDONE_delay <= RXCKCALDONE_out;
    RXCLKCORCNT_delay <= RXCLKCORCNT_out;
    RXCOMINITDET_delay <= RXCOMINITDET_out;
    RXCOMMADET_delay <= RXCOMMADET_out;
    RXCOMSASDET_delay <= RXCOMSASDET_out;
    RXCOMWAKEDET_delay <= RXCOMWAKEDET_out;
    RXCTRL0_delay <= RXCTRL0_out;
    RXCTRL1_delay <= RXCTRL1_out;
    RXCTRL2_delay <= RXCTRL2_out;
    RXCTRL3_delay <= RXCTRL3_out;
    RXDATAEXTENDRSVD_delay <= RXDATAEXTENDRSVD_out;
    RXDATAVALID_delay <= RXDATAVALID_out;
    RXDATA_delay <= RXDATA_out;
    RXDLYSRESETDONE_delay <= RXDLYSRESETDONE_out;
    RXELECIDLE_delay <= RXELECIDLE_out;
    RXHEADERVALID_delay <= RXHEADERVALID_out;
    RXHEADER_delay <= RXHEADER_out;
    RXMONITOROUT_delay <= RXMONITOROUT_out;
    RXOSINTDONE_delay <= RXOSINTDONE_out;
    RXOSINTSTARTED_delay <= RXOSINTSTARTED_out;
    RXOSINTSTROBEDONE_delay <= RXOSINTSTROBEDONE_out;
    RXOSINTSTROBESTARTED_delay <= RXOSINTSTROBESTARTED_out;
    RXOUTCLKFABRIC_delay <= RXOUTCLKFABRIC_out;
    RXOUTCLKPCS_delay <= RXOUTCLKPCS_out;
    RXOUTCLK_delay <= RXOUTCLK_out;
    RXPHALIGNDONE_delay <= RXPHALIGNDONE_out;
    RXPHALIGNERR_delay <= RXPHALIGNERR_out;
    RXPMARESETDONE_delay <= RXPMARESETDONE_out;
    RXPRBSERR_delay <= RXPRBSERR_out;
    RXPRBSLOCKED_delay <= RXPRBSLOCKED_out;
    RXPRGDIVRESETDONE_delay <= RXPRGDIVRESETDONE_out;
    RXRATEDONE_delay <= RXRATEDONE_out;
    RXRECCLKOUT_delay <= RXRECCLKOUT_out;
    RXRESETDONE_delay <= RXRESETDONE_out;
    RXSLIDERDY_delay <= RXSLIDERDY_out;
    RXSLIPDONE_delay <= RXSLIPDONE_out;
    RXSLIPOUTCLKRDY_delay <= RXSLIPOUTCLKRDY_out;
    RXSLIPPMARDY_delay <= RXSLIPPMARDY_out;
    RXSTARTOFSEQ_delay <= RXSTARTOFSEQ_out;
    RXSTATUS_delay <= RXSTATUS_out;
    RXSYNCDONE_delay <= RXSYNCDONE_out;
    RXSYNCOUT_delay <= RXSYNCOUT_out;
    RXVALID_delay <= RXVALID_out;
    TXBUFSTATUS_delay <= TXBUFSTATUS_out;
    TXCOMFINISH_delay <= TXCOMFINISH_out;
    TXDCCDONE_delay <= TXDCCDONE_out;
    TXDLYSRESETDONE_delay <= TXDLYSRESETDONE_out;
    TXOUTCLKFABRIC_delay <= TXOUTCLKFABRIC_out;
    TXOUTCLKPCS_delay <= TXOUTCLKPCS_out;
    TXOUTCLK_delay <= TXOUTCLK_out;
    TXPHALIGNDONE_delay <= TXPHALIGNDONE_out;
    TXPHINITDONE_delay <= TXPHINITDONE_out;
    TXPMARESETDONE_delay <= TXPMARESETDONE_out;
    TXPRGDIVRESETDONE_delay <= TXPRGDIVRESETDONE_out;
    TXRATEDONE_delay <= TXRATEDONE_out;
    TXRESETDONE_delay <= TXRESETDONE_out;
    TXSYNCDONE_delay <= TXSYNCDONE_out;
    TXSYNCOUT_delay <= TXSYNCOUT_out;
    
    CLKRSVD0_delay <= CLKRSVD0 after INCLK_DELAY;
    CLKRSVD1_delay <= CLKRSVD1 after INCLK_DELAY;
    CPLLLOCKDETCLK_delay <= CPLLLOCKDETCLK after INCLK_DELAY;
    DMONITORCLK_delay <= DMONITORCLK after INCLK_DELAY;
    DRPCLK_delay <= DRPCLK after INCLK_DELAY;
    GTGREFCLK_delay <= GTGREFCLK after INCLK_DELAY;
    RXLATCLK_delay <= RXLATCLK after INCLK_DELAY;
    RXUSRCLK2_delay <= RXUSRCLK2 after INCLK_DELAY;
    RXUSRCLK_delay <= RXUSRCLK after INCLK_DELAY;
    SIGVALIDCLK_delay <= SIGVALIDCLK after INCLK_DELAY;
    TXLATCLK_delay <= TXLATCLK after INCLK_DELAY;
    TXPHDLYTSTCLK_delay <= TXPHDLYTSTCLK after INCLK_DELAY;
    TXUSRCLK2_delay <= TXUSRCLK2 after INCLK_DELAY;
    TXUSRCLK_delay <= TXUSRCLK after INCLK_DELAY;
    
    CDRSTEPDIR_delay <= CDRSTEPDIR after IN_DELAY;
    CDRSTEPSQ_delay <= CDRSTEPSQ after IN_DELAY;
    CDRSTEPSX_delay <= CDRSTEPSX after IN_DELAY;
    CFGRESET_delay <= CFGRESET after IN_DELAY;
    CPLLLOCKEN_delay <= CPLLLOCKEN after IN_DELAY;
    CPLLPD_delay <= CPLLPD after IN_DELAY;
    CPLLREFCLKSEL_delay <= CPLLREFCLKSEL after IN_DELAY;
    CPLLRESET_delay <= CPLLRESET after IN_DELAY;
    DMONFIFORESET_delay <= DMONFIFORESET after IN_DELAY;
    DRPADDR_delay <= DRPADDR after IN_DELAY;
    DRPDI_delay <= DRPDI after IN_DELAY;
    DRPEN_delay <= DRPEN after IN_DELAY;
    DRPWE_delay <= DRPWE after IN_DELAY;
    ELPCALDVORWREN_delay <= ELPCALDVORWREN after IN_DELAY;
    ELPCALPAORWREN_delay <= ELPCALPAORWREN after IN_DELAY;
    EVODDPHICALDONE_delay <= EVODDPHICALDONE after IN_DELAY;
    EVODDPHICALSTART_delay <= EVODDPHICALSTART after IN_DELAY;
    EVODDPHIDRDEN_delay <= EVODDPHIDRDEN after IN_DELAY;
    EVODDPHIDWREN_delay <= EVODDPHIDWREN after IN_DELAY;
    EVODDPHIXRDEN_delay <= EVODDPHIXRDEN after IN_DELAY;
    EVODDPHIXWREN_delay <= EVODDPHIXWREN after IN_DELAY;
    EYESCANMODE_delay <= EYESCANMODE after IN_DELAY;
    EYESCANRESET_delay <= EYESCANRESET after IN_DELAY;
    EYESCANTRIGGER_delay <= EYESCANTRIGGER after IN_DELAY;
    GTNORTHREFCLK0_delay <= GTNORTHREFCLK0 after IN_DELAY;
    GTNORTHREFCLK1_delay <= GTNORTHREFCLK1 after IN_DELAY;
    GTREFCLK0_delay <= GTREFCLK0 after IN_DELAY;
    GTREFCLK1_delay <= GTREFCLK1 after IN_DELAY;
    GTRESETSEL_delay <= GTRESETSEL after IN_DELAY;
    GTRSVD_delay <= GTRSVD after IN_DELAY;
    GTRXRESET_delay <= GTRXRESET after IN_DELAY;
    GTSOUTHREFCLK0_delay <= GTSOUTHREFCLK0 after IN_DELAY;
    GTSOUTHREFCLK1_delay <= GTSOUTHREFCLK1 after IN_DELAY;
    GTTXRESET_delay <= GTTXRESET after IN_DELAY;
    GTYRXN_delay <= GTYRXN after IN_DELAY;
    GTYRXP_delay <= GTYRXP after IN_DELAY;
    LOOPBACK_delay <= LOOPBACK after IN_DELAY;
    LOOPRSVD_delay <= LOOPRSVD after IN_DELAY;
    LPBKRXTXSEREN_delay <= LPBKRXTXSEREN after IN_DELAY;
    LPBKTXRXSEREN_delay <= LPBKTXRXSEREN after IN_DELAY;
    PCIEEQRXEQADAPTDONE_delay <= PCIEEQRXEQADAPTDONE after IN_DELAY;
    PCIERSTIDLE_delay <= PCIERSTIDLE after IN_DELAY;
    PCIERSTTXSYNCSTART_delay <= PCIERSTTXSYNCSTART after IN_DELAY;
    PCIEUSERRATEDONE_delay <= PCIEUSERRATEDONE after IN_DELAY;
    PCSRSVDIN2_delay <= PCSRSVDIN2 after IN_DELAY;
    PCSRSVDIN_delay <= PCSRSVDIN after IN_DELAY;
    PMARSVDIN_delay <= PMARSVDIN after IN_DELAY;
    QPLL0CLK_delay <= QPLL0CLK after IN_DELAY;
    QPLL0REFCLK_delay <= QPLL0REFCLK after IN_DELAY;
    QPLL1CLK_delay <= QPLL1CLK after IN_DELAY;
    QPLL1REFCLK_delay <= QPLL1REFCLK after IN_DELAY;
    RESETOVRD_delay <= RESETOVRD after IN_DELAY;
    RSTCLKENTX_delay <= RSTCLKENTX after IN_DELAY;
    RX8B10BEN_delay <= RX8B10BEN after IN_DELAY;
    RXBUFRESET_delay <= RXBUFRESET after IN_DELAY;
    RXCDRFREQRESET_delay <= RXCDRFREQRESET after IN_DELAY;
    RXCDRHOLD_delay <= RXCDRHOLD after IN_DELAY;
    RXCDROVRDEN_delay <= RXCDROVRDEN after IN_DELAY;
    RXCDRRESETRSV_delay <= RXCDRRESETRSV after IN_DELAY;
    RXCDRRESET_delay <= RXCDRRESET after IN_DELAY;
    RXCHBONDEN_delay <= RXCHBONDEN after IN_DELAY;
    RXCHBONDI_delay <= RXCHBONDI after IN_DELAY;
    RXCHBONDLEVEL_delay <= RXCHBONDLEVEL after IN_DELAY;
    RXCHBONDMASTER_delay <= RXCHBONDMASTER after IN_DELAY;
    RXCHBONDSLAVE_delay <= RXCHBONDSLAVE after IN_DELAY;
    RXCKCALRESET_delay <= RXCKCALRESET after IN_DELAY;
    RXCOMMADETEN_delay <= RXCOMMADETEN after IN_DELAY;
    RXDCCFORCESTART_delay <= RXDCCFORCESTART after IN_DELAY;
    RXDFEAGCHOLD_delay <= RXDFEAGCHOLD after IN_DELAY;
    RXDFEAGCOVRDEN_delay <= RXDFEAGCOVRDEN after IN_DELAY;
    RXDFELFHOLD_delay <= RXDFELFHOLD after IN_DELAY;
    RXDFELFOVRDEN_delay <= RXDFELFOVRDEN after IN_DELAY;
    RXDFELPMRESET_delay <= RXDFELPMRESET after IN_DELAY;
    RXDFETAP10HOLD_delay <= RXDFETAP10HOLD after IN_DELAY;
    RXDFETAP10OVRDEN_delay <= RXDFETAP10OVRDEN after IN_DELAY;
    RXDFETAP11HOLD_delay <= RXDFETAP11HOLD after IN_DELAY;
    RXDFETAP11OVRDEN_delay <= RXDFETAP11OVRDEN after IN_DELAY;
    RXDFETAP12HOLD_delay <= RXDFETAP12HOLD after IN_DELAY;
    RXDFETAP12OVRDEN_delay <= RXDFETAP12OVRDEN after IN_DELAY;
    RXDFETAP13HOLD_delay <= RXDFETAP13HOLD after IN_DELAY;
    RXDFETAP13OVRDEN_delay <= RXDFETAP13OVRDEN after IN_DELAY;
    RXDFETAP14HOLD_delay <= RXDFETAP14HOLD after IN_DELAY;
    RXDFETAP14OVRDEN_delay <= RXDFETAP14OVRDEN after IN_DELAY;
    RXDFETAP15HOLD_delay <= RXDFETAP15HOLD after IN_DELAY;
    RXDFETAP15OVRDEN_delay <= RXDFETAP15OVRDEN after IN_DELAY;
    RXDFETAP2HOLD_delay <= RXDFETAP2HOLD after IN_DELAY;
    RXDFETAP2OVRDEN_delay <= RXDFETAP2OVRDEN after IN_DELAY;
    RXDFETAP3HOLD_delay <= RXDFETAP3HOLD after IN_DELAY;
    RXDFETAP3OVRDEN_delay <= RXDFETAP3OVRDEN after IN_DELAY;
    RXDFETAP4HOLD_delay <= RXDFETAP4HOLD after IN_DELAY;
    RXDFETAP4OVRDEN_delay <= RXDFETAP4OVRDEN after IN_DELAY;
    RXDFETAP5HOLD_delay <= RXDFETAP5HOLD after IN_DELAY;
    RXDFETAP5OVRDEN_delay <= RXDFETAP5OVRDEN after IN_DELAY;
    RXDFETAP6HOLD_delay <= RXDFETAP6HOLD after IN_DELAY;
    RXDFETAP6OVRDEN_delay <= RXDFETAP6OVRDEN after IN_DELAY;
    RXDFETAP7HOLD_delay <= RXDFETAP7HOLD after IN_DELAY;
    RXDFETAP7OVRDEN_delay <= RXDFETAP7OVRDEN after IN_DELAY;
    RXDFETAP8HOLD_delay <= RXDFETAP8HOLD after IN_DELAY;
    RXDFETAP8OVRDEN_delay <= RXDFETAP8OVRDEN after IN_DELAY;
    RXDFETAP9HOLD_delay <= RXDFETAP9HOLD after IN_DELAY;
    RXDFETAP9OVRDEN_delay <= RXDFETAP9OVRDEN after IN_DELAY;
    RXDFEUTHOLD_delay <= RXDFEUTHOLD after IN_DELAY;
    RXDFEUTOVRDEN_delay <= RXDFEUTOVRDEN after IN_DELAY;
    RXDFEVPHOLD_delay <= RXDFEVPHOLD after IN_DELAY;
    RXDFEVPOVRDEN_delay <= RXDFEVPOVRDEN after IN_DELAY;
    RXDFEVSEN_delay <= RXDFEVSEN after IN_DELAY;
    RXDFEXYDEN_delay <= RXDFEXYDEN after IN_DELAY;
    RXDLYBYPASS_delay <= RXDLYBYPASS after IN_DELAY;
    RXDLYEN_delay <= RXDLYEN after IN_DELAY;
    RXDLYOVRDEN_delay <= RXDLYOVRDEN after IN_DELAY;
    RXDLYSRESET_delay <= RXDLYSRESET after IN_DELAY;
    RXELECIDLEMODE_delay <= RXELECIDLEMODE after IN_DELAY;
    RXGEARBOXSLIP_delay <= RXGEARBOXSLIP after IN_DELAY;
    RXLPMEN_delay <= RXLPMEN after IN_DELAY;
    RXLPMGCHOLD_delay <= RXLPMGCHOLD after IN_DELAY;
    RXLPMGCOVRDEN_delay <= RXLPMGCOVRDEN after IN_DELAY;
    RXLPMHFHOLD_delay <= RXLPMHFHOLD after IN_DELAY;
    RXLPMHFOVRDEN_delay <= RXLPMHFOVRDEN after IN_DELAY;
    RXLPMLFHOLD_delay <= RXLPMLFHOLD after IN_DELAY;
    RXLPMLFKLOVRDEN_delay <= RXLPMLFKLOVRDEN after IN_DELAY;
    RXLPMOSHOLD_delay <= RXLPMOSHOLD after IN_DELAY;
    RXLPMOSOVRDEN_delay <= RXLPMOSOVRDEN after IN_DELAY;
    RXMCOMMAALIGNEN_delay <= RXMCOMMAALIGNEN after IN_DELAY;
    RXMONITORSEL_delay <= RXMONITORSEL after IN_DELAY;
    RXOOBRESET_delay <= RXOOBRESET after IN_DELAY;
    RXOSCALRESET_delay <= RXOSCALRESET after IN_DELAY;
    RXOSHOLD_delay <= RXOSHOLD after IN_DELAY;
    RXOSINTCFG_delay <= RXOSINTCFG after IN_DELAY;
    RXOSINTEN_delay <= RXOSINTEN after IN_DELAY;
    RXOSINTHOLD_delay <= RXOSINTHOLD after IN_DELAY;
    RXOSINTOVRDEN_delay <= RXOSINTOVRDEN after IN_DELAY;
    RXOSINTSTROBE_delay <= RXOSINTSTROBE after IN_DELAY;
    RXOSINTTESTOVRDEN_delay <= RXOSINTTESTOVRDEN after IN_DELAY;
    RXOSOVRDEN_delay <= RXOSOVRDEN after IN_DELAY;
    RXOUTCLKSEL_delay <= RXOUTCLKSEL after IN_DELAY;
    RXPCOMMAALIGNEN_delay <= RXPCOMMAALIGNEN after IN_DELAY;
    RXPCSRESET_delay <= RXPCSRESET after IN_DELAY;
    RXPD_delay <= RXPD after IN_DELAY;
    RXPHALIGNEN_delay <= RXPHALIGNEN after IN_DELAY;
    RXPHALIGN_delay <= RXPHALIGN after IN_DELAY;
    RXPHDLYPD_delay <= RXPHDLYPD after IN_DELAY;
    RXPHDLYRESET_delay <= RXPHDLYRESET after IN_DELAY;
    RXPHOVRDEN_delay <= RXPHOVRDEN after IN_DELAY;
    RXPLLCLKSEL_delay <= RXPLLCLKSEL after IN_DELAY;
    RXPMARESET_delay <= RXPMARESET after IN_DELAY;
    RXPOLARITY_delay <= RXPOLARITY after IN_DELAY;
    RXPRBSCNTRESET_delay <= RXPRBSCNTRESET after IN_DELAY;
    RXPRBSSEL_delay <= RXPRBSSEL after IN_DELAY;
    RXPROGDIVRESET_delay <= RXPROGDIVRESET after IN_DELAY;
    RXRATEMODE_delay <= RXRATEMODE after IN_DELAY;
    RXRATE_delay <= RXRATE after IN_DELAY;
    RXSLIDE_delay <= RXSLIDE after IN_DELAY;
    RXSLIPOUTCLK_delay <= RXSLIPOUTCLK after IN_DELAY;
    RXSLIPPMA_delay <= RXSLIPPMA after IN_DELAY;
    RXSYNCALLIN_delay <= RXSYNCALLIN after IN_DELAY;
    RXSYNCIN_delay <= RXSYNCIN after IN_DELAY;
    RXSYNCMODE_delay <= RXSYNCMODE after IN_DELAY;
    RXSYSCLKSEL_delay <= RXSYSCLKSEL after IN_DELAY;
    RXUSERRDY_delay <= RXUSERRDY after IN_DELAY;
    TSTIN_delay <= TSTIN after IN_DELAY;
    TX8B10BBYPASS_delay <= TX8B10BBYPASS after IN_DELAY;
    TX8B10BEN_delay <= TX8B10BEN after IN_DELAY;
    TXBUFDIFFCTRL_delay <= TXBUFDIFFCTRL after IN_DELAY;
    TXCOMINIT_delay <= TXCOMINIT after IN_DELAY;
    TXCOMSAS_delay <= TXCOMSAS after IN_DELAY;
    TXCOMWAKE_delay <= TXCOMWAKE after IN_DELAY;
    TXCTRL0_delay <= TXCTRL0 after IN_DELAY;
    TXCTRL1_delay <= TXCTRL1 after IN_DELAY;
    TXCTRL2_delay <= TXCTRL2 after IN_DELAY;
    TXDATAEXTENDRSVD_delay <= TXDATAEXTENDRSVD after IN_DELAY;
    TXDATA_delay <= TXDATA after IN_DELAY;
    TXDCCFORCESTART_delay <= TXDCCFORCESTART after IN_DELAY;
    TXDCCRESET_delay <= TXDCCRESET after IN_DELAY;
    TXDEEMPH_delay <= TXDEEMPH after IN_DELAY;
    TXDETECTRX_delay <= TXDETECTRX after IN_DELAY;
    TXDIFFCTRL_delay <= TXDIFFCTRL after IN_DELAY;
    TXDIFFPD_delay <= TXDIFFPD after IN_DELAY;
    TXDLYBYPASS_delay <= TXDLYBYPASS after IN_DELAY;
    TXDLYEN_delay <= TXDLYEN after IN_DELAY;
    TXDLYHOLD_delay <= TXDLYHOLD after IN_DELAY;
    TXDLYOVRDEN_delay <= TXDLYOVRDEN after IN_DELAY;
    TXDLYSRESET_delay <= TXDLYSRESET after IN_DELAY;
    TXDLYUPDOWN_delay <= TXDLYUPDOWN after IN_DELAY;
    TXELECIDLE_delay <= TXELECIDLE after IN_DELAY;
    TXELFORCESTART_delay <= TXELFORCESTART after IN_DELAY;
    TXHEADER_delay <= TXHEADER after IN_DELAY;
    TXINHIBIT_delay <= TXINHIBIT after IN_DELAY;
    TXMAINCURSOR_delay <= TXMAINCURSOR after IN_DELAY;
    TXMARGIN_delay <= TXMARGIN after IN_DELAY;
    TXOUTCLKSEL_delay <= TXOUTCLKSEL after IN_DELAY;
    TXPCSRESET_delay <= TXPCSRESET after IN_DELAY;
    TXPDELECIDLEMODE_delay <= TXPDELECIDLEMODE after IN_DELAY;
    TXPD_delay <= TXPD after IN_DELAY;
    TXPHALIGNEN_delay <= TXPHALIGNEN after IN_DELAY;
    TXPHALIGN_delay <= TXPHALIGN after IN_DELAY;
    TXPHDLYPD_delay <= TXPHDLYPD after IN_DELAY;
    TXPHDLYRESET_delay <= TXPHDLYRESET after IN_DELAY;
    TXPHINIT_delay <= TXPHINIT after IN_DELAY;
    TXPHOVRDEN_delay <= TXPHOVRDEN after IN_DELAY;
    TXPIPPMEN_delay <= TXPIPPMEN after IN_DELAY;
    TXPIPPMOVRDEN_delay <= TXPIPPMOVRDEN after IN_DELAY;
    TXPIPPMPD_delay <= TXPIPPMPD after IN_DELAY;
    TXPIPPMSEL_delay <= TXPIPPMSEL after IN_DELAY;
    TXPIPPMSTEPSIZE_delay <= TXPIPPMSTEPSIZE after IN_DELAY;
    TXPISOPD_delay <= TXPISOPD after IN_DELAY;
    TXPLLCLKSEL_delay <= TXPLLCLKSEL after IN_DELAY;
    TXPMARESET_delay <= TXPMARESET after IN_DELAY;
    TXPOLARITY_delay <= TXPOLARITY after IN_DELAY;
    TXPOSTCURSOR_delay <= TXPOSTCURSOR after IN_DELAY;
    TXPRBSFORCEERR_delay <= TXPRBSFORCEERR after IN_DELAY;
    TXPRBSSEL_delay <= TXPRBSSEL after IN_DELAY;
    TXPRECURSOR_delay <= TXPRECURSOR after IN_DELAY;
    TXPROGDIVRESET_delay <= TXPROGDIVRESET after IN_DELAY;
    TXRATEMODE_delay <= TXRATEMODE after IN_DELAY;
    TXRATE_delay <= TXRATE after IN_DELAY;
    TXSEQUENCE_delay <= TXSEQUENCE after IN_DELAY;
    TXSWING_delay <= TXSWING after IN_DELAY;
    TXSYNCALLIN_delay <= TXSYNCALLIN after IN_DELAY;
    TXSYNCIN_delay <= TXSYNCIN after IN_DELAY;
    TXSYNCMODE_delay <= TXSYNCMODE after IN_DELAY;
    TXSYSCLKSEL_delay <= TXSYSCLKSEL after IN_DELAY;
    TXUSERRDY_delay <= TXUSERRDY after IN_DELAY;
    
    CDRSTEPDIR_in <= CDRSTEPDIR_delay;
    CDRSTEPSQ_in <= CDRSTEPSQ_delay;
    CDRSTEPSX_in <= CDRSTEPSX_delay;
    CFGRESET_in <= CFGRESET_delay;
    CLKRSVD0_in <= CLKRSVD0_delay;
    CLKRSVD1_in <= CLKRSVD1_delay;
    CPLLLOCKDETCLK_in <= CPLLLOCKDETCLK_delay;
    CPLLLOCKEN_in <= CPLLLOCKEN_delay;
    CPLLPD_in <= CPLLPD_delay;
    CPLLREFCLKSEL_in <= CPLLREFCLKSEL_delay;
    CPLLRESET_in <= CPLLRESET_delay;
    DMONFIFORESET_in <= DMONFIFORESET_delay;
    DMONITORCLK_in <= DMONITORCLK_delay;
    DRPADDR_in <= DRPADDR_delay;
    DRPCLK_in <= DRPCLK_delay;
    DRPDI_in <= DRPDI_delay;
    DRPEN_in <= DRPEN_delay;
    DRPWE_in <= DRPWE_delay;
    ELPCALDVORWREN_in <= ELPCALDVORWREN_delay;
    ELPCALPAORWREN_in <= ELPCALPAORWREN_delay;
    EVODDPHICALDONE_in <= EVODDPHICALDONE_delay;
    EVODDPHICALSTART_in <= EVODDPHICALSTART_delay;
    EVODDPHIDRDEN_in <= EVODDPHIDRDEN_delay;
    EVODDPHIDWREN_in <= EVODDPHIDWREN_delay;
    EVODDPHIXRDEN_in <= EVODDPHIXRDEN_delay;
    EVODDPHIXWREN_in <= EVODDPHIXWREN_delay;
    EYESCANMODE_in <= EYESCANMODE_delay;
    EYESCANRESET_in <= EYESCANRESET_delay;
    EYESCANTRIGGER_in <= EYESCANTRIGGER_delay;
    GTGREFCLK_in <= GTGREFCLK_delay;
    GTNORTHREFCLK0_in <= GTNORTHREFCLK0_delay;
    GTNORTHREFCLK1_in <= GTNORTHREFCLK1_delay;
    GTREFCLK0_in <= GTREFCLK0_delay;
    GTREFCLK1_in <= GTREFCLK1_delay;
    GTRESETSEL_in <= GTRESETSEL_delay;
    GTRSVD_in <= GTRSVD_delay;
    GTRXRESET_in <= GTRXRESET_delay;
    GTSOUTHREFCLK0_in <= GTSOUTHREFCLK0_delay;
    GTSOUTHREFCLK1_in <= GTSOUTHREFCLK1_delay;
    GTTXRESET_in <= GTTXRESET_delay;
    GTYRXN_in <= GTYRXN_delay;
    GTYRXP_in <= GTYRXP_delay;
    LOOPBACK_in <= LOOPBACK_delay;
    LOOPRSVD_in <= LOOPRSVD_delay;
    LPBKRXTXSEREN_in <= LPBKRXTXSEREN_delay;
    LPBKTXRXSEREN_in <= LPBKTXRXSEREN_delay;
    PCIEEQRXEQADAPTDONE_in <= PCIEEQRXEQADAPTDONE_delay;
    PCIERSTIDLE_in <= PCIERSTIDLE_delay;
    PCIERSTTXSYNCSTART_in <= PCIERSTTXSYNCSTART_delay;
    PCIEUSERRATEDONE_in <= PCIEUSERRATEDONE_delay;
    PCSRSVDIN2_in <= PCSRSVDIN2_delay;
    PCSRSVDIN_in <= PCSRSVDIN_delay;
    PMARSVDIN_in <= PMARSVDIN_delay;
    QPLL0CLK_in <= QPLL0CLK_delay;
    QPLL0REFCLK_in <= QPLL0REFCLK_delay;
    QPLL1CLK_in <= QPLL1CLK_delay;
    QPLL1REFCLK_in <= QPLL1REFCLK_delay;
    RESETOVRD_in <= RESETOVRD_delay;
    RSTCLKENTX_in <= RSTCLKENTX_delay;
    RX8B10BEN_in <= RX8B10BEN_delay;
    RXBUFRESET_in <= RXBUFRESET_delay;
    RXCDRFREQRESET_in <= RXCDRFREQRESET_delay;
    RXCDRHOLD_in <= RXCDRHOLD_delay;
    RXCDROVRDEN_in <= RXCDROVRDEN_delay;
    RXCDRRESETRSV_in <= RXCDRRESETRSV_delay;
    RXCDRRESET_in <= RXCDRRESET_delay;
    RXCHBONDEN_in <= RXCHBONDEN_delay;
    RXCHBONDI_in <= RXCHBONDI_delay;
    RXCHBONDLEVEL_in <= RXCHBONDLEVEL_delay;
    RXCHBONDMASTER_in <= RXCHBONDMASTER_delay;
    RXCHBONDSLAVE_in <= RXCHBONDSLAVE_delay;
    RXCKCALRESET_in <= RXCKCALRESET_delay;
    RXCOMMADETEN_in <= RXCOMMADETEN_delay;
    RXDCCFORCESTART_in <= RXDCCFORCESTART_delay;
    RXDFEAGCHOLD_in <= RXDFEAGCHOLD_delay;
    RXDFEAGCOVRDEN_in <= RXDFEAGCOVRDEN_delay;
    RXDFELFHOLD_in <= RXDFELFHOLD_delay;
    RXDFELFOVRDEN_in <= RXDFELFOVRDEN_delay;
    RXDFELPMRESET_in <= RXDFELPMRESET_delay;
    RXDFETAP10HOLD_in <= RXDFETAP10HOLD_delay;
    RXDFETAP10OVRDEN_in <= RXDFETAP10OVRDEN_delay;
    RXDFETAP11HOLD_in <= RXDFETAP11HOLD_delay;
    RXDFETAP11OVRDEN_in <= RXDFETAP11OVRDEN_delay;
    RXDFETAP12HOLD_in <= RXDFETAP12HOLD_delay;
    RXDFETAP12OVRDEN_in <= RXDFETAP12OVRDEN_delay;
    RXDFETAP13HOLD_in <= RXDFETAP13HOLD_delay;
    RXDFETAP13OVRDEN_in <= RXDFETAP13OVRDEN_delay;
    RXDFETAP14HOLD_in <= RXDFETAP14HOLD_delay;
    RXDFETAP14OVRDEN_in <= RXDFETAP14OVRDEN_delay;
    RXDFETAP15HOLD_in <= RXDFETAP15HOLD_delay;
    RXDFETAP15OVRDEN_in <= RXDFETAP15OVRDEN_delay;
    RXDFETAP2HOLD_in <= RXDFETAP2HOLD_delay;
    RXDFETAP2OVRDEN_in <= RXDFETAP2OVRDEN_delay;
    RXDFETAP3HOLD_in <= RXDFETAP3HOLD_delay;
    RXDFETAP3OVRDEN_in <= RXDFETAP3OVRDEN_delay;
    RXDFETAP4HOLD_in <= RXDFETAP4HOLD_delay;
    RXDFETAP4OVRDEN_in <= RXDFETAP4OVRDEN_delay;
    RXDFETAP5HOLD_in <= RXDFETAP5HOLD_delay;
    RXDFETAP5OVRDEN_in <= RXDFETAP5OVRDEN_delay;
    RXDFETAP6HOLD_in <= RXDFETAP6HOLD_delay;
    RXDFETAP6OVRDEN_in <= RXDFETAP6OVRDEN_delay;
    RXDFETAP7HOLD_in <= RXDFETAP7HOLD_delay;
    RXDFETAP7OVRDEN_in <= RXDFETAP7OVRDEN_delay;
    RXDFETAP8HOLD_in <= RXDFETAP8HOLD_delay;
    RXDFETAP8OVRDEN_in <= RXDFETAP8OVRDEN_delay;
    RXDFETAP9HOLD_in <= RXDFETAP9HOLD_delay;
    RXDFETAP9OVRDEN_in <= RXDFETAP9OVRDEN_delay;
    RXDFEUTHOLD_in <= RXDFEUTHOLD_delay;
    RXDFEUTOVRDEN_in <= RXDFEUTOVRDEN_delay;
    RXDFEVPHOLD_in <= RXDFEVPHOLD_delay;
    RXDFEVPOVRDEN_in <= RXDFEVPOVRDEN_delay;
    RXDFEVSEN_in <= RXDFEVSEN_delay;
    RXDFEXYDEN_in <= RXDFEXYDEN_delay;
    RXDLYBYPASS_in <= RXDLYBYPASS_delay;
    RXDLYEN_in <= RXDLYEN_delay;
    RXDLYOVRDEN_in <= RXDLYOVRDEN_delay;
    RXDLYSRESET_in <= RXDLYSRESET_delay;
    RXELECIDLEMODE_in <= RXELECIDLEMODE_delay;
    RXGEARBOXSLIP_in <= RXGEARBOXSLIP_delay;
    RXLATCLK_in <= RXLATCLK_delay;
    RXLPMEN_in <= RXLPMEN_delay;
    RXLPMGCHOLD_in <= RXLPMGCHOLD_delay;
    RXLPMGCOVRDEN_in <= RXLPMGCOVRDEN_delay;
    RXLPMHFHOLD_in <= RXLPMHFHOLD_delay;
    RXLPMHFOVRDEN_in <= RXLPMHFOVRDEN_delay;
    RXLPMLFHOLD_in <= RXLPMLFHOLD_delay;
    RXLPMLFKLOVRDEN_in <= RXLPMLFKLOVRDEN_delay;
    RXLPMOSHOLD_in <= RXLPMOSHOLD_delay;
    RXLPMOSOVRDEN_in <= RXLPMOSOVRDEN_delay;
    RXMCOMMAALIGNEN_in <= RXMCOMMAALIGNEN_delay;
    RXMONITORSEL_in <= RXMONITORSEL_delay;
    RXOOBRESET_in <= RXOOBRESET_delay;
    RXOSCALRESET_in <= RXOSCALRESET_delay;
    RXOSHOLD_in <= RXOSHOLD_delay;
    RXOSINTCFG_in <= RXOSINTCFG_delay;
    RXOSINTEN_in <= RXOSINTEN_delay;
    RXOSINTHOLD_in <= RXOSINTHOLD_delay;
    RXOSINTOVRDEN_in <= RXOSINTOVRDEN_delay;
    RXOSINTSTROBE_in <= RXOSINTSTROBE_delay;
    RXOSINTTESTOVRDEN_in <= RXOSINTTESTOVRDEN_delay;
    RXOSOVRDEN_in <= RXOSOVRDEN_delay;
    RXOUTCLKSEL_in <= RXOUTCLKSEL_delay;
    RXPCOMMAALIGNEN_in <= RXPCOMMAALIGNEN_delay;
    RXPCSRESET_in <= RXPCSRESET_delay;
    RXPD_in <= RXPD_delay;
    RXPHALIGNEN_in <= RXPHALIGNEN_delay;
    RXPHALIGN_in <= RXPHALIGN_delay;
    RXPHDLYPD_in <= RXPHDLYPD_delay;
    RXPHDLYRESET_in <= RXPHDLYRESET_delay;
    RXPHOVRDEN_in <= RXPHOVRDEN_delay;
    RXPLLCLKSEL_in <= RXPLLCLKSEL_delay;
    RXPMARESET_in <= RXPMARESET_delay;
    RXPOLARITY_in <= RXPOLARITY_delay;
    RXPRBSCNTRESET_in <= RXPRBSCNTRESET_delay;
    RXPRBSSEL_in <= RXPRBSSEL_delay;
    RXPROGDIVRESET_in <= RXPROGDIVRESET_delay;
    RXRATEMODE_in <= RXRATEMODE_delay;
    RXRATE_in <= RXRATE_delay;
    RXSLIDE_in <= RXSLIDE_delay;
    RXSLIPOUTCLK_in <= RXSLIPOUTCLK_delay;
    RXSLIPPMA_in <= RXSLIPPMA_delay;
    RXSYNCALLIN_in <= RXSYNCALLIN_delay;
    RXSYNCIN_in <= RXSYNCIN_delay;
    RXSYNCMODE_in <= RXSYNCMODE_delay;
    RXSYSCLKSEL_in <= RXSYSCLKSEL_delay;
    RXUSERRDY_in <= RXUSERRDY_delay;
    RXUSRCLK2_in <= RXUSRCLK2_delay;
    RXUSRCLK_in <= RXUSRCLK_delay;
    SIGVALIDCLK_in <= SIGVALIDCLK_delay;
    TSTIN_in <= TSTIN_delay;
    TX8B10BBYPASS_in <= TX8B10BBYPASS_delay;
    TX8B10BEN_in <= TX8B10BEN_delay;
    TXBUFDIFFCTRL_in <= TXBUFDIFFCTRL_delay;
    TXCOMINIT_in <= TXCOMINIT_delay;
    TXCOMSAS_in <= TXCOMSAS_delay;
    TXCOMWAKE_in <= TXCOMWAKE_delay;
    TXCTRL0_in <= TXCTRL0_delay;
    TXCTRL1_in <= TXCTRL1_delay;
    TXCTRL2_in <= TXCTRL2_delay;
    TXDATAEXTENDRSVD_in <= TXDATAEXTENDRSVD_delay;
    TXDATA_in <= TXDATA_delay;
    TXDCCFORCESTART_in <= TXDCCFORCESTART_delay;
    TXDCCRESET_in <= TXDCCRESET_delay;
    TXDEEMPH_in <= TXDEEMPH_delay;
    TXDETECTRX_in <= TXDETECTRX_delay;
    TXDIFFCTRL_in <= TXDIFFCTRL_delay;
    TXDIFFPD_in <= TXDIFFPD_delay;
    TXDLYBYPASS_in <= TXDLYBYPASS_delay;
    TXDLYEN_in <= TXDLYEN_delay;
    TXDLYHOLD_in <= TXDLYHOLD_delay;
    TXDLYOVRDEN_in <= TXDLYOVRDEN_delay;
    TXDLYSRESET_in <= TXDLYSRESET_delay;
    TXDLYUPDOWN_in <= TXDLYUPDOWN_delay;
    TXELECIDLE_in <= TXELECIDLE_delay;
    TXELFORCESTART_in <= TXELFORCESTART_delay;
    TXHEADER_in <= TXHEADER_delay;
    TXINHIBIT_in <= TXINHIBIT_delay;
    TXLATCLK_in <= TXLATCLK_delay;
    TXMAINCURSOR_in <= TXMAINCURSOR_delay;
    TXMARGIN_in <= TXMARGIN_delay;
    TXOUTCLKSEL_in <= TXOUTCLKSEL_delay;
    TXPCSRESET_in <= TXPCSRESET_delay;
    TXPDELECIDLEMODE_in <= TXPDELECIDLEMODE_delay;
    TXPD_in <= TXPD_delay;
    TXPHALIGNEN_in <= TXPHALIGNEN_delay;
    TXPHALIGN_in <= TXPHALIGN_delay;
    TXPHDLYPD_in <= TXPHDLYPD_delay;
    TXPHDLYRESET_in <= TXPHDLYRESET_delay;
    TXPHDLYTSTCLK_in <= TXPHDLYTSTCLK_delay;
    TXPHINIT_in <= TXPHINIT_delay;
    TXPHOVRDEN_in <= TXPHOVRDEN_delay;
    TXPIPPMEN_in <= TXPIPPMEN_delay;
    TXPIPPMOVRDEN_in <= TXPIPPMOVRDEN_delay;
    TXPIPPMPD_in <= TXPIPPMPD_delay;
    TXPIPPMSEL_in <= TXPIPPMSEL_delay;
    TXPIPPMSTEPSIZE_in <= TXPIPPMSTEPSIZE_delay;
    TXPISOPD_in <= TXPISOPD_delay;
    TXPLLCLKSEL_in <= TXPLLCLKSEL_delay;
    TXPMARESET_in <= TXPMARESET_delay;
    TXPOLARITY_in <= TXPOLARITY_delay;
    TXPOSTCURSOR_in <= TXPOSTCURSOR_delay;
    TXPRBSFORCEERR_in <= TXPRBSFORCEERR_delay;
    TXPRBSSEL_in <= TXPRBSSEL_delay;
    TXPRECURSOR_in <= TXPRECURSOR_delay;
    TXPROGDIVRESET_in <= TXPROGDIVRESET_delay;
    TXRATEMODE_in <= TXRATEMODE_delay;
    TXRATE_in <= TXRATE_delay;
    TXSEQUENCE_in <= TXSEQUENCE_delay;
    TXSWING_in <= TXSWING_delay;
    TXSYNCALLIN_in <= TXSYNCALLIN_delay;
    TXSYNCIN_in <= TXSYNCIN_delay;
    TXSYNCMODE_in <= TXSYNCMODE_delay;
    TXSYSCLKSEL_in <= TXSYSCLKSEL_delay;
    TXUSERRDY_in <= TXUSERRDY_delay;
    TXUSRCLK2_in <= TXUSRCLK2_delay;
    TXUSRCLK_in <= TXUSRCLK_delay;
    

    PMASCANCLK0_in <= '1'; -- tie off
    PMASCANCLK1_in <= '1'; -- tie off
    PMASCANCLK2_in <= '1'; -- tie off
    PMASCANCLK3_in <= '1'; -- tie off
    PMASCANCLK4_in <= '1'; -- tie off
    PMASCANCLK5_in <= '1'; -- tie off
    SCANCLK_in <= '1'; -- tie off
    TSTCLK0_in <= '1'; -- tie off
    TSTCLK1_in <= '1'; -- tie off

    PMASCANENB_in <= '1'; -- tie off
    PMASCANIN_in <= "111111111111"; -- tie off
    PMASCANMODEB_in <= '1'; -- tie off
    PMASCANRSTEN_in <= '1'; -- tie off
    SARCCLK_in <= '1'; -- tie off
    SCANENB_in <= '1'; -- tie off
    SCANIN_in <= "1111111111111111111"; -- tie off
    SCANMODEB_in <= '1'; -- tie off
    TSTPDOVRDB_in <= '1'; -- tie off
    TSTPD_in <= "11111"; -- tie off
    
    GTYE3_CHANNEL_INST : SIP_GTYE3_CHANNEL
      port map (
        ACJTAG_DEBUG_MODE    => ACJTAG_DEBUG_MODE_REG,
        ACJTAG_MODE          => ACJTAG_MODE_REG,
        ACJTAG_RESET         => ACJTAG_RESET_REG,
        ADAPT_CFG0           => ADAPT_CFG0_REG,
        ADAPT_CFG1           => ADAPT_CFG1_REG,
        ADAPT_CFG2           => ADAPT_CFG2_REG,
        AEN_CDRSTEPSEL       => AEN_CDRSTEPSEL_REG,
        AEN_CPLL             => AEN_CPLL_REG,
        AEN_ELPCAL           => AEN_ELPCAL_REG,
        AEN_EYESCAN          => AEN_EYESCAN_REG,
        AEN_LOOPBACK         => AEN_LOOPBACK_REG,
        AEN_MASTER           => AEN_MASTER_REG,
        AEN_MUXDCD           => AEN_MUXDCD_REG,
        AEN_PD_AND_EIDLE     => AEN_PD_AND_EIDLE_REG,
        AEN_POLARITY         => AEN_POLARITY_REG,
        AEN_PRBS             => AEN_PRBS_REG,
        AEN_RESET            => AEN_RESET_REG,
        AEN_RXCDR            => AEN_RXCDR_REG,
        AEN_RXDFE            => AEN_RXDFE_REG,
        AEN_RXDFELPM         => AEN_RXDFELPM_REG,
        AEN_RXOUTCLK_SEL     => AEN_RXOUTCLK_SEL_REG,
        AEN_RXPHDLY          => AEN_RXPHDLY_REG,
        AEN_RXPLLCLK_SEL     => AEN_RXPLLCLK_SEL_REG,
        AEN_RXSYSCLK_SEL     => AEN_RXSYSCLK_SEL_REG,
        AEN_TXOUTCLK_SEL     => AEN_TXOUTCLK_SEL_REG,
        AEN_TXPHDLY          => AEN_TXPHDLY_REG,
        AEN_TXPI_PPM         => AEN_TXPI_PPM_REG,
        AEN_TXPLLCLK_SEL     => AEN_TXPLLCLK_SEL_REG,
        AEN_TXSYSCLK_SEL     => AEN_TXSYSCLK_SEL_REG,
        AEN_TX_DRIVE_MODE    => AEN_TX_DRIVE_MODE_REG,
        ALIGN_COMMA_DOUBLE   => ALIGN_COMMA_DOUBLE_REG,
        ALIGN_COMMA_ENABLE   => ALIGN_COMMA_ENABLE_REG,
        ALIGN_COMMA_WORD     => ALIGN_COMMA_WORD_REG,
        ALIGN_MCOMMA_DET     => ALIGN_MCOMMA_DET_REG,
        ALIGN_MCOMMA_VALUE   => ALIGN_MCOMMA_VALUE_REG,
        ALIGN_PCOMMA_DET     => ALIGN_PCOMMA_DET_REG,
        ALIGN_PCOMMA_VALUE   => ALIGN_PCOMMA_VALUE_REG,
        AMONITOR_CFG         => AMONITOR_CFG_REG,
        AUTO_BW_SEL_BYPASS   => AUTO_BW_SEL_BYPASS_REG,
        A_AFECFOKEN          => A_AFECFOKEN_REG,
        A_CPLLLOCKEN         => A_CPLLLOCKEN_REG,
        A_CPLLPD             => A_CPLLPD_REG,
        A_CPLLRESET          => A_CPLLRESET_REG,
        A_DFECFOKFCDAC       => A_DFECFOKFCDAC_REG,
        A_DFECFOKFCNUM       => A_DFECFOKFCNUM_REG,
        A_DFECFOKFPULSE      => A_DFECFOKFPULSE_REG,
        A_DFECFOKHOLD        => A_DFECFOKHOLD_REG,
        A_DFECFOKOVREN       => A_DFECFOKOVREN_REG,
        A_ELPCALDVORWREN     => A_ELPCALDVORWREN_REG,
        A_ELPCALPAORWREN     => A_ELPCALPAORWREN_REG,
        A_EYESCANMODE        => A_EYESCANMODE_REG,
        A_EYESCANRESET       => A_EYESCANRESET_REG,
        A_GTRESETSEL         => A_GTRESETSEL_REG,
        A_GTRXRESET          => A_GTRXRESET_REG,
        A_GTTXRESET          => A_GTTXRESET_REG,
        A_LOOPBACK           => A_LOOPBACK_REG,
        A_LPMGCHOLD          => A_LPMGCHOLD_REG,
        A_LPMGCOVREN         => A_LPMGCOVREN_REG,
        A_LPMOSHOLD          => A_LPMOSHOLD_REG,
        A_LPMOSOVREN         => A_LPMOSOVREN_REG,
        A_MUXDCDEXHOLD       => A_MUXDCDEXHOLD_REG,
        A_MUXDCDORWREN       => A_MUXDCDORWREN_REG,
        A_RXBUFRESET         => A_RXBUFRESET_REG,
        A_RXCDRFREQRESET     => A_RXCDRFREQRESET_REG,
        A_RXCDRHOLD          => A_RXCDRHOLD_REG,
        A_RXCDROVRDEN        => A_RXCDROVRDEN_REG,
        A_RXCDRRESET         => A_RXCDRRESET_REG,
        A_RXDFEAGCHOLD       => A_RXDFEAGCHOLD_REG,
        A_RXDFEAGCOVRDEN     => A_RXDFEAGCOVRDEN_REG,
        A_RXDFECFOKFEN       => A_RXDFECFOKFEN_REG,
        A_RXDFELFHOLD        => A_RXDFELFHOLD_REG,
        A_RXDFELFOVRDEN      => A_RXDFELFOVRDEN_REG,
        A_RXDFELPMRESET      => A_RXDFELPMRESET_REG,
        A_RXDFETAP10HOLD     => A_RXDFETAP10HOLD_REG,
        A_RXDFETAP10OVRDEN   => A_RXDFETAP10OVRDEN_REG,
        A_RXDFETAP11HOLD     => A_RXDFETAP11HOLD_REG,
        A_RXDFETAP11OVRDEN   => A_RXDFETAP11OVRDEN_REG,
        A_RXDFETAP12HOLD     => A_RXDFETAP12HOLD_REG,
        A_RXDFETAP12OVRDEN   => A_RXDFETAP12OVRDEN_REG,
        A_RXDFETAP13HOLD     => A_RXDFETAP13HOLD_REG,
        A_RXDFETAP13OVRDEN   => A_RXDFETAP13OVRDEN_REG,
        A_RXDFETAP14HOLD     => A_RXDFETAP14HOLD_REG,
        A_RXDFETAP14OVRDEN   => A_RXDFETAP14OVRDEN_REG,
        A_RXDFETAP15HOLD     => A_RXDFETAP15HOLD_REG,
        A_RXDFETAP15OVRDEN   => A_RXDFETAP15OVRDEN_REG,
        A_RXDFETAP2HOLD      => A_RXDFETAP2HOLD_REG,
        A_RXDFETAP2OVRDEN    => A_RXDFETAP2OVRDEN_REG,
        A_RXDFETAP3HOLD      => A_RXDFETAP3HOLD_REG,
        A_RXDFETAP3OVRDEN    => A_RXDFETAP3OVRDEN_REG,
        A_RXDFETAP4HOLD      => A_RXDFETAP4HOLD_REG,
        A_RXDFETAP4OVRDEN    => A_RXDFETAP4OVRDEN_REG,
        A_RXDFETAP5HOLD      => A_RXDFETAP5HOLD_REG,
        A_RXDFETAP5OVRDEN    => A_RXDFETAP5OVRDEN_REG,
        A_RXDFETAP6HOLD      => A_RXDFETAP6HOLD_REG,
        A_RXDFETAP6OVRDEN    => A_RXDFETAP6OVRDEN_REG,
        A_RXDFETAP7HOLD      => A_RXDFETAP7HOLD_REG,
        A_RXDFETAP7OVRDEN    => A_RXDFETAP7OVRDEN_REG,
        A_RXDFETAP8HOLD      => A_RXDFETAP8HOLD_REG,
        A_RXDFETAP8OVRDEN    => A_RXDFETAP8OVRDEN_REG,
        A_RXDFETAP9HOLD      => A_RXDFETAP9HOLD_REG,
        A_RXDFETAP9OVRDEN    => A_RXDFETAP9OVRDEN_REG,
        A_RXDFEUTHOLD        => A_RXDFEUTHOLD_REG,
        A_RXDFEUTOVRDEN      => A_RXDFEUTOVRDEN_REG,
        A_RXDFEVPHOLD        => A_RXDFEVPHOLD_REG,
        A_RXDFEVPOVRDEN      => A_RXDFEVPOVRDEN_REG,
        A_RXDFEVSEN          => A_RXDFEVSEN_REG,
        A_RXDFEXYDEN         => A_RXDFEXYDEN_REG,
        A_RXDLYBYPASS        => A_RXDLYBYPASS_REG,
        A_RXDLYEN            => A_RXDLYEN_REG,
        A_RXDLYOVRDEN        => A_RXDLYOVRDEN_REG,
        A_RXDLYSRESET        => A_RXDLYSRESET_REG,
        A_RXLPMEN            => A_RXLPMEN_REG,
        A_RXLPMHFHOLD        => A_RXLPMHFHOLD_REG,
        A_RXLPMHFOVRDEN      => A_RXLPMHFOVRDEN_REG,
        A_RXLPMLFHOLD        => A_RXLPMLFHOLD_REG,
        A_RXLPMLFKLOVRDEN    => A_RXLPMLFKLOVRDEN_REG,
        A_RXMONITORSEL       => A_RXMONITORSEL_REG,
        A_RXOOBRESET         => A_RXOOBRESET_REG,
        A_RXOSCALRESET       => A_RXOSCALRESET_REG,
        A_RXOSHOLD           => A_RXOSHOLD_REG,
        A_RXOSOVRDEN         => A_RXOSOVRDEN_REG,
        A_RXOUTCLKSEL        => A_RXOUTCLKSEL_REG,
        A_RXPCSRESET         => A_RXPCSRESET_REG,
        A_RXPD               => A_RXPD_REG,
        A_RXPHALIGN          => A_RXPHALIGN_REG,
        A_RXPHALIGNEN        => A_RXPHALIGNEN_REG,
        A_RXPHDLYPD          => A_RXPHDLYPD_REG,
        A_RXPHDLYRESET       => A_RXPHDLYRESET_REG,
        A_RXPHOVRDEN         => A_RXPHOVRDEN_REG,
        A_RXPLLCLKSEL        => A_RXPLLCLKSEL_REG,
        A_RXPMARESET         => A_RXPMARESET_REG,
        A_RXPOLARITY         => A_RXPOLARITY_REG,
        A_RXPRBSCNTRESET     => A_RXPRBSCNTRESET_REG,
        A_RXPRBSSEL          => A_RXPRBSSEL_REG,
        A_RXPROGDIVRESET     => A_RXPROGDIVRESET_REG,
        A_RXSYSCLKSEL        => A_RXSYSCLKSEL_REG,
        A_TXBUFDIFFCTRL      => A_TXBUFDIFFCTRL_REG,
        A_TXDEEMPH           => A_TXDEEMPH_REG,
        A_TXDIFFCTRL         => A_TXDIFFCTRL_REG,
        A_TXDLYBYPASS        => A_TXDLYBYPASS_REG,
        A_TXDLYEN            => A_TXDLYEN_REG,
        A_TXDLYOVRDEN        => A_TXDLYOVRDEN_REG,
        A_TXDLYSRESET        => A_TXDLYSRESET_REG,
        A_TXELECIDLE         => A_TXELECIDLE_REG,
        A_TXINHIBIT          => A_TXINHIBIT_REG,
        A_TXMAINCURSOR       => A_TXMAINCURSOR_REG,
        A_TXMARGIN           => A_TXMARGIN_REG,
        A_TXOUTCLKSEL        => A_TXOUTCLKSEL_REG,
        A_TXPCSRESET         => A_TXPCSRESET_REG,
        A_TXPD               => A_TXPD_REG,
        A_TXPHALIGN          => A_TXPHALIGN_REG,
        A_TXPHALIGNEN        => A_TXPHALIGNEN_REG,
        A_TXPHDLYPD          => A_TXPHDLYPD_REG,
        A_TXPHDLYRESET       => A_TXPHDLYRESET_REG,
        A_TXPHINIT           => A_TXPHINIT_REG,
        A_TXPHOVRDEN         => A_TXPHOVRDEN_REG,
        A_TXPIPPMOVRDEN      => A_TXPIPPMOVRDEN_REG,
        A_TXPIPPMPD          => A_TXPIPPMPD_REG,
        A_TXPIPPMSEL         => A_TXPIPPMSEL_REG,
        A_TXPLLCLKSEL        => A_TXPLLCLKSEL_REG,
        A_TXPMARESET         => A_TXPMARESET_REG,
        A_TXPOLARITY         => A_TXPOLARITY_REG,
        A_TXPOSTCURSOR       => A_TXPOSTCURSOR_REG,
        A_TXPRBSFORCEERR     => A_TXPRBSFORCEERR_REG,
        A_TXPRBSSEL          => A_TXPRBSSEL_REG,
        A_TXPRECURSOR        => A_TXPRECURSOR_REG,
        A_TXPROGDIVRESET     => A_TXPROGDIVRESET_REG,
        A_TXSWING            => A_TXSWING_REG,
        A_TXSYSCLKSEL        => A_TXSYSCLKSEL_REG,
        CAPBYPASS_FORCE      => CAPBYPASS_FORCE_REG,
        CBCC_DATA_SOURCE_SEL => CBCC_DATA_SOURCE_SEL_REG,
        CDR_SWAP_MODE_EN     => CDR_SWAP_MODE_EN_REG,
        CHAN_BOND_KEEP_ALIGN => CHAN_BOND_KEEP_ALIGN_REG,
        CHAN_BOND_MAX_SKEW   => CHAN_BOND_MAX_SKEW_REG,
        CHAN_BOND_SEQ_1_1    => CHAN_BOND_SEQ_1_1_REG,
        CHAN_BOND_SEQ_1_2    => CHAN_BOND_SEQ_1_2_REG,
        CHAN_BOND_SEQ_1_3    => CHAN_BOND_SEQ_1_3_REG,
        CHAN_BOND_SEQ_1_4    => CHAN_BOND_SEQ_1_4_REG,
        CHAN_BOND_SEQ_1_ENABLE => CHAN_BOND_SEQ_1_ENABLE_REG,
        CHAN_BOND_SEQ_2_1    => CHAN_BOND_SEQ_2_1_REG,
        CHAN_BOND_SEQ_2_2    => CHAN_BOND_SEQ_2_2_REG,
        CHAN_BOND_SEQ_2_3    => CHAN_BOND_SEQ_2_3_REG,
        CHAN_BOND_SEQ_2_4    => CHAN_BOND_SEQ_2_4_REG,
        CHAN_BOND_SEQ_2_ENABLE => CHAN_BOND_SEQ_2_ENABLE_REG,
        CHAN_BOND_SEQ_2_USE  => CHAN_BOND_SEQ_2_USE_REG,
        CHAN_BOND_SEQ_LEN    => CHAN_BOND_SEQ_LEN_REG,
        CH_HSPMUX            => CH_HSPMUX_REG,
        CKCAL1_CFG_0         => CKCAL1_CFG_0_REG,
        CKCAL1_CFG_1         => CKCAL1_CFG_1_REG,
        CKCAL1_CFG_2         => CKCAL1_CFG_2_REG,
        CKCAL1_CFG_3         => CKCAL1_CFG_3_REG,
        CKCAL2_CFG_0         => CKCAL2_CFG_0_REG,
        CKCAL2_CFG_1         => CKCAL2_CFG_1_REG,
        CKCAL2_CFG_2         => CKCAL2_CFG_2_REG,
        CKCAL2_CFG_3         => CKCAL2_CFG_3_REG,
        CKCAL2_CFG_4         => CKCAL2_CFG_4_REG,
        CKCAL_RSVD0          => CKCAL_RSVD0_REG,
        CKCAL_RSVD1          => CKCAL_RSVD1_REG,
        CLK_CORRECT_USE      => CLK_CORRECT_USE_REG,
        CLK_COR_KEEP_IDLE    => CLK_COR_KEEP_IDLE_REG,
        CLK_COR_MAX_LAT      => CLK_COR_MAX_LAT_REG,
        CLK_COR_MIN_LAT      => CLK_COR_MIN_LAT_REG,
        CLK_COR_PRECEDENCE   => CLK_COR_PRECEDENCE_REG,
        CLK_COR_REPEAT_WAIT  => CLK_COR_REPEAT_WAIT_REG,
        CLK_COR_SEQ_1_1      => CLK_COR_SEQ_1_1_REG,
        CLK_COR_SEQ_1_2      => CLK_COR_SEQ_1_2_REG,
        CLK_COR_SEQ_1_3      => CLK_COR_SEQ_1_3_REG,
        CLK_COR_SEQ_1_4      => CLK_COR_SEQ_1_4_REG,
        CLK_COR_SEQ_1_ENABLE => CLK_COR_SEQ_1_ENABLE_REG,
        CLK_COR_SEQ_2_1      => CLK_COR_SEQ_2_1_REG,
        CLK_COR_SEQ_2_2      => CLK_COR_SEQ_2_2_REG,
        CLK_COR_SEQ_2_3      => CLK_COR_SEQ_2_3_REG,
        CLK_COR_SEQ_2_4      => CLK_COR_SEQ_2_4_REG,
        CLK_COR_SEQ_2_ENABLE => CLK_COR_SEQ_2_ENABLE_REG,
        CLK_COR_SEQ_2_USE    => CLK_COR_SEQ_2_USE_REG,
        CLK_COR_SEQ_LEN      => CLK_COR_SEQ_LEN_REG,
        CPLL_CFG0            => CPLL_CFG0_REG,
        CPLL_CFG1            => CPLL_CFG1_REG,
        CPLL_CFG2            => CPLL_CFG2_REG,
        CPLL_CFG3            => CPLL_CFG3_REG,
        CPLL_FBDIV           => CPLL_FBDIV_REG,
        CPLL_FBDIV_45        => CPLL_FBDIV_45_REG,
        CPLL_INIT_CFG0       => CPLL_INIT_CFG0_REG,
        CPLL_INIT_CFG1       => CPLL_INIT_CFG1_REG,
        CPLL_LOCK_CFG        => CPLL_LOCK_CFG_REG,
        CPLL_REFCLK_DIV      => CPLL_REFCLK_DIV_REG,
        CTLE3_OCAP_EXT_CTRL  => CTLE3_OCAP_EXT_CTRL_REG,
        CTLE3_OCAP_EXT_EN    => CTLE3_OCAP_EXT_EN_REG,
        DDI_CTRL             => DDI_CTRL_REG,
        DDI_REALIGN_WAIT     => DDI_REALIGN_WAIT_REG,
        DEC_MCOMMA_DETECT    => DEC_MCOMMA_DETECT_REG,
        DEC_PCOMMA_DETECT    => DEC_PCOMMA_DETECT_REG,
        DEC_VALID_COMMA_ONLY => DEC_VALID_COMMA_ONLY_REG,
        DFE_D_X_REL_POS      => DFE_D_X_REL_POS_REG,
        DFE_VCM_COMP_EN      => DFE_VCM_COMP_EN_REG,
        DMONITOR_CFG0        => DMONITOR_CFG0_REG,
        DMONITOR_CFG1        => DMONITOR_CFG1_REG,
        ES_CLK_PHASE_SEL     => ES_CLK_PHASE_SEL_REG,
        ES_CONTROL           => ES_CONTROL_REG,
        ES_ERRDET_EN         => ES_ERRDET_EN_REG,
        ES_EYE_SCAN_EN       => ES_EYE_SCAN_EN_REG,
        ES_HORZ_OFFSET       => ES_HORZ_OFFSET_REG,
        ES_PMA_CFG           => ES_PMA_CFG_REG,
        ES_PRESCALE          => ES_PRESCALE_REG,
        ES_QUALIFIER0        => ES_QUALIFIER0_REG,
        ES_QUALIFIER1        => ES_QUALIFIER1_REG,
        ES_QUALIFIER2        => ES_QUALIFIER2_REG,
        ES_QUALIFIER3        => ES_QUALIFIER3_REG,
        ES_QUALIFIER4        => ES_QUALIFIER4_REG,
        ES_QUALIFIER5        => ES_QUALIFIER5_REG,
        ES_QUALIFIER6        => ES_QUALIFIER6_REG,
        ES_QUALIFIER7        => ES_QUALIFIER7_REG,
        ES_QUALIFIER8        => ES_QUALIFIER8_REG,
        ES_QUALIFIER9        => ES_QUALIFIER9_REG,
        ES_QUAL_MASK0        => ES_QUAL_MASK0_REG,
        ES_QUAL_MASK1        => ES_QUAL_MASK1_REG,
        ES_QUAL_MASK2        => ES_QUAL_MASK2_REG,
        ES_QUAL_MASK3        => ES_QUAL_MASK3_REG,
        ES_QUAL_MASK4        => ES_QUAL_MASK4_REG,
        ES_QUAL_MASK5        => ES_QUAL_MASK5_REG,
        ES_QUAL_MASK6        => ES_QUAL_MASK6_REG,
        ES_QUAL_MASK7        => ES_QUAL_MASK7_REG,
        ES_QUAL_MASK8        => ES_QUAL_MASK8_REG,
        ES_QUAL_MASK9        => ES_QUAL_MASK9_REG,
        ES_SDATA_MASK0       => ES_SDATA_MASK0_REG,
        ES_SDATA_MASK1       => ES_SDATA_MASK1_REG,
        ES_SDATA_MASK2       => ES_SDATA_MASK2_REG,
        ES_SDATA_MASK3       => ES_SDATA_MASK3_REG,
        ES_SDATA_MASK4       => ES_SDATA_MASK4_REG,
        ES_SDATA_MASK5       => ES_SDATA_MASK5_REG,
        ES_SDATA_MASK6       => ES_SDATA_MASK6_REG,
        ES_SDATA_MASK7       => ES_SDATA_MASK7_REG,
        ES_SDATA_MASK8       => ES_SDATA_MASK8_REG,
        ES_SDATA_MASK9       => ES_SDATA_MASK9_REG,
        EVODD_PHI_CFG        => EVODD_PHI_CFG_REG,
        EYE_SCAN_SWAP_EN     => EYE_SCAN_SWAP_EN_REG,
        FTS_DESKEW_SEQ_ENABLE => FTS_DESKEW_SEQ_ENABLE_REG,
        FTS_LANE_DESKEW_CFG  => FTS_LANE_DESKEW_CFG_REG,
        FTS_LANE_DESKEW_EN   => FTS_LANE_DESKEW_EN_REG,
        GEARBOX_MODE         => GEARBOX_MODE_REG,
        GEN_RXUSRCLK         => GEN_RXUSRCLK_REG,
        GEN_TXUSRCLK         => GEN_TXUSRCLK_REG,
        GM_BIAS_SELECT       => GM_BIAS_SELECT_REG,
        GT_INSTANTIATED      => GT_INSTANTIATED_REG,
        ISCAN_CK_PH_SEL2     => ISCAN_CK_PH_SEL2_REG,
        LOCAL_MASTER         => LOCAL_MASTER_REG,
        LOOP0_CFG            => LOOP0_CFG_REG,
        LOOP10_CFG           => LOOP10_CFG_REG,
        LOOP11_CFG           => LOOP11_CFG_REG,
        LOOP12_CFG           => LOOP12_CFG_REG,
        LOOP13_CFG           => LOOP13_CFG_REG,
        LOOP1_CFG            => LOOP1_CFG_REG,
        LOOP2_CFG            => LOOP2_CFG_REG,
        LOOP3_CFG            => LOOP3_CFG_REG,
        LOOP4_CFG            => LOOP4_CFG_REG,
        LOOP5_CFG            => LOOP5_CFG_REG,
        LOOP6_CFG            => LOOP6_CFG_REG,
        LOOP7_CFG            => LOOP7_CFG_REG,
        LOOP8_CFG            => LOOP8_CFG_REG,
        LOOP9_CFG            => LOOP9_CFG_REG,
        LPBK_BIAS_CTRL       => LPBK_BIAS_CTRL_REG,
        LPBK_EN_RCAL_B       => LPBK_EN_RCAL_B_REG,
        LPBK_EXT_RCAL        => LPBK_EXT_RCAL_REG,
        LPBK_RG_CTRL         => LPBK_RG_CTRL_REG,
        OOBDIVCTL            => OOBDIVCTL_REG,
        OOB_PWRUP            => OOB_PWRUP_REG,
        PCI3_AUTO_REALIGN    => PCI3_AUTO_REALIGN_REG,
        PCI3_PIPE_RX_ELECIDLE => PCI3_PIPE_RX_ELECIDLE_REG,
        PCI3_RX_ASYNC_EBUF_BYPASS => PCI3_RX_ASYNC_EBUF_BYPASS_REG,
        PCI3_RX_ELECIDLE_EI2_ENABLE => PCI3_RX_ELECIDLE_EI2_ENABLE_REG,
        PCI3_RX_ELECIDLE_H2L_COUNT => PCI3_RX_ELECIDLE_H2L_COUNT_REG,
        PCI3_RX_ELECIDLE_H2L_DISABLE => PCI3_RX_ELECIDLE_H2L_DISABLE_REG,
        PCI3_RX_ELECIDLE_HI_COUNT => PCI3_RX_ELECIDLE_HI_COUNT_REG,
        PCI3_RX_ELECIDLE_LP4_DISABLE => PCI3_RX_ELECIDLE_LP4_DISABLE_REG,
        PCI3_RX_FIFO_DISABLE => PCI3_RX_FIFO_DISABLE_REG,
        PCIE_BUFG_DIV_CTRL   => PCIE_BUFG_DIV_CTRL_REG,
        PCIE_RXPCS_CFG_GEN3  => PCIE_RXPCS_CFG_GEN3_REG,
        PCIE_RXPMA_CFG       => PCIE_RXPMA_CFG_REG,
        PCIE_TXPCS_CFG_GEN3  => PCIE_TXPCS_CFG_GEN3_REG,
        PCIE_TXPMA_CFG       => PCIE_TXPMA_CFG_REG,
        PCS_PCIE_EN          => PCS_PCIE_EN_REG,
        PCS_RSVD0            => PCS_RSVD0_REG,
        PCS_RSVD1            => PCS_RSVD1_REG,
        PD_TRANS_TIME_FROM_P2 => PD_TRANS_TIME_FROM_P2_REG,
        PD_TRANS_TIME_NONE_P2 => PD_TRANS_TIME_NONE_P2_REG,
        PD_TRANS_TIME_TO_P2  => PD_TRANS_TIME_TO_P2_REG,
        PLL_SEL_MODE_GEN12   => PLL_SEL_MODE_GEN12_REG,
        PLL_SEL_MODE_GEN3    => PLL_SEL_MODE_GEN3_REG,
        PMA_RSV0             => PMA_RSV0_REG,
        PMA_RSV1             => PMA_RSV1_REG,
        PREIQ_FREQ_BST       => PREIQ_FREQ_BST_REG,
        PROCESS_PAR          => PROCESS_PAR_REG,
        RATE_SW_USE_DRP      => RATE_SW_USE_DRP_REG,
        RESET_POWERSAVE_DISABLE => RESET_POWERSAVE_DISABLE_REG,
        RXBUFRESET_TIME      => RXBUFRESET_TIME_REG,
        RXBUF_ADDR_MODE      => RXBUF_ADDR_MODE_REG,
        RXBUF_EIDLE_HI_CNT   => RXBUF_EIDLE_HI_CNT_REG,
        RXBUF_EIDLE_LO_CNT   => RXBUF_EIDLE_LO_CNT_REG,
        RXBUF_EN             => RXBUF_EN_REG,
        RXBUF_RESET_ON_CB_CHANGE => RXBUF_RESET_ON_CB_CHANGE_REG,
        RXBUF_RESET_ON_COMMAALIGN => RXBUF_RESET_ON_COMMAALIGN_REG,
        RXBUF_RESET_ON_EIDLE => RXBUF_RESET_ON_EIDLE_REG,
        RXBUF_RESET_ON_RATE_CHANGE => RXBUF_RESET_ON_RATE_CHANGE_REG,
        RXBUF_THRESH_OVFLW   => RXBUF_THRESH_OVFLW_REG,
        RXBUF_THRESH_OVRD    => RXBUF_THRESH_OVRD_REG,
        RXBUF_THRESH_UNDFLW  => RXBUF_THRESH_UNDFLW_REG,
        RXCDRFREQRESET_TIME  => RXCDRFREQRESET_TIME_REG,
        RXCDRPHRESET_TIME    => RXCDRPHRESET_TIME_REG,
        RXCDR_CFG0           => RXCDR_CFG0_REG,
        RXCDR_CFG0_GEN3      => RXCDR_CFG0_GEN3_REG,
        RXCDR_CFG1           => RXCDR_CFG1_REG,
        RXCDR_CFG1_GEN3      => RXCDR_CFG1_GEN3_REG,
        RXCDR_CFG2           => RXCDR_CFG2_REG,
        RXCDR_CFG2_GEN3      => RXCDR_CFG2_GEN3_REG,
        RXCDR_CFG3           => RXCDR_CFG3_REG,
        RXCDR_CFG3_GEN3      => RXCDR_CFG3_GEN3_REG,
        RXCDR_CFG4           => RXCDR_CFG4_REG,
        RXCDR_CFG4_GEN3      => RXCDR_CFG4_GEN3_REG,
        RXCDR_CFG5           => RXCDR_CFG5_REG,
        RXCDR_CFG5_GEN3      => RXCDR_CFG5_GEN3_REG,
        RXCDR_FR_RESET_ON_EIDLE => RXCDR_FR_RESET_ON_EIDLE_REG,
        RXCDR_HOLD_DURING_EIDLE => RXCDR_HOLD_DURING_EIDLE_REG,
        RXCDR_LOCK_CFG0      => RXCDR_LOCK_CFG0_REG,
        RXCDR_LOCK_CFG1      => RXCDR_LOCK_CFG1_REG,
        RXCDR_LOCK_CFG2      => RXCDR_LOCK_CFG2_REG,
        RXCDR_LOCK_CFG3      => RXCDR_LOCK_CFG3_REG,
        RXCDR_PH_RESET_ON_EIDLE => RXCDR_PH_RESET_ON_EIDLE_REG,
        RXCFOKDONE_SRC       => RXCFOKDONE_SRC_REG,
        RXCFOK_CFG0          => RXCFOK_CFG0_REG,
        RXCFOK_CFG1          => RXCFOK_CFG1_REG,
        RXCFOK_CFG2          => RXCFOK_CFG2_REG,
        RXDFELPMRESET_TIME   => RXDFELPMRESET_TIME_REG,
        RXDFELPM_KL_CFG0     => RXDFELPM_KL_CFG0_REG,
        RXDFELPM_KL_CFG1     => RXDFELPM_KL_CFG1_REG,
        RXDFELPM_KL_CFG2     => RXDFELPM_KL_CFG2_REG,
        RXDFE_CFG0           => RXDFE_CFG0_REG,
        RXDFE_CFG1           => RXDFE_CFG1_REG,
        RXDFE_GC_CFG0        => RXDFE_GC_CFG0_REG,
        RXDFE_GC_CFG1        => RXDFE_GC_CFG1_REG,
        RXDFE_GC_CFG2        => RXDFE_GC_CFG2_REG,
        RXDFE_H2_CFG0        => RXDFE_H2_CFG0_REG,
        RXDFE_H2_CFG1        => RXDFE_H2_CFG1_REG,
        RXDFE_H3_CFG0        => RXDFE_H3_CFG0_REG,
        RXDFE_H3_CFG1        => RXDFE_H3_CFG1_REG,
        RXDFE_H4_CFG0        => RXDFE_H4_CFG0_REG,
        RXDFE_H4_CFG1        => RXDFE_H4_CFG1_REG,
        RXDFE_H5_CFG0        => RXDFE_H5_CFG0_REG,
        RXDFE_H5_CFG1        => RXDFE_H5_CFG1_REG,
        RXDFE_H6_CFG0        => RXDFE_H6_CFG0_REG,
        RXDFE_H6_CFG1        => RXDFE_H6_CFG1_REG,
        RXDFE_H7_CFG0        => RXDFE_H7_CFG0_REG,
        RXDFE_H7_CFG1        => RXDFE_H7_CFG1_REG,
        RXDFE_H8_CFG0        => RXDFE_H8_CFG0_REG,
        RXDFE_H8_CFG1        => RXDFE_H8_CFG1_REG,
        RXDFE_H9_CFG0        => RXDFE_H9_CFG0_REG,
        RXDFE_H9_CFG1        => RXDFE_H9_CFG1_REG,
        RXDFE_HA_CFG0        => RXDFE_HA_CFG0_REG,
        RXDFE_HA_CFG1        => RXDFE_HA_CFG1_REG,
        RXDFE_HB_CFG0        => RXDFE_HB_CFG0_REG,
        RXDFE_HB_CFG1        => RXDFE_HB_CFG1_REG,
        RXDFE_HC_CFG0        => RXDFE_HC_CFG0_REG,
        RXDFE_HC_CFG1        => RXDFE_HC_CFG1_REG,
        RXDFE_HD_CFG0        => RXDFE_HD_CFG0_REG,
        RXDFE_HD_CFG1        => RXDFE_HD_CFG1_REG,
        RXDFE_HE_CFG0        => RXDFE_HE_CFG0_REG,
        RXDFE_HE_CFG1        => RXDFE_HE_CFG1_REG,
        RXDFE_HF_CFG0        => RXDFE_HF_CFG0_REG,
        RXDFE_HF_CFG1        => RXDFE_HF_CFG1_REG,
        RXDFE_OS_CFG0        => RXDFE_OS_CFG0_REG,
        RXDFE_OS_CFG1        => RXDFE_OS_CFG1_REG,
        RXDFE_PWR_SAVING     => RXDFE_PWR_SAVING_REG,
        RXDFE_UT_CFG0        => RXDFE_UT_CFG0_REG,
        RXDFE_UT_CFG1        => RXDFE_UT_CFG1_REG,
        RXDFE_VP_CFG0        => RXDFE_VP_CFG0_REG,
        RXDFE_VP_CFG1        => RXDFE_VP_CFG1_REG,
        RXDLY_CFG            => RXDLY_CFG_REG,
        RXDLY_LCFG           => RXDLY_LCFG_REG,
        RXELECIDLE_CFG       => RXELECIDLE_CFG_REG,
        RXGBOX_FIFO_INIT_RD_ADDR => RXGBOX_FIFO_INIT_RD_ADDR_REG,
        RXGEARBOX_EN         => RXGEARBOX_EN_REG,
        RXISCANRESET_TIME    => RXISCANRESET_TIME_REG,
        RXLPM_CFG            => RXLPM_CFG_REG,
        RXLPM_GC_CFG         => RXLPM_GC_CFG_REG,
        RXLPM_KH_CFG0        => RXLPM_KH_CFG0_REG,
        RXLPM_KH_CFG1        => RXLPM_KH_CFG1_REG,
        RXLPM_OS_CFG0        => RXLPM_OS_CFG0_REG,
        RXLPM_OS_CFG1        => RXLPM_OS_CFG1_REG,
        RXOOB_CFG            => RXOOB_CFG_REG,
        RXOOB_CLK_CFG        => RXOOB_CLK_CFG_REG,
        RXOSCALRESET_TIME    => RXOSCALRESET_TIME_REG,
        RXOUT_DIV            => RXOUT_DIV_REG,
        RXPCSRESET_TIME      => RXPCSRESET_TIME_REG,
        RXPHBEACON_CFG       => RXPHBEACON_CFG_REG,
        RXPHDLY_CFG          => RXPHDLY_CFG_REG,
        RXPHSAMP_CFG         => RXPHSAMP_CFG_REG,
        RXPHSLIP_CFG         => RXPHSLIP_CFG_REG,
        RXPH_MONITOR_SEL     => RXPH_MONITOR_SEL_REG,
        RXPI_AUTO_BW_SEL_BYPASS => RXPI_AUTO_BW_SEL_BYPASS_REG,
        RXPI_CFG             => RXPI_CFG_REG,
        RXPI_LPM             => RXPI_LPM_REG,
        RXPI_RSV0            => RXPI_RSV0_REG,
        RXPI_SEL_LC          => RXPI_SEL_LC_REG,
        RXPI_STARTCODE       => RXPI_STARTCODE_REG,
        RXPI_VREFSEL         => RXPI_VREFSEL_REG,
        RXPLL_SEL            => RXPLL_SEL_REG,
        RXPMACLK_SEL         => RXPMACLK_SEL_REG,
        RXPMARESET_TIME      => RXPMARESET_TIME_REG,
        RXPRBS_ERR_LOOPBACK  => RXPRBS_ERR_LOOPBACK_REG,
        RXPRBS_LINKACQ_CNT   => RXPRBS_LINKACQ_CNT_REG,
        RXSLIDE_AUTO_WAIT    => RXSLIDE_AUTO_WAIT_REG,
        RXSLIDE_MODE         => RXSLIDE_MODE_REG,
        RXSYNC_MULTILANE     => RXSYNC_MULTILANE_REG,
        RXSYNC_OVRD          => RXSYNC_OVRD_REG,
        RXSYNC_SKIP_DA       => RXSYNC_SKIP_DA_REG,
        RX_AFE_CM_EN         => RX_AFE_CM_EN_REG,
        RX_BIAS_CFG0         => RX_BIAS_CFG0_REG,
        RX_BUFFER_CFG        => RX_BUFFER_CFG_REG,
        RX_CAPFF_SARC_ENB    => RX_CAPFF_SARC_ENB_REG,
        RX_CLK25_DIV         => RX_CLK25_DIV_REG,
        RX_CLKMUX_EN         => RX_CLKMUX_EN_REG,
        RX_CLK_SLIP_OVRD     => RX_CLK_SLIP_OVRD_REG,
        RX_CM_BUF_CFG        => RX_CM_BUF_CFG_REG,
        RX_CM_BUF_PD         => RX_CM_BUF_PD_REG,
        RX_CM_SEL            => RX_CM_SEL_REG,
        RX_CM_TRIM           => RX_CM_TRIM_REG,
        RX_CTLE1_KHKL        => RX_CTLE1_KHKL_REG,
        RX_CTLE2_KHKL        => RX_CTLE2_KHKL_REG,
        RX_CTLE3_AGC         => RX_CTLE3_AGC_REG,
        RX_DATA_WIDTH        => RX_DATA_WIDTH_REG,
        RX_DDI_SEL           => RX_DDI_SEL_REG,
        RX_DEFER_RESET_BUF_EN => RX_DEFER_RESET_BUF_EN_REG,
        RX_DEGEN_CTRL        => RX_DEGEN_CTRL_REG,
        RX_DFELPM_CFG0       => RX_DFELPM_CFG0_REG,
        RX_DFELPM_CFG1       => RX_DFELPM_CFG1_REG,
        RX_DFELPM_KLKH_AGC_STUP_EN => RX_DFELPM_KLKH_AGC_STUP_EN_REG,
        RX_DFE_AGC_CFG0      => RX_DFE_AGC_CFG0_REG,
        RX_DFE_AGC_CFG1      => RX_DFE_AGC_CFG1_REG,
        RX_DFE_KL_LPM_KH_CFG0 => RX_DFE_KL_LPM_KH_CFG0_REG,
        RX_DFE_KL_LPM_KH_CFG1 => RX_DFE_KL_LPM_KH_CFG1_REG,
        RX_DFE_KL_LPM_KL_CFG0 => RX_DFE_KL_LPM_KL_CFG0_REG,
        RX_DFE_KL_LPM_KL_CFG1 => RX_DFE_KL_LPM_KL_CFG1_REG,
        RX_DFE_LPM_HOLD_DURING_EIDLE => RX_DFE_LPM_HOLD_DURING_EIDLE_REG,
        RX_DISPERR_SEQ_MATCH => RX_DISPERR_SEQ_MATCH_REG,
        RX_DIV2_MODE_B       => RX_DIV2_MODE_B_REG,
        RX_DIVRESET_TIME     => RX_DIVRESET_TIME_REG,
        RX_EN_CTLE_RCAL_B    => RX_EN_CTLE_RCAL_B_REG,
        RX_EN_HI_LR          => RX_EN_HI_LR_REG,
        RX_EXT_RL_CTRL       => RX_EXT_RL_CTRL_REG,
        RX_EYESCAN_VS_CODE   => RX_EYESCAN_VS_CODE_REG,
        RX_EYESCAN_VS_NEG_DIR => RX_EYESCAN_VS_NEG_DIR_REG,
        RX_EYESCAN_VS_RANGE  => RX_EYESCAN_VS_RANGE_REG,
        RX_EYESCAN_VS_UT_SIGN => RX_EYESCAN_VS_UT_SIGN_REG,
        RX_FABINT_USRCLK_FLOP => RX_FABINT_USRCLK_FLOP_REG,
        RX_INT_DATAWIDTH     => RX_INT_DATAWIDTH_REG,
        RX_PMA_POWER_SAVE    => RX_PMA_POWER_SAVE_REG,
        RX_PROGDIV_CFG       => RX_PROGDIV_CFG_INT,
        RX_PROGDIV_RATE      => RX_PROGDIV_RATE_REG,
        RX_RESLOAD_CTRL      => RX_RESLOAD_CTRL_REG,
        RX_RESLOAD_OVRD      => RX_RESLOAD_OVRD_REG,
        RX_SAMPLE_PERIOD     => RX_SAMPLE_PERIOD_REG,
        RX_SIG_VALID_DLY     => RX_SIG_VALID_DLY_REG,
        RX_SUM_DFETAPREP_EN  => RX_SUM_DFETAPREP_EN_REG,
        RX_SUM_IREF_TUNE     => RX_SUM_IREF_TUNE_REG,
        RX_SUM_VCMTUNE       => RX_SUM_VCMTUNE_REG,
        RX_SUM_VCM_OVWR      => RX_SUM_VCM_OVWR_REG,
        RX_SUM_VREF_TUNE     => RX_SUM_VREF_TUNE_REG,
        RX_TUNE_AFE_OS       => RX_TUNE_AFE_OS_REG,
        RX_VREG_CTRL         => RX_VREG_CTRL_REG,
        RX_VREG_PDB          => RX_VREG_PDB_REG,
        RX_WIDEMODE_CDR      => RX_WIDEMODE_CDR_REG,
        RX_XCLK_SEL          => RX_XCLK_SEL_REG,
        RX_XMODE_SEL         => RX_XMODE_SEL_REG,
        SAS_MAX_COM          => SAS_MAX_COM_REG,
        SAS_MIN_COM          => SAS_MIN_COM_REG,
        SATA_BURST_SEQ_LEN   => SATA_BURST_SEQ_LEN_REG,
        SATA_BURST_VAL       => SATA_BURST_VAL_REG,
        SATA_CPLL_CFG        => SATA_CPLL_CFG_REG,
        SATA_EIDLE_VAL       => SATA_EIDLE_VAL_REG,
        SATA_MAX_BURST       => SATA_MAX_BURST_REG,
        SATA_MAX_INIT        => SATA_MAX_INIT_REG,
        SATA_MAX_WAKE        => SATA_MAX_WAKE_REG,
        SATA_MIN_BURST       => SATA_MIN_BURST_REG,
        SATA_MIN_INIT        => SATA_MIN_INIT_REG,
        SATA_MIN_WAKE        => SATA_MIN_WAKE_REG,
        SHOW_REALIGN_COMMA   => SHOW_REALIGN_COMMA_REG,
        TAPDLY_SET_TX        => TAPDLY_SET_TX_REG,
        TEMPERATURE_PAR      => TEMPERATURE_PAR_REG,
        TERM_RCAL_CFG        => TERM_RCAL_CFG_REG,
        TERM_RCAL_OVRD       => TERM_RCAL_OVRD_REG,
        TRANS_TIME_RATE      => TRANS_TIME_RATE_REG,
        TST_RSV0             => TST_RSV0_REG,
        TST_RSV1             => TST_RSV1_REG,
        TXBUF_EN             => TXBUF_EN_REG,
        TXBUF_RESET_ON_RATE_CHANGE => TXBUF_RESET_ON_RATE_CHANGE_REG,
        TXDLY_CFG            => TXDLY_CFG_REG,
        TXDLY_LCFG           => TXDLY_LCFG_REG,
        TXFIFO_ADDR_CFG      => TXFIFO_ADDR_CFG_REG,
        TXGBOX_FIFO_INIT_RD_ADDR => TXGBOX_FIFO_INIT_RD_ADDR_REG,
        TXGEARBOX_EN         => TXGEARBOX_EN_REG,
        TXOUTCLKPCS_SEL      => TXOUTCLKPCS_SEL_REG,
        TXOUT_DIV            => TXOUT_DIV_REG,
        TXPCSRESET_TIME      => TXPCSRESET_TIME_REG,
        TXPHDLY_CFG0         => TXPHDLY_CFG0_REG,
        TXPHDLY_CFG1         => TXPHDLY_CFG1_REG,
        TXPH_CFG             => TXPH_CFG_REG,
        TXPH_CFG2            => TXPH_CFG2_REG,
        TXPH_MONITOR_SEL     => TXPH_MONITOR_SEL_REG,
        TXPI_CFG0            => TXPI_CFG0_REG,
        TXPI_CFG1            => TXPI_CFG1_REG,
        TXPI_CFG2            => TXPI_CFG2_REG,
        TXPI_CFG3            => TXPI_CFG3_REG,
        TXPI_CFG4            => TXPI_CFG4_REG,
        TXPI_CFG5            => TXPI_CFG5_REG,
        TXPI_GRAY_SEL        => TXPI_GRAY_SEL_REG,
        TXPI_INVSTROBE_SEL   => TXPI_INVSTROBE_SEL_REG,
        TXPI_LPM             => TXPI_LPM_REG,
        TXPI_PPMCLK_SEL      => TXPI_PPMCLK_SEL_REG,
        TXPI_PPM_CFG         => TXPI_PPM_CFG_REG,
        TXPI_RSV0            => TXPI_RSV0_REG,
        TXPI_SYNFREQ_PPM     => TXPI_SYNFREQ_PPM_REG,
        TXPI_VREFSEL         => TXPI_VREFSEL_REG,
        TXPMARESET_TIME      => TXPMARESET_TIME_REG,
        TXSYNC_MULTILANE     => TXSYNC_MULTILANE_REG,
        TXSYNC_OVRD          => TXSYNC_OVRD_REG,
        TXSYNC_SKIP_DA       => TXSYNC_SKIP_DA_REG,
        TX_CLK25_DIV         => TX_CLK25_DIV_REG,
        TX_CLKMUX_EN         => TX_CLKMUX_EN_REG,
        TX_CLKREG_PDB        => TX_CLKREG_PDB_REG,
        TX_CLKREG_SET        => TX_CLKREG_SET_REG,
        TX_DATA_WIDTH        => TX_DATA_WIDTH_REG,
        TX_DCD_CFG           => TX_DCD_CFG_REG,
        TX_DCD_EN            => TX_DCD_EN_REG,
        TX_DEEMPH0           => TX_DEEMPH0_REG,
        TX_DEEMPH1           => TX_DEEMPH1_REG,
        TX_DIVRESET_TIME     => TX_DIVRESET_TIME_REG,
        TX_DRIVE_MODE        => TX_DRIVE_MODE_REG,
        TX_DRVMUX_CTRL       => TX_DRVMUX_CTRL_REG,
        TX_EIDLE_ASSERT_DELAY => TX_EIDLE_ASSERT_DELAY_REG,
        TX_EIDLE_DEASSERT_DELAY => TX_EIDLE_DEASSERT_DELAY_REG,
        TX_EML_PHI_TUNE      => TX_EML_PHI_TUNE_REG,
        TX_FABINT_USRCLK_FLOP => TX_FABINT_USRCLK_FLOP_REG,
        TX_FIFO_BYP_EN       => TX_FIFO_BYP_EN_REG,
        TX_IDLE_DATA_ZERO    => TX_IDLE_DATA_ZERO_REG,
        TX_INT_DATAWIDTH     => TX_INT_DATAWIDTH_REG,
        TX_LOOPBACK_DRIVE_HIZ => TX_LOOPBACK_DRIVE_HIZ_REG,
        TX_MAINCURSOR_SEL    => TX_MAINCURSOR_SEL_REG,
        TX_MARGIN_FULL_0     => TX_MARGIN_FULL_0_REG,
        TX_MARGIN_FULL_1     => TX_MARGIN_FULL_1_REG,
        TX_MARGIN_FULL_2     => TX_MARGIN_FULL_2_REG,
        TX_MARGIN_FULL_3     => TX_MARGIN_FULL_3_REG,
        TX_MARGIN_FULL_4     => TX_MARGIN_FULL_4_REG,
        TX_MARGIN_LOW_0      => TX_MARGIN_LOW_0_REG,
        TX_MARGIN_LOW_1      => TX_MARGIN_LOW_1_REG,
        TX_MARGIN_LOW_2      => TX_MARGIN_LOW_2_REG,
        TX_MARGIN_LOW_3      => TX_MARGIN_LOW_3_REG,
        TX_MARGIN_LOW_4      => TX_MARGIN_LOW_4_REG,
        TX_MODE_SEL          => TX_MODE_SEL_REG,
        TX_PHICAL_CFG0       => TX_PHICAL_CFG0_REG,
        TX_PHICAL_CFG1       => TX_PHICAL_CFG1_REG,
        TX_PHICAL_CFG2       => TX_PHICAL_CFG2_REG,
        TX_PI_BIASSET        => TX_PI_BIASSET_REG,
        TX_PI_CFG0           => TX_PI_CFG0_REG,
        TX_PI_CFG1           => TX_PI_CFG1_REG,
        TX_PI_DIV2_MODE_B    => TX_PI_DIV2_MODE_B_REG,
        TX_PI_SEL_QPLL0      => TX_PI_SEL_QPLL0_REG,
        TX_PI_SEL_QPLL1      => TX_PI_SEL_QPLL1_REG,
        TX_PMADATA_OPT       => TX_PMADATA_OPT_REG,
        TX_PMA_POWER_SAVE    => TX_PMA_POWER_SAVE_REG,
        TX_PREDRV_CTRL       => TX_PREDRV_CTRL_REG,
        TX_PROGCLK_SEL       => TX_PROGCLK_SEL_REG,
        TX_PROGDIV_CFG       => TX_PROGDIV_CFG_INT,
        TX_PROGDIV_RATE      => TX_PROGDIV_RATE_REG,
        TX_RXDETECT_CFG      => TX_RXDETECT_CFG_REG,
        TX_RXDETECT_REF      => TX_RXDETECT_REF_REG,
        TX_SAMPLE_PERIOD     => TX_SAMPLE_PERIOD_REG,
        TX_SARC_LPBK_ENB     => TX_SARC_LPBK_ENB_REG,
        TX_USERPATTERN_DATA0 => TX_USERPATTERN_DATA0_REG,
        TX_USERPATTERN_DATA1 => TX_USERPATTERN_DATA1_REG,
        TX_USERPATTERN_DATA2 => TX_USERPATTERN_DATA2_REG,
        TX_USERPATTERN_DATA3 => TX_USERPATTERN_DATA3_REG,
        TX_USERPATTERN_DATA4 => TX_USERPATTERN_DATA4_REG,
        TX_USERPATTERN_DATA5 => TX_USERPATTERN_DATA5_REG,
        TX_USERPATTERN_DATA6 => TX_USERPATTERN_DATA6_REG,
        TX_USERPATTERN_DATA7 => TX_USERPATTERN_DATA7_REG,
        TX_XCLK_SEL          => TX_XCLK_SEL_REG,
        USE_PCS_CLK_PHASE_SEL => USE_PCS_CLK_PHASE_SEL_REG,
        BUFGTCE              => BUFGTCE_out,
        BUFGTCEMASK          => BUFGTCEMASK_out,
        BUFGTDIV             => BUFGTDIV_out,
        BUFGTRESET           => BUFGTRESET_out,
        BUFGTRSTMASK         => BUFGTRSTMASK_out,
        CPLLFBCLKLOST        => CPLLFBCLKLOST_out,
        CPLLLOCK             => CPLLLOCK_out,
        CPLLREFCLKLOST       => CPLLREFCLKLOST_out,
        DMONITOROUT          => DMONITOROUT_out,
        DRPDO                => DRPDO_out,
        DRPRDY               => DRPRDY_out,
        EYESCANDATAERROR     => EYESCANDATAERROR_out,
        GTPOWERGOOD          => GTPOWERGOOD_out,
        GTREFCLKMONITOR      => GTREFCLKMONITOR_out,
        GTYTXN               => GTYTXN_out,
        GTYTXP               => GTYTXP_out,
        PCIERATEGEN3         => PCIERATEGEN3_out,
        PCIERATEIDLE         => PCIERATEIDLE_out,
        PCIERATEQPLLPD       => PCIERATEQPLLPD_out,
        PCIERATEQPLLRESET    => PCIERATEQPLLRESET_out,
        PCIESYNCTXSYNCDONE   => PCIESYNCTXSYNCDONE_out,
        PCIEUSERGEN3RDY      => PCIEUSERGEN3RDY_out,
        PCIEUSERPHYSTATUSRST => PCIEUSERPHYSTATUSRST_out,
        PCIEUSERRATESTART    => PCIEUSERRATESTART_out,
        PCSRSVDOUT           => PCSRSVDOUT_out,
        PHYSTATUS            => PHYSTATUS_out,
        PINRSRVDAS           => PINRSRVDAS_out,
        PMASCANOUT           => PMASCANOUT_out,
        RESETEXCEPTION       => RESETEXCEPTION_out,
        RXBUFSTATUS          => RXBUFSTATUS_out,
        RXBYTEISALIGNED      => RXBYTEISALIGNED_out,
        RXBYTEREALIGN        => RXBYTEREALIGN_out,
        RXCDRLOCK            => RXCDRLOCK_out,
        RXCDRPHDONE          => RXCDRPHDONE_out,
        RXCHANBONDSEQ        => RXCHANBONDSEQ_out,
        RXCHANISALIGNED      => RXCHANISALIGNED_out,
        RXCHANREALIGN        => RXCHANREALIGN_out,
        RXCHBONDO            => RXCHBONDO_out,
        RXCKCALDONE          => RXCKCALDONE_out,
        RXCLKCORCNT          => RXCLKCORCNT_out,
        RXCOMINITDET         => RXCOMINITDET_out,
        RXCOMMADET           => RXCOMMADET_out,
        RXCOMSASDET          => RXCOMSASDET_out,
        RXCOMWAKEDET         => RXCOMWAKEDET_out,
        RXCTRL0              => RXCTRL0_out,
        RXCTRL1              => RXCTRL1_out,
        RXCTRL2              => RXCTRL2_out,
        RXCTRL3              => RXCTRL3_out,
        RXDATA               => RXDATA_out,
        RXDATAEXTENDRSVD     => RXDATAEXTENDRSVD_out,
        RXDATAVALID          => RXDATAVALID_out,
        RXDLYSRESETDONE      => RXDLYSRESETDONE_out,
        RXELECIDLE           => RXELECIDLE_out,
        RXHEADER             => RXHEADER_out,
        RXHEADERVALID        => RXHEADERVALID_out,
        RXMONITOROUT         => RXMONITOROUT_out,
        RXOSINTDONE          => RXOSINTDONE_out,
        RXOSINTSTARTED       => RXOSINTSTARTED_out,
        RXOSINTSTROBEDONE    => RXOSINTSTROBEDONE_out,
        RXOSINTSTROBESTARTED => RXOSINTSTROBESTARTED_out,
        RXOUTCLK             => RXOUTCLK_out,
        RXOUTCLKFABRIC       => RXOUTCLKFABRIC_out,
        RXOUTCLKPCS          => RXOUTCLKPCS_out,
        RXPHALIGNDONE        => RXPHALIGNDONE_out,
        RXPHALIGNERR         => RXPHALIGNERR_out,
        RXPMARESETDONE       => RXPMARESETDONE_out,
        RXPRBSERR            => RXPRBSERR_out,
        RXPRBSLOCKED         => RXPRBSLOCKED_out,
        RXPRGDIVRESETDONE    => RXPRGDIVRESETDONE_out,
        RXRATEDONE           => RXRATEDONE_out,
        RXRECCLKOUT          => RXRECCLKOUT_out,
        RXRESETDONE          => RXRESETDONE_out,
        RXSLIDERDY           => RXSLIDERDY_out,
        RXSLIPDONE           => RXSLIPDONE_out,
        RXSLIPOUTCLKRDY      => RXSLIPOUTCLKRDY_out,
        RXSLIPPMARDY         => RXSLIPPMARDY_out,
        RXSTARTOFSEQ         => RXSTARTOFSEQ_out,
        RXSTATUS             => RXSTATUS_out,
        RXSYNCDONE           => RXSYNCDONE_out,
        RXSYNCOUT            => RXSYNCOUT_out,
        RXVALID              => RXVALID_out,
        SCANOUT              => SCANOUT_out,
        TXBUFSTATUS          => TXBUFSTATUS_out,
        TXCOMFINISH          => TXCOMFINISH_out,
        TXDCCDONE            => TXDCCDONE_out,
        TXDLYSRESETDONE      => TXDLYSRESETDONE_out,
        TXOUTCLK             => TXOUTCLK_out,
        TXOUTCLKFABRIC       => TXOUTCLKFABRIC_out,
        TXOUTCLKPCS          => TXOUTCLKPCS_out,
        TXPHALIGNDONE        => TXPHALIGNDONE_out,
        TXPHINITDONE         => TXPHINITDONE_out,
        TXPMARESETDONE       => TXPMARESETDONE_out,
        TXPRGDIVRESETDONE    => TXPRGDIVRESETDONE_out,
        TXRATEDONE           => TXRATEDONE_out,
        TXRESETDONE          => TXRESETDONE_out,
        TXSYNCDONE           => TXSYNCDONE_out,
        TXSYNCOUT            => TXSYNCOUT_out,
        CDRSTEPDIR           => CDRSTEPDIR_in,
        CDRSTEPSQ            => CDRSTEPSQ_in,
        CDRSTEPSX            => CDRSTEPSX_in,
        CFGRESET             => CFGRESET_in,
        CLKRSVD0             => CLKRSVD0_in,
        CLKRSVD1             => CLKRSVD1_in,
        CPLLLOCKDETCLK       => CPLLLOCKDETCLK_in,
        CPLLLOCKEN           => CPLLLOCKEN_in,
        CPLLPD               => CPLLPD_in,
        CPLLREFCLKSEL        => CPLLREFCLKSEL_in,
        CPLLRESET            => CPLLRESET_in,
        DMONFIFORESET        => DMONFIFORESET_in,
        DMONITORCLK          => DMONITORCLK_in,
        DRPADDR              => DRPADDR_in,
        DRPCLK               => DRPCLK_in,
        DRPDI                => DRPDI_in,
        DRPEN                => DRPEN_in,
        DRPWE                => DRPWE_in,
        ELPCALDVORWREN       => ELPCALDVORWREN_in,
        ELPCALPAORWREN       => ELPCALPAORWREN_in,
        EVODDPHICALDONE      => EVODDPHICALDONE_in,
        EVODDPHICALSTART     => EVODDPHICALSTART_in,
        EVODDPHIDRDEN        => EVODDPHIDRDEN_in,
        EVODDPHIDWREN        => EVODDPHIDWREN_in,
        EVODDPHIXRDEN        => EVODDPHIXRDEN_in,
        EVODDPHIXWREN        => EVODDPHIXWREN_in,
        EYESCANMODE          => EYESCANMODE_in,
        EYESCANRESET         => EYESCANRESET_in,
        EYESCANTRIGGER       => EYESCANTRIGGER_in,
        GTGREFCLK            => GTGREFCLK_in,
        GTNORTHREFCLK0       => GTNORTHREFCLK0_in,
        GTNORTHREFCLK1       => GTNORTHREFCLK1_in,
        GTREFCLK0            => GTREFCLK0_in,
        GTREFCLK1            => GTREFCLK1_in,
        GTRESETSEL           => GTRESETSEL_in,
        GTRSVD               => GTRSVD_in,
        GTRXRESET            => GTRXRESET_in,
        GTSOUTHREFCLK0       => GTSOUTHREFCLK0_in,
        GTSOUTHREFCLK1       => GTSOUTHREFCLK1_in,
        GTTXRESET            => GTTXRESET_in,
        GTYRXN               => GTYRXN_in,
        GTYRXP               => GTYRXP_in,
        LOOPBACK             => LOOPBACK_in,
        LOOPRSVD             => LOOPRSVD_in,
        LPBKRXTXSEREN        => LPBKRXTXSEREN_in,
        LPBKTXRXSEREN        => LPBKTXRXSEREN_in,
        PCIEEQRXEQADAPTDONE  => PCIEEQRXEQADAPTDONE_in,
        PCIERSTIDLE          => PCIERSTIDLE_in,
        PCIERSTTXSYNCSTART   => PCIERSTTXSYNCSTART_in,
        PCIEUSERRATEDONE     => PCIEUSERRATEDONE_in,
        PCSRSVDIN            => PCSRSVDIN_in,
        PCSRSVDIN2           => PCSRSVDIN2_in,
        PMARSVDIN            => PMARSVDIN_in,
        PMASCANCLK0          => PMASCANCLK0_in,
        PMASCANCLK1          => PMASCANCLK1_in,
        PMASCANCLK2          => PMASCANCLK2_in,
        PMASCANCLK3          => PMASCANCLK3_in,
        PMASCANCLK4          => PMASCANCLK4_in,
        PMASCANCLK5          => PMASCANCLK5_in,
        PMASCANENB           => PMASCANENB_in,
        PMASCANIN            => PMASCANIN_in,
        PMASCANMODEB         => PMASCANMODEB_in,
        PMASCANRSTEN         => PMASCANRSTEN_in,
        QPLL0CLK             => QPLL0CLK_in,
        QPLL0REFCLK          => QPLL0REFCLK_in,
        QPLL1CLK             => QPLL1CLK_in,
        QPLL1REFCLK          => QPLL1REFCLK_in,
        RESETOVRD            => RESETOVRD_in,
        RSTCLKENTX           => RSTCLKENTX_in,
        RX8B10BEN            => RX8B10BEN_in,
        RXBUFRESET           => RXBUFRESET_in,
        RXCDRFREQRESET       => RXCDRFREQRESET_in,
        RXCDRHOLD            => RXCDRHOLD_in,
        RXCDROVRDEN          => RXCDROVRDEN_in,
        RXCDRRESET           => RXCDRRESET_in,
        RXCDRRESETRSV        => RXCDRRESETRSV_in,
        RXCHBONDEN           => RXCHBONDEN_in,
        RXCHBONDI            => RXCHBONDI_in,
        RXCHBONDLEVEL        => RXCHBONDLEVEL_in,
        RXCHBONDMASTER       => RXCHBONDMASTER_in,
        RXCHBONDSLAVE        => RXCHBONDSLAVE_in,
        RXCKCALRESET         => RXCKCALRESET_in,
        RXCOMMADETEN         => RXCOMMADETEN_in,
        RXDCCFORCESTART      => RXDCCFORCESTART_in,
        RXDFEAGCHOLD         => RXDFEAGCHOLD_in,
        RXDFEAGCOVRDEN       => RXDFEAGCOVRDEN_in,
        RXDFELFHOLD          => RXDFELFHOLD_in,
        RXDFELFOVRDEN        => RXDFELFOVRDEN_in,
        RXDFELPMRESET        => RXDFELPMRESET_in,
        RXDFETAP10HOLD       => RXDFETAP10HOLD_in,
        RXDFETAP10OVRDEN     => RXDFETAP10OVRDEN_in,
        RXDFETAP11HOLD       => RXDFETAP11HOLD_in,
        RXDFETAP11OVRDEN     => RXDFETAP11OVRDEN_in,
        RXDFETAP12HOLD       => RXDFETAP12HOLD_in,
        RXDFETAP12OVRDEN     => RXDFETAP12OVRDEN_in,
        RXDFETAP13HOLD       => RXDFETAP13HOLD_in,
        RXDFETAP13OVRDEN     => RXDFETAP13OVRDEN_in,
        RXDFETAP14HOLD       => RXDFETAP14HOLD_in,
        RXDFETAP14OVRDEN     => RXDFETAP14OVRDEN_in,
        RXDFETAP15HOLD       => RXDFETAP15HOLD_in,
        RXDFETAP15OVRDEN     => RXDFETAP15OVRDEN_in,
        RXDFETAP2HOLD        => RXDFETAP2HOLD_in,
        RXDFETAP2OVRDEN      => RXDFETAP2OVRDEN_in,
        RXDFETAP3HOLD        => RXDFETAP3HOLD_in,
        RXDFETAP3OVRDEN      => RXDFETAP3OVRDEN_in,
        RXDFETAP4HOLD        => RXDFETAP4HOLD_in,
        RXDFETAP4OVRDEN      => RXDFETAP4OVRDEN_in,
        RXDFETAP5HOLD        => RXDFETAP5HOLD_in,
        RXDFETAP5OVRDEN      => RXDFETAP5OVRDEN_in,
        RXDFETAP6HOLD        => RXDFETAP6HOLD_in,
        RXDFETAP6OVRDEN      => RXDFETAP6OVRDEN_in,
        RXDFETAP7HOLD        => RXDFETAP7HOLD_in,
        RXDFETAP7OVRDEN      => RXDFETAP7OVRDEN_in,
        RXDFETAP8HOLD        => RXDFETAP8HOLD_in,
        RXDFETAP8OVRDEN      => RXDFETAP8OVRDEN_in,
        RXDFETAP9HOLD        => RXDFETAP9HOLD_in,
        RXDFETAP9OVRDEN      => RXDFETAP9OVRDEN_in,
        RXDFEUTHOLD          => RXDFEUTHOLD_in,
        RXDFEUTOVRDEN        => RXDFEUTOVRDEN_in,
        RXDFEVPHOLD          => RXDFEVPHOLD_in,
        RXDFEVPOVRDEN        => RXDFEVPOVRDEN_in,
        RXDFEVSEN            => RXDFEVSEN_in,
        RXDFEXYDEN           => RXDFEXYDEN_in,
        RXDLYBYPASS          => RXDLYBYPASS_in,
        RXDLYEN              => RXDLYEN_in,
        RXDLYOVRDEN          => RXDLYOVRDEN_in,
        RXDLYSRESET          => RXDLYSRESET_in,
        RXELECIDLEMODE       => RXELECIDLEMODE_in,
        RXGEARBOXSLIP        => RXGEARBOXSLIP_in,
        RXLATCLK             => RXLATCLK_in,
        RXLPMEN              => RXLPMEN_in,
        RXLPMGCHOLD          => RXLPMGCHOLD_in,
        RXLPMGCOVRDEN        => RXLPMGCOVRDEN_in,
        RXLPMHFHOLD          => RXLPMHFHOLD_in,
        RXLPMHFOVRDEN        => RXLPMHFOVRDEN_in,
        RXLPMLFHOLD          => RXLPMLFHOLD_in,
        RXLPMLFKLOVRDEN      => RXLPMLFKLOVRDEN_in,
        RXLPMOSHOLD          => RXLPMOSHOLD_in,
        RXLPMOSOVRDEN        => RXLPMOSOVRDEN_in,
        RXMCOMMAALIGNEN      => RXMCOMMAALIGNEN_in,
        RXMONITORSEL         => RXMONITORSEL_in,
        RXOOBRESET           => RXOOBRESET_in,
        RXOSCALRESET         => RXOSCALRESET_in,
        RXOSHOLD             => RXOSHOLD_in,
        RXOSINTCFG           => RXOSINTCFG_in,
        RXOSINTEN            => RXOSINTEN_in,
        RXOSINTHOLD          => RXOSINTHOLD_in,
        RXOSINTOVRDEN        => RXOSINTOVRDEN_in,
        RXOSINTSTROBE        => RXOSINTSTROBE_in,
        RXOSINTTESTOVRDEN    => RXOSINTTESTOVRDEN_in,
        RXOSOVRDEN           => RXOSOVRDEN_in,
        RXOUTCLKSEL          => RXOUTCLKSEL_in,
        RXPCOMMAALIGNEN      => RXPCOMMAALIGNEN_in,
        RXPCSRESET           => RXPCSRESET_in,
        RXPD                 => RXPD_in,
        RXPHALIGN            => RXPHALIGN_in,
        RXPHALIGNEN          => RXPHALIGNEN_in,
        RXPHDLYPD            => RXPHDLYPD_in,
        RXPHDLYRESET         => RXPHDLYRESET_in,
        RXPHOVRDEN           => RXPHOVRDEN_in,
        RXPLLCLKSEL          => RXPLLCLKSEL_in,
        RXPMARESET           => RXPMARESET_in,
        RXPOLARITY           => RXPOLARITY_in,
        RXPRBSCNTRESET       => RXPRBSCNTRESET_in,
        RXPRBSSEL            => RXPRBSSEL_in,
        RXPROGDIVRESET       => RXPROGDIVRESET_in,
        RXRATE               => RXRATE_in,
        RXRATEMODE           => RXRATEMODE_in,
        RXSLIDE              => RXSLIDE_in,
        RXSLIPOUTCLK         => RXSLIPOUTCLK_in,
        RXSLIPPMA            => RXSLIPPMA_in,
        RXSYNCALLIN          => RXSYNCALLIN_in,
        RXSYNCIN             => RXSYNCIN_in,
        RXSYNCMODE           => RXSYNCMODE_in,
        RXSYSCLKSEL          => RXSYSCLKSEL_in,
        RXUSERRDY            => RXUSERRDY_in,
        RXUSRCLK             => RXUSRCLK_in,
        RXUSRCLK2            => RXUSRCLK2_in,
        SARCCLK              => SARCCLK_in,
        SCANCLK              => SCANCLK_in,
        SCANENB              => SCANENB_in,
        SCANIN               => SCANIN_in,
        SCANMODEB            => SCANMODEB_in,
        SIGVALIDCLK          => SIGVALIDCLK_in,
        TSTCLK0              => TSTCLK0_in,
        TSTCLK1              => TSTCLK1_in,
        TSTIN                => TSTIN_in,
        TSTPD                => TSTPD_in,
        TSTPDOVRDB           => TSTPDOVRDB_in,
        TX8B10BBYPASS        => TX8B10BBYPASS_in,
        TX8B10BEN            => TX8B10BEN_in,
        TXBUFDIFFCTRL        => TXBUFDIFFCTRL_in,
        TXCOMINIT            => TXCOMINIT_in,
        TXCOMSAS             => TXCOMSAS_in,
        TXCOMWAKE            => TXCOMWAKE_in,
        TXCTRL0              => TXCTRL0_in,
        TXCTRL1              => TXCTRL1_in,
        TXCTRL2              => TXCTRL2_in,
        TXDATA               => TXDATA_in,
        TXDATAEXTENDRSVD     => TXDATAEXTENDRSVD_in,
        TXDCCFORCESTART      => TXDCCFORCESTART_in,
        TXDCCRESET           => TXDCCRESET_in,
        TXDEEMPH             => TXDEEMPH_in,
        TXDETECTRX           => TXDETECTRX_in,
        TXDIFFCTRL           => TXDIFFCTRL_in,
        TXDIFFPD             => TXDIFFPD_in,
        TXDLYBYPASS          => TXDLYBYPASS_in,
        TXDLYEN              => TXDLYEN_in,
        TXDLYHOLD            => TXDLYHOLD_in,
        TXDLYOVRDEN          => TXDLYOVRDEN_in,
        TXDLYSRESET          => TXDLYSRESET_in,
        TXDLYUPDOWN          => TXDLYUPDOWN_in,
        TXELECIDLE           => TXELECIDLE_in,
        TXELFORCESTART       => TXELFORCESTART_in,
        TXHEADER             => TXHEADER_in,
        TXINHIBIT            => TXINHIBIT_in,
        TXLATCLK             => TXLATCLK_in,
        TXMAINCURSOR         => TXMAINCURSOR_in,
        TXMARGIN             => TXMARGIN_in,
        TXOUTCLKSEL          => TXOUTCLKSEL_in,
        TXPCSRESET           => TXPCSRESET_in,
        TXPD                 => TXPD_in,
        TXPDELECIDLEMODE     => TXPDELECIDLEMODE_in,
        TXPHALIGN            => TXPHALIGN_in,
        TXPHALIGNEN          => TXPHALIGNEN_in,
        TXPHDLYPD            => TXPHDLYPD_in,
        TXPHDLYRESET         => TXPHDLYRESET_in,
        TXPHDLYTSTCLK        => TXPHDLYTSTCLK_in,
        TXPHINIT             => TXPHINIT_in,
        TXPHOVRDEN           => TXPHOVRDEN_in,
        TXPIPPMEN            => TXPIPPMEN_in,
        TXPIPPMOVRDEN        => TXPIPPMOVRDEN_in,
        TXPIPPMPD            => TXPIPPMPD_in,
        TXPIPPMSEL           => TXPIPPMSEL_in,
        TXPIPPMSTEPSIZE      => TXPIPPMSTEPSIZE_in,
        TXPISOPD             => TXPISOPD_in,
        TXPLLCLKSEL          => TXPLLCLKSEL_in,
        TXPMARESET           => TXPMARESET_in,
        TXPOLARITY           => TXPOLARITY_in,
        TXPOSTCURSOR         => TXPOSTCURSOR_in,
        TXPRBSFORCEERR       => TXPRBSFORCEERR_in,
        TXPRBSSEL            => TXPRBSSEL_in,
        TXPRECURSOR          => TXPRECURSOR_in,
        TXPROGDIVRESET       => TXPROGDIVRESET_in,
        TXRATE               => TXRATE_in,
        TXRATEMODE           => TXRATEMODE_in,
        TXSEQUENCE           => TXSEQUENCE_in,
        TXSWING              => TXSWING_in,
        TXSYNCALLIN          => TXSYNCALLIN_in,
        TXSYNCIN             => TXSYNCIN_in,
        TXSYNCMODE           => TXSYNCMODE_in,
        TXSYSCLKSEL          => TXSYSCLKSEL_in,
        TXUSERRDY            => TXUSERRDY_in,
        TXUSRCLK             => TXUSRCLK_in,
        TXUSRCLK2            => TXUSRCLK2_in,
        GSR                  => glblGSR        
      );

  INIPROC : process
  variable Message : line;
  variable attr_err : boolean := false;
  begin
    -------- ALIGN_COMMA_DOUBLE check
  if((xil_attr_test) or
     ((ALIGN_COMMA_DOUBLE /= "FALSE") and 
      (ALIGN_COMMA_DOUBLE /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-131] ALIGN_COMMA_DOUBLE attribute is set to """));
    Write ( Message, string'(ALIGN_COMMA_DOUBLE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- ALIGN_COMMA_WORD check
  if((xil_attr_test) or
     ((ALIGN_COMMA_WORD /= 1) and 
      (ALIGN_COMMA_WORD /= 2) and 
      (ALIGN_COMMA_WORD /= 4))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-133] ALIGN_COMMA_WORD attribute is set to "));
    Write ( Message, ALIGN_COMMA_WORD);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2 or "));
    Write ( Message, string'("4. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- ALIGN_MCOMMA_DET check
  if((xil_attr_test) or
     ((ALIGN_MCOMMA_DET /= "TRUE") and 
      (ALIGN_MCOMMA_DET /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-134] ALIGN_MCOMMA_DET attribute is set to """));
    Write ( Message, string'(ALIGN_MCOMMA_DET));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- ALIGN_PCOMMA_DET check
  if((xil_attr_test) or
     ((ALIGN_PCOMMA_DET /= "TRUE") and 
      (ALIGN_PCOMMA_DET /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-136] ALIGN_PCOMMA_DET attribute is set to """));
    Write ( Message, string'(ALIGN_PCOMMA_DET));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CBCC_DATA_SOURCE_SEL check
  if((xil_attr_test) or
     ((CBCC_DATA_SOURCE_SEL /= "DECODED") and 
      (CBCC_DATA_SOURCE_SEL /= "ENCODED"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-271] CBCC_DATA_SOURCE_SEL attribute is set to """));
    Write ( Message, string'(CBCC_DATA_SOURCE_SEL));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""DECODED"" or "));
    Write ( Message, string'("""ENCODED"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CHAN_BOND_KEEP_ALIGN check
  if((xil_attr_test) or
     ((CHAN_BOND_KEEP_ALIGN /= "FALSE") and 
      (CHAN_BOND_KEEP_ALIGN /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-273] CHAN_BOND_KEEP_ALIGN attribute is set to """));
    Write ( Message, string'(CHAN_BOND_KEEP_ALIGN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CHAN_BOND_MAX_SKEW check
  if((xil_attr_test) or
     ((CHAN_BOND_MAX_SKEW /= 7) and 
      (CHAN_BOND_MAX_SKEW /= 1) and 
      (CHAN_BOND_MAX_SKEW /= 2) and 
      (CHAN_BOND_MAX_SKEW /= 3) and 
      (CHAN_BOND_MAX_SKEW /= 4) and 
      (CHAN_BOND_MAX_SKEW /= 5) and 
      (CHAN_BOND_MAX_SKEW /= 6) and 
      (CHAN_BOND_MAX_SKEW /= 8) and 
      (CHAN_BOND_MAX_SKEW /= 9) and 
      (CHAN_BOND_MAX_SKEW /= 10) and 
      (CHAN_BOND_MAX_SKEW /= 11) and 
      (CHAN_BOND_MAX_SKEW /= 12) and 
      (CHAN_BOND_MAX_SKEW /= 13) and 
      (CHAN_BOND_MAX_SKEW /= 14))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-274] CHAN_BOND_MAX_SKEW attribute is set to "));
    Write ( Message, CHAN_BOND_MAX_SKEW);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("7, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("5, "));
    Write ( Message, string'("6, "));
    Write ( Message, string'("8, "));
    Write ( Message, string'("9, "));
    Write ( Message, string'("10, "));
    Write ( Message, string'("11, "));
    Write ( Message, string'("12, "));
    Write ( Message, string'("13 or "));
    Write ( Message, string'("14. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CHAN_BOND_SEQ_2_USE check
  if((xil_attr_test) or
     ((CHAN_BOND_SEQ_2_USE /= "FALSE") and 
      (CHAN_BOND_SEQ_2_USE /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-285] CHAN_BOND_SEQ_2_USE attribute is set to """));
    Write ( Message, string'(CHAN_BOND_SEQ_2_USE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CHAN_BOND_SEQ_LEN check
  if((xil_attr_test) or
     ((CHAN_BOND_SEQ_LEN /= 2) and 
      (CHAN_BOND_SEQ_LEN /= 1) and 
      (CHAN_BOND_SEQ_LEN /= 3) and 
      (CHAN_BOND_SEQ_LEN /= 4))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-286] CHAN_BOND_SEQ_LEN attribute is set to "));
    Write ( Message, CHAN_BOND_SEQ_LEN);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("3 or "));
    Write ( Message, string'("4. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CLK_CORRECT_USE check
  if((xil_attr_test) or
     ((CLK_CORRECT_USE /= "TRUE") and 
      (CLK_CORRECT_USE /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-299] CLK_CORRECT_USE attribute is set to """));
    Write ( Message, string'(CLK_CORRECT_USE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CLK_COR_KEEP_IDLE check
  if((xil_attr_test) or
     ((CLK_COR_KEEP_IDLE /= "FALSE") and 
      (CLK_COR_KEEP_IDLE /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-300] CLK_COR_KEEP_IDLE attribute is set to """));
    Write ( Message, string'(CLK_COR_KEEP_IDLE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CLK_COR_MAX_LAT check
    if ((CLK_COR_MAX_LAT < 3) or (CLK_COR_MAX_LAT > 60)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-301] CLK_COR_MAX_LAT attribute is set to "));
      Write ( Message, CLK_COR_MAX_LAT);
      Write ( Message, string'(". Legal values for this attribute are 3 to 60. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- CLK_COR_MIN_LAT check
    if ((CLK_COR_MIN_LAT < 3) or (CLK_COR_MIN_LAT > 63)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-302] CLK_COR_MIN_LAT attribute is set to "));
      Write ( Message, CLK_COR_MIN_LAT);
      Write ( Message, string'(". Legal values for this attribute are 3 to 63. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- CLK_COR_PRECEDENCE check
  if((xil_attr_test) or
     ((CLK_COR_PRECEDENCE /= "TRUE") and 
      (CLK_COR_PRECEDENCE /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-303] CLK_COR_PRECEDENCE attribute is set to """));
    Write ( Message, string'(CLK_COR_PRECEDENCE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CLK_COR_REPEAT_WAIT check
    if ((CLK_COR_REPEAT_WAIT < 0) or (CLK_COR_REPEAT_WAIT > 31)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-304] CLK_COR_REPEAT_WAIT attribute is set to "));
      Write ( Message, CLK_COR_REPEAT_WAIT);
      Write ( Message, string'(". Legal values for this attribute are 0 to 31. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- CLK_COR_SEQ_2_USE check
  if((xil_attr_test) or
     ((CLK_COR_SEQ_2_USE /= "FALSE") and 
      (CLK_COR_SEQ_2_USE /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-315] CLK_COR_SEQ_2_USE attribute is set to """));
    Write ( Message, string'(CLK_COR_SEQ_2_USE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CLK_COR_SEQ_LEN check
  if((xil_attr_test) or
     ((CLK_COR_SEQ_LEN /= 2) and 
      (CLK_COR_SEQ_LEN /= 1) and 
      (CLK_COR_SEQ_LEN /= 3) and 
      (CLK_COR_SEQ_LEN /= 4))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-316] CLK_COR_SEQ_LEN attribute is set to "));
    Write ( Message, CLK_COR_SEQ_LEN);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("3 or "));
    Write ( Message, string'("4. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CPLL_FBDIV check
  if((xil_attr_test) or
     ((CPLL_FBDIV /= 4) and 
      (CPLL_FBDIV /= 1) and 
      (CPLL_FBDIV /= 2) and 
      (CPLL_FBDIV /= 3) and 
      (CPLL_FBDIV /= 5) and 
      (CPLL_FBDIV /= 6) and 
      (CPLL_FBDIV /= 8) and 
      (CPLL_FBDIV /= 10) and 
      (CPLL_FBDIV /= 12) and 
      (CPLL_FBDIV /= 16) and 
      (CPLL_FBDIV /= 20))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-321] CPLL_FBDIV attribute is set to "));
    Write ( Message, CPLL_FBDIV);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("5, "));
    Write ( Message, string'("6, "));
    Write ( Message, string'("8, "));
    Write ( Message, string'("10, "));
    Write ( Message, string'("12, "));
    Write ( Message, string'("16 or "));
    Write ( Message, string'("20. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CPLL_FBDIV_45 check
  if((xil_attr_test) or
     ((CPLL_FBDIV_45 /= 4) and 
      (CPLL_FBDIV_45 /= 5))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-322] CPLL_FBDIV_45 attribute is set to "));
    Write ( Message, CPLL_FBDIV_45);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("4 or "));
    Write ( Message, string'("5. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- CPLL_REFCLK_DIV check
  if((xil_attr_test) or
     ((CPLL_REFCLK_DIV /= 1) and 
      (CPLL_REFCLK_DIV /= 2) and 
      (CPLL_REFCLK_DIV /= 3) and 
      (CPLL_REFCLK_DIV /= 4) and 
      (CPLL_REFCLK_DIV /= 5) and 
      (CPLL_REFCLK_DIV /= 6) and 
      (CPLL_REFCLK_DIV /= 8) and 
      (CPLL_REFCLK_DIV /= 10) and 
      (CPLL_REFCLK_DIV /= 12) and 
      (CPLL_REFCLK_DIV /= 16) and 
      (CPLL_REFCLK_DIV /= 20))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-326] CPLL_REFCLK_DIV attribute is set to "));
    Write ( Message, CPLL_REFCLK_DIV);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("5, "));
    Write ( Message, string'("6, "));
    Write ( Message, string'("8, "));
    Write ( Message, string'("10, "));
    Write ( Message, string'("12, "));
    Write ( Message, string'("16 or "));
    Write ( Message, string'("20. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- DDI_REALIGN_WAIT check
    if ((DDI_REALIGN_WAIT < 0) or (DDI_REALIGN_WAIT > 31)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-330] DDI_REALIGN_WAIT attribute is set to "));
      Write ( Message, DDI_REALIGN_WAIT);
      Write ( Message, string'(". Legal values for this attribute are 0 to 31. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- DEC_MCOMMA_DETECT check
  if((xil_attr_test) or
     ((DEC_MCOMMA_DETECT /= "TRUE") and 
      (DEC_MCOMMA_DETECT /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-331] DEC_MCOMMA_DETECT attribute is set to """));
    Write ( Message, string'(DEC_MCOMMA_DETECT));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- DEC_PCOMMA_DETECT check
  if((xil_attr_test) or
     ((DEC_PCOMMA_DETECT /= "TRUE") and 
      (DEC_PCOMMA_DETECT /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-332] DEC_PCOMMA_DETECT attribute is set to """));
    Write ( Message, string'(DEC_PCOMMA_DETECT));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- DEC_VALID_COMMA_ONLY check
  if((xil_attr_test) or
     ((DEC_VALID_COMMA_ONLY /= "TRUE") and 
      (DEC_VALID_COMMA_ONLY /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-333] DEC_VALID_COMMA_ONLY attribute is set to """));
    Write ( Message, string'(DEC_VALID_COMMA_ONLY));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- ES_ERRDET_EN check
  if((xil_attr_test) or
     ((ES_ERRDET_EN /= "FALSE") and 
      (ES_ERRDET_EN /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-340] ES_ERRDET_EN attribute is set to """));
    Write ( Message, string'(ES_ERRDET_EN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- ES_EYE_SCAN_EN check
  if((xil_attr_test) or
     ((ES_EYE_SCAN_EN /= "FALSE") and 
      (ES_EYE_SCAN_EN /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-341] ES_EYE_SCAN_EN attribute is set to """));
    Write ( Message, string'(ES_EYE_SCAN_EN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- FTS_LANE_DESKEW_EN check
  if((xil_attr_test) or
     ((FTS_LANE_DESKEW_EN /= "FALSE") and 
      (FTS_LANE_DESKEW_EN /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-379] FTS_LANE_DESKEW_EN attribute is set to """));
    Write ( Message, string'(FTS_LANE_DESKEW_EN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- PCI3_AUTO_REALIGN check
  if((xil_attr_test) or
     ((PCI3_AUTO_REALIGN /= "FRST_SMPL") and 
      (PCI3_AUTO_REALIGN /= "OVR_1K_BLK") and 
      (PCI3_AUTO_REALIGN /= "OVR_8_BLK") and 
      (PCI3_AUTO_REALIGN /= "OVR_64_BLK"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-407] PCI3_AUTO_REALIGN attribute is set to """));
    Write ( Message, string'(PCI3_AUTO_REALIGN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FRST_SMPL"", "));
    Write ( Message, string'("""OVR_1K_BLK"", "));
    Write ( Message, string'("""OVR_8_BLK"" or "));
    Write ( Message, string'("""OVR_64_BLK"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- PCS_PCIE_EN check
  if((xil_attr_test) or
     ((PCS_PCIE_EN /= "FALSE") and 
      (PCS_PCIE_EN /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-421] PCS_PCIE_EN attribute is set to """));
    Write ( Message, string'(PCS_PCIE_EN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- PREIQ_FREQ_BST check
  if((xil_attr_test) or
     ((PREIQ_FREQ_BST /= 0) and 
      (PREIQ_FREQ_BST /= 1) and 
      (PREIQ_FREQ_BST /= 2) and 
      (PREIQ_FREQ_BST /= 3))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-431] PREIQ_FREQ_BST attribute is set to "));
    Write ( Message, PREIQ_FREQ_BST);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2 or "));
    Write ( Message, string'("3. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXBUF_ADDR_MODE check
  if((xil_attr_test) or
     ((RXBUF_ADDR_MODE /= "FULL") and 
      (RXBUF_ADDR_MODE /= "FAST"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-436] RXBUF_ADDR_MODE attribute is set to """));
    Write ( Message, string'(RXBUF_ADDR_MODE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FULL"" or "));
    Write ( Message, string'("""FAST"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXBUF_EN check
  if((xil_attr_test) or
     ((RXBUF_EN /= "TRUE") and 
      (RXBUF_EN /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-439] RXBUF_EN attribute is set to """));
    Write ( Message, string'(RXBUF_EN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXBUF_RESET_ON_CB_CHANGE check
  if((xil_attr_test) or
     ((RXBUF_RESET_ON_CB_CHANGE /= "TRUE") and 
      (RXBUF_RESET_ON_CB_CHANGE /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-440] RXBUF_RESET_ON_CB_CHANGE attribute is set to """));
    Write ( Message, string'(RXBUF_RESET_ON_CB_CHANGE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXBUF_RESET_ON_COMMAALIGN check
  if((xil_attr_test) or
     ((RXBUF_RESET_ON_COMMAALIGN /= "FALSE") and 
      (RXBUF_RESET_ON_COMMAALIGN /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-441] RXBUF_RESET_ON_COMMAALIGN attribute is set to """));
    Write ( Message, string'(RXBUF_RESET_ON_COMMAALIGN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXBUF_RESET_ON_EIDLE check
  if((xil_attr_test) or
     ((RXBUF_RESET_ON_EIDLE /= "FALSE") and 
      (RXBUF_RESET_ON_EIDLE /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-442] RXBUF_RESET_ON_EIDLE attribute is set to """));
    Write ( Message, string'(RXBUF_RESET_ON_EIDLE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXBUF_RESET_ON_RATE_CHANGE check
  if((xil_attr_test) or
     ((RXBUF_RESET_ON_RATE_CHANGE /= "TRUE") and 
      (RXBUF_RESET_ON_RATE_CHANGE /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-443] RXBUF_RESET_ON_RATE_CHANGE attribute is set to """));
    Write ( Message, string'(RXBUF_RESET_ON_RATE_CHANGE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXBUF_THRESH_OVFLW check
    if ((RXBUF_THRESH_OVFLW < 0) or (RXBUF_THRESH_OVFLW > 63)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-444] RXBUF_THRESH_OVFLW attribute is set to "));
      Write ( Message, RXBUF_THRESH_OVFLW);
      Write ( Message, string'(". Legal values for this attribute are 0 to 63. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- RXBUF_THRESH_OVRD check
  if((xil_attr_test) or
     ((RXBUF_THRESH_OVRD /= "FALSE") and 
      (RXBUF_THRESH_OVRD /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-445] RXBUF_THRESH_OVRD attribute is set to """));
    Write ( Message, string'(RXBUF_THRESH_OVRD));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXBUF_THRESH_UNDFLW check
    if ((RXBUF_THRESH_UNDFLW < 0) or (RXBUF_THRESH_UNDFLW > 63)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-446] RXBUF_THRESH_UNDFLW attribute is set to "));
      Write ( Message, RXBUF_THRESH_UNDFLW);
      Write ( Message, string'(". Legal values for this attribute are 0 to 63. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- RXELECIDLE_CFG check
  if((xil_attr_test) or
     ((RXELECIDLE_CFG /= "SIGCFG_4") and 
      (RXELECIDLE_CFG /= "SIGCFG_1") and 
      (RXELECIDLE_CFG /= "SIGCFG_2") and 
      (RXELECIDLE_CFG /= "SIGCFG_3") and 
      (RXELECIDLE_CFG /= "SIGCFG_6") and 
      (RXELECIDLE_CFG /= "SIGCFG_8") and 
      (RXELECIDLE_CFG /= "SIGCFG_12") and 
      (RXELECIDLE_CFG /= "SIGCFG_16"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-518] RXELECIDLE_CFG attribute is set to """));
    Write ( Message, string'(RXELECIDLE_CFG));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""SIGCFG_4"", "));
    Write ( Message, string'("""SIGCFG_1"", "));
    Write ( Message, string'("""SIGCFG_2"", "));
    Write ( Message, string'("""SIGCFG_3"", "));
    Write ( Message, string'("""SIGCFG_6"", "));
    Write ( Message, string'("""SIGCFG_8"", "));
    Write ( Message, string'("""SIGCFG_12"" or "));
    Write ( Message, string'("""SIGCFG_16"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXGBOX_FIFO_INIT_RD_ADDR check
  if((xil_attr_test) or
     ((RXGBOX_FIFO_INIT_RD_ADDR /= 4) and 
      (RXGBOX_FIFO_INIT_RD_ADDR /= 2) and 
      (RXGBOX_FIFO_INIT_RD_ADDR /= 3) and 
      (RXGBOX_FIFO_INIT_RD_ADDR /= 5))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-519] RXGBOX_FIFO_INIT_RD_ADDR attribute is set to "));
    Write ( Message, RXGBOX_FIFO_INIT_RD_ADDR);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3 or "));
    Write ( Message, string'("5. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXGEARBOX_EN check
  if((xil_attr_test) or
     ((RXGEARBOX_EN /= "FALSE") and 
      (RXGEARBOX_EN /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-520] RXGEARBOX_EN attribute is set to """));
    Write ( Message, string'(RXGEARBOX_EN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXOOB_CLK_CFG check
  if((xil_attr_test) or
     ((RXOOB_CLK_CFG /= "PMA") and 
      (RXOOB_CLK_CFG /= "FABRIC"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-529] RXOOB_CLK_CFG attribute is set to """));
    Write ( Message, string'(RXOOB_CLK_CFG));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""PMA"" or "));
    Write ( Message, string'("""FABRIC"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXOUT_DIV check
  if((xil_attr_test) or
     ((RXOUT_DIV /= 4) and 
      (RXOUT_DIV /= 1) and 
      (RXOUT_DIV /= 2) and 
      (RXOUT_DIV /= 8) and 
      (RXOUT_DIV /= 16) and 
      (RXOUT_DIV /= 32))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-531] RXOUT_DIV attribute is set to "));
    Write ( Message, RXOUT_DIV);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("8, "));
    Write ( Message, string'("16 or "));
    Write ( Message, string'("32. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXPMACLK_SEL check
  if((xil_attr_test) or
     ((RXPMACLK_SEL /= "DATA") and 
      (RXPMACLK_SEL /= "CROSSING") and 
      (RXPMACLK_SEL /= "EYESCAN"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-546] RXPMACLK_SEL attribute is set to """));
    Write ( Message, string'(RXPMACLK_SEL));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""DATA"", "));
    Write ( Message, string'("""CROSSING"" or "));
    Write ( Message, string'("""EYESCAN"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXPRBS_LINKACQ_CNT check
    if ((RXPRBS_LINKACQ_CNT < 15) or (RXPRBS_LINKACQ_CNT > 255)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-549] RXPRBS_LINKACQ_CNT attribute is set to "));
      Write ( Message, RXPRBS_LINKACQ_CNT);
      Write ( Message, string'(". Legal values for this attribute are 15 to 255. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- RXSLIDE_AUTO_WAIT check
  if((xil_attr_test) or
     ((RXSLIDE_AUTO_WAIT /= 7) and 
      (RXSLIDE_AUTO_WAIT /= 1) and 
      (RXSLIDE_AUTO_WAIT /= 2) and 
      (RXSLIDE_AUTO_WAIT /= 3) and 
      (RXSLIDE_AUTO_WAIT /= 4) and 
      (RXSLIDE_AUTO_WAIT /= 5) and 
      (RXSLIDE_AUTO_WAIT /= 6) and 
      (RXSLIDE_AUTO_WAIT /= 8) and 
      (RXSLIDE_AUTO_WAIT /= 9) and 
      (RXSLIDE_AUTO_WAIT /= 10) and 
      (RXSLIDE_AUTO_WAIT /= 11) and 
      (RXSLIDE_AUTO_WAIT /= 12) and 
      (RXSLIDE_AUTO_WAIT /= 13) and 
      (RXSLIDE_AUTO_WAIT /= 14) and 
      (RXSLIDE_AUTO_WAIT /= 15))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-550] RXSLIDE_AUTO_WAIT attribute is set to "));
    Write ( Message, RXSLIDE_AUTO_WAIT);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("7, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("5, "));
    Write ( Message, string'("6, "));
    Write ( Message, string'("8, "));
    Write ( Message, string'("9, "));
    Write ( Message, string'("10, "));
    Write ( Message, string'("11, "));
    Write ( Message, string'("12, "));
    Write ( Message, string'("13, "));
    Write ( Message, string'("14 or "));
    Write ( Message, string'("15. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RXSLIDE_MODE check
  if((xil_attr_test) or
     ((RXSLIDE_MODE /= "OFF") and 
      (RXSLIDE_MODE /= "AUTO") and 
      (RXSLIDE_MODE /= "PCS") and 
      (RXSLIDE_MODE /= "PMA"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-551] RXSLIDE_MODE attribute is set to """));
    Write ( Message, string'(RXSLIDE_MODE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""OFF"", "));
    Write ( Message, string'("""AUTO"", "));
    Write ( Message, string'("""PCS"" or "));
    Write ( Message, string'("""PMA"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_CLK25_DIV check
    if ((RX_CLK25_DIV < 1) or (RX_CLK25_DIV > 32)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-559] RX_CLK25_DIV attribute is set to "));
      Write ( Message, RX_CLK25_DIV);
      Write ( Message, string'(". Legal values for this attribute are 1 to 32. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- RX_CM_SEL check
  if((xil_attr_test) or
     ((RX_CM_SEL /= 3) and 
      (RX_CM_SEL /= 0) and 
      (RX_CM_SEL /= 1) and 
      (RX_CM_SEL /= 2))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-564] RX_CM_SEL attribute is set to "));
    Write ( Message, RX_CM_SEL);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("1 or "));
    Write ( Message, string'("2. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_CM_TRIM check
  if((xil_attr_test) or
     ((RX_CM_TRIM /= 10) and 
      (RX_CM_TRIM /= 0) and 
      (RX_CM_TRIM /= 1) and 
      (RX_CM_TRIM /= 2) and 
      (RX_CM_TRIM /= 3) and 
      (RX_CM_TRIM /= 4) and 
      (RX_CM_TRIM /= 5) and 
      (RX_CM_TRIM /= 6) and 
      (RX_CM_TRIM /= 7) and 
      (RX_CM_TRIM /= 8) and 
      (RX_CM_TRIM /= 9) and 
      (RX_CM_TRIM /= 11) and 
      (RX_CM_TRIM /= 12) and 
      (RX_CM_TRIM /= 13) and 
      (RX_CM_TRIM /= 14) and 
      (RX_CM_TRIM /= 15))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-565] RX_CM_TRIM attribute is set to "));
    Write ( Message, RX_CM_TRIM);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("10, "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("5, "));
    Write ( Message, string'("6, "));
    Write ( Message, string'("7, "));
    Write ( Message, string'("8, "));
    Write ( Message, string'("9, "));
    Write ( Message, string'("11, "));
    Write ( Message, string'("12, "));
    Write ( Message, string'("13, "));
    Write ( Message, string'("14 or "));
    Write ( Message, string'("15. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_DATA_WIDTH check
  if((xil_attr_test) or
     ((RX_DATA_WIDTH /= 20) and 
      (RX_DATA_WIDTH /= 16) and 
      (RX_DATA_WIDTH /= 32) and 
      (RX_DATA_WIDTH /= 40) and 
      (RX_DATA_WIDTH /= 64) and 
      (RX_DATA_WIDTH /= 80) and 
      (RX_DATA_WIDTH /= 128) and 
      (RX_DATA_WIDTH /= 160))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-569] RX_DATA_WIDTH attribute is set to "));
    Write ( Message, RX_DATA_WIDTH);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("20, "));
    Write ( Message, string'("16, "));
    Write ( Message, string'("32, "));
    Write ( Message, string'("40, "));
    Write ( Message, string'("64, "));
    Write ( Message, string'("80, "));
    Write ( Message, string'("128 or "));
    Write ( Message, string'("160. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_DEFER_RESET_BUF_EN check
  if((xil_attr_test) or
     ((RX_DEFER_RESET_BUF_EN /= "TRUE") and 
      (RX_DEFER_RESET_BUF_EN /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-571] RX_DEFER_RESET_BUF_EN attribute is set to """));
    Write ( Message, string'(RX_DEFER_RESET_BUF_EN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_DFELPM_CFG0 check
  if((xil_attr_test) or
     ((RX_DFELPM_CFG0 /= 6) and 
      (RX_DFELPM_CFG0 /= 0) and 
      (RX_DFELPM_CFG0 /= 1) and 
      (RX_DFELPM_CFG0 /= 2) and 
      (RX_DFELPM_CFG0 /= 3) and 
      (RX_DFELPM_CFG0 /= 4) and 
      (RX_DFELPM_CFG0 /= 5) and 
      (RX_DFELPM_CFG0 /= 7))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-573] RX_DFELPM_CFG0 attribute is set to "));
    Write ( Message, RX_DFELPM_CFG0);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("6, "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("5 or "));
    Write ( Message, string'("7. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_DFE_AGC_CFG1 check
  if((xil_attr_test) or
     ((RX_DFE_AGC_CFG1 /= 4) and 
      (RX_DFE_AGC_CFG1 /= 0) and 
      (RX_DFE_AGC_CFG1 /= 1) and 
      (RX_DFE_AGC_CFG1 /= 2) and 
      (RX_DFE_AGC_CFG1 /= 3) and 
      (RX_DFE_AGC_CFG1 /= 5) and 
      (RX_DFE_AGC_CFG1 /= 6) and 
      (RX_DFE_AGC_CFG1 /= 7))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-577] RX_DFE_AGC_CFG1 attribute is set to "));
    Write ( Message, RX_DFE_AGC_CFG1);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("5, "));
    Write ( Message, string'("6 or "));
    Write ( Message, string'("7. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_DFE_KL_LPM_KH_CFG0 check
  if((xil_attr_test) or
     ((RX_DFE_KL_LPM_KH_CFG0 /= 1) and 
      (RX_DFE_KL_LPM_KH_CFG0 /= 0) and 
      (RX_DFE_KL_LPM_KH_CFG0 /= 2) and 
      (RX_DFE_KL_LPM_KH_CFG0 /= 3))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-578] RX_DFE_KL_LPM_KH_CFG0 attribute is set to "));
    Write ( Message, RX_DFE_KL_LPM_KH_CFG0);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("2 or "));
    Write ( Message, string'("3. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_DFE_KL_LPM_KH_CFG1 check
  if((xil_attr_test) or
     ((RX_DFE_KL_LPM_KH_CFG1 /= 2) and 
      (RX_DFE_KL_LPM_KH_CFG1 /= 1) and 
      (RX_DFE_KL_LPM_KH_CFG1 /= 3) and 
      (RX_DFE_KL_LPM_KH_CFG1 /= 4) and 
      (RX_DFE_KL_LPM_KH_CFG1 /= 5) and 
      (RX_DFE_KL_LPM_KH_CFG1 /= 6) and 
      (RX_DFE_KL_LPM_KH_CFG1 /= 7))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-579] RX_DFE_KL_LPM_KH_CFG1 attribute is set to "));
    Write ( Message, RX_DFE_KL_LPM_KH_CFG1);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("5, "));
    Write ( Message, string'("6 or "));
    Write ( Message, string'("7. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_DISPERR_SEQ_MATCH check
  if((xil_attr_test) or
     ((RX_DISPERR_SEQ_MATCH /= "TRUE") and 
      (RX_DISPERR_SEQ_MATCH /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-583] RX_DISPERR_SEQ_MATCH attribute is set to """));
    Write ( Message, string'(RX_DISPERR_SEQ_MATCH));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_INT_DATAWIDTH check
  if((xil_attr_test) or
     ((RX_INT_DATAWIDTH /= 1) and 
      (RX_INT_DATAWIDTH /= 0) and 
      (RX_INT_DATAWIDTH /= 2))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-594] RX_INT_DATAWIDTH attribute is set to "));
    Write ( Message, RX_INT_DATAWIDTH);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("0 or "));
    Write ( Message, string'("2. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_PROGDIV_CFG check
  if((xil_attr_test) or
     ((RX_PROGDIV_CFG /= 0.0) and 
      (RX_PROGDIV_CFG /= 4.0) and 
      (RX_PROGDIV_CFG /= 5.0) and 
      (RX_PROGDIV_CFG /= 8.0) and 
      (RX_PROGDIV_CFG /= 10.0) and 
      (RX_PROGDIV_CFG /= 16.0) and 
      (RX_PROGDIV_CFG /= 16.5) and 
      (RX_PROGDIV_CFG /= 20.0) and 
      (RX_PROGDIV_CFG /= 32.0) and 
      (RX_PROGDIV_CFG /= 33.0) and 
      (RX_PROGDIV_CFG /= 40.0) and 
      (RX_PROGDIV_CFG /= 64.0) and 
      (RX_PROGDIV_CFG /= 66.0) and 
      (RX_PROGDIV_CFG /= 80.0) and 
      (RX_PROGDIV_CFG /= 100.0))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-596] RX_PROGDIV_CFG attribute is set to "));
    Write ( Message, RX_PROGDIV_CFG);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("0.0, "));
    Write ( Message, string'("4.0, "));
    Write ( Message, string'("5.0, "));
    Write ( Message, string'("8.0, "));
    Write ( Message, string'("10.0, "));
    Write ( Message, string'("16.0, "));
    Write ( Message, string'("16.5, "));
    Write ( Message, string'("20.0, "));
    Write ( Message, string'("32.0, "));
    Write ( Message, string'("33.0, "));
    Write ( Message, string'("40.0, "));
    Write ( Message, string'("64.0, "));
    Write ( Message, string'("66.0, "));
    Write ( Message, string'("80.0 or "));
    Write ( Message, string'("100.0. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- RX_SIG_VALID_DLY check
    if ((RX_SIG_VALID_DLY < 1) or (RX_SIG_VALID_DLY > 32)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-601] RX_SIG_VALID_DLY attribute is set to "));
      Write ( Message, RX_SIG_VALID_DLY);
      Write ( Message, string'(". Legal values for this attribute are 1 to 32. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- RX_XCLK_SEL check
  if((xil_attr_test) or
     ((RX_XCLK_SEL /= "RXDES") and 
      (RX_XCLK_SEL /= "RXPMA") and 
      (RX_XCLK_SEL /= "RXUSR"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-611] RX_XCLK_SEL attribute is set to """));
    Write ( Message, string'(RX_XCLK_SEL));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""RXDES"", "));
    Write ( Message, string'("""RXPMA"" or "));
    Write ( Message, string'("""RXUSR"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- SAS_MAX_COM check
    if ((SAS_MAX_COM < 1) or (SAS_MAX_COM > 127)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-613] SAS_MAX_COM attribute is set to "));
      Write ( Message, SAS_MAX_COM);
      Write ( Message, string'(". Legal values for this attribute are 1 to 127. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- SAS_MIN_COM check
    if ((SAS_MIN_COM < 1) or (SAS_MIN_COM > 63)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-614] SAS_MIN_COM attribute is set to "));
      Write ( Message, SAS_MIN_COM);
      Write ( Message, string'(". Legal values for this attribute are 1 to 63. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- SATA_CPLL_CFG check
  if((xil_attr_test) or
     ((SATA_CPLL_CFG /= "VCO_3000MHZ") and 
      (SATA_CPLL_CFG /= "VCO_750MHZ") and 
      (SATA_CPLL_CFG /= "VCO_1500MHZ"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-617] SATA_CPLL_CFG attribute is set to """));
    Write ( Message, string'(SATA_CPLL_CFG));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""VCO_3000MHZ"", "));
    Write ( Message, string'("""VCO_750MHZ"" or "));
    Write ( Message, string'("""VCO_1500MHZ"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- SATA_MAX_BURST check
    if ((SATA_MAX_BURST < 1) or (SATA_MAX_BURST > 63)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-619] SATA_MAX_BURST attribute is set to "));
      Write ( Message, SATA_MAX_BURST);
      Write ( Message, string'(". Legal values for this attribute are 1 to 63. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- SATA_MAX_INIT check
    if ((SATA_MAX_INIT < 1) or (SATA_MAX_INIT > 63)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-620] SATA_MAX_INIT attribute is set to "));
      Write ( Message, SATA_MAX_INIT);
      Write ( Message, string'(". Legal values for this attribute are 1 to 63. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- SATA_MAX_WAKE check
    if ((SATA_MAX_WAKE < 1) or (SATA_MAX_WAKE > 63)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-621] SATA_MAX_WAKE attribute is set to "));
      Write ( Message, SATA_MAX_WAKE);
      Write ( Message, string'(". Legal values for this attribute are 1 to 63. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- SATA_MIN_BURST check
    if ((SATA_MIN_BURST < 1) or (SATA_MIN_BURST > 61)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-622] SATA_MIN_BURST attribute is set to "));
      Write ( Message, SATA_MIN_BURST);
      Write ( Message, string'(". Legal values for this attribute are 1 to 61. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- SATA_MIN_INIT check
    if ((SATA_MIN_INIT < 1) or (SATA_MIN_INIT > 63)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-623] SATA_MIN_INIT attribute is set to "));
      Write ( Message, SATA_MIN_INIT);
      Write ( Message, string'(". Legal values for this attribute are 1 to 63. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- SATA_MIN_WAKE check
    if ((SATA_MIN_WAKE < 1) or (SATA_MIN_WAKE > 63)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-624] SATA_MIN_WAKE attribute is set to "));
      Write ( Message, SATA_MIN_WAKE);
      Write ( Message, string'(". Legal values for this attribute are 1 to 63. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- SHOW_REALIGN_COMMA check
  if((xil_attr_test) or
     ((SHOW_REALIGN_COMMA /= "TRUE") and 
      (SHOW_REALIGN_COMMA /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-625] SHOW_REALIGN_COMMA attribute is set to """));
    Write ( Message, string'(SHOW_REALIGN_COMMA));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- SIM_RECEIVER_DETECT_PASS check
  if((xil_attr_test) or
     ((SIM_RECEIVER_DETECT_PASS /= "TRUE") and 
      (SIM_RECEIVER_DETECT_PASS /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-626] SIM_RECEIVER_DETECT_PASS attribute is set to """));
    Write ( Message, string'(SIM_RECEIVER_DETECT_PASS));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- SIM_RESET_SPEEDUP check
  if((xil_attr_test) or
     ((SIM_RESET_SPEEDUP /= "TRUE") and 
      (SIM_RESET_SPEEDUP /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-627] SIM_RESET_SPEEDUP attribute is set to """));
    Write ( Message, string'(SIM_RESET_SPEEDUP));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- SIM_VERSION check
  if((xil_attr_test) or
     ((SIM_VERSION /= 1.0) and 
      (SIM_VERSION /= 2.0))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-629] SIM_VERSION attribute is set to "));
    Write ( Message, SIM_VERSION);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("1.0 or "));
    Write ( Message, string'("2.0. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TXBUF_EN check
  if((xil_attr_test) or
     ((TXBUF_EN /= "TRUE") and 
      (TXBUF_EN /= "FALSE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-637] TXBUF_EN attribute is set to """));
    Write ( Message, string'(TXBUF_EN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TXBUF_RESET_ON_RATE_CHANGE check
  if((xil_attr_test) or
     ((TXBUF_RESET_ON_RATE_CHANGE /= "FALSE") and 
      (TXBUF_RESET_ON_RATE_CHANGE /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-638] TXBUF_RESET_ON_RATE_CHANGE attribute is set to """));
    Write ( Message, string'(TXBUF_RESET_ON_RATE_CHANGE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TXFIFO_ADDR_CFG check
  if((xil_attr_test) or
     ((TXFIFO_ADDR_CFG /= "LOW") and 
      (TXFIFO_ADDR_CFG /= "HIGH"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-641] TXFIFO_ADDR_CFG attribute is set to """));
    Write ( Message, string'(TXFIFO_ADDR_CFG));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""LOW"" or "));
    Write ( Message, string'("""HIGH"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TXGBOX_FIFO_INIT_RD_ADDR check
  if((xil_attr_test) or
     ((TXGBOX_FIFO_INIT_RD_ADDR /= 4) and 
      (TXGBOX_FIFO_INIT_RD_ADDR /= 2) and 
      (TXGBOX_FIFO_INIT_RD_ADDR /= 3) and 
      (TXGBOX_FIFO_INIT_RD_ADDR /= 5) and 
      (TXGBOX_FIFO_INIT_RD_ADDR /= 6))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-642] TXGBOX_FIFO_INIT_RD_ADDR attribute is set to "));
    Write ( Message, TXGBOX_FIFO_INIT_RD_ADDR);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("5 or "));
    Write ( Message, string'("6. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TXGEARBOX_EN check
  if((xil_attr_test) or
     ((TXGEARBOX_EN /= "FALSE") and 
      (TXGEARBOX_EN /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-643] TXGEARBOX_EN attribute is set to """));
    Write ( Message, string'(TXGEARBOX_EN));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TXOUT_DIV check
  if((xil_attr_test) or
     ((TXOUT_DIV /= 4) and 
      (TXOUT_DIV /= 1) and 
      (TXOUT_DIV /= 2) and 
      (TXOUT_DIV /= 8) and 
      (TXOUT_DIV /= 16) and 
      (TXOUT_DIV /= 32))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-645] TXOUT_DIV attribute is set to "));
    Write ( Message, TXOUT_DIV);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("8, "));
    Write ( Message, string'("16 or "));
    Write ( Message, string'("32. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TXPI_PPMCLK_SEL check
  if((xil_attr_test) or
     ((TXPI_PPMCLK_SEL /= "TXUSRCLK2") and 
      (TXPI_PPMCLK_SEL /= "TXUSRCLK"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-661] TXPI_PPMCLK_SEL attribute is set to """));
    Write ( Message, string'(TXPI_PPMCLK_SEL));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TXUSRCLK2"" or "));
    Write ( Message, string'("""TXUSRCLK"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_CLK25_DIV check
    if ((TX_CLK25_DIV < 1) or (TX_CLK25_DIV > 32)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-670] TX_CLK25_DIV attribute is set to "));
      Write ( Message, TX_CLK25_DIV);
      Write ( Message, string'(". Legal values for this attribute are 1 to 32. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- TX_DATA_WIDTH check
  if((xil_attr_test) or
     ((TX_DATA_WIDTH /= 20) and 
      (TX_DATA_WIDTH /= 16) and 
      (TX_DATA_WIDTH /= 32) and 
      (TX_DATA_WIDTH /= 40) and 
      (TX_DATA_WIDTH /= 64) and 
      (TX_DATA_WIDTH /= 80) and 
      (TX_DATA_WIDTH /= 128) and 
      (TX_DATA_WIDTH /= 160))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-674] TX_DATA_WIDTH attribute is set to "));
    Write ( Message, TX_DATA_WIDTH);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("20, "));
    Write ( Message, string'("16, "));
    Write ( Message, string'("32, "));
    Write ( Message, string'("40, "));
    Write ( Message, string'("64, "));
    Write ( Message, string'("80, "));
    Write ( Message, string'("128 or "));
    Write ( Message, string'("160. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_DRIVE_MODE check
  if((xil_attr_test) or
     ((TX_DRIVE_MODE /= "DIRECT") and 
      (TX_DRIVE_MODE /= "PIPE") and 
      (TX_DRIVE_MODE /= "PIPEGEN3"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-680] TX_DRIVE_MODE attribute is set to """));
    Write ( Message, string'(TX_DRIVE_MODE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""DIRECT"", "));
    Write ( Message, string'("""PIPE"" or "));
    Write ( Message, string'("""PIPEGEN3"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_DRVMUX_CTRL check
  if((xil_attr_test) or
     ((TX_DRVMUX_CTRL /= 2) and 
      (TX_DRVMUX_CTRL /= 0) and 
      (TX_DRVMUX_CTRL /= 1) and 
      (TX_DRVMUX_CTRL /= 3))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-681] TX_DRVMUX_CTRL attribute is set to "));
    Write ( Message, TX_DRVMUX_CTRL);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("1 or "));
    Write ( Message, string'("3. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_INT_DATAWIDTH check
  if((xil_attr_test) or
     ((TX_INT_DATAWIDTH /= 1) and 
      (TX_INT_DATAWIDTH /= 0) and 
      (TX_INT_DATAWIDTH /= 2))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-688] TX_INT_DATAWIDTH attribute is set to "));
    Write ( Message, TX_INT_DATAWIDTH);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("0 or "));
    Write ( Message, string'("2. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_LOOPBACK_DRIVE_HIZ check
  if((xil_attr_test) or
     ((TX_LOOPBACK_DRIVE_HIZ /= "FALSE") and 
      (TX_LOOPBACK_DRIVE_HIZ /= "TRUE"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-689] TX_LOOPBACK_DRIVE_HIZ attribute is set to """));
    Write ( Message, string'(TX_LOOPBACK_DRIVE_HIZ));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FALSE"" or "));
    Write ( Message, string'("""TRUE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_PI_BIASSET check
  if((xil_attr_test) or
     ((TX_PI_BIASSET /= 0) and 
      (TX_PI_BIASSET /= 1) and 
      (TX_PI_BIASSET /= 2) and 
      (TX_PI_BIASSET /= 3))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-705] TX_PI_BIASSET attribute is set to "));
    Write ( Message, TX_PI_BIASSET);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2 or "));
    Write ( Message, string'("3. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_PREDRV_CTRL check
  if((xil_attr_test) or
     ((TX_PREDRV_CTRL /= 2) and 
      (TX_PREDRV_CTRL /= 0) and 
      (TX_PREDRV_CTRL /= 1) and 
      (TX_PREDRV_CTRL /= 3))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-713] TX_PREDRV_CTRL attribute is set to "));
    Write ( Message, TX_PREDRV_CTRL);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("1 or "));
    Write ( Message, string'("3. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_PROGCLK_SEL check
  if((xil_attr_test) or
     ((TX_PROGCLK_SEL /= "POSTPI") and 
      (TX_PROGCLK_SEL /= "CPLL") and 
      (TX_PROGCLK_SEL /= "PREPI"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-714] TX_PROGCLK_SEL attribute is set to """));
    Write ( Message, string'(TX_PROGCLK_SEL));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""POSTPI"", "));
    Write ( Message, string'("""CPLL"" or "));
    Write ( Message, string'("""PREPI"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_PROGDIV_CFG check
  if((xil_attr_test) or
     ((TX_PROGDIV_CFG /= 0.0) and 
      (TX_PROGDIV_CFG /= 4.0) and 
      (TX_PROGDIV_CFG /= 5.0) and 
      (TX_PROGDIV_CFG /= 8.0) and 
      (TX_PROGDIV_CFG /= 10.0) and 
      (TX_PROGDIV_CFG /= 16.0) and 
      (TX_PROGDIV_CFG /= 16.5) and 
      (TX_PROGDIV_CFG /= 20.0) and 
      (TX_PROGDIV_CFG /= 32.0) and 
      (TX_PROGDIV_CFG /= 33.0) and 
      (TX_PROGDIV_CFG /= 40.0) and 
      (TX_PROGDIV_CFG /= 64.0) and 
      (TX_PROGDIV_CFG /= 66.0) and 
      (TX_PROGDIV_CFG /= 80.0) and 
      (TX_PROGDIV_CFG /= 100.0))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-715] TX_PROGDIV_CFG attribute is set to "));
    Write ( Message, TX_PROGDIV_CFG);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("0.0, "));
    Write ( Message, string'("4.0, "));
    Write ( Message, string'("5.0, "));
    Write ( Message, string'("8.0, "));
    Write ( Message, string'("10.0, "));
    Write ( Message, string'("16.0, "));
    Write ( Message, string'("16.5, "));
    Write ( Message, string'("20.0, "));
    Write ( Message, string'("32.0, "));
    Write ( Message, string'("33.0, "));
    Write ( Message, string'("40.0, "));
    Write ( Message, string'("64.0, "));
    Write ( Message, string'("66.0, "));
    Write ( Message, string'("80.0 or "));
    Write ( Message, string'("100.0. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_RXDETECT_REF check
  if((xil_attr_test) or
     ((TX_RXDETECT_REF /= 4) and 
      (TX_RXDETECT_REF /= 0) and 
      (TX_RXDETECT_REF /= 1) and 
      (TX_RXDETECT_REF /= 2) and 
      (TX_RXDETECT_REF /= 3) and 
      (TX_RXDETECT_REF /= 5) and 
      (TX_RXDETECT_REF /= 6) and 
      (TX_RXDETECT_REF /= 7))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-718] TX_RXDETECT_REF attribute is set to "));
    Write ( Message, TX_RXDETECT_REF);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("4, "));
    Write ( Message, string'("0, "));
    Write ( Message, string'("1, "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("3, "));
    Write ( Message, string'("5, "));
    Write ( Message, string'("6 or "));
    Write ( Message, string'("7. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- TX_XCLK_SEL check
  if((xil_attr_test) or
     ((TX_XCLK_SEL /= "TXOUT") and 
      (TX_XCLK_SEL /= "TXUSR"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-729] TX_XCLK_SEL attribute is set to """));
    Write ( Message, string'(TX_XCLK_SEL));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TXOUT"" or "));
    Write ( Message, string'("""TXUSR"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    if  (attr_err) then
      Write ( Message, string'("[Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-567] Attribute Error(s) encountered. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_CHANNEL_V'INSTANCE_NAME));
      assert FALSE
      report Message.all
      severity error;
    end if;
    wait;
    end process INIPROC;

end GTYE3_CHANNEL_V;
