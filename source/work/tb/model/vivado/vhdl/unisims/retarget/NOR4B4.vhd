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
--  /   /                  4-input NOR Gate (Discontinue in 13.1)
-- /___/   /\     Filename : NOR4B4.vhd
-- \   \  /  \    Timestamp : Mon May 24 16:06:39 PDT 2010

--  \___\/\___\
--
-- Revision:
--    05/24/10 - Initial version.

----- CELL NOR4B4 -----

library IEEE;
use IEEE.STD_LOGIC_1164.all;

library unisim;
use unisim.VPKG.all;
use unisim.VCOMPONENTS.all;

entity NOR4B4 is
  port(
    O : out std_ulogic;

    I0 : in std_ulogic;
    I1 : in std_ulogic;
    I2 : in std_ulogic;
    I3 : in std_ulogic
    );
end NOR4B4;

architecture NOR4B4_V of NOR4B4 is
begin
    L4 : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      O  => O,
      I0 => I0,
      I1 => I1,
      I2 => I2,
      I3 => I3
);
end NOR4B4_V;