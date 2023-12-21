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
-- /___/   /\      Filename    : GTYE3_COMMON.vhd
-- \   \  /  \
--  \__ \/\__ \
--
-----------------------------------------------------------------------------
--  Revision:
--
--  End Revision:
-----------------------------------------------------------------------------

----- CELL GTYE3_COMMON -----

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

entity GTYE3_COMMON is
  generic (
    A_SDM1DATA1_0 : std_logic_vector(15 downto 0) := "0000000000000000";
    A_SDM1DATA1_1 : std_logic_vector(8 downto 0) := "000000000";
    BIAS_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    BIAS_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    BIAS_CFG2 : std_logic_vector(15 downto 0) := X"0000";
    BIAS_CFG3 : std_logic_vector(15 downto 0) := X"0000";
    BIAS_CFG4 : std_logic_vector(15 downto 0) := X"0000";
    BIAS_CFG_RSVD : std_logic_vector(9 downto 0) := "0000000000";
    COMMON_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    COMMON_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    POR_CFG : std_logic_vector(15 downto 0) := X"0004";
    PPF0_CFG : std_logic_vector(15 downto 0) := X"0FFF";
    PPF1_CFG : std_logic_vector(15 downto 0) := X"0FFF";
    QPLL0CLKOUT_RATE : string := "FULL";
    QPLL0_CFG0 : std_logic_vector(15 downto 0) := X"301C";
    QPLL0_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    QPLL0_CFG1_G3 : std_logic_vector(15 downto 0) := X"0020";
    QPLL0_CFG2 : std_logic_vector(15 downto 0) := X"0780";
    QPLL0_CFG2_G3 : std_logic_vector(15 downto 0) := X"0780";
    QPLL0_CFG3 : std_logic_vector(15 downto 0) := X"0120";
    QPLL0_CFG4 : std_logic_vector(15 downto 0) := X"0021";
    QPLL0_CP : std_logic_vector(9 downto 0) := "0000011111";
    QPLL0_CP_G3 : std_logic_vector(9 downto 0) := "0000011111";
    QPLL0_FBDIV : integer := 66;
    QPLL0_FBDIV_G3 : integer := 80;
    QPLL0_INIT_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    QPLL0_INIT_CFG1 : std_logic_vector(7 downto 0) := X"00";
    QPLL0_LOCK_CFG : std_logic_vector(15 downto 0) := X"01E8";
    QPLL0_LOCK_CFG_G3 : std_logic_vector(15 downto 0) := X"21E8";
    QPLL0_LPF : std_logic_vector(9 downto 0) := "1111111111";
    QPLL0_LPF_G3 : std_logic_vector(9 downto 0) := "1111111111";
    QPLL0_REFCLK_DIV : integer := 2;
    QPLL0_SDM_CFG0 : std_logic_vector(15 downto 0) := X"0040";
    QPLL0_SDM_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    QPLL0_SDM_CFG2 : std_logic_vector(15 downto 0) := X"0000";
    QPLL1CLKOUT_RATE : string := "FULL";
    QPLL1_CFG0 : std_logic_vector(15 downto 0) := X"301C";
    QPLL1_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    QPLL1_CFG1_G3 : std_logic_vector(15 downto 0) := X"0020";
    QPLL1_CFG2 : std_logic_vector(15 downto 0) := X"0780";
    QPLL1_CFG2_G3 : std_logic_vector(15 downto 0) := X"0780";
    QPLL1_CFG3 : std_logic_vector(15 downto 0) := X"0120";
    QPLL1_CFG4 : std_logic_vector(15 downto 0) := X"0021";
    QPLL1_CP : std_logic_vector(9 downto 0) := "0000011111";
    QPLL1_CP_G3 : std_logic_vector(9 downto 0) := "0000011111";
    QPLL1_FBDIV : integer := 66;
    QPLL1_FBDIV_G3 : integer := 80;
    QPLL1_INIT_CFG0 : std_logic_vector(15 downto 0) := X"0000";
    QPLL1_INIT_CFG1 : std_logic_vector(7 downto 0) := X"00";
    QPLL1_LOCK_CFG : std_logic_vector(15 downto 0) := X"01E8";
    QPLL1_LOCK_CFG_G3 : std_logic_vector(15 downto 0) := X"21E8";
    QPLL1_LPF : std_logic_vector(9 downto 0) := "1111111111";
    QPLL1_LPF_G3 : std_logic_vector(9 downto 0) := "1111111111";
    QPLL1_REFCLK_DIV : integer := 2;
    QPLL1_SDM_CFG0 : std_logic_vector(15 downto 0) := X"0040";
    QPLL1_SDM_CFG1 : std_logic_vector(15 downto 0) := X"0000";
    QPLL1_SDM_CFG2 : std_logic_vector(15 downto 0) := X"0000";
    RSVD_ATTR0 : std_logic_vector(15 downto 0) := X"0000";
    RSVD_ATTR1 : std_logic_vector(15 downto 0) := X"0000";
    RSVD_ATTR2 : std_logic_vector(15 downto 0) := X"0000";
    RSVD_ATTR3 : std_logic_vector(15 downto 0) := X"0000";
    RXRECCLKOUT0_SEL : std_logic_vector(1 downto 0) := "00";
    RXRECCLKOUT1_SEL : std_logic_vector(1 downto 0) := "00";
    SARC_EN : bit := '1';
    SARC_SEL : bit := '0';
    SDM0INITSEED0_0 : std_logic_vector(15 downto 0) := "0000000000000000";
    SDM0INITSEED0_1 : std_logic_vector(8 downto 0) := "000000000";
    SDM1INITSEED0_0 : std_logic_vector(15 downto 0) := "0000000000000000";
    SDM1INITSEED0_1 : std_logic_vector(8 downto 0) := "000000000";
    SIM_RESET_SPEEDUP : string := "TRUE";
    SIM_VERSION : real := 1.0
  );

  port (
    DRPDO                : out std_logic_vector(15 downto 0);
    DRPRDY               : out std_ulogic;
    PMARSVDOUT0          : out std_logic_vector(7 downto 0);
    PMARSVDOUT1          : out std_logic_vector(7 downto 0);
    QPLL0FBCLKLOST       : out std_ulogic;
    QPLL0LOCK            : out std_ulogic;
    QPLL0OUTCLK          : out std_ulogic;
    QPLL0OUTREFCLK       : out std_ulogic;
    QPLL0REFCLKLOST      : out std_ulogic;
    QPLL1FBCLKLOST       : out std_ulogic;
    QPLL1LOCK            : out std_ulogic;
    QPLL1OUTCLK          : out std_ulogic;
    QPLL1OUTREFCLK       : out std_ulogic;
    QPLL1REFCLKLOST      : out std_ulogic;
    QPLLDMONITOR0        : out std_logic_vector(7 downto 0);
    QPLLDMONITOR1        : out std_logic_vector(7 downto 0);
    REFCLKOUTMONITOR0    : out std_ulogic;
    REFCLKOUTMONITOR1    : out std_ulogic;
    RXRECCLK0_SEL        : out std_logic_vector(1 downto 0);
    RXRECCLK1_SEL        : out std_logic_vector(1 downto 0);
    SDM0FINALOUT         : out std_logic_vector(3 downto 0);
    SDM0TESTDATA         : out std_logic_vector(14 downto 0);
    SDM1FINALOUT         : out std_logic_vector(3 downto 0);
    SDM1TESTDATA         : out std_logic_vector(14 downto 0);
    BGBYPASSB            : in std_ulogic;
    BGMONITORENB         : in std_ulogic;
    BGPDB                : in std_ulogic;
    BGRCALOVRD           : in std_logic_vector(4 downto 0);
    BGRCALOVRDENB        : in std_ulogic;
    DRPADDR              : in std_logic_vector(9 downto 0);
    DRPCLK               : in std_ulogic;
    DRPDI                : in std_logic_vector(15 downto 0);
    DRPEN                : in std_ulogic;
    DRPWE                : in std_ulogic;
    GTGREFCLK0           : in std_ulogic;
    GTGREFCLK1           : in std_ulogic;
    GTNORTHREFCLK00      : in std_ulogic;
    GTNORTHREFCLK01      : in std_ulogic;
    GTNORTHREFCLK10      : in std_ulogic;
    GTNORTHREFCLK11      : in std_ulogic;
    GTREFCLK00           : in std_ulogic;
    GTREFCLK01           : in std_ulogic;
    GTREFCLK10           : in std_ulogic;
    GTREFCLK11           : in std_ulogic;
    GTSOUTHREFCLK00      : in std_ulogic;
    GTSOUTHREFCLK01      : in std_ulogic;
    GTSOUTHREFCLK10      : in std_ulogic;
    GTSOUTHREFCLK11      : in std_ulogic;
    PMARSVD0             : in std_logic_vector(7 downto 0);
    PMARSVD1             : in std_logic_vector(7 downto 0);
    QPLL0CLKRSVD0        : in std_ulogic;
    QPLL0LOCKDETCLK      : in std_ulogic;
    QPLL0LOCKEN          : in std_ulogic;
    QPLL0PD              : in std_ulogic;
    QPLL0REFCLKSEL       : in std_logic_vector(2 downto 0);
    QPLL0RESET           : in std_ulogic;
    QPLL1CLKRSVD0        : in std_ulogic;
    QPLL1LOCKDETCLK      : in std_ulogic;
    QPLL1LOCKEN          : in std_ulogic;
    QPLL1PD              : in std_ulogic;
    QPLL1REFCLKSEL       : in std_logic_vector(2 downto 0);
    QPLL1RESET           : in std_ulogic;
    QPLLRSVD1            : in std_logic_vector(7 downto 0);
    QPLLRSVD2            : in std_logic_vector(4 downto 0);
    QPLLRSVD3            : in std_logic_vector(4 downto 0);
    QPLLRSVD4            : in std_logic_vector(7 downto 0);
    RCALENB              : in std_ulogic;
    SDM0DATA             : in std_logic_vector(24 downto 0);
    SDM0RESET            : in std_ulogic;
    SDM0WIDTH            : in std_logic_vector(1 downto 0);
    SDM1DATA             : in std_logic_vector(24 downto 0);
    SDM1RESET            : in std_ulogic;
    SDM1WIDTH            : in std_logic_vector(1 downto 0)    
  );
