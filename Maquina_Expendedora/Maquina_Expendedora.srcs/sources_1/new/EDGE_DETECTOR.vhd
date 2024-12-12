----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.12.2024 16:09:51
-- Design Name: 
-- Module Name: EDGE_DETECTOR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity EDGE_DETECTOR is
    Port ( CLK : in STD_LOGIC;
           SYNC_IN : in STD_LOGIC;
           EDGE : out STD_LOGIC);
end EDGE_DETECTOR;

architecture BEHAVIORAL of EDGE_DETECTOR is
 signal sreg : std_logic_vector(2 downto 0);
begin
 process (CLK)
 begin
 if rising_edge(CLK) then
 sreg <= sreg(1 downto 0) & SYNC_IN;
 end if;
 end process;
 with sreg select
 EDGE <= '1' when "100",
 '0' when others;
end BEHAVIORAL;
