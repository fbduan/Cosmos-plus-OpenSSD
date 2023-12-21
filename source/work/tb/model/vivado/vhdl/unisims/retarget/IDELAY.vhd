-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 12.1
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                    Input Delay Line
-- /___/   /\     Filename : IDELAY.vhd
-- \   \  /  \    Timestamp : Tue Oct 20 09:43:11 PST 2010
--  \___\/\___\
--
-- Revision:
--    10/20/10 - Initial version.
-- End Revision

----- CELL IDELAY -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;


library unisim;
use unisim.VPKG.all;
use unisim.VCOMPONENTS.all;



entity IDELAY is

  generic(

      IOBDELAY_TYPE  : string := "DEFAULT";
      IOBDELAY_VALUE : integer := 0
      );

  port(
      O      : out std_ulogic;

      C      : in  std_ulogic;
      CE     : in  std_ulogic;
      I      : in  std_ulogic;
      INC    : in  std_ulogic;
      RST    : in  std_ulogic
      );
end IDELAY;


architecture IDELAY_V of IDELAY is
signal Q0_G1, Q1_G1, Q0_G2, Q1_G2 : std_ulogic;
begin
     uut : IDELAYE2
     generic map (
	CINVCTRL_SEL => "FALSE",
	DELAY_SRC => "IDATAIN",
	HIGH_PERFORMANCE_MODE => "TRUE",
	IDELAY_TYPE => IOBDELAY_TYPE,
	IDELAY_VALUE => IOBDELAY_VALUE,
	PIPE_SEL => "FALSE",
	REFCLK_FREQUENCY => 200.0,
	SIGNAL_PATTERN => "DATA"
     )
      port map (   	
        CNTVALUEOUT => open, 
        DATAOUT => O,
        C => C, 
        CE => CE,
        CINVCTRL => '0',
        CNTVALUEIN => "00000",
        DATAIN => '0',
        IDATAIN => I,
        INC => INC,
        LD => '0',
        LDPIPEEN => '0',
        REGRST => RST
  );
end IDELAY_V;
