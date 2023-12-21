-------------------------------------------------------------------------------
-- Copyright (c) 1995/2014 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor      : Xilinx
-- \   \   \/     Version     : 2014.3
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  32-Bit Shift Register Look-Up-Table with Carry and Clock Enable
-- /___/   /\     Filename    : SRLC32E.vhd
-- \   \  /  \
--  \___\/\___\
--
-------------------------------------------------------------------------------
-- Revision:
--    03/15/04 - Initial version.
--    04/22/05 - Change input A type from ulogic vector to logic vector.
--    11/28/11 - Change bit attribute to std_logic (CR591750)
--    01/16/12 - 591750, 586884 - revert change severe IP impact.
--    04/16/13 - PR683925 - add invertible pin support.
--    04/22/13 - 714426 - A_in <= A connection missing.
--    04/22/13 - 714490 - infinite loop if CLK stays X or Z causes XSIM to run forever.
-- End Revision
-------------------------------------------------------------------------------

----- CELL SRLC32E -----

library IEEE;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_1164.all;

library UNISIM;
use UNISIM.VPKG.all;
--use UNISIM.VCOMPONENTS.all;

entity SRLC32E is

  generic (
    INIT : bit_vector := X"00000000";
    IS_CLK_INVERTED : bit := '0'
  );

  port (
    Q   : out STD_ULOGIC;
    Q31 : out STD_ULOGIC;
    A   : in STD_LOGIC_VECTOR (4 downto 0) := "00000";
    CE  : in STD_ULOGIC;
    CLK : in STD_ULOGIC;        
    D   : in STD_ULOGIC
  ); 
end SRLC32E;

architecture SRLC32E_V of SRLC32E is

  constant MODULE_NAME : string := "SRLC32E";

  signal IS_CLK_INVERTED_BIN : std_ulogic;

  signal A_in : std_logic_vector(4 downto 0);
--  signal CE_in : std_ulogic;
--  signal CLK_in : std_ulogic;
--  signal D_in : std_ulogic;

  signal Index : integer := 0;
  signal SHIFT_REG : std_logic_vector (31 downto 0) := To_StdLogicVector(INIT);

begin
  A_in <= A;
--  CE_in <= '1' when (CE = 'Z') else CE; -- rv 1
--  CLK_in <= CLK;
--  D_in <= D;

  Index <= TO_INTEGER(UNSIGNED(A_in)) when ADDR_IS_VALID(SLV => A_in) else 0;
  Q <= SHIFT_REG(Index);
  Q31 <= SHIFT_REG(31);

  IS_CLK_INVERTED_BIN <= TO_X01(IS_CLK_INVERTED);

  WriteBehavior : process (CLK)
  begin
    if (CE = '1' or CE = 'Z') then
      if (CLK'event and xil_pos_edge_inv(CLK, IS_CLK_INVERTED_BIN)) then
        SHIFT_REG(31 downto 0) <= (SHIFT_REG(30 downto 0) & D) after 100 ps;
      end if;
    end if;
  end process WriteBehavior;
end SRLC32E_V;
