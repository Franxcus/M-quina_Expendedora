----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:30:37
-- Design Name: 
-- Module Name: EDGE_DETECTOR_tb - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity EDGE_DETECTOR_tb is
end;

architecture Behavioral of EDGE_DETECTOR_tb is
    --Declaración del componente
    component EDGE_DETECTOR
        generic(
            NUM_MONEDAS: positive:= 4     
        );
        port(
            CLK: in std_logic;
            MONEDAS_IN: in std_logic_vector(NUM_MONEDAS - 1 downto 0);
            EDGE_MONEDAS: out std_logic_vector(NUM_MONEDAS - 1 downto 0)
        );
    end component;
  
    --Señales y constantes de testeo
    constant NUM_MONEDAS: positive:= 4;
    signal CLK: std_logic;
    signal MONEDAS_IN: std_logic_vector(NUM_MONEDAS - 1 downto 0);
    signal EDGE_MONEDAS: std_logic_vector(NUM_MONEDAS - 1 downto 0) ;
    constant CLOCK_PERIOD: time := 10 ns;
begin
    UUT: EDGE_DETECTOR 
        generic map ( 
            NUM_MONEDAS => NUM_MONEDAS 
        )
        port map ( 
            CLK => CLK,
            MONEDAS_IN => MONEDAS_IN,
            EDGE_MONEDAS => EDGE_MONEDAS 
        );
        
    --Señal de reloj                           
    CLK_TREATMENT: process
    begin
        CLK <= '0';
        wait for 0.5 * CLOCK_PERIOD;

        CLK <= '1';
        wait for 0.5 * CLOCK_PERIOD;
    end process;

    --Testbench Edge_Detector
    STIMULUS: process
    begin
  
  	MONEDAS_IN <= "0000";
    wait for CLOCK_PERIOD * 1;
    
	MONEDAS_IN <= "0010";
    wait for CLOCK_PERIOD * 1;
    
    MONEDAS_IN <= "0100";
    wait for CLOCK_PERIOD * 1;
    
    MONEDAS_IN <= "1000";
    wait for CLOCK_PERIOD * 1;

    assert false
        report "Success: simulation finished."
        severity failure;

    wait;
  end process;

end;