end GTYE3_COMMON;

architecture GTYE3_COMMON_V of GTYE3_COMMON is
  component SIP_GTYE3_COMMON
    
    port (
        AEN_BGBS0            : in std_logic_vector(0 downto 0);
        AEN_BGBS1            : in std_logic_vector(0 downto 0);
        AEN_MASTER0          : in std_logic_vector(0 downto 0);
        AEN_MASTER1          : in std_logic_vector(0 downto 0);
        AEN_PD0              : in std_logic_vector(0 downto 0);
        AEN_PD1              : in std_logic_vector(0 downto 0);
        AEN_QPLL0            : in std_logic_vector(0 downto 0);
        AEN_QPLL1            : in std_logic_vector(0 downto 0);
        AEN_REFCLK0          : in std_logic_vector(0 downto 0);
        AEN_REFCLK1          : in std_logic_vector(0 downto 0);
        AEN_RESET0           : in std_logic_vector(0 downto 0);
        AEN_RESET1           : in std_logic_vector(0 downto 0);
        AEN_SDMDATA0         : in std_logic_vector(0 downto 0);
        AEN_SDMDATA1         : in std_logic_vector(0 downto 0);
        AEN_SDMRESET0        : in std_logic_vector(0 downto 0);
        AEN_SDMRESET1        : in std_logic_vector(0 downto 0);
        AEN_SDMWIDTH0        : in std_logic_vector(0 downto 0);
        AEN_SDMWIDTH1        : in std_logic_vector(0 downto 0);
        AQDMUXSEL1           : in std_logic_vector(3 downto 0);
        AVCC_SENSE_SEL       : in std_logic_vector(3 downto 0);
        AVTT_SENSE_SEL       : in std_logic_vector(3 downto 0);
        A_BGMONITOREN        : in std_logic_vector(0 downto 0);
        A_BGPD               : in std_logic_vector(0 downto 0);
        A_GTREFCLKPD0        : in std_logic_vector(0 downto 0);
        A_GTREFCLKPD1        : in std_logic_vector(0 downto 0);
        A_QPLL0LOCKEN        : in std_logic_vector(0 downto 0);
        A_QPLL0PD            : in std_logic_vector(0 downto 0);
        A_QPLL0RESET         : in std_logic_vector(0 downto 0);
        A_QPLL1LOCKEN        : in std_logic_vector(0 downto 0);
        A_QPLL1PD            : in std_logic_vector(0 downto 0);
        A_QPLL1RESET         : in std_logic_vector(0 downto 0);
        A_SDM0DATA1_0        : in std_logic_vector(15 downto 0);
        A_SDM0DATA1_1        : in std_logic_vector(8 downto 0);
        A_SDM1DATA1_0        : in std_logic_vector(15 downto 0);
        A_SDM1DATA1_1        : in std_logic_vector(8 downto 0);
        A_SDMRESET0          : in std_logic_vector(0 downto 0);
        A_SDMRESET1          : in std_logic_vector(0 downto 0);
        BIAS_CFG0            : in std_logic_vector(15 downto 0);
        BIAS_CFG1            : in std_logic_vector(15 downto 0);
        BIAS_CFG2            : in std_logic_vector(15 downto 0);
        BIAS_CFG3            : in std_logic_vector(15 downto 0);
        BIAS_CFG4            : in std_logic_vector(15 downto 0);
        BIAS_CFG_RSVD        : in std_logic_vector(9 downto 0);
        COMMON_AMUX_SEL0     : in std_logic_vector(1 downto 0);
        COMMON_AMUX_SEL1     : in std_logic_vector(1 downto 0);
        COMMON_CFG0          : in std_logic_vector(15 downto 0);
        COMMON_CFG1          : in std_logic_vector(15 downto 0);
        COMMON_INSTANTIATED  : in std_logic_vector(0 downto 0);
        POR_CFG              : in std_logic_vector(15 downto 0);
        PPF0_CFG             : in std_logic_vector(15 downto 0);
        PPF1_CFG             : in std_logic_vector(15 downto 0);
        QPLL0CLKOUT_RATE     : in std_logic_vector(31 downto 0);
        QPLL0_AMONITOR_SEL   : in std_logic_vector(2 downto 0);
        QPLL0_CFG0           : in std_logic_vector(15 downto 0);
        QPLL0_CFG1           : in std_logic_vector(15 downto 0);
        QPLL0_CFG1_G3        : in std_logic_vector(15 downto 0);
        QPLL0_CFG2           : in std_logic_vector(15 downto 0);
        QPLL0_CFG2_G3        : in std_logic_vector(15 downto 0);
        QPLL0_CFG3           : in std_logic_vector(15 downto 0);
        QPLL0_CFG4           : in std_logic_vector(15 downto 0);
        QPLL0_CP             : in std_logic_vector(9 downto 0);
        QPLL0_CP_G3          : in std_logic_vector(9 downto 0);
        QPLL0_FBDIV          : in std_logic_vector(7 downto 0);
        QPLL0_FBDIV_G3       : in std_logic_vector(7 downto 0);
        QPLL0_INIT_CFG0      : in std_logic_vector(15 downto 0);
        QPLL0_INIT_CFG1      : in std_logic_vector(7 downto 0);
        QPLL0_LOCK_CFG       : in std_logic_vector(15 downto 0);
        QPLL0_LOCK_CFG_G3    : in std_logic_vector(15 downto 0);
        QPLL0_LPF            : in std_logic_vector(9 downto 0);
        QPLL0_LPF_G3         : in std_logic_vector(9 downto 0);
        QPLL0_REFCLK_DIV     : in std_logic_vector(4 downto 0);
        QPLL0_SDM_CFG0       : in std_logic_vector(15 downto 0);
        QPLL0_SDM_CFG1       : in std_logic_vector(15 downto 0);
        QPLL0_SDM_CFG2       : in std_logic_vector(15 downto 0);
        QPLL1CLKOUT_RATE     : in std_logic_vector(31 downto 0);
        QPLL1_AMONITOR_SEL   : in std_logic_vector(2 downto 0);
        QPLL1_CFG0           : in std_logic_vector(15 downto 0);
        QPLL1_CFG1           : in std_logic_vector(15 downto 0);
        QPLL1_CFG1_G3        : in std_logic_vector(15 downto 0);
        QPLL1_CFG2           : in std_logic_vector(15 downto 0);
        QPLL1_CFG2_G3        : in std_logic_vector(15 downto 0);
        QPLL1_CFG3           : in std_logic_vector(15 downto 0);
        QPLL1_CFG4           : in std_logic_vector(15 downto 0);
        QPLL1_CP             : in std_logic_vector(9 downto 0);
        QPLL1_CP_G3          : in std_logic_vector(9 downto 0);
        QPLL1_FBDIV          : in std_logic_vector(7 downto 0);
        QPLL1_FBDIV_G3       : in std_logic_vector(7 downto 0);
        QPLL1_INIT_CFG0      : in std_logic_vector(15 downto 0);
        QPLL1_INIT_CFG1      : in std_logic_vector(7 downto 0);
        QPLL1_LOCK_CFG       : in std_logic_vector(15 downto 0);
        QPLL1_LOCK_CFG_G3    : in std_logic_vector(15 downto 0);
        QPLL1_LPF            : in std_logic_vector(9 downto 0);
        QPLL1_LPF_G3         : in std_logic_vector(9 downto 0);
        QPLL1_REFCLK_DIV     : in std_logic_vector(4 downto 0);
        QPLL1_SDM_CFG0       : in std_logic_vector(15 downto 0);
        QPLL1_SDM_CFG1       : in std_logic_vector(15 downto 0);
        QPLL1_SDM_CFG2       : in std_logic_vector(15 downto 0);
        RCALSAP_TESTEN       : in std_logic_vector(0 downto 0);
        RCAL_APROBE          : in std_logic_vector(0 downto 0);
        REFCLK0_EN_DC_COUP   : in std_logic_vector(0 downto 0);
        REFCLK0_VCM_HIGH     : in std_logic_vector(0 downto 0);
        REFCLK0_VCM_LOW      : in std_logic_vector(0 downto 0);
        REFCLK1_EN_DC_COUP   : in std_logic_vector(0 downto 0);
        REFCLK1_VCM_HIGH     : in std_logic_vector(0 downto 0);
        REFCLK1_VCM_LOW      : in std_logic_vector(0 downto 0);
        RSVD_ATTR0           : in std_logic_vector(15 downto 0);
        RSVD_ATTR1           : in std_logic_vector(15 downto 0);
        RSVD_ATTR2           : in std_logic_vector(15 downto 0);
        RSVD_ATTR3           : in std_logic_vector(15 downto 0);
        RXRECCLKOUT0_SEL     : in std_logic_vector(1 downto 0);
        RXRECCLKOUT1_SEL     : in std_logic_vector(1 downto 0);
        SARC_EN              : in std_logic_vector(0 downto 0);
        SARC_SEL             : in std_logic_vector(0 downto 0);
        SDM0INITSEED0_0      : in std_logic_vector(15 downto 0);
        SDM0INITSEED0_1      : in std_logic_vector(8 downto 0);
        SDM1INITSEED0_0      : in std_logic_vector(15 downto 0);
        SDM1INITSEED0_1      : in std_logic_vector(8 downto 0);
        VCCAUX_SENSE_SEL     : in std_logic_vector(1 downto 0);
        DRPDO                : out std_logic_vector(15 downto 0);
        DRPRDY               : out std_ulogic;
        PMARSVDOUT0          : out std_logic_vector(7 downto 0);
        PMARSVDOUT1          : out std_logic_vector(7 downto 0);
        PMASCANOUT           : out std_logic_vector(7 downto 0);
        QPLL0FBCLKLOST       : out std_ulogic;
        QPLL0LOCK            : out std_ulogic;
        QPLL0OUTCLK          : out std_ulogic;
        QPLL0OUTREFCLK       : out std_ulogic;
        QPLL0REFCLKLOST      : out std_ulogic;
        QPLL1FBCLKLOST       : out std_ulogic;
        QPLL1LOCK            : out std_ulogic;
        QPLL1OUTCLK          : out std_ulogic;
        QPLL1OUTREFCLK       : out std_ulogic;
        QPLL1REFCLKLOST      : out std_ulogic;
        QPLLDMONITOR0        : out std_logic_vector(7 downto 0);
        QPLLDMONITOR1        : out std_logic_vector(7 downto 0);
        REFCLKOUTMONITOR0    : out std_ulogic;
        REFCLKOUTMONITOR1    : out std_ulogic;
        RXRECCLK0_SEL        : out std_logic_vector(1 downto 0);
        RXRECCLK1_SEL        : out std_logic_vector(1 downto 0);
        SARCCLK              : out std_logic_vector(3 downto 0);
        SDM0FINALOUT         : out std_logic_vector(3 downto 0);
        SDM0TESTDATA         : out std_logic_vector(14 downto 0);
        SDM1FINALOUT         : out std_logic_vector(3 downto 0);
        SDM1TESTDATA         : out std_logic_vector(14 downto 0);
        BGBYPASSB            : in std_ulogic;
        BGMONITORENB         : in std_ulogic;
        BGPDB                : in std_ulogic;
        BGRCALOVRD           : in std_logic_vector(4 downto 0);
        BGRCALOVRDENB        : in std_ulogic;
        DRPADDR              : in std_logic_vector(9 downto 0);
        DRPCLK               : in std_ulogic;
        DRPDI                : in std_logic_vector(15 downto 0);
        DRPEN                : in std_ulogic;
        DRPWE                : in std_ulogic;
        GTGREFCLK0           : in std_ulogic;
        GTGREFCLK1           : in std_ulogic;
        GTNORTHREFCLK00      : in std_ulogic;
        GTNORTHREFCLK01      : in std_ulogic;
        GTNORTHREFCLK10      : in std_ulogic;
        GTNORTHREFCLK11      : in std_ulogic;
        GTREFCLK00           : in std_ulogic;
        GTREFCLK01           : in std_ulogic;
        GTREFCLK10           : in std_ulogic;
        GTREFCLK11           : in std_ulogic;
        GTSOUTHREFCLK00      : in std_ulogic;
        GTSOUTHREFCLK01      : in std_ulogic;
        GTSOUTHREFCLK10      : in std_ulogic;
        GTSOUTHREFCLK11      : in std_ulogic;
        PMARSVD0             : in std_logic_vector(7 downto 0);
        PMARSVD1             : in std_logic_vector(7 downto 0);
        PMASCANCLK           : in std_logic_vector(7 downto 0);
        PMASCANENB           : in std_ulogic;
        PMASCANIN            : in std_logic_vector(7 downto 0);
        QDPMASCANMODEB       : in std_ulogic;
        QDPMASCANRSTEN       : in std_ulogic;
        QPLL0CLKRSVD0        : in std_ulogic;
        QPLL0LOCKDETCLK      : in std_ulogic;
        QPLL0LOCKEN          : in std_ulogic;
        QPLL0PD              : in std_ulogic;
        QPLL0REFCLKSEL       : in std_logic_vector(2 downto 0);
        QPLL0RESET           : in std_ulogic;
        QPLL1CLKRSVD0        : in std_ulogic;
        QPLL1LOCKDETCLK      : in std_ulogic;
        QPLL1LOCKEN          : in std_ulogic;
        QPLL1PD              : in std_ulogic;
        QPLL1REFCLKSEL       : in std_logic_vector(2 downto 0);
        QPLL1RESET           : in std_ulogic;
        QPLLRSVD1            : in std_logic_vector(7 downto 0);
        QPLLRSVD2            : in std_logic_vector(4 downto 0);
        QPLLRSVD3            : in std_logic_vector(4 downto 0);
        QPLLRSVD4            : in std_logic_vector(7 downto 0);
        RCALENB              : in std_ulogic;
        RXRECCLK             : in std_logic_vector(3 downto 0);
        SDM0DATA             : in std_logic_vector(24 downto 0);
        SDM0RESET            : in std_ulogic;
        SDM0WIDTH            : in std_logic_vector(1 downto 0);
        SDM1DATA             : in std_logic_vector(24 downto 0);
        SDM1RESET            : in std_ulogic;
        SDM1WIDTH            : in std_logic_vector(1 downto 0);
        GSR                  : in std_ulogic
      );
    end component;
    
    constant MODULE_NAME : string := "GTYE3_COMMON";
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
    constant QPLL0CLKOUT_RATE_REG : std_logic_vector(31 downto 0) := conv_string_to_slv(QPLL0CLKOUT_RATE,32);
    constant QPLL1CLKOUT_RATE_REG : std_logic_vector(31 downto 0) := conv_string_to_slv(QPLL1CLKOUT_RATE,32);
    
    constant AEN_BGBS0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_BGBS1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_MASTER0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_MASTER1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_PD0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_PD1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_QPLL0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_QPLL1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_REFCLK0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_REFCLK1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RESET0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_RESET1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_SDMDATA0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_SDMDATA1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_SDMRESET0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_SDMRESET1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_SDMWIDTH0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AEN_SDMWIDTH1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant AQDMUXSEL1_REG : std_logic_vector(3 downto 0) := "0000";
    constant AVCC_SENSE_SEL_REG : std_logic_vector(3 downto 0) := "0000";
    constant AVTT_SENSE_SEL_REG : std_logic_vector(3 downto 0) := "0000";
    constant A_BGMONITOREN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_BGPD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_GTREFCLKPD0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_GTREFCLKPD1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_QPLL0LOCKEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_QPLL0PD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_QPLL0RESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_QPLL1LOCKEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_QPLL1PD_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_QPLL1RESET_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_SDM0DATA1_0_REG : std_logic_vector(15 downto 0) := "0000000000000000";
    constant A_SDM0DATA1_1_REG : std_logic_vector(8 downto 0) := "000000000";
    constant A_SDM1DATA1_0_REG : std_logic_vector(15 downto 0) := A_SDM1DATA1_0;
    constant A_SDM1DATA1_1_REG : std_logic_vector(8 downto 0) := A_SDM1DATA1_1;
    constant A_SDMRESET0_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant A_SDMRESET1_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant BIAS_CFG0_REG : std_logic_vector(15 downto 0) := BIAS_CFG0;
    constant BIAS_CFG1_REG : std_logic_vector(15 downto 0) := BIAS_CFG1;
    constant BIAS_CFG2_REG : std_logic_vector(15 downto 0) := BIAS_CFG2;
    constant BIAS_CFG3_REG : std_logic_vector(15 downto 0) := BIAS_CFG3;
    constant BIAS_CFG4_REG : std_logic_vector(15 downto 0) := BIAS_CFG4;
    constant BIAS_CFG_RSVD_REG : std_logic_vector(9 downto 0) := BIAS_CFG_RSVD;
    constant COMMON_AMUX_SEL0_REG : std_logic_vector(1 downto 0) := "00";
    constant COMMON_AMUX_SEL1_REG : std_logic_vector(1 downto 0) := "00";
    constant COMMON_CFG0_REG : std_logic_vector(15 downto 0) := COMMON_CFG0;
    constant COMMON_CFG1_REG : std_logic_vector(15 downto 0) := COMMON_CFG1;
    constant COMMON_INSTANTIATED_REG : std_logic_vector(0 downto 0) := (0=>'1');
    constant POR_CFG_REG : std_logic_vector(15 downto 0) := POR_CFG;
    constant PPF0_CFG_REG : std_logic_vector(15 downto 0) := PPF0_CFG;
    constant PPF1_CFG_REG : std_logic_vector(15 downto 0) := PPF1_CFG;
    constant QPLL0_AMONITOR_SEL_REG : std_logic_vector(2 downto 0) := "000";
    constant QPLL0_CFG0_REG : std_logic_vector(15 downto 0) := QPLL0_CFG0;
    constant QPLL0_CFG1_G3_REG : std_logic_vector(15 downto 0) := QPLL0_CFG1_G3;
    constant QPLL0_CFG1_REG : std_logic_vector(15 downto 0) := QPLL0_CFG1;
    constant QPLL0_CFG2_G3_REG : std_logic_vector(15 downto 0) := QPLL0_CFG2_G3;
    constant QPLL0_CFG2_REG : std_logic_vector(15 downto 0) := QPLL0_CFG2;
    constant QPLL0_CFG3_REG : std_logic_vector(15 downto 0) := QPLL0_CFG3;
    constant QPLL0_CFG4_REG : std_logic_vector(15 downto 0) := QPLL0_CFG4;
    constant QPLL0_CP_G3_REG : std_logic_vector(9 downto 0) := QPLL0_CP_G3;
    constant QPLL0_CP_REG : std_logic_vector(9 downto 0) := QPLL0_CP;
    constant QPLL0_FBDIV_G3_REG : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(QPLL0_FBDIV_G3,8));
    constant QPLL0_FBDIV_REG : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(QPLL0_FBDIV,8));
    constant QPLL0_INIT_CFG0_REG : std_logic_vector(15 downto 0) := QPLL0_INIT_CFG0;
    constant QPLL0_INIT_CFG1_REG : std_logic_vector(7 downto 0) := QPLL0_INIT_CFG1;
    constant QPLL0_LOCK_CFG_G3_REG : std_logic_vector(15 downto 0) := QPLL0_LOCK_CFG_G3;
    constant QPLL0_LOCK_CFG_REG : std_logic_vector(15 downto 0) := QPLL0_LOCK_CFG;
    constant QPLL0_LPF_G3_REG : std_logic_vector(9 downto 0) := QPLL0_LPF_G3;
    constant QPLL0_LPF_REG : std_logic_vector(9 downto 0) := QPLL0_LPF;
    constant QPLL0_REFCLK_DIV_REG : std_logic_vector(4 downto 0) := std_logic_vector(to_unsigned(QPLL0_REFCLK_DIV,5));
    constant QPLL0_SDM_CFG0_REG : std_logic_vector(15 downto 0) := QPLL0_SDM_CFG0;
    constant QPLL0_SDM_CFG1_REG : std_logic_vector(15 downto 0) := QPLL0_SDM_CFG1;
    constant QPLL0_SDM_CFG2_REG : std_logic_vector(15 downto 0) := QPLL0_SDM_CFG2;
    constant QPLL1_AMONITOR_SEL_REG : std_logic_vector(2 downto 0) := "000";
    constant QPLL1_CFG0_REG : std_logic_vector(15 downto 0) := QPLL1_CFG0;
    constant QPLL1_CFG1_G3_REG : std_logic_vector(15 downto 0) := QPLL1_CFG1_G3;
    constant QPLL1_CFG1_REG : std_logic_vector(15 downto 0) := QPLL1_CFG1;
    constant QPLL1_CFG2_G3_REG : std_logic_vector(15 downto 0) := QPLL1_CFG2_G3;
    constant QPLL1_CFG2_REG : std_logic_vector(15 downto 0) := QPLL1_CFG2;
    constant QPLL1_CFG3_REG : std_logic_vector(15 downto 0) := QPLL1_CFG3;
    constant QPLL1_CFG4_REG : std_logic_vector(15 downto 0) := QPLL1_CFG4;
    constant QPLL1_CP_G3_REG : std_logic_vector(9 downto 0) := QPLL1_CP_G3;
    constant QPLL1_CP_REG : std_logic_vector(9 downto 0) := QPLL1_CP;
    constant QPLL1_FBDIV_G3_REG : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(QPLL1_FBDIV_G3,8));
    constant QPLL1_FBDIV_REG : std_logic_vector(7 downto 0) := std_logic_vector(to_unsigned(QPLL1_FBDIV,8));
    constant QPLL1_INIT_CFG0_REG : std_logic_vector(15 downto 0) := QPLL1_INIT_CFG0;
    constant QPLL1_INIT_CFG1_REG : std_logic_vector(7 downto 0) := QPLL1_INIT_CFG1;
    constant QPLL1_LOCK_CFG_G3_REG : std_logic_vector(15 downto 0) := QPLL1_LOCK_CFG_G3;
    constant QPLL1_LOCK_CFG_REG : std_logic_vector(15 downto 0) := QPLL1_LOCK_CFG;
    constant QPLL1_LPF_G3_REG : std_logic_vector(9 downto 0) := QPLL1_LPF_G3;
    constant QPLL1_LPF_REG : std_logic_vector(9 downto 0) := QPLL1_LPF;
    constant QPLL1_REFCLK_DIV_REG : std_logic_vector(4 downto 0) := std_logic_vector(to_unsigned(QPLL1_REFCLK_DIV,5));
    constant QPLL1_SDM_CFG0_REG : std_logic_vector(15 downto 0) := QPLL1_SDM_CFG0;
    constant QPLL1_SDM_CFG1_REG : std_logic_vector(15 downto 0) := QPLL1_SDM_CFG1;
    constant QPLL1_SDM_CFG2_REG : std_logic_vector(15 downto 0) := QPLL1_SDM_CFG2;
    constant RCALSAP_TESTEN_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant RCAL_APROBE_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant REFCLK0_EN_DC_COUP_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant REFCLK0_VCM_HIGH_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant REFCLK0_VCM_LOW_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant REFCLK1_EN_DC_COUP_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant REFCLK1_VCM_HIGH_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant REFCLK1_VCM_LOW_REG : std_logic_vector(0 downto 0) := (0=>'0');
    constant RSVD_ATTR0_REG : std_logic_vector(15 downto 0) := RSVD_ATTR0;
    constant RSVD_ATTR1_REG : std_logic_vector(15 downto 0) := RSVD_ATTR1;
    constant RSVD_ATTR2_REG : std_logic_vector(15 downto 0) := RSVD_ATTR2;
    constant RSVD_ATTR3_REG : std_logic_vector(15 downto 0) := RSVD_ATTR3;
    constant RXRECCLKOUT0_SEL_REG : std_logic_vector(1 downto 0) := RXRECCLKOUT0_SEL;
    constant RXRECCLKOUT1_SEL_REG : std_logic_vector(1 downto 0) := RXRECCLKOUT1_SEL;
    constant SARC_EN_REG : std_logic_vector(0 downto 0) :=  (0=>TO_X01(SARC_EN));
    constant SARC_SEL_REG : std_logic_vector(0 downto 0) :=  (0=>TO_X01(SARC_SEL));
    constant SDM0INITSEED0_0_REG : std_logic_vector(15 downto 0) := SDM0INITSEED0_0;
    constant SDM0INITSEED0_1_REG : std_logic_vector(8 downto 0) := SDM0INITSEED0_1;
    constant SDM1INITSEED0_0_REG : std_logic_vector(15 downto 0) := SDM1INITSEED0_0;
    constant SDM1INITSEED0_1_REG : std_logic_vector(8 downto 0) := SDM1INITSEED0_1;
    constant VCCAUX_SENSE_SEL_REG : std_logic_vector(1 downto 0) := "00";
    
  -- Parameter encodings and registers

    signal glblGSR      : std_ulogic;
    signal xil_attr_test : boolean := false;
  
    signal attr_err     : std_ulogic := '0';
    
    signal DRPDO_out : std_logic_vector(15 downto 0);
    signal DRPRDY_out : std_ulogic;
    signal PMARSVDOUT0_out : std_logic_vector(7 downto 0);
    signal PMARSVDOUT1_out : std_logic_vector(7 downto 0);
    signal PMASCANOUT_out : std_logic_vector(7 downto 0);
    signal QPLL0FBCLKLOST_out : std_ulogic;
    signal QPLL0LOCK_out : std_ulogic;
    signal QPLL0OUTCLK_out : std_ulogic;
    signal QPLL0OUTREFCLK_out : std_ulogic;
    signal QPLL0REFCLKLOST_out : std_ulogic;
    signal QPLL1FBCLKLOST_out : std_ulogic;
    signal QPLL1LOCK_out : std_ulogic;
    signal QPLL1OUTCLK_out : std_ulogic;
    signal QPLL1OUTREFCLK_out : std_ulogic;
    signal QPLL1REFCLKLOST_out : std_ulogic;
    signal QPLLDMONITOR0_out : std_logic_vector(7 downto 0);
    signal QPLLDMONITOR1_out : std_logic_vector(7 downto 0);
    signal REFCLKOUTMONITOR0_out : std_ulogic;
    signal REFCLKOUTMONITOR1_out : std_ulogic;
    signal RXRECCLK0_SEL_out : std_logic_vector(1 downto 0);
    signal RXRECCLK1_SEL_out : std_logic_vector(1 downto 0);
    signal SARCCLK_out : std_logic_vector(3 downto 0);
    signal SDM0FINALOUT_out : std_logic_vector(3 downto 0);
    signal SDM0TESTDATA_out : std_logic_vector(14 downto 0);
    signal SDM1FINALOUT_out : std_logic_vector(3 downto 0);
    signal SDM1TESTDATA_out : std_logic_vector(14 downto 0);
    
    signal DRPDO_delay : std_logic_vector(15 downto 0);
    signal DRPRDY_delay : std_ulogic;
    signal PMARSVDOUT0_delay : std_logic_vector(7 downto 0);
    signal PMARSVDOUT1_delay : std_logic_vector(7 downto 0);
    signal QPLL0FBCLKLOST_delay : std_ulogic;
    signal QPLL0LOCK_delay : std_ulogic;
    signal QPLL0OUTCLK_delay : std_ulogic;
    signal QPLL0OUTREFCLK_delay : std_ulogic;
    signal QPLL0REFCLKLOST_delay : std_ulogic;
    signal QPLL1FBCLKLOST_delay : std_ulogic;
    signal QPLL1LOCK_delay : std_ulogic;
    signal QPLL1OUTCLK_delay : std_ulogic;
    signal QPLL1OUTREFCLK_delay : std_ulogic;
    signal QPLL1REFCLKLOST_delay : std_ulogic;
    signal QPLLDMONITOR0_delay : std_logic_vector(7 downto 0);
    signal QPLLDMONITOR1_delay : std_logic_vector(7 downto 0);
    signal REFCLKOUTMONITOR0_delay : std_ulogic;
    signal REFCLKOUTMONITOR1_delay : std_ulogic;
    signal RXRECCLK0_SEL_delay : std_logic_vector(1 downto 0);
    signal RXRECCLK1_SEL_delay : std_logic_vector(1 downto 0);
    signal SDM0FINALOUT_delay : std_logic_vector(3 downto 0);
    signal SDM0TESTDATA_delay : std_logic_vector(14 downto 0);
    signal SDM1FINALOUT_delay : std_logic_vector(3 downto 0);
    signal SDM1TESTDATA_delay : std_logic_vector(14 downto 0);
    
    signal BGBYPASSB_delay : std_ulogic;
    signal BGMONITORENB_delay : std_ulogic;
    signal BGPDB_delay : std_ulogic;
    signal BGRCALOVRDENB_delay : std_ulogic;
    signal BGRCALOVRD_delay : std_logic_vector(4 downto 0);
    signal DRPADDR_delay : std_logic_vector(9 downto 0);
    signal DRPCLK_delay : std_ulogic;
    signal DRPDI_delay : std_logic_vector(15 downto 0);
    signal DRPEN_delay : std_ulogic;
    signal DRPWE_delay : std_ulogic;
    signal GTGREFCLK0_delay : std_ulogic;
    signal GTGREFCLK1_delay : std_ulogic;
    signal GTNORTHREFCLK00_delay : std_ulogic;
    signal GTNORTHREFCLK01_delay : std_ulogic;
    signal GTNORTHREFCLK10_delay : std_ulogic;
    signal GTNORTHREFCLK11_delay : std_ulogic;
    signal GTREFCLK00_delay : std_ulogic;
    signal GTREFCLK01_delay : std_ulogic;
    signal GTREFCLK10_delay : std_ulogic;
    signal GTREFCLK11_delay : std_ulogic;
    signal GTSOUTHREFCLK00_delay : std_ulogic;
    signal GTSOUTHREFCLK01_delay : std_ulogic;
    signal GTSOUTHREFCLK10_delay : std_ulogic;
    signal GTSOUTHREFCLK11_delay : std_ulogic;
    signal PMARSVD0_delay : std_logic_vector(7 downto 0);
    signal PMARSVD1_delay : std_logic_vector(7 downto 0);
    signal QPLL0CLKRSVD0_delay : std_ulogic;
    signal QPLL0LOCKDETCLK_delay : std_ulogic;
    signal QPLL0LOCKEN_delay : std_ulogic;
    signal QPLL0PD_delay : std_ulogic;
    signal QPLL0REFCLKSEL_delay : std_logic_vector(2 downto 0);
    signal QPLL0RESET_delay : std_ulogic;
    signal QPLL1CLKRSVD0_delay : std_ulogic;
    signal QPLL1LOCKDETCLK_delay : std_ulogic;
    signal QPLL1LOCKEN_delay : std_ulogic;
    signal QPLL1PD_delay : std_ulogic;
    signal QPLL1REFCLKSEL_delay : std_logic_vector(2 downto 0);
    signal QPLL1RESET_delay : std_ulogic;
    signal QPLLRSVD1_delay : std_logic_vector(7 downto 0);
    signal QPLLRSVD2_delay : std_logic_vector(4 downto 0);
    signal QPLLRSVD3_delay : std_logic_vector(4 downto 0);
    signal QPLLRSVD4_delay : std_logic_vector(7 downto 0);
    signal RCALENB_delay : std_ulogic;
    signal SDM0DATA_delay : std_logic_vector(24 downto 0);
    signal SDM0RESET_delay : std_ulogic;
    signal SDM0WIDTH_delay : std_logic_vector(1 downto 0);
    signal SDM1DATA_delay : std_logic_vector(24 downto 0);
    signal SDM1RESET_delay : std_ulogic;
    signal SDM1WIDTH_delay : std_logic_vector(1 downto 0);
    
    signal BGBYPASSB_in : std_ulogic;
    signal BGMONITORENB_in : std_ulogic;
    signal BGPDB_in : std_ulogic;
    signal BGRCALOVRDENB_in : std_ulogic;
    signal BGRCALOVRD_in : std_logic_vector(4 downto 0);
    signal DRPADDR_in : std_logic_vector(9 downto 0);
    signal DRPCLK_in : std_ulogic;
    signal DRPDI_in : std_logic_vector(15 downto 0);
    signal DRPEN_in : std_ulogic;
    signal DRPWE_in : std_ulogic;
    signal GTGREFCLK0_in : std_ulogic;
    signal GTGREFCLK1_in : std_ulogic;
    signal GTNORTHREFCLK00_in : std_ulogic;
    signal GTNORTHREFCLK01_in : std_ulogic;
    signal GTNORTHREFCLK10_in : std_ulogic;
    signal GTNORTHREFCLK11_in : std_ulogic;
    signal GTREFCLK00_in : std_ulogic;
    signal GTREFCLK01_in : std_ulogic;
    signal GTREFCLK10_in : std_ulogic;
    signal GTREFCLK11_in : std_ulogic;
    signal GTSOUTHREFCLK00_in : std_ulogic;
    signal GTSOUTHREFCLK01_in : std_ulogic;
    signal GTSOUTHREFCLK10_in : std_ulogic;
    signal GTSOUTHREFCLK11_in : std_ulogic;
    signal PMARSVD0_in : std_logic_vector(7 downto 0);
    signal PMARSVD1_in : std_logic_vector(7 downto 0);
    signal PMASCANCLK_in : std_logic_vector(7 downto 0);
    signal PMASCANENB_in : std_ulogic;
    signal PMASCANIN_in : std_logic_vector(7 downto 0);
    signal QDPMASCANMODEB_in : std_ulogic;
    signal QDPMASCANRSTEN_in : std_ulogic;
    signal QPLL0CLKRSVD0_in : std_ulogic;
    signal QPLL0LOCKDETCLK_in : std_ulogic;
    signal QPLL0LOCKEN_in : std_ulogic;
    signal QPLL0PD_in : std_ulogic;
    signal QPLL0REFCLKSEL_in : std_logic_vector(2 downto 0);
    signal QPLL0RESET_in : std_ulogic;
    signal QPLL1CLKRSVD0_in : std_ulogic;
    signal QPLL1LOCKDETCLK_in : std_ulogic;
    signal QPLL1LOCKEN_in : std_ulogic;
    signal QPLL1PD_in : std_ulogic;
    signal QPLL1REFCLKSEL_in : std_logic_vector(2 downto 0);
    signal QPLL1RESET_in : std_ulogic;
    signal QPLLRSVD1_in : std_logic_vector(7 downto 0);
    signal QPLLRSVD2_in : std_logic_vector(4 downto 0);
    signal QPLLRSVD3_in : std_logic_vector(4 downto 0);
    signal QPLLRSVD4_in : std_logic_vector(7 downto 0);
    signal RCALENB_in : std_ulogic;
    signal RXRECCLK_in : std_logic_vector(3 downto 0);
    signal SDM0DATA_in : std_logic_vector(24 downto 0);
    signal SDM0RESET_in : std_ulogic;
    signal SDM0WIDTH_in : std_logic_vector(1 downto 0);
    signal SDM1DATA_in : std_logic_vector(24 downto 0);
    signal SDM1RESET_in : std_ulogic;
    signal SDM1WIDTH_in : std_logic_vector(1 downto 0);
    
    begin
    glblGSR     <= TO_X01(GSR);
    DRPDO <= DRPDO_delay after OUT_DELAY;
    DRPRDY <= DRPRDY_delay after OUT_DELAY;
    PMARSVDOUT0 <= PMARSVDOUT0_delay after OUT_DELAY;
    PMARSVDOUT1 <= PMARSVDOUT1_delay after OUT_DELAY;
    QPLL0FBCLKLOST <= QPLL0FBCLKLOST_delay after OUT_DELAY;
    QPLL0LOCK <= QPLL0LOCK_delay after OUT_DELAY;
    QPLL0OUTCLK <= QPLL0OUTCLK_delay after OUT_DELAY;
    QPLL0OUTREFCLK <= QPLL0OUTREFCLK_delay after OUT_DELAY;
    QPLL0REFCLKLOST <= QPLL0REFCLKLOST_delay after OUT_DELAY;
    QPLL1FBCLKLOST <= QPLL1FBCLKLOST_delay after OUT_DELAY;
    QPLL1LOCK <= QPLL1LOCK_delay after OUT_DELAY;
    QPLL1OUTCLK <= QPLL1OUTCLK_delay after OUT_DELAY;
    QPLL1OUTREFCLK <= QPLL1OUTREFCLK_delay after OUT_DELAY;
    QPLL1REFCLKLOST <= QPLL1REFCLKLOST_delay after OUT_DELAY;
    QPLLDMONITOR0 <= QPLLDMONITOR0_delay after OUT_DELAY;
    QPLLDMONITOR1 <= QPLLDMONITOR1_delay after OUT_DELAY;
    REFCLKOUTMONITOR0 <= REFCLKOUTMONITOR0_delay after OUT_DELAY;
    REFCLKOUTMONITOR1 <= REFCLKOUTMONITOR1_delay after OUT_DELAY;
    RXRECCLK0_SEL <= RXRECCLK0_SEL_delay after OUT_DELAY;
    RXRECCLK1_SEL <= RXRECCLK1_SEL_delay after OUT_DELAY;
    SDM0FINALOUT <= SDM0FINALOUT_delay after OUT_DELAY;
    SDM0TESTDATA <= SDM0TESTDATA_delay after OUT_DELAY;
    SDM1FINALOUT <= SDM1FINALOUT_delay after OUT_DELAY;
    SDM1TESTDATA <= SDM1TESTDATA_delay after OUT_DELAY;
    
    DRPDO_delay <= DRPDO_out;
    DRPRDY_delay <= DRPRDY_out;
    PMARSVDOUT0_delay <= PMARSVDOUT0_out;
    PMARSVDOUT1_delay <= PMARSVDOUT1_out;
    QPLL0FBCLKLOST_delay <= QPLL0FBCLKLOST_out;
    QPLL0LOCK_delay <= QPLL0LOCK_out;
    QPLL0OUTCLK_delay <= QPLL0OUTCLK_out;
    QPLL0OUTREFCLK_delay <= QPLL0OUTREFCLK_out;
    QPLL0REFCLKLOST_delay <= QPLL0REFCLKLOST_out;
    QPLL1FBCLKLOST_delay <= QPLL1FBCLKLOST_out;
    QPLL1LOCK_delay <= QPLL1LOCK_out;
    QPLL1OUTCLK_delay <= QPLL1OUTCLK_out;
    QPLL1OUTREFCLK_delay <= QPLL1OUTREFCLK_out;
    QPLL1REFCLKLOST_delay <= QPLL1REFCLKLOST_out;
    QPLLDMONITOR0_delay <= QPLLDMONITOR0_out;
    QPLLDMONITOR1_delay <= QPLLDMONITOR1_out;
    REFCLKOUTMONITOR0_delay <= REFCLKOUTMONITOR0_out;
    REFCLKOUTMONITOR1_delay <= REFCLKOUTMONITOR1_out;
    RXRECCLK0_SEL_delay <= RXRECCLK0_SEL_out;
    RXRECCLK1_SEL_delay <= RXRECCLK1_SEL_out;
    SDM0FINALOUT_delay <= SDM0FINALOUT_out;
    SDM0TESTDATA_delay <= SDM0TESTDATA_out;
    SDM1FINALOUT_delay <= SDM1FINALOUT_out;
    SDM1TESTDATA_delay <= SDM1TESTDATA_out;
    
    DRPCLK_delay <= DRPCLK after INCLK_DELAY;
    GTGREFCLK0_delay <= GTGREFCLK0 after INCLK_DELAY;
    GTGREFCLK1_delay <= GTGREFCLK1 after INCLK_DELAY;
    GTNORTHREFCLK00_delay <= GTNORTHREFCLK00 after INCLK_DELAY;
    GTNORTHREFCLK01_delay <= GTNORTHREFCLK01 after INCLK_DELAY;
    GTNORTHREFCLK10_delay <= GTNORTHREFCLK10 after INCLK_DELAY;
    GTNORTHREFCLK11_delay <= GTNORTHREFCLK11 after INCLK_DELAY;
    GTREFCLK00_delay <= GTREFCLK00 after INCLK_DELAY;
    GTREFCLK01_delay <= GTREFCLK01 after INCLK_DELAY;
    GTREFCLK10_delay <= GTREFCLK10 after INCLK_DELAY;
    GTREFCLK11_delay <= GTREFCLK11 after INCLK_DELAY;
    GTSOUTHREFCLK00_delay <= GTSOUTHREFCLK00 after INCLK_DELAY;
    GTSOUTHREFCLK01_delay <= GTSOUTHREFCLK01 after INCLK_DELAY;
    GTSOUTHREFCLK10_delay <= GTSOUTHREFCLK10 after INCLK_DELAY;
    GTSOUTHREFCLK11_delay <= GTSOUTHREFCLK11 after INCLK_DELAY;
    QPLL0CLKRSVD0_delay <= QPLL0CLKRSVD0 after INCLK_DELAY;
    QPLL0LOCKDETCLK_delay <= QPLL0LOCKDETCLK after INCLK_DELAY;
    QPLL1CLKRSVD0_delay <= QPLL1CLKRSVD0 after INCLK_DELAY;
    QPLL1LOCKDETCLK_delay <= QPLL1LOCKDETCLK after INCLK_DELAY;
    
    BGBYPASSB_delay <= BGBYPASSB after IN_DELAY;
    BGMONITORENB_delay <= BGMONITORENB after IN_DELAY;
    BGPDB_delay <= BGPDB after IN_DELAY;
    BGRCALOVRDENB_delay <= BGRCALOVRDENB after IN_DELAY;
    BGRCALOVRD_delay <= BGRCALOVRD after IN_DELAY;
    DRPADDR_delay <= DRPADDR after IN_DELAY;
    DRPDI_delay <= DRPDI after IN_DELAY;
    DRPEN_delay <= DRPEN after IN_DELAY;
    DRPWE_delay <= DRPWE after IN_DELAY;
    PMARSVD0_delay <= PMARSVD0 after IN_DELAY;
    PMARSVD1_delay <= PMARSVD1 after IN_DELAY;
    QPLL0LOCKEN_delay <= QPLL0LOCKEN after IN_DELAY;
    QPLL0PD_delay <= QPLL0PD after IN_DELAY;
    QPLL0REFCLKSEL_delay <= QPLL0REFCLKSEL after IN_DELAY;
    QPLL0RESET_delay <= QPLL0RESET after IN_DELAY;
    QPLL1LOCKEN_delay <= QPLL1LOCKEN after IN_DELAY;
    QPLL1PD_delay <= QPLL1PD after IN_DELAY;
    QPLL1REFCLKSEL_delay <= QPLL1REFCLKSEL after IN_DELAY;
    QPLL1RESET_delay <= QPLL1RESET after IN_DELAY;
    QPLLRSVD1_delay <= QPLLRSVD1 after IN_DELAY;
    QPLLRSVD2_delay <= QPLLRSVD2 after IN_DELAY;
    QPLLRSVD3_delay <= QPLLRSVD3 after IN_DELAY;
    QPLLRSVD4_delay <= QPLLRSVD4 after IN_DELAY;
    RCALENB_delay <= RCALENB after IN_DELAY;
    SDM0DATA_delay <= SDM0DATA after IN_DELAY;
    SDM0RESET_delay <= SDM0RESET after IN_DELAY;
    SDM0WIDTH_delay <= SDM0WIDTH after IN_DELAY;
    SDM1DATA_delay <= SDM1DATA after IN_DELAY;
    SDM1RESET_delay <= SDM1RESET after IN_DELAY;
    SDM1WIDTH_delay <= SDM1WIDTH after IN_DELAY;
    
    BGBYPASSB_in <= BGBYPASSB_delay;
    BGMONITORENB_in <= BGMONITORENB_delay;
    BGPDB_in <= BGPDB_delay;
    BGRCALOVRDENB_in <= BGRCALOVRDENB_delay;
    BGRCALOVRD_in <= BGRCALOVRD_delay;
    DRPADDR_in <= DRPADDR_delay;
    DRPCLK_in <= DRPCLK_delay;
    DRPDI_in <= DRPDI_delay;
    DRPEN_in <= DRPEN_delay;
    DRPWE_in <= DRPWE_delay;
    GTGREFCLK0_in <= GTGREFCLK0_delay;
    GTGREFCLK1_in <= GTGREFCLK1_delay;
    GTNORTHREFCLK00_in <= GTNORTHREFCLK00_delay;
    GTNORTHREFCLK01_in <= GTNORTHREFCLK01_delay;
    GTNORTHREFCLK10_in <= GTNORTHREFCLK10_delay;
    GTNORTHREFCLK11_in <= GTNORTHREFCLK11_delay;
    GTREFCLK00_in <= GTREFCLK00_delay;
    GTREFCLK01_in <= GTREFCLK01_delay;
    GTREFCLK10_in <= GTREFCLK10_delay;
    GTREFCLK11_in <= GTREFCLK11_delay;
    GTSOUTHREFCLK00_in <= GTSOUTHREFCLK00_delay;
    GTSOUTHREFCLK01_in <= GTSOUTHREFCLK01_delay;
    GTSOUTHREFCLK10_in <= GTSOUTHREFCLK10_delay;
    GTSOUTHREFCLK11_in <= GTSOUTHREFCLK11_delay;
    PMARSVD0_in <= PMARSVD0_delay;
    PMARSVD1_in <= PMARSVD1_delay;
    QPLL0CLKRSVD0_in <= QPLL0CLKRSVD0_delay;
    QPLL0LOCKDETCLK_in <= QPLL0LOCKDETCLK_delay;
    QPLL0LOCKEN_in <= QPLL0LOCKEN_delay;
    QPLL0PD_in <= QPLL0PD_delay;
    QPLL0REFCLKSEL_in <= QPLL0REFCLKSEL_delay;
    QPLL0RESET_in <= QPLL0RESET_delay;
    QPLL1CLKRSVD0_in <= QPLL1CLKRSVD0_delay;
    QPLL1LOCKDETCLK_in <= QPLL1LOCKDETCLK_delay;
    QPLL1LOCKEN_in <= QPLL1LOCKEN_delay;
    QPLL1PD_in <= QPLL1PD_delay;
    QPLL1REFCLKSEL_in <= QPLL1REFCLKSEL_delay;
    QPLL1RESET_in <= QPLL1RESET_delay;
    QPLLRSVD1_in <= QPLLRSVD1_delay;
    QPLLRSVD2_in <= QPLLRSVD2_delay;
    QPLLRSVD3_in <= QPLLRSVD3_delay;
    QPLLRSVD4_in <= QPLLRSVD4_delay;
    RCALENB_in <= RCALENB_delay;
    SDM0DATA_in <= SDM0DATA_delay;
    SDM0RESET_in <= SDM0RESET_delay;
    SDM0WIDTH_in <= SDM0WIDTH_delay;
    SDM1DATA_in <= SDM1DATA_delay;
    SDM1RESET_in <= SDM1RESET_delay;
    SDM1WIDTH_in <= SDM1WIDTH_delay;
    

    PMASCANCLK_in <= "11111111"; -- tie off

    PMASCANENB_in <= '1'; -- tie off
    PMASCANIN_in <= "11111111"; -- tie off
    QDPMASCANMODEB_in <= '1'; -- tie off
    QDPMASCANRSTEN_in <= '1'; -- tie off
    RXRECCLK_in <= "1111"; -- tie off
    
    GTYE3_COMMON_INST : SIP_GTYE3_COMMON
      port map (
        AEN_BGBS0            => AEN_BGBS0_REG,
        AEN_BGBS1            => AEN_BGBS1_REG,
        AEN_MASTER0          => AEN_MASTER0_REG,
        AEN_MASTER1          => AEN_MASTER1_REG,
        AEN_PD0              => AEN_PD0_REG,
        AEN_PD1              => AEN_PD1_REG,
        AEN_QPLL0            => AEN_QPLL0_REG,
        AEN_QPLL1            => AEN_QPLL1_REG,
        AEN_REFCLK0          => AEN_REFCLK0_REG,
        AEN_REFCLK1          => AEN_REFCLK1_REG,
        AEN_RESET0           => AEN_RESET0_REG,
        AEN_RESET1           => AEN_RESET1_REG,
        AEN_SDMDATA0         => AEN_SDMDATA0_REG,
        AEN_SDMDATA1         => AEN_SDMDATA1_REG,
        AEN_SDMRESET0        => AEN_SDMRESET0_REG,
        AEN_SDMRESET1        => AEN_SDMRESET1_REG,
        AEN_SDMWIDTH0        => AEN_SDMWIDTH0_REG,
        AEN_SDMWIDTH1        => AEN_SDMWIDTH1_REG,
        AQDMUXSEL1           => AQDMUXSEL1_REG,
        AVCC_SENSE_SEL       => AVCC_SENSE_SEL_REG,
        AVTT_SENSE_SEL       => AVTT_SENSE_SEL_REG,
        A_BGMONITOREN        => A_BGMONITOREN_REG,
        A_BGPD               => A_BGPD_REG,
        A_GTREFCLKPD0        => A_GTREFCLKPD0_REG,
        A_GTREFCLKPD1        => A_GTREFCLKPD1_REG,
        A_QPLL0LOCKEN        => A_QPLL0LOCKEN_REG,
        A_QPLL0PD            => A_QPLL0PD_REG,
        A_QPLL0RESET         => A_QPLL0RESET_REG,
        A_QPLL1LOCKEN        => A_QPLL1LOCKEN_REG,
        A_QPLL1PD            => A_QPLL1PD_REG,
        A_QPLL1RESET         => A_QPLL1RESET_REG,
        A_SDM0DATA1_0        => A_SDM0DATA1_0_REG,
        A_SDM0DATA1_1        => A_SDM0DATA1_1_REG,
        A_SDM1DATA1_0        => A_SDM1DATA1_0_REG,
        A_SDM1DATA1_1        => A_SDM1DATA1_1_REG,
        A_SDMRESET0          => A_SDMRESET0_REG,
        A_SDMRESET1          => A_SDMRESET1_REG,
        BIAS_CFG0            => BIAS_CFG0_REG,
        BIAS_CFG1            => BIAS_CFG1_REG,
        BIAS_CFG2            => BIAS_CFG2_REG,
        BIAS_CFG3            => BIAS_CFG3_REG,
        BIAS_CFG4            => BIAS_CFG4_REG,
        BIAS_CFG_RSVD        => BIAS_CFG_RSVD_REG,
        COMMON_AMUX_SEL0     => COMMON_AMUX_SEL0_REG,
        COMMON_AMUX_SEL1     => COMMON_AMUX_SEL1_REG,
        COMMON_CFG0          => COMMON_CFG0_REG,
        COMMON_CFG1          => COMMON_CFG1_REG,
        COMMON_INSTANTIATED  => COMMON_INSTANTIATED_REG,
        POR_CFG              => POR_CFG_REG,
        PPF0_CFG             => PPF0_CFG_REG,
        PPF1_CFG             => PPF1_CFG_REG,
        QPLL0CLKOUT_RATE     => QPLL0CLKOUT_RATE_REG,
        QPLL0_AMONITOR_SEL   => QPLL0_AMONITOR_SEL_REG,
        QPLL0_CFG0           => QPLL0_CFG0_REG,
        QPLL0_CFG1           => QPLL0_CFG1_REG,
        QPLL0_CFG1_G3        => QPLL0_CFG1_G3_REG,
        QPLL0_CFG2           => QPLL0_CFG2_REG,
        QPLL0_CFG2_G3        => QPLL0_CFG2_G3_REG,
        QPLL0_CFG3           => QPLL0_CFG3_REG,
        QPLL0_CFG4           => QPLL0_CFG4_REG,
        QPLL0_CP             => QPLL0_CP_REG,
        QPLL0_CP_G3          => QPLL0_CP_G3_REG,
        QPLL0_FBDIV          => QPLL0_FBDIV_REG,
        QPLL0_FBDIV_G3       => QPLL0_FBDIV_G3_REG,
        QPLL0_INIT_CFG0      => QPLL0_INIT_CFG0_REG,
        QPLL0_INIT_CFG1      => QPLL0_INIT_CFG1_REG,
        QPLL0_LOCK_CFG       => QPLL0_LOCK_CFG_REG,
        QPLL0_LOCK_CFG_G3    => QPLL0_LOCK_CFG_G3_REG,
        QPLL0_LPF            => QPLL0_LPF_REG,
        QPLL0_LPF_G3         => QPLL0_LPF_G3_REG,
        QPLL0_REFCLK_DIV     => QPLL0_REFCLK_DIV_REG,
        QPLL0_SDM_CFG0       => QPLL0_SDM_CFG0_REG,
        QPLL0_SDM_CFG1       => QPLL0_SDM_CFG1_REG,
        QPLL0_SDM_CFG2       => QPLL0_SDM_CFG2_REG,
        QPLL1CLKOUT_RATE     => QPLL1CLKOUT_RATE_REG,
        QPLL1_AMONITOR_SEL   => QPLL1_AMONITOR_SEL_REG,
        QPLL1_CFG0           => QPLL1_CFG0_REG,
        QPLL1_CFG1           => QPLL1_CFG1_REG,
        QPLL1_CFG1_G3        => QPLL1_CFG1_G3_REG,
        QPLL1_CFG2           => QPLL1_CFG2_REG,
        QPLL1_CFG2_G3        => QPLL1_CFG2_G3_REG,
        QPLL1_CFG3           => QPLL1_CFG3_REG,
        QPLL1_CFG4           => QPLL1_CFG4_REG,
        QPLL1_CP             => QPLL1_CP_REG,
        QPLL1_CP_G3          => QPLL1_CP_G3_REG,
        QPLL1_FBDIV          => QPLL1_FBDIV_REG,
        QPLL1_FBDIV_G3       => QPLL1_FBDIV_G3_REG,
        QPLL1_INIT_CFG0      => QPLL1_INIT_CFG0_REG,
        QPLL1_INIT_CFG1      => QPLL1_INIT_CFG1_REG,
        QPLL1_LOCK_CFG       => QPLL1_LOCK_CFG_REG,
        QPLL1_LOCK_CFG_G3    => QPLL1_LOCK_CFG_G3_REG,
        QPLL1_LPF            => QPLL1_LPF_REG,
        QPLL1_LPF_G3         => QPLL1_LPF_G3_REG,
        QPLL1_REFCLK_DIV     => QPLL1_REFCLK_DIV_REG,
        QPLL1_SDM_CFG0       => QPLL1_SDM_CFG0_REG,
        QPLL1_SDM_CFG1       => QPLL1_SDM_CFG1_REG,
        QPLL1_SDM_CFG2       => QPLL1_SDM_CFG2_REG,
        RCALSAP_TESTEN       => RCALSAP_TESTEN_REG,
        RCAL_APROBE          => RCAL_APROBE_REG,
        REFCLK0_EN_DC_COUP   => REFCLK0_EN_DC_COUP_REG,
        REFCLK0_VCM_HIGH     => REFCLK0_VCM_HIGH_REG,
        REFCLK0_VCM_LOW      => REFCLK0_VCM_LOW_REG,
        REFCLK1_EN_DC_COUP   => REFCLK1_EN_DC_COUP_REG,
        REFCLK1_VCM_HIGH     => REFCLK1_VCM_HIGH_REG,
        REFCLK1_VCM_LOW      => REFCLK1_VCM_LOW_REG,
        RSVD_ATTR0           => RSVD_ATTR0_REG,
        RSVD_ATTR1           => RSVD_ATTR1_REG,
        RSVD_ATTR2           => RSVD_ATTR2_REG,
        RSVD_ATTR3           => RSVD_ATTR3_REG,
        RXRECCLKOUT0_SEL     => RXRECCLKOUT0_SEL_REG,
        RXRECCLKOUT1_SEL     => RXRECCLKOUT1_SEL_REG,
        SARC_EN              => SARC_EN_REG,
        SARC_SEL             => SARC_SEL_REG,
        SDM0INITSEED0_0      => SDM0INITSEED0_0_REG,
        SDM0INITSEED0_1      => SDM0INITSEED0_1_REG,
        SDM1INITSEED0_0      => SDM1INITSEED0_0_REG,
        SDM1INITSEED0_1      => SDM1INITSEED0_1_REG,
        VCCAUX_SENSE_SEL     => VCCAUX_SENSE_SEL_REG,
        DRPDO                => DRPDO_out,
        DRPRDY               => DRPRDY_out,
        PMARSVDOUT0          => PMARSVDOUT0_out,
        PMARSVDOUT1          => PMARSVDOUT1_out,
        PMASCANOUT           => PMASCANOUT_out,
        QPLL0FBCLKLOST       => QPLL0FBCLKLOST_out,
        QPLL0LOCK            => QPLL0LOCK_out,
        QPLL0OUTCLK          => QPLL0OUTCLK_out,
        QPLL0OUTREFCLK       => QPLL0OUTREFCLK_out,
        QPLL0REFCLKLOST      => QPLL0REFCLKLOST_out,
        QPLL1FBCLKLOST       => QPLL1FBCLKLOST_out,
        QPLL1LOCK            => QPLL1LOCK_out,
        QPLL1OUTCLK          => QPLL1OUTCLK_out,
        QPLL1OUTREFCLK       => QPLL1OUTREFCLK_out,
        QPLL1REFCLKLOST      => QPLL1REFCLKLOST_out,
        QPLLDMONITOR0        => QPLLDMONITOR0_out,
        QPLLDMONITOR1        => QPLLDMONITOR1_out,
        REFCLKOUTMONITOR0    => REFCLKOUTMONITOR0_out,
        REFCLKOUTMONITOR1    => REFCLKOUTMONITOR1_out,
        RXRECCLK0_SEL        => RXRECCLK0_SEL_out,
        RXRECCLK1_SEL        => RXRECCLK1_SEL_out,
        SARCCLK              => SARCCLK_out,
        SDM0FINALOUT         => SDM0FINALOUT_out,
        SDM0TESTDATA         => SDM0TESTDATA_out,
        SDM1FINALOUT         => SDM1FINALOUT_out,
        SDM1TESTDATA         => SDM1TESTDATA_out,
        BGBYPASSB            => BGBYPASSB_in,
        BGMONITORENB         => BGMONITORENB_in,
        BGPDB                => BGPDB_in,
        BGRCALOVRD           => BGRCALOVRD_in,
        BGRCALOVRDENB        => BGRCALOVRDENB_in,
        DRPADDR              => DRPADDR_in,
        DRPCLK               => DRPCLK_in,
        DRPDI                => DRPDI_in,
        DRPEN                => DRPEN_in,
        DRPWE                => DRPWE_in,
        GTGREFCLK0           => GTGREFCLK0_in,
        GTGREFCLK1           => GTGREFCLK1_in,
        GTNORTHREFCLK00      => GTNORTHREFCLK00_in,
        GTNORTHREFCLK01      => GTNORTHREFCLK01_in,
        GTNORTHREFCLK10      => GTNORTHREFCLK10_in,
        GTNORTHREFCLK11      => GTNORTHREFCLK11_in,
        GTREFCLK00           => GTREFCLK00_in,
        GTREFCLK01           => GTREFCLK01_in,
        GTREFCLK10           => GTREFCLK10_in,
        GTREFCLK11           => GTREFCLK11_in,
        GTSOUTHREFCLK00      => GTSOUTHREFCLK00_in,
        GTSOUTHREFCLK01      => GTSOUTHREFCLK01_in,
        GTSOUTHREFCLK10      => GTSOUTHREFCLK10_in,
        GTSOUTHREFCLK11      => GTSOUTHREFCLK11_in,
        PMARSVD0             => PMARSVD0_in,
        PMARSVD1             => PMARSVD1_in,
        PMASCANCLK           => PMASCANCLK_in,
        PMASCANENB           => PMASCANENB_in,
        PMASCANIN            => PMASCANIN_in,
        QDPMASCANMODEB       => QDPMASCANMODEB_in,
        QDPMASCANRSTEN       => QDPMASCANRSTEN_in,
        QPLL0CLKRSVD0        => QPLL0CLKRSVD0_in,
        QPLL0LOCKDETCLK      => QPLL0LOCKDETCLK_in,
        QPLL0LOCKEN          => QPLL0LOCKEN_in,
        QPLL0PD              => QPLL0PD_in,
        QPLL0REFCLKSEL       => QPLL0REFCLKSEL_in,
        QPLL0RESET           => QPLL0RESET_in,
        QPLL1CLKRSVD0        => QPLL1CLKRSVD0_in,
        QPLL1LOCKDETCLK      => QPLL1LOCKDETCLK_in,
        QPLL1LOCKEN          => QPLL1LOCKEN_in,
        QPLL1PD              => QPLL1PD_in,
        QPLL1REFCLKSEL       => QPLL1REFCLKSEL_in,
        QPLL1RESET           => QPLL1RESET_in,
        QPLLRSVD1            => QPLLRSVD1_in,
        QPLLRSVD2            => QPLLRSVD2_in,
        QPLLRSVD3            => QPLLRSVD3_in,
        QPLLRSVD4            => QPLLRSVD4_in,
        RCALENB              => RCALENB_in,
        RXRECCLK             => RXRECCLK_in,
        SDM0DATA             => SDM0DATA_in,
        SDM0RESET            => SDM0RESET_in,
        SDM0WIDTH            => SDM0WIDTH_in,
        SDM1DATA             => SDM1DATA_in,
        SDM1RESET            => SDM1RESET_in,
        SDM1WIDTH            => SDM1WIDTH_in,
        GSR                  => glblGSR        
      );

  INIPROC : process
  variable Message : line;
  variable attr_err : boolean := false;
  begin
    -------- QPLL0CLKOUT_RATE check
  if((xil_attr_test) or
     ((QPLL0CLKOUT_RATE /= "FULL") and 
      (QPLL0CLKOUT_RATE /= "HALF"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-152] QPLL0CLKOUT_RATE attribute is set to """));
    Write ( Message, string'(QPLL0CLKOUT_RATE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FULL"" or "));
    Write ( Message, string'("""HALF"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- QPLL0_FBDIV check
    if ((QPLL0_FBDIV < 16) or (QPLL0_FBDIV > 160)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-163] QPLL0_FBDIV attribute is set to "));
      Write ( Message, QPLL0_FBDIV);
      Write ( Message, string'(". Legal values for this attribute are 16 to 160. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- QPLL0_FBDIV_G3 check
    if ((QPLL0_FBDIV_G3 < 16) or (QPLL0_FBDIV_G3 > 160)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-164] QPLL0_FBDIV_G3 attribute is set to "));
      Write ( Message, QPLL0_FBDIV_G3);
      Write ( Message, string'(". Legal values for this attribute are 16 to 160. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- QPLL0_REFCLK_DIV check
  if((xil_attr_test) or
     ((QPLL0_REFCLK_DIV /= 2) and 
      (QPLL0_REFCLK_DIV /= 1) and 
      (QPLL0_REFCLK_DIV /= 3) and 
      (QPLL0_REFCLK_DIV /= 4) and 
      (QPLL0_REFCLK_DIV /= 5) and 
      (QPLL0_REFCLK_DIV /= 6) and 
      (QPLL0_REFCLK_DIV /= 8) and 
      (QPLL0_REFCLK_DIV /= 10) and 
      (QPLL0_REFCLK_DIV /= 12) and 
      (QPLL0_REFCLK_DIV /= 16) and 
      (QPLL0_REFCLK_DIV /= 20))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-171] QPLL0_REFCLK_DIV attribute is set to "));
    Write ( Message, QPLL0_REFCLK_DIV);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("1, "));
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
    Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- QPLL1CLKOUT_RATE check
  if((xil_attr_test) or
     ((QPLL1CLKOUT_RATE /= "FULL") and 
      (QPLL1CLKOUT_RATE /= "HALF"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-175] QPLL1CLKOUT_RATE attribute is set to """));
    Write ( Message, string'(QPLL1CLKOUT_RATE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""FULL"" or "));
    Write ( Message, string'("""HALF"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    -------- QPLL1_FBDIV check
    if ((QPLL1_FBDIV < 16) or (QPLL1_FBDIV > 160)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-186] QPLL1_FBDIV attribute is set to "));
      Write ( Message, QPLL1_FBDIV);
      Write ( Message, string'(". Legal values for this attribute are 16 to 160. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- QPLL1_FBDIV_G3 check
    if ((QPLL1_FBDIV_G3 < 16) or (QPLL1_FBDIV_G3 > 160)) then
      attr_err := true;
      Write ( Message, string'("Error : [Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-187] QPLL1_FBDIV_G3 attribute is set to "));
      Write ( Message, QPLL1_FBDIV_G3);
      Write ( Message, string'(". Legal values for this attribute are 16 to 160. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
      writeline(output, Message);
      DEALLOCATE (Message);
    end if;
    -------- QPLL1_REFCLK_DIV check
  if((xil_attr_test) or
     ((QPLL1_REFCLK_DIV /= 2) and 
      (QPLL1_REFCLK_DIV /= 1) and 
      (QPLL1_REFCLK_DIV /= 3) and 
      (QPLL1_REFCLK_DIV /= 4) and 
      (QPLL1_REFCLK_DIV /= 5) and 
      (QPLL1_REFCLK_DIV /= 6) and 
      (QPLL1_REFCLK_DIV /= 8) and 
      (QPLL1_REFCLK_DIV /= 10) and 
      (QPLL1_REFCLK_DIV /= 12) and 
      (QPLL1_REFCLK_DIV /= 16) and 
      (QPLL1_REFCLK_DIV /= 20))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-194] QPLL1_REFCLK_DIV attribute is set to "));
    Write ( Message, QPLL1_REFCLK_DIV);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("2, "));
    Write ( Message, string'("1, "));
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
    Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
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
    Write ( Message, string'("-218] SIM_RESET_SPEEDUP attribute is set to """));
    Write ( Message, string'(SIM_RESET_SPEEDUP));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""TRUE"" or "));
    Write ( Message, string'("""FALSE"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
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
    Write ( Message, string'("-219] SIM_VERSION attribute is set to "));
    Write ( Message, SIM_VERSION);
    Write ( Message, string'(". Legal values for this attribute are "));
    Write ( Message, string'("1.0 or "));
    Write ( Message, string'("2.0. "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    if  (attr_err) then
      Write ( Message, string'("[Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-172] Attribute Error(s) encountered. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(GTYE3_COMMON_V'INSTANCE_NAME));
      assert FALSE
      report Message.all
      severity error;
    end if;
    wait;
    end process INIPROC;

end GTYE3_COMMON_V;
