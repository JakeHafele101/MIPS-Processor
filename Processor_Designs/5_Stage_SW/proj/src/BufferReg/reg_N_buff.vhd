-------------------------------------------------------------------------
-- Jake Hafele
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------
-- reg_N_buff.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of an N-bit wide 
-- register file using dffg.vhd for each bit 
--
--
-- 
-- Created 1/30/2023
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity reg_N_buff is
  generic (N : integer := 32); -- Generic of type integer for input/output data width. Default value is 32.
  port (
    i_CLK : in std_logic;                          -- Clock input
    i_RST : in std_logic;                          -- Reset input
    i_WE  : in std_logic;                          -- Write enable input
    i_D   : in std_logic_vector(N - 1 downto 0);   --N bit data value input
    o_Q   : out std_logic_vector(N - 1 downto 0)); -- N bit data value output
end reg_N_buff;

architecture structural of reg_N_buff is

  component dffg is
    port (
      i_CLK : in std_logic;   -- Clock input
      i_RST : in std_logic;   -- Reset input
      i_WE  : in std_logic;   -- Write enable input
      i_D   : in std_logic;   -- Data value input
      o_Q   : out std_logic); -- Data value output
  end component;

begin

  -- Instantiate N mux instances.
  G_NBit_Reg : for i in 0 to N - 1 generate
    DFFI : dffg port map(
      i_CLK => i_CLK,   -- All instances share the same clock input
      i_RST => i_RST,   -- All instances share the same reset input
      i_WE  => i_WE,    -- All instances share the same write enable input
      i_D   => i_D(i),  -- ith instance's data input hooked up to ith data input.
      o_Q   => o_Q(i)); -- ith instance's data output hooked up to ith data output.
  end generate G_NBit_Reg;

end structural;