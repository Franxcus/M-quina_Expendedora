----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:24:41
-- Design Name: 
-- Module Name: COUNTER_tb - Behavioral
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
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity COUNTER_tb is
end;

architecture Behavioral of COUNTER_TB is
    component COUNTER 
        generic(
            NUM_MONEDAS: positive:= 4;
            NUM_REFRESCOS: positive:= 2;
            TAM_CUENTA: positive:= 5      
        );
        port(
            CLK: in std_logic;
            CE: in std_logic;
            RESET: in std_logic;
            MONEDAS: in std_logic_vector(NUM_MONEDAS - 1 downto 0);
            TIPO_REFRESCO: in std_logic_vector(NUM_REFRESCOS - 1 downto 0);
            ERROR: out std_logic;
            PAGO_OK: out std_logic;
            CUENTA: out std_logic_vector(TAM_CUENTA - 1 downto 0);
            PRECIOS: out std_logic_vector(NUM_REFRESCOS * TAM_CUENTA - 1 downto 0);
            REFRESCO_ACTUAL: out std_logic_vector(NUM_REFRESCOS - 1 downto 0)
        );
    end component;

    --Señales y constantes de testeo
    constant NUM_MONEDAS: positive := 4;
    constant NUM_REFRESCOS: positive := 2;
    constant TAM_CUENTA: positive := 5; 
    signal CLK: std_logic;
    signal CE: std_logic;
    signal RESET: std_logic;
    signal MONEDAS: std_logic_vector(NUM_MONEDAS - 1 downto 0);
    signal TIPO_REFRESCO: std_logic_vector(NUM_REFRESCOS - 1 downto 0);
    signal REFRESCO_ACTUAL: std_logic_vector(NUM_REFRESCOS - 1 downto 0);
    signal ERROR: std_logic;
    signal PAGO_OK: std_logic;
    signal CUENTA: std_logic_vector(TAM_CUENTA - 1 downto 0);
    signal PRECIOS: std_logic_vector(NUM_REFRESCOS * TAM_CUENTA - 1 downto 0);
    constant CLOCK_PERIOD: time := 10 ns;
begin
    UUT: COUNTER 
        generic map(
            NUM_MONEDAS => NUM_MONEDAS,
            NUM_REFRESCOS => NUM_REFRESCOS,
            TAM_CUENTA => TAM_CUENTA
        )
        port map( 
            CLK => CLK,
            CE => CE,
            RESET => RESET,
            MONEDAS => MONEDAS,
            TIPO_REFRESCO => TIPO_REFRESCO,
            ERROR => ERROR,
            PAGO_OK => PAGO_OK,
            CUENTA => CUENTA,
            PRECIOS => PRECIOS,
            REFRESCO_ACTUAL => REFRESCO_ACTUAL
        );

    --Señal de reloj                             
    CLK_PROCESS: process
    begin
        CLK <= '0';
        wait for 0.5 * CLOCK_PERIOD;
        
        CLK <= '1';
        wait for 0.5 * CLOCK_PERIOD;
    end process;
    
    --Testeo Counter
    STIMULUS: process
    begin
        RESET <= '0';
        TIPO_REFRESCO <= "01";
        CE <= '1';
        wait for 0.5 * CLOCK_PERIOD;
        RESET <= '1';
        
        wait for 1.5 * CLOCK_PERIOD;
        RESET <= '0'; 
        MONEDAS <= "0001"; --10cents
        wait for CLOCK_PERIOD;
        MONEDAS <= "0010"; --10cents + 20cents = 30cents
        wait for CLOCK_PERIOD;
        MONEDAS <= "0100"; -- 30cents + 50cents = 80cents
        wait for CLOCK_PERIOD;   
        MONEDAS <= "0010"; -- 80cents + 20cents = 1euro
        wait for CLOCK_PERIOD; 
        MONEDAS <= "0000"; --No se introducen mas monedas
        wait for 2 * CLOCK_PERIOD; 
      
        RESET <= '1';
        wait for CLOCK_PERIOD;
        TIPO_REFRESCO <= "10";
        wait for CLOCK_PERIOD;
        RESET <= '0';
        wait for 2 * CLOCK_PERIOD;
        
      
        MONEDAS <= "0100"; --50cents
        wait for CLOCK_PERIOD;
        MONEDAS <= "0010"; --50cents + 20cents = 70cents
        wait for CLOCK_PERIOD;  
            
        TIPO_REFRESCO <= "01"; 
        --Aunque se cambie de refresco se siguen contando monedas para el refresco primeramente seleccionado
      
        MONEDAS <= "0100"; --70cents + 50cents = 1.20euros
        wait for CLOCK_PERIOD;   
        MONEDAS <= "0001"; --1.20euros + 10cents = 1.30euros
        wait for CLOCK_PERIOD; 
        MONEDAS <= "0000"; --No se introducen mas monedas 
        wait for 2 * CLOCK_PERIOD;
         
        assert false
        report "Success: simulation finished."
        severity failure;

        wait;
    end process;
end Behavioral;

