-------------------------------------------------------------------------------
-- Copyright (c) 1995/2014 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /     Vendor      : Xilinx 
-- \   \   \/      Version     : 2014.2 
--  \   \          Description : Xilinx Functional Simulation Library Component
--  /   /                        Dedicated Dual Data Rate (DDR) Output Register
-- /___/   /\      Filename    : ODDRE1.vhd
-- \   \  /  \
--  \___\/\___\
--
-------------------------------------------------------------------------------
-- Revision
-- _revision_history_
-- End Revision
-------------------------------------------------------------------------------

----- CELL ODDRE1 -----

library IEEE;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_1164.all;

library STD;
use STD.TEXTIO.all;

library UNISIM;
use UNISIM.VPKG.all;
use UNISIM.VCOMPONENTS.all;

entity ODDRE1 is
  generic (
    IS_C_INVERTED : bit := '0';
    IS_D1_INVERTED : bit := '0';
    IS_D2_INVERTED : bit := '0';
    SRVAL : bit := '0'
  );

  port (
    Q                    : out std_ulogic;
    C                    : in std_ulogic;
    D1                   : in std_ulogic;
    D2                   : in std_ulogic;
    SR                   : in std_ulogic    
  );
end ODDRE1;

architecture ODDRE1_V of ODDRE1 is
  
  constant MODULE_NAME : string := "ODDRE1";
  constant IN_DELAY : time := 0 ps;
  constant OUT_DELAY : time := 0 ps;
  constant INCLK_DELAY : time := 0 ps;
  constant OUTCLK_DELAY : time := 100 ps;

-- Parameter encodings and registers

  signal IS_C_INVERTED_BIN : std_ulogic;
  signal IS_D1_INVERTED_BIN : std_ulogic;
  signal IS_D2_INVERTED_BIN : std_ulogic;
  signal SRVAL_BIN : std_ulogic;

  signal glblGSR       : std_ulogic;
  signal xil_attr_test : boolean := false;
  
  -- internal signal declarations
  -- _out used in behavioral logic, can take an init value
  -- continuous assignment to out pin may effect simulation speed

  signal Q_out : std_ulogic;
  
  -- _in optional if no pins have a required value
  -- continuous assignment to _in clocks effect simulation speed
  signal C_in : std_ulogic;
  signal D1_in : std_ulogic;
  signal D2_in : std_ulogic;
  signal SR_in : std_ulogic;
  signal QD2_posedge_int : std_ulogic;
  signal      R_sync1        : std_ulogic := '0'; 
  signal      R_sync2        : std_ulogic := '0'; 
  signal      R_sync3        : std_ulogic := '0'; 
 
  -- start behavioral body
  -- common declarations first, INIT PROC, then functional
  begin
  glblGSR     <= TO_X01(GSR);
  Q <= Q_out after OUT_DELAY;
  
  C_in <= C xor IS_C_INVERTED_BIN;
  D1_in <= D1 xor IS_D1_INVERTED_BIN;
  D2_in <= D2 xor IS_D2_INVERTED_BIN;
  SR_in <= SR;
  
  IS_C_INVERTED_BIN <= TO_X01(IS_C_INVERTED);
  IS_D1_INVERTED_BIN <= TO_X01(IS_D1_INVERTED);
  IS_D2_INVERTED_BIN <= TO_X01(IS_D2_INVERTED);
  SRVAL_BIN <= TO_X01(SRVAL);
 
  prcs_R_sync: process(C_in)
  begin
	  if(rising_edge(C_in)) then
		  R_sync1 <= SR_in;
		  R_sync2 <= R_sync1;
		  R_sync3 <= R_sync2;
	  end if;
  end process prcs_R_sync;
  
  PRCS_C : process(C_in,glblGSR,SR_in)
  begin
    if(glblGSR = '1') then
       Q_out <= TO_X01(SRVAL);
       QD2_posedge_int <= TO_X01(SRVAL);
    elsif(glblGSR = '0') then
      if (SR_in = '1' or R_sync1 = '1' or R_sync2 = '1' or R_sync3 = '1') then
        Q_out <= TO_X01(SRVAL);
	QD2_posedge_int <= TO_X01(SRVAL);
      elsif (R_sync3 = '0' or R_sync3 = 'L' or R_sync3 = 'U') then
        if(rising_edge(C_in)) then
	  Q_out <= D1_in;
	  QD2_posedge_int <= D2_in;
	end if;
	if (falling_edge(C_in)) then
	  Q_out <= QD2_posedge_int;
	end if;
      end if;	
    end if;
  
  end process PRCS_C;
 
    -- end behavioral body
  end ODDRE1_V;
