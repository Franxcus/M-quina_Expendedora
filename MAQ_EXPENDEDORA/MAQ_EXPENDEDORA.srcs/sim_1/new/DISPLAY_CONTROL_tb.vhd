----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:28:41
-- Design Name: 
-- Module Name: DISPLAY_CONTROL_tb - Behavioral
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
USE ieee.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;


entity DISPLAY_CONTROL_tb is
end;

architecture bench of DISPLAY_CONTROL_tb is

  component DISPLAY_CONTROL
      generic(
          TAM_CUENTA: POSITIVE:= 5;
          NUM_REFRESCOS: POSITIVE:= 2;
          TAM_CODE: POSITIVE:= 5;
          NUM_ESTADOS: POSITIVE:= 4;
          NUM_DISPLAYS: POSITIVE:= 9
      );
      port(
          CUENTA : in STD_LOGIC_VECTOR (TAM_CUENTA - 1 downto 0);
          TIPO_REFRESCO: in STD_LOGIC_VECTOR (NUM_REFRESCOS - 1 downto 0);
          PRECIOS: in std_logic_vector(NUM_REFRESCOS * TAM_CUENTA - 1 downto 0);
          CLK : in STD_LOGIC;
          CODE : out STD_LOGIC_VECTOR (TAM_CODE * NUM_ESTADOS - 1 downto 0);
          CONTROL : out STD_LOGIC_VECTOR (NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0)
      );
  end component; 
  
  --Señales y constantes de testeo
  constant TAM_CUENTA: POSITIVE := 5;
  constant NUM_REFRESCOS: POSITIVE := 2;
  constant TAM_CODE: POSITIVE := 5;
  constant NUM_ESTADOS: POSITIVE := 4;
  constant NUM_DISPLAYS: POSITIVE := 9;
  signal CUENTA: STD_LOGIC_VECTOR (TAM_CUENTA - 1 downto 0);
  signal TIPO_REFRESCO: STD_LOGIC_VECTOR (NUM_REFRESCOS - 1 downto 0);
  signal PRECIOS: std_logic_vector(NUM_REFRESCOS * TAM_CUENTA - 1 downto 0);
  signal CLK: STD_LOGIC;
  signal CODE: STD_LOGIC_VECTOR (TAM_CODE * NUM_ESTADOS - 1 downto 0);
  signal CONTROL: STD_LOGIC_VECTOR (NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0) ;
  constant CLOCK_PERIOD: time := 10 ns;

begin

  UUT: DISPLAY_CONTROL 
    generic map( 
        TAM_CUENTA => TAM_CUENTA,
        NUM_REFRESCOS => NUM_REFRESCOS,
        TAM_CODE => TAM_CODE,
        NUM_ESTADOS => NUM_ESTADOS,
        NUM_DISPLAYS => NUM_DISPLAYS
        )
    port map( 
        CUENTA => CUENTA,
        TIPO_REFRESCO => TIPO_REFRESCO,
        PRECIOS => PRECIOS,
        CLK => CLK,
        CODE => CODE,
        CONTROL => CONTROL 
        );

  CLK_TREATMENT: process
  begin

  CLK <= '0';
  wait for 0.5 * CLOCK_PERIOD;

  CLK <= '1';
  wait for 0.5 * CLOCK_PERIOD;

  end process;

  stimulus: process
  begin
  
    PRECIOS <= "01101"&"01010"; --1.30euros para el REF 2 Y 1.00euro para el REF 1
    TIPO_REFRESCO <= "01"; --Empezamos con el REF 1
    CUENTA <= "00000";
    WAIT FOR CLOCK_PERIOD * 5;
    
    --Vamos incrementando la cuenta hasta llegar al precio
    CUENTA <= CUENTA + "00010";
    WAIT FOR CLOCK_PERIOD * 5;
    
    CUENTA <= CUENTA + "00100";
    WAIT FOR CLOCK_PERIOD * 5;
    
    CUENTA <= CUENTA + "00100";
    WAIT FOR CLOCK_PERIOD * 5;
    
    --Se prueba ahora con el REF 2
    TIPO_REFRESCO <= "10"; --REF 2
    CUENTA <= "00000";
    WAIT FOR CLOCK_PERIOD * 5;
    
    --Vamos incrementando la cuenta hasta llegar al precio
    CUENTA <= CUENTA + "00010";
    WAIT FOR CLOCK_PERIOD * 5;
    
    CUENTA <= CUENTA + "00100";
    WAIT FOR CLOCK_PERIOD * 5;
    
    CUENTA <= CUENTA + "00101";
    WAIT FOR CLOCK_PERIOD * 5;
    
    CUENTA <= CUENTA + "00010";
    WAIT FOR CLOCK_PERIOD * 5;
    
    assert false
    report "Success: simulation finished."
    severity failure;

    wait;
  end process;

end;
