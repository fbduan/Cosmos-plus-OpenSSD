-- $Header:  $
-------------------------------------------------------------------------------
-- Copyright (c) 1995/2004 Xilinx, Inc.
-- All Right Reserved.
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor : Xilinx
-- \   \   \/     Version : 12.1
--  \   \         Description : Xilinx Functional Simulation Library Component
--  /   /                  3-State Output Buffer with LVDS I/O Standard  (Discontinue in 13.1)
-- /___/   /\     Filename : OBUFT_LVDS.vhd
-- \   \  /  \    Timestamp : Fri Aug 13 11:15:45 PDT 2010

--  \___\/\___\
--
-- Revision:
--    08/13/10 - Initial version.

----- CELL OBUFT_LVDS-----
library IEEE;
use IEEE.STD_LOGIC_1164.all;


library unisim;
use unisim.VPKG.all;
use unisim.VCOMPONENTS.all;

entity OBUFT_LVDS is
  port(
    O : out std_ulogic;

    T : in std_ulogic;

    I : in std_ulogic
    );

end OBUFT_LVDS;

architecture OBUFT_LVDS_V of OBUFT_LVDS is
begin
    O1 : OBUFT
    generic map (
      IOSTANDARD => "LVDS"
      
      
    )
    port map (
      O  => O,
      T => T,
      I => I
);

end OBUFT_LVDS_V;