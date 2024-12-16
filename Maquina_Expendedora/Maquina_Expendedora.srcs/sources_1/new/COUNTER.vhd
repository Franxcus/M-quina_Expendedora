----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2024 19:25:02
-- Design Name: 
-- Module Name: COUNTER - Behavioral
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

entity COUNTER is
    Port ( CE : in STD_LOGIC;
           CLK : in STD_LOGIC;
           MONEDAS : in STD_LOGIC_VECTOR (3 downto 0);
           RESET : in STD_LOGIC;
           TIPO_REFRESCO : in STD_LOGIC_VECTOR (1 downto 0);
           CUENTA : out STD_LOGIC_VECTOR (4 downto 0);
           ERROR : out STD_LOGIC;
           PAGO_OK : out STD_LOGIC;
           PRECIOS : out STD_LOGIC_VECTOR (9 downto 0);
           REFRESCO_ACTUAL : out STD_LOGIC_VECTOR (1 downto 0));
end COUNTER;

architecture Behavioral of COUNTER is

begin


end Behavioral;
