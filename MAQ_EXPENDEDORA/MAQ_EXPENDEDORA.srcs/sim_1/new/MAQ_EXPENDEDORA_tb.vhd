----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:57:57
-- Design Name: 
-- Module Name: MAQ_EXPENDEDORA_tb - Behavioral
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

entity TESTBENCH is
end;

architecture bench of TESTBENCH is

  component MAQ_EXPENDEDORA
    Generic(
        NUM_MONEDAS: positive;
        NUM_REFRESCOS: positive;
        NUM_ESTADOS: positive;
        NUM_SEGMENTOS: positive;
        NUM_DISPLAYS: positive; -- 8 mas el punto decimal
        TAM_CUENTA: positive;
        TAM_CODE: positive;
        PRESCALER_DIV: positive   
    );
    
    Port(
        CLK: in std_logic;
        RESET: in std_logic;
        PAGAR: in std_logic;
        MONEDAS: in std_logic_vector(NUM_MONEDAS - 1 downto 0);
        TIPO_REFRESCO: in std_logic_vector(NUM_REFRESCOS - 1 downto 0);
        ERROR: out std_logic;
        REFRESCO_OUT: out std_logic;
        ESTADOS: out std_logic_vector(NUM_ESTADOS - 1 downto 0);
        LED_AUX5: out std_logic;
        LED_RESET: out std_logic;
        SEGMENTOS: out std_logic_vector(NUM_SEGMENTOS - 1 downto 0);
        DIGCTRL: out std_logic_vector(NUM_DISPLAYS - 1 downto 0)
     );
  end component;

  signal CLK: std_logic;
  signal RESET: std_logic;
  signal PAGAR: std_logic;
  signal MONEDAS: std_logic_vector(3 downto 0);
  signal TIPO_REFRESCO: std_logic_vector(2 - 1 downto 0);
  signal ERROR: std_logic;
  signal REFRESCO_OUT: std_logic;
  signal ESTADOS: std_logic_vector(3 downto 0);
  signal LED_AUX5: std_logic;
  signal LED_RESET: std_logic;
  signal SEGMENTOS: std_logic_vector(6 downto 0);
  signal DIGCTRL: std_logic_vector(8 downto 0);

  
  constant clock_period: time := 10 ns;

begin

  uut: MAQ_EXPENDEDORA
      generic map( 
          NUM_MONEDAS => 4,
          NUM_ESTADOS => 4,
          NUM_REFRESCOS => 2,
          NUM_SEGMENTOS => 7,                          
          NUM_DISPLAYS => 9, 
          TAM_CUENTA => 5, 
          TAM_CODE => 5,
          PRESCALER_DIV => 1
      )  
                                                  
      port map(
          CLK => CLK,
          RESET => RESET,
          PAGAR => PAGAR,
          MONEDAS => MONEDAS,
          TIPO_REFRESCO => TIPO_REFRESCO,
          ERROR => ERROR,
          REFRESCO_OUT => REFRESCO_OUT,
          ESTADOS => ESTADOS,
          LED_AUX5 => LED_AUX5,
          LED_RESET => LED_RESET,
          SEGMENTOS => SEGMENTOS,
          DIGCTRL => DIGCTRL
          );         
                                        
   CLK_TREATMENT: process
   begin

   CLK <= '0';
   wait for 0.5 * clock_period;

   CLK <= '1';
   wait for 0.5 * clock_period;

   end process;

  stimulus: process
  begin
  
    -- Put initialisation code here
	RESET <= '0';
    wait for 5 ns;
    RESET <= '1';
    wait for 5 ns;
    
	PAGAR <= '1';
    TIPO_REFRESCO <= "01";
    wait for clock_period;
    
    MONEDAS <= "0010";
    wait for clock_period*2;
    MONEDAS <= "0100";
    wait for clock_period*2;
    MONEDAS <= "0010";
    wait for clock_period*2;
    MONEDAS <= "0001";
    wait for clock_period*2;
    MONEDAS <= "0100";
    wait for clock_period*2;
    PAGAR <= '0';
    
    wait for clock_period * 8;
    
    assert false
    report "Success: simulation finished."
    severity failure;

    wait;
  end process;
  
  end;