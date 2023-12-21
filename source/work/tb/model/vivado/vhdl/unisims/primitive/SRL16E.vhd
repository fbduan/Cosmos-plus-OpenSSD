-------------------------------------------------------------------------------
-- Copyright (c) 1995/2014 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor      : Xilinx
-- \   \   \/     Version     : 2014.3
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  16-Bit Shift Register Look-Up-Table with Clock Enable
-- /___/   /\     Filename    : SRL16E.vhd
-- \   \  /  \
--  \___\/\___\
--
-------------------------------------------------------------------------------
-- Revision:
--    03/23/04 - Initial version.
--    11/28/11 - Change bit attribute to std_logic (CR591750)
--    01/16/12 - 591750, 586884 - revert change severe IP impact.
--    04/16/13 - PR683925 - add invertible pin support.
--    04/22/13 - 714490 - infinite loop if CLK stays X or Z causes XSIM to run forever.
-- End Revision
-------------------------------------------------------------------------------

----- CELL SRL16E -----

library IEEE;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_1164.all;

library UNISIM;
use UNISIM.VPKG.all;
--use UNISIM.VCOMPONENTS.all;

entity SRL16E is

  generic (
    INIT : bit_vector := X"0000";
    IS_CLK_INVERTED : bit := '0'
  );

  port (
    Q   : out STD_ULOGIC;
    A0  : in STD_ULOGIC;
    A1  : in STD_ULOGIC;
    A2  : in STD_ULOGIC;
    A3  : in STD_ULOGIC;
    CE  : in STD_ULOGIC;
    CLK : in STD_ULOGIC;        
    D   : in STD_ULOGIC
  ); 
end SRL16E;

architecture SRL16E_V of SRL16E is

  constant MODULE_NAME : string := "SRL16E";

  signal IS_CLK_INVERTED_BIN : std_ulogic;

  signal A_in : std_logic_vector(3 downto 0);
--  signal CE_in : std_ulogic;
--  signal CLK_in : std_ulogic;
--  signal D_in : std_ulogic;

  signal Index : integer := 0;
  signal SHIFT_REG : std_logic_vector (16 downto 0) := ('X' & To_StdLogicVector(INIT));

begin
  A_in <= A3 & A2 & A1 & A0;
--  CE_in <= '1' when (CE = 'Z') else CE; -- rv 1
--  CLK_in <= CLK;
--  D_in <= D;

  Index <= TO_INTEGER(UNSIGNED(A_in)) when ADDR_IS_VALID(SLV => A_in) else 0;
  Q <= SHIFT_REG(Index);

  IS_CLK_INVERTED_BIN <= TO_X01(IS_CLK_INVERTED);

  WriteBehavior : process (CLK)
  begin
    if (CE = '1' or CE = 'Z') then
      if (CLK'event and xil_pos_edge_inv(CLK, IS_CLK_INVERTED_BIN)) then
        SHIFT_REG(15 downto 0) <= (SHIFT_REG(14 downto 0) & D) after 100 ps;
      end if;
    end if;
  end process WriteBehavior;
end SRL16E_V;
