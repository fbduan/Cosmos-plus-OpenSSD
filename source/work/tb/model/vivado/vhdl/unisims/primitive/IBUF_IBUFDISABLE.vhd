-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 11.1
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  Input Buffer
-- /___/   /\     Filename : IBUF_IBUFDISABLE.vhd
-- \   \  /  \    Timestamp : Wed Dec  8 17:04:24 PST 2010
--  \___\/\___\
--
-- Revision:
--    12/08/10 - Initial version.
--    04/04/11 - CR 604808 fix
--    06/15/11 - CR 613347 -- made ouput logic_1 when IBUFDISABLE is active
--    08/31/11 - CR 623170 -- added attribute USE_IBUFDISABLE
--    09/13/11 - CR 624774 -- Removed attributes IBUF_DELAY_VALUE and IFD_DELAY_VALUE
--    09/16/11 - CR 625725 -- Removed attribute CAPACITANCE
-- End Revision

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity IBUF_IBUFDISABLE is
  generic(
    IBUF_LOW_PWR : string :=  "TRUE";
    IOSTANDARD  : string := "DEFAULT";
    SIM_DEVICE : string := "7SERIES";
    USE_IBUFDISABLE : string :=  "TRUE"
    );

  port(
    O : out std_ulogic;

    I : in std_ulogic;
    IBUFDISABLE : in std_ulogic
    );

end IBUF_IBUFDISABLE;

architecture IBUF_IBUFDISABLE_V of IBUF_IBUFDISABLE is
 signal out_val : std_ulogic := '1';

begin

  prcs_init : process
  variable FIRST_TIME        : boolean    := TRUE;
  begin
     
     If(FIRST_TIME = true) then

        if((IBUF_LOW_PWR = "TRUE") or
           (IBUF_LOW_PWR = "FALSE")) then
           FIRST_TIME := false;
        else
           assert false
           report "Attribute Syntax Error: The Legal values for IBUF_LOW_PWR are TRUE or FALSE"
           severity Failure;
        end if;

--
        if((USE_IBUFDISABLE = "TRUE") or
           (USE_IBUFDISABLE = "FALSE")) then
           FIRST_TIME := false;
        else
           assert false
           report "Attribute Syntax Error: The Legal values for USE_IBUFDISABLE are TRUE or FALSE"
           severity Failure;
        end if;

--  
       if((SIM_DEVICE = "7SERIES") or (SIM_DEVICE = "7series")) then
         FIRST_TIME := false;
        elsif((SIM_DEVICE = "ULTRASCALE") or (SIM_DEVICE = "ultrascale")) then
         FIRST_TIME := false;
        else
          assert FALSE report "Attribute Syntax Error : The Legal values for SIM_DEVICE are 7SERIES or ULTRASCALE." severity Failure;
        end if;

     end if;
     wait; 
  end process prcs_init;
  
  out_val <= '0' when (SIM_DEVICE = "ULTRASCALE") else
              '1' when (SIM_DEVICE = "7SERIES");


  O <=   TO_X01(I) when ((USE_IBUFDISABLE = "FALSE") OR ((USE_IBUFDISABLE = "TRUE") AND (IBUFDISABLE = '0'))) else
        out_val when ((USE_IBUFDISABLE = "TRUE") AND (IBUFDISABLE = '1'));



end IBUF_IBUFDISABLE_V;