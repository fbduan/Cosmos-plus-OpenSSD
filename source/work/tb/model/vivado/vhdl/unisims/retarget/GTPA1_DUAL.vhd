-------------------------------------------------------
--  Copyright (c) 2011 Xilinx Inc.
--  All Right Reserved.
-------------------------------------------------------
--
--   ____  ____
--  /   /\/   / 
-- /___/  \  /     Vendor      : Xilinx 
-- \   \   \/      Version : 11.1
--  \   \          Description : Xilinx Functional Simulation Library Component
--  /   /                        Multi-Gigabit Tranceiver Port Secure IP
-- /___/   /\      Filename    : GTPA1_DUAL.vhd
-- \   \  /  \      
--  \__ \/\__ \                   
--                                 
-- Revision:
--    08/16/11 - Initial version.
-- End Revision

----- CELL GTPA1_DUAL -----

library IEEE;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_1164.all;

library unisim;
use unisim.VCOMPONENTS.all;
use unisim.vpkg.all;

  entity GTPA1_DUAL is
    generic (
      AC_CAP_DIS_0 : boolean := TRUE;
      AC_CAP_DIS_1 : boolean := TRUE;
      ALIGN_COMMA_WORD_0 : integer := 1;
      ALIGN_COMMA_WORD_1 : integer := 1;
      CB2_INH_CC_PERIOD_0 : integer := 8;
      CB2_INH_CC_PERIOD_1 : integer := 8;
      CDR_PH_ADJ_TIME_0 : bit_vector := "01010";
      CDR_PH_ADJ_TIME_1 : bit_vector := "01010";
      CHAN_BOND_1_MAX_SKEW_0 : integer := 7;
      CHAN_BOND_1_MAX_SKEW_1 : integer := 7;
      CHAN_BOND_2_MAX_SKEW_0 : integer := 1;
      CHAN_BOND_2_MAX_SKEW_1 : integer := 1;
      CHAN_BOND_KEEP_ALIGN_0 : boolean := FALSE;
      CHAN_BOND_KEEP_ALIGN_1 : boolean := FALSE;
      CHAN_BOND_SEQ_1_1_0 : bit_vector := "0101111100";
      CHAN_BOND_SEQ_1_1_1 : bit_vector := "0101111100";
      CHAN_BOND_SEQ_1_2_0 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_2_1 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_3_0 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_3_1 : bit_vector := "0001001010";
      CHAN_BOND_SEQ_1_4_0 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_1_4_1 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_1_ENABLE_0 : bit_vector := "1111";
      CHAN_BOND_SEQ_1_ENABLE_1 : bit_vector := "1111";
      CHAN_BOND_SEQ_2_1_0 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_2_1_1 : bit_vector := "0110111100";
      CHAN_BOND_SEQ_2_2_0 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_2_1 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_3_0 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_3_1 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_4_0 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_4_1 : bit_vector := "0100111100";
      CHAN_BOND_SEQ_2_ENABLE_0 : bit_vector := "1111";
      CHAN_BOND_SEQ_2_ENABLE_1 : bit_vector := "1111";
      CHAN_BOND_SEQ_2_USE_0 : boolean := FALSE;
      CHAN_BOND_SEQ_2_USE_1 : boolean := FALSE;
      CHAN_BOND_SEQ_LEN_0 : integer := 1;
      CHAN_BOND_SEQ_LEN_1 : integer := 1;
      CLK25_DIVIDER_0 : integer := 4;
      CLK25_DIVIDER_1 : integer := 4;
      CLKINDC_B_0 : boolean := TRUE;
      CLKINDC_B_1 : boolean := TRUE;
      CLKRCV_TRST_0 : boolean := TRUE;
      CLKRCV_TRST_1 : boolean := TRUE;
      CLK_CORRECT_USE_0 : boolean := TRUE;
      CLK_CORRECT_USE_1 : boolean := TRUE;
      CLK_COR_ADJ_LEN_0 : integer := 1;
      CLK_COR_ADJ_LEN_1 : integer := 1;
      CLK_COR_DET_LEN_0 : integer := 1;
      CLK_COR_DET_LEN_1 : integer := 1;
      CLK_COR_INSERT_IDLE_FLAG_0 : boolean := FALSE;
      CLK_COR_INSERT_IDLE_FLAG_1 : boolean := FALSE;
      CLK_COR_KEEP_IDLE_0 : boolean := FALSE;
      CLK_COR_KEEP_IDLE_1 : boolean := FALSE;
      CLK_COR_MAX_LAT_0 : integer := 20;
      CLK_COR_MAX_LAT_1 : integer := 20;
      CLK_COR_MIN_LAT_0 : integer := 18;
      CLK_COR_MIN_LAT_1 : integer := 18;
      CLK_COR_PRECEDENCE_0 : boolean := TRUE;
      CLK_COR_PRECEDENCE_1 : boolean := TRUE;
      CLK_COR_REPEAT_WAIT_0 : integer := 0;
      CLK_COR_REPEAT_WAIT_1 : integer := 0;
      CLK_COR_SEQ_1_1_0 : bit_vector := "0100011100";
      CLK_COR_SEQ_1_1_1 : bit_vector := "0100011100";
      CLK_COR_SEQ_1_2_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_1_2_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_1_3_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_1_3_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_1_4_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_1_4_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_1_ENABLE_0 : bit_vector := "1111";
      CLK_COR_SEQ_1_ENABLE_1 : bit_vector := "1111";
      CLK_COR_SEQ_2_1_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_1_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_2_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_2_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_3_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_3_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_4_0 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_4_1 : bit_vector := "0000000000";
      CLK_COR_SEQ_2_ENABLE_0 : bit_vector := "1111";
      CLK_COR_SEQ_2_ENABLE_1 : bit_vector := "1111";
      CLK_COR_SEQ_2_USE_0 : boolean := FALSE;
      CLK_COR_SEQ_2_USE_1 : boolean := FALSE;
      CLK_OUT_GTP_SEL_0 : string := "REFCLKPLL0";
      CLK_OUT_GTP_SEL_1 : string := "REFCLKPLL1";
      CM_TRIM_0 : bit_vector := "00";
      CM_TRIM_1 : bit_vector := "00";
      COMMA_10B_ENABLE_0 : bit_vector := "1111111111";
      COMMA_10B_ENABLE_1 : bit_vector := "1111111111";
      COM_BURST_VAL_0 : bit_vector := "1111";
      COM_BURST_VAL_1 : bit_vector := "1111";
      DEC_MCOMMA_DETECT_0 : boolean := TRUE;
      DEC_MCOMMA_DETECT_1 : boolean := TRUE;
      DEC_PCOMMA_DETECT_0 : boolean := TRUE;
      DEC_PCOMMA_DETECT_1 : boolean := TRUE;
      DEC_VALID_COMMA_ONLY_0 : boolean := TRUE;
      DEC_VALID_COMMA_ONLY_1 : boolean := TRUE;
      GTP_CFG_PWRUP_0 : boolean := TRUE;
      GTP_CFG_PWRUP_1 : boolean := TRUE;
      MCOMMA_10B_VALUE_0 : bit_vector := "1010000011";
      MCOMMA_10B_VALUE_1 : bit_vector := "1010000011";
      MCOMMA_DETECT_0 : boolean := TRUE;
      MCOMMA_DETECT_1 : boolean := TRUE;
      OOBDETECT_THRESHOLD_0 : bit_vector := "110";
      OOBDETECT_THRESHOLD_1 : bit_vector := "110";
      OOB_CLK_DIVIDER_0 : integer := 4;
      OOB_CLK_DIVIDER_1 : integer := 4;
      PCI_EXPRESS_MODE_0 : boolean := FALSE;
      PCI_EXPRESS_MODE_1 : boolean := FALSE;
      PCOMMA_10B_VALUE_0 : bit_vector := "0101111100";
      PCOMMA_10B_VALUE_1 : bit_vector := "0101111100";
      PCOMMA_DETECT_0 : boolean := TRUE;
      PCOMMA_DETECT_1 : boolean := TRUE;
      PLLLKDET_CFG_0 : bit_vector := "101";
      PLLLKDET_CFG_1 : bit_vector := "101";
      PLL_COM_CFG_0 : bit_vector := X"21680A";
      PLL_COM_CFG_1 : bit_vector := X"21680A";
      PLL_CP_CFG_0 : bit_vector := X"00";
      PLL_CP_CFG_1 : bit_vector := X"00";
      PLL_DIVSEL_FB_0 : integer := 5;
      PLL_DIVSEL_FB_1 : integer := 5;
      PLL_DIVSEL_REF_0 : integer := 2;
      PLL_DIVSEL_REF_1 : integer := 2;
      PLL_RXDIVSEL_OUT_0 : integer := 1;
      PLL_RXDIVSEL_OUT_1 : integer := 1;
      PLL_SATA_0 : boolean := FALSE;
      PLL_SATA_1 : boolean := FALSE;
      PLL_SOURCE_0 : string := "PLL0";
      PLL_SOURCE_1 : string := "PLL0";
      PLL_TXDIVSEL_OUT_0 : integer := 1;
      PLL_TXDIVSEL_OUT_1 : integer := 1;
      PMA_CDR_SCAN_0 : bit_vector := X"6404040";
      PMA_CDR_SCAN_1 : bit_vector := X"6404040";
      PMA_COM_CFG_EAST : bit_vector := X"000008000";
      PMA_COM_CFG_WEST : bit_vector := X"00000A000";
      PMA_RXSYNC_CFG_0 : bit_vector := X"00";
      PMA_RXSYNC_CFG_1 : bit_vector := X"00";
      PMA_RX_CFG_0 : bit_vector := X"05CE048";
      PMA_RX_CFG_1 : bit_vector := X"05CE048";
      PMA_TX_CFG_0 : bit_vector := X"00082";
      PMA_TX_CFG_1 : bit_vector := X"00082";
      RCV_TERM_GND_0 : boolean := FALSE;
      RCV_TERM_GND_1 : boolean := FALSE;
      RCV_TERM_VTTRX_0 : boolean := TRUE;
      RCV_TERM_VTTRX_1 : boolean := TRUE;
      RXEQ_CFG_0 : bit_vector := "01111011";
      RXEQ_CFG_1 : bit_vector := "01111011";
      RXPRBSERR_LOOPBACK_0 : bit := '0';
      RXPRBSERR_LOOPBACK_1 : bit := '0';
      RX_BUFFER_USE_0 : boolean := TRUE;
      RX_BUFFER_USE_1 : boolean := TRUE;
      RX_DECODE_SEQ_MATCH_0 : boolean := TRUE;
      RX_DECODE_SEQ_MATCH_1 : boolean := TRUE;
      RX_EN_IDLE_HOLD_CDR_0 : boolean := FALSE;
      RX_EN_IDLE_HOLD_CDR_1 : boolean := FALSE;
      RX_EN_IDLE_RESET_BUF_0 : boolean := TRUE;
      RX_EN_IDLE_RESET_BUF_1 : boolean := TRUE;
      RX_EN_IDLE_RESET_FR_0 : boolean := TRUE;
      RX_EN_IDLE_RESET_FR_1 : boolean := TRUE;
      RX_EN_IDLE_RESET_PH_0 : boolean := TRUE;
      RX_EN_IDLE_RESET_PH_1 : boolean := TRUE;
      RX_EN_MODE_RESET_BUF_0 : boolean := TRUE;
      RX_EN_MODE_RESET_BUF_1 : boolean := TRUE;
      RX_IDLE_HI_CNT_0 : bit_vector := "1000";
      RX_IDLE_HI_CNT_1 : bit_vector := "1000";
      RX_IDLE_LO_CNT_0 : bit_vector := "0000";
      RX_IDLE_LO_CNT_1 : bit_vector := "0000";
      RX_LOSS_OF_SYNC_FSM_0 : boolean := FALSE;
      RX_LOSS_OF_SYNC_FSM_1 : boolean := FALSE;
      RX_LOS_INVALID_INCR_0 : integer := 1;
      RX_LOS_INVALID_INCR_1 : integer := 1;
      RX_LOS_THRESHOLD_0 : integer := 4;
      RX_LOS_THRESHOLD_1 : integer := 4;
      RX_SLIDE_MODE_0 : string := "PCS";
      RX_SLIDE_MODE_1 : string := "PCS";
      RX_STATUS_FMT_0 : string := "PCIE";
      RX_STATUS_FMT_1 : string := "PCIE";
      RX_XCLK_SEL_0 : string := "RXREC";
      RX_XCLK_SEL_1 : string := "RXREC";
      SATA_BURST_VAL_0 : bit_vector := "100";
      SATA_BURST_VAL_1 : bit_vector := "100";
      SATA_IDLE_VAL_0 : bit_vector := "011";
      SATA_IDLE_VAL_1 : bit_vector := "011";
      SATA_MAX_BURST_0 : integer := 7;
      SATA_MAX_BURST_1 : integer := 7;
      SATA_MAX_INIT_0 : integer := 22;
      SATA_MAX_INIT_1 : integer := 22;
      SATA_MAX_WAKE_0 : integer := 7;
      SATA_MAX_WAKE_1 : integer := 7;
      SATA_MIN_BURST_0 : integer := 4;
      SATA_MIN_BURST_1 : integer := 4;
      SATA_MIN_INIT_0 : integer := 12;
      SATA_MIN_INIT_1 : integer := 12;
      SATA_MIN_WAKE_0 : integer := 4;
      SATA_MIN_WAKE_1 : integer := 4;
      SIM_GTPRESET_SPEEDUP : integer := 0;
      SIM_RECEIVER_DETECT_PASS : boolean := FALSE;
      SIM_REFCLK0_SOURCE : bit_vector := "000";
      SIM_REFCLK1_SOURCE : bit_vector := "000";
      SIM_TX_ELEC_IDLE_LEVEL : string := "X";
      SIM_VERSION : string := "2.0";
      TERMINATION_CTRL_0 : bit_vector := "10100";
      TERMINATION_CTRL_1 : bit_vector := "10100";
      TERMINATION_OVRD_0 : boolean := FALSE;
      TERMINATION_OVRD_1 : boolean := FALSE;
      TRANS_TIME_FROM_P2_0 : bit_vector := X"03C";
      TRANS_TIME_FROM_P2_1 : bit_vector := X"03C";
      TRANS_TIME_NON_P2_0 : bit_vector := X"19";
      TRANS_TIME_NON_P2_1 : bit_vector := X"19";
      TRANS_TIME_TO_P2_0 : bit_vector := X"064";
      TRANS_TIME_TO_P2_1 : bit_vector := X"064";
      TST_ATTR_0 : bit_vector := X"00000000";
      TST_ATTR_1 : bit_vector := X"00000000";
      TXRX_INVERT_0 : bit_vector := "011";
      TXRX_INVERT_1 : bit_vector := "011";
      TX_BUFFER_USE_0 : boolean := FALSE;
      TX_BUFFER_USE_1 : boolean := FALSE;
      TX_DETECT_RX_CFG_0 : bit_vector := X"1832";
      TX_DETECT_RX_CFG_1 : bit_vector := X"1832";
      TX_IDLE_DELAY_0 : bit_vector := "011";
      TX_IDLE_DELAY_1 : bit_vector := "011";
      TX_TDCC_CFG_0 : bit_vector := "00";
      TX_TDCC_CFG_1 : bit_vector := "00";
      TX_XCLK_SEL_0 : string := "TXUSR";
      TX_XCLK_SEL_1 : string := "TXUSR"
    );

    port (
      DRDY                 : out std_ulogic;
      DRPDO                : out std_logic_vector(15 downto 0);
      GTPCLKFBEAST         : out std_logic_vector(1 downto 0);
      GTPCLKFBWEST         : out std_logic_vector(1 downto 0);
      GTPCLKOUT0           : out std_logic_vector(1 downto 0);
      GTPCLKOUT1           : out std_logic_vector(1 downto 0);
      PHYSTATUS0           : out std_ulogic;
      PHYSTATUS1           : out std_ulogic;
      PLLLKDET0            : out std_ulogic;
      PLLLKDET1            : out std_ulogic;
      RCALOUTEAST          : out std_logic_vector(4 downto 0);
      RCALOUTWEST          : out std_logic_vector(4 downto 0);
      REFCLKOUT0           : out std_ulogic;
      REFCLKOUT1           : out std_ulogic;
      REFCLKPLL0           : out std_ulogic;
      REFCLKPLL1           : out std_ulogic;
      RESETDONE0           : out std_ulogic;
      RESETDONE1           : out std_ulogic;
      RXBUFSTATUS0         : out std_logic_vector(2 downto 0);
      RXBUFSTATUS1         : out std_logic_vector(2 downto 0);
      RXBYTEISALIGNED0     : out std_ulogic;
      RXBYTEISALIGNED1     : out std_ulogic;
      RXBYTEREALIGN0       : out std_ulogic;
      RXBYTEREALIGN1       : out std_ulogic;
      RXCHANBONDSEQ0       : out std_ulogic;
      RXCHANBONDSEQ1       : out std_ulogic;
      RXCHANISALIGNED0     : out std_ulogic;
      RXCHANISALIGNED1     : out std_ulogic;
      RXCHANREALIGN0       : out std_ulogic;
      RXCHANREALIGN1       : out std_ulogic;
      RXCHARISCOMMA0       : out std_logic_vector(3 downto 0);
      RXCHARISCOMMA1       : out std_logic_vector(3 downto 0);
      RXCHARISK0           : out std_logic_vector(3 downto 0);
      RXCHARISK1           : out std_logic_vector(3 downto 0);
      RXCHBONDO            : out std_logic_vector(2 downto 0);
      RXCLKCORCNT0         : out std_logic_vector(2 downto 0);
      RXCLKCORCNT1         : out std_logic_vector(2 downto 0);
      RXCOMMADET0          : out std_ulogic;
      RXCOMMADET1          : out std_ulogic;
      RXDATA0              : out std_logic_vector(31 downto 0);
      RXDATA1              : out std_logic_vector(31 downto 0);
      RXDISPERR0           : out std_logic_vector(3 downto 0);
      RXDISPERR1           : out std_logic_vector(3 downto 0);
      RXELECIDLE0          : out std_ulogic;
      RXELECIDLE1          : out std_ulogic;
      RXLOSSOFSYNC0        : out std_logic_vector(1 downto 0);
      RXLOSSOFSYNC1        : out std_logic_vector(1 downto 0);
      RXNOTINTABLE0        : out std_logic_vector(3 downto 0);
      RXNOTINTABLE1        : out std_logic_vector(3 downto 0);
      RXPRBSERR0           : out std_ulogic;
      RXPRBSERR1           : out std_ulogic;
      RXRECCLK0            : out std_ulogic;
      RXRECCLK1            : out std_ulogic;
      RXRUNDISP0           : out std_logic_vector(3 downto 0);
      RXRUNDISP1           : out std_logic_vector(3 downto 0);
      RXSTATUS0            : out std_logic_vector(2 downto 0);
      RXSTATUS1            : out std_logic_vector(2 downto 0);
      RXVALID0             : out std_ulogic;
      RXVALID1             : out std_ulogic;
      TSTOUT0              : out std_logic_vector(4 downto 0);
      TSTOUT1              : out std_logic_vector(4 downto 0);
      TXBUFSTATUS0         : out std_logic_vector(1 downto 0);
      TXBUFSTATUS1         : out std_logic_vector(1 downto 0);
      TXKERR0              : out std_logic_vector(3 downto 0);
      TXKERR1              : out std_logic_vector(3 downto 0);
      TXN0                 : out std_ulogic;
      TXN1                 : out std_ulogic;
      TXOUTCLK0            : out std_ulogic;
      TXOUTCLK1            : out std_ulogic;
      TXP0                 : out std_ulogic;
      TXP1                 : out std_ulogic;
      TXRUNDISP0           : out std_logic_vector(3 downto 0);
      TXRUNDISP1           : out std_logic_vector(3 downto 0);
      CLK00                : in std_ulogic;
      CLK01                : in std_ulogic;
      CLK10                : in std_ulogic;
      CLK11                : in std_ulogic;
      CLKINEAST0           : in std_ulogic;
      CLKINEAST1           : in std_ulogic;
      CLKINWEST0           : in std_ulogic;
      CLKINWEST1           : in std_ulogic;
      DADDR                : in std_logic_vector(7 downto 0);
      DCLK                 : in std_ulogic;
      DEN                  : in std_ulogic;
      DI                   : in std_logic_vector(15 downto 0);
      DWE                  : in std_ulogic;
      GATERXELECIDLE0      : in std_ulogic;
      GATERXELECIDLE1      : in std_ulogic;
      GCLK00               : in std_ulogic;
      GCLK01               : in std_ulogic;
      GCLK10               : in std_ulogic;
      GCLK11               : in std_ulogic;
      GTPCLKFBSEL0EAST     : in std_logic_vector(1 downto 0);
      GTPCLKFBSEL0WEST     : in std_logic_vector(1 downto 0);
      GTPCLKFBSEL1EAST     : in std_logic_vector(1 downto 0);
      GTPCLKFBSEL1WEST     : in std_logic_vector(1 downto 0);
      GTPRESET0            : in std_ulogic;
      GTPRESET1            : in std_ulogic;
      GTPTEST0             : in std_logic_vector(7 downto 0);
      GTPTEST1             : in std_logic_vector(7 downto 0);
      IGNORESIGDET0        : in std_ulogic;
      IGNORESIGDET1        : in std_ulogic;
      INTDATAWIDTH0        : in std_ulogic;
      INTDATAWIDTH1        : in std_ulogic;
      LOOPBACK0            : in std_logic_vector(2 downto 0);
      LOOPBACK1            : in std_logic_vector(2 downto 0);
      PLLCLK00             : in std_ulogic;
      PLLCLK01             : in std_ulogic;
      PLLCLK10             : in std_ulogic;
      PLLCLK11             : in std_ulogic;
      PLLLKDETEN0          : in std_ulogic;
      PLLLKDETEN1          : in std_ulogic;
      PLLPOWERDOWN0        : in std_ulogic;
      PLLPOWERDOWN1        : in std_ulogic;
      PRBSCNTRESET0        : in std_ulogic;
      PRBSCNTRESET1        : in std_ulogic;
      RCALINEAST           : in std_logic_vector(4 downto 0);
      RCALINWEST           : in std_logic_vector(4 downto 0);
      REFCLKPWRDNB0        : in std_ulogic;
      REFCLKPWRDNB1        : in std_ulogic;
      REFSELDYPLL0         : in std_logic_vector(2 downto 0);
      REFSELDYPLL1         : in std_logic_vector(2 downto 0);
      RXBUFRESET0          : in std_ulogic;
      RXBUFRESET1          : in std_ulogic;
      RXCDRRESET0          : in std_ulogic;
      RXCDRRESET1          : in std_ulogic;
      RXCHBONDI            : in std_logic_vector(2 downto 0);
      RXCHBONDMASTER0      : in std_ulogic;
      RXCHBONDMASTER1      : in std_ulogic;
      RXCHBONDSLAVE0       : in std_ulogic;
      RXCHBONDSLAVE1       : in std_ulogic;
      RXCOMMADETUSE0       : in std_ulogic;
      RXCOMMADETUSE1       : in std_ulogic;
      RXDATAWIDTH0         : in std_logic_vector(1 downto 0);
      RXDATAWIDTH1         : in std_logic_vector(1 downto 0);
      RXDEC8B10BUSE0       : in std_ulogic;
      RXDEC8B10BUSE1       : in std_ulogic;
      RXENCHANSYNC0        : in std_ulogic;
      RXENCHANSYNC1        : in std_ulogic;
      RXENMCOMMAALIGN0     : in std_ulogic;
      RXENMCOMMAALIGN1     : in std_ulogic;
      RXENPCOMMAALIGN0     : in std_ulogic;
      RXENPCOMMAALIGN1     : in std_ulogic;
      RXENPMAPHASEALIGN0   : in std_ulogic;
      RXENPMAPHASEALIGN1   : in std_ulogic;
      RXENPRBSTST0         : in std_logic_vector(2 downto 0);
      RXENPRBSTST1         : in std_logic_vector(2 downto 0);
      RXEQMIX0             : in std_logic_vector(1 downto 0);
      RXEQMIX1             : in std_logic_vector(1 downto 0);
      RXN0                 : in std_ulogic;
      RXN1                 : in std_ulogic;
      RXP0                 : in std_ulogic;
      RXP1                 : in std_ulogic;
      RXPMASETPHASE0       : in std_ulogic;
      RXPMASETPHASE1       : in std_ulogic;
      RXPOLARITY0          : in std_ulogic;
      RXPOLARITY1          : in std_ulogic;
      RXPOWERDOWN0         : in std_logic_vector(1 downto 0);
      RXPOWERDOWN1         : in std_logic_vector(1 downto 0);
      RXRESET0             : in std_ulogic;
      RXRESET1             : in std_ulogic;
      RXSLIDE0             : in std_ulogic;
      RXSLIDE1             : in std_ulogic;
      RXUSRCLK0            : in std_ulogic;
      RXUSRCLK1            : in std_ulogic;
      RXUSRCLK20           : in std_ulogic;
      RXUSRCLK21           : in std_ulogic;
      TSTCLK0              : in std_ulogic;
      TSTCLK1              : in std_ulogic;
      TSTIN0               : in std_logic_vector(11 downto 0);
      TSTIN1               : in std_logic_vector(11 downto 0);
      TXBUFDIFFCTRL0       : in std_logic_vector(2 downto 0);
      TXBUFDIFFCTRL1       : in std_logic_vector(2 downto 0);
      TXBYPASS8B10B0       : in std_logic_vector(3 downto 0);
      TXBYPASS8B10B1       : in std_logic_vector(3 downto 0);
      TXCHARDISPMODE0      : in std_logic_vector(3 downto 0);
      TXCHARDISPMODE1      : in std_logic_vector(3 downto 0);
      TXCHARDISPVAL0       : in std_logic_vector(3 downto 0);
      TXCHARDISPVAL1       : in std_logic_vector(3 downto 0);
      TXCHARISK0           : in std_logic_vector(3 downto 0);
      TXCHARISK1           : in std_logic_vector(3 downto 0);
      TXCOMSTART0          : in std_ulogic;
      TXCOMSTART1          : in std_ulogic;
      TXCOMTYPE0           : in std_ulogic;
      TXCOMTYPE1           : in std_ulogic;
      TXDATA0              : in std_logic_vector(31 downto 0);
      TXDATA1              : in std_logic_vector(31 downto 0);
      TXDATAWIDTH0         : in std_logic_vector(1 downto 0);
      TXDATAWIDTH1         : in std_logic_vector(1 downto 0);
      TXDETECTRX0          : in std_ulogic;
      TXDETECTRX1          : in std_ulogic;
      TXDIFFCTRL0          : in std_logic_vector(3 downto 0);
      TXDIFFCTRL1          : in std_logic_vector(3 downto 0);
      TXELECIDLE0          : in std_ulogic;
      TXELECIDLE1          : in std_ulogic;
      TXENC8B10BUSE0       : in std_ulogic;
      TXENC8B10BUSE1       : in std_ulogic;
      TXENPMAPHASEALIGN0   : in std_ulogic;
      TXENPMAPHASEALIGN1   : in std_ulogic;
      TXENPRBSTST0         : in std_logic_vector(2 downto 0);
      TXENPRBSTST1         : in std_logic_vector(2 downto 0);
      TXINHIBIT0           : in std_ulogic;
      TXINHIBIT1           : in std_ulogic;
      TXPDOWNASYNCH0       : in std_ulogic;
      TXPDOWNASYNCH1       : in std_ulogic;
      TXPMASETPHASE0       : in std_ulogic;
      TXPMASETPHASE1       : in std_ulogic;
      TXPOLARITY0          : in std_ulogic;
      TXPOLARITY1          : in std_ulogic;
      TXPOWERDOWN0         : in std_logic_vector(1 downto 0);
      TXPOWERDOWN1         : in std_logic_vector(1 downto 0);
      TXPRBSFORCEERR0      : in std_ulogic;
      TXPRBSFORCEERR1      : in std_ulogic;
      TXPREEMPHASIS0       : in std_logic_vector(2 downto 0);
      TXPREEMPHASIS1       : in std_logic_vector(2 downto 0);
      TXRESET0             : in std_ulogic;
      TXRESET1             : in std_ulogic;
      TXUSRCLK0            : in std_ulogic;
      TXUSRCLK1            : in std_ulogic;
      TXUSRCLK20           : in std_ulogic;
      TXUSRCLK21           : in std_ulogic;
      USRCODEERR0          : in std_ulogic;
      USRCODEERR1          : in std_ulogic      
    );
  end GTPA1_DUAL;

  architecture GTPA1_DUAL_V of GTPA1_DUAL is

  begin
      
--####################################################################
--#####                        Initialization                      ###
--####################################################################
      prcs_init:process
        begin

            assert false
                report "ERROR : The following component GTPA1_DUAL is not supported for retargeting in this architecture.  Please modify your source code to use supported primitives.  The complete list of supported primitives for this architectures is provided in the 7 Series HDL Libraries Guide available on www.xilinx.com."
                severity Failure;

              wait;

          end process prcs_init;
      
  end GTPA1_DUAL_V;