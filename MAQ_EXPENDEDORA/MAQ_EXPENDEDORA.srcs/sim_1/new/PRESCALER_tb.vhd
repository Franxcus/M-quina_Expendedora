----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:32:40
-- Design Name: 
-- Module Name: PRESCALER_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity PRESCALER_tb is
end;

architecture Behavioral of PRESCALER_tb is
    --Declaracion del componente
    component PRESCALER
        generic(
            PRESCALER_DIV: POSITIVE:= 2      
        );
        port(
            CLK : in STD_LOGIC;
            CLK_OUT : out STD_LOGIC
        );
    end component;
    
    --Señales y constantes de testeo
    constant PRESCALER_DIV: positive:= 2;
    signal CLK: STD_LOGIC;
    signal CLK_OUT: STD_LOGIC ;
    constant CLOCK_PERIOD: time := 10 ns;
begin
    UUT: PRESCALER 
        generic map( 
            PRESCALER_DIV => PRESCALER_DIV
            )
        port map( 
            CLK => CLK,
            CLK_OUT => CLK_OUT 
            );
            
    --Señal de reloj                             
    CLK_TREATMENT: process
    begin
        CLK <= '0';
        wait for 0.5 * CLOCK_PERIOD;

        CLK <= '1';
        wait for 0.5 * CLOCK_PERIOD;
    end process;
    
    --Testeo Prescaler
    STIMULUS: process
    begin
        wait for CLOCK_PERIOD * 10;

        assert false
        report "Success: simulation finished."
        severity failure;
    
        wait;
    end process;
  
end Behavioral;
