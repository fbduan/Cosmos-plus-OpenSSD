-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                 5-input Dynamically Reconfigurable Look-Up-Table with Carry and Clock Enable 
-- /___/   /\     Filename : CFGLUT5.vhd
-- \   \  /  \    Timestamp : 
--  \___\/\___\
--
-- Revision:
--    12/28/05 - Initial version.
--    04/13/06 - Add address declaration. (CR229735)
--    05/13/13 - Add IS_CLK_INVERTED
-- End Revision

----- CELL CFGLUT5 -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

library UNISIM;
use UNISIM.VPKG.all;

entity CFGLUT5 is

  generic (
       INIT : bit_vector := X"00000000";
       IS_CLK_INVERTED : bit := '0'
  );

  port (
        CDO : out STD_ULOGIC;
        O5  : out STD_ULOGIC;
        O6  : out STD_ULOGIC;

        CDI : in STD_ULOGIC;
        CE  : in STD_ULOGIC;
        CLK : in STD_ULOGIC;        
        I0  : in STD_ULOGIC;
        I1  : in STD_ULOGIC;
        I2  : in STD_ULOGIC;
        I3  : in STD_ULOGIC;
        I4  : in STD_ULOGIC
       ); 
end CFGLUT5;

architecture CFGLUT5_V of CFGLUT5 is
  signal SHIFT_REG : std_logic_vector (31 downto 0) :=  To_StdLogicVector(INIT)(31 downto 0);
  signal CLK_in : std_ulogic;
  signal CDI_in : std_ulogic;
  signal CE_in  : std_ulogic;
  signal IS_CLK_INVERTED_BIN : std_ulogic;

  signal o6_slv : std_logic_vector (4 downto 0) ;
  signal o5_slv : std_logic_vector (3 downto 0) ;
  signal o6_addr : integer := 0;
  signal o5_addr : integer := 0;
begin

    o6_slv <= I4 & I3 & I2 & I1 & I0;
    o5_slv <= I3 & I2 & I1 & I0;

    o6_addr <= TO_INTEGER(UNSIGNED(o6_slv)) when ADDR_IS_VALID(SLV => o6_slv) else 0;
    o5_addr <= TO_INTEGER(UNSIGNED(o5_slv)) when ADDR_IS_VALID(SLV => o5_slv) else 0;
    O6 <= SHIFT_REG(o6_addr);
    O5 <= SHIFT_REG(o5_addr);
    CDO <= SHIFT_REG(31);
    CLK_in <= CLK xor IS_CLK_INVERTED_BIN;
    CE_in  <= CE;
    CDI_in <= CDI;
    IS_CLK_INVERTED_BIN <= TO_X01(IS_CLK_INVERTED);


  WriteBehavior : process
  begin
-- 714490 remove FIRST_TIME logic, replace with rising_edge
    if (rising_edge(CLK_in)) then
        if (CE_in = '1') then
           SHIFT_REG(31 downto 0) <= (SHIFT_REG(30 downto 0) & CDI_in) after 100 ps;
        end if ;
    end if;

    wait on CLK_in;

  end process WriteBehavior;

end CFGLUT5_V;


