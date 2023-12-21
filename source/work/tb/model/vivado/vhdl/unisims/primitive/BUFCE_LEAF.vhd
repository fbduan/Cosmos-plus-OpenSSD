-------------------------------------------------------------------------------
-- Copyright (c) 1995/2014 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /     Vendor      : Xilinx
-- \   \   \/      Version     : 2014.3
--  \   \          Description : Xilinx Functional Simulation Library Component
--  /   /                        Clock Buffer 
-- /___/   /\      Filename    : BUFCE_LEAF.vhd
-- \   \  /  \
--  \__ \/\__ \
--
-------------------------------------------------------------------------------
--  Revision
--  05/15/12 - Initial version.
--  10/17/12 - 682802 - convert GSR H/L to 1/0
--  End Revision
-------------------------------------------------------------------------------

----- CELL BUFCE_LEAF -----

library IEEE;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_1164.all;

library STD;
use STD.TEXTIO.all;

library UNISIM;
use UNISIM.VPKG.all;
use UNISIM.VCOMPONENTS.all;

entity BUFCE_LEAF is
  generic (
    CE_TYPE : string := "SYNC";
    IS_CE_INVERTED : bit := '0';
    IS_I_INVERTED : bit := '0'
  );

  port (
    O                    : out std_ulogic;
    CE                   : in std_ulogic;
    I                    : in std_ulogic
  );
end BUFCE_LEAF;

architecture BUFCE_LEAF_V of BUFCE_LEAF is

  constant MODULE_NAME : string := "BUFCE_LEAF";
  constant IN_DELAY : time := 0 ps;
  constant OUT_DELAY : time := 0 ps;
  constant INCLK_DELAY : time := 0 ps;
  constant OUTCLK_DELAY : time := 100 ps;

-- Parameter encodings and registers
  constant CE_TYPE_ASYNC : std_ulogic := '1';
  constant CE_TYPE_SYNC : std_ulogic := '0';

  signal CE_TYPE_BIN : std_ulogic;
  signal IS_CE_INVERTED_BIN : std_ulogic;
  signal IS_I_INVERTED_BIN : std_ulogic;

  signal glblGSR       : std_ulogic;
  signal xil_attr_test : boolean := false;

  signal O_out : std_ulogic;
    
  signal CE_in : std_ulogic;
  signal I_in : std_ulogic;

  signal CE_TYPE_INV : std_ulogic;
  signal ice : std_ulogic := 'X';
  signal enable_clk : std_ulogic := '0';
  signal ce_inv : std_ulogic := 'X';


  begin
  glblGSR     <= TO_X01(GSR);
  O <= O_out after OUT_DELAY;
  
  CE_in <= '1' when (CE = 'Z') else CE xor IS_CE_INVERTED_BIN; -- rv 1
  I_in <= I xor IS_I_INVERTED_BIN;
  
  CE_TYPE_BIN <= 
    CE_TYPE_SYNC when (CE_TYPE = "SYNC") else
    CE_TYPE_ASYNC when (CE_TYPE = "ASYNC") else
    CE_TYPE_SYNC;

  IS_CE_INVERTED_BIN <= TO_X01(IS_CE_INVERTED);
  IS_I_INVERTED_BIN <= TO_X01(IS_I_INVERTED);

--####################################################################
--#####                     Initialize                           #####
--#################################################################### 

  INIPROC:process
  variable FIRST_TIME : boolean := true;
  variable Message : line;
  variable attr_err : boolean := false;

  begin
  if(FIRST_TIME) then
  FIRST_TIME := false;
  if((xil_attr_test) or
     ((CE_TYPE /= "SYNC") and 
      (CE_TYPE /= "ASYNC"))) then
    attr_err := true;
    Write ( Message, string'("Error : [Unisim "));
    Write ( Message, string'(MODULE_NAME));
    Write ( Message, string'("-101] CE_TYPE attribute is set to """));
    Write ( Message, string'(CE_TYPE));
    Write ( Message, string'(""". Legal values for this attribute are "));
    Write ( Message, string'("""SYNC"" or "));
    Write ( Message, string'("""ASYNC"". "));
    Write ( Message, string'("Instance "));
    Write ( Message, string'(BUFCE_LEAF_V'INSTANCE_NAME));
    writeline(output, Message);
    DEALLOCATE (Message);
  end if;
    if  (attr_err) then
      Write ( Message, string'("[Unisim "));
      Write ( Message, string'(MODULE_NAME));
      Write ( Message, string'("-104] Attribute Error(s) encountered. "));
      Write ( Message, string'("Instance "));
      Write ( Message, string'(BUFCE_LEAF_V'INSTANCE_NAME));
      assert FALSE
      report Message.all
      severity error;
    end if;
  end if;
  wait;
  end process INIPROC;

  CE_TYPE_INV <= not CE_TYPE_BIN;
  ce_inv <=  not CE_in;
  ice <= not (CE_TYPE_INV and I_in);

  prcs_1 : process(glblGSR, ice, ce_inv)
  begin
    if (glblGSR = '1') then
      enable_clk <= '1';
    elsif (ice = '1') then
      enable_clk <= not ce_inv;
  end if;  
  end process prcs_1;

  O_out <= enable_clk and I_in;

  end BUFCE_LEAF_V;
