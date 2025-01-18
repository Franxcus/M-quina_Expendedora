----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:31:49
-- Design Name: 
-- Module Name: PRESCALER - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PRESCALER is
    generic(
        PRESCALER_DIV: positive:= 2     
    );
    port(
        CLK : in std_logic;
        CLK_OUT : out std_logic
    );
end PRESCALER;

architecture Behavioral of PRESCALER is
    signal CLK_BUFFER: std_logic_vector(PRESCALER_DIV - 1 downto 0):= (others => '0');
begin
    process (CLK)
    begin
        if rising_edge (CLK) then
            if CLK_BUFFER(CLK_BUFFER'length - 1) = '1' then
                CLK_BUFFER <= (others => '0');
            else
                CLK_BUFFER <= CLK_BUFFER + 1;
            end if;
        end if;
    end process;
    --Señal de reloj con frecuencia reducida
    CLK_OUT <= CLK_BUFFER(CLK_BUFFER'length - 1);

end Behavioral;
