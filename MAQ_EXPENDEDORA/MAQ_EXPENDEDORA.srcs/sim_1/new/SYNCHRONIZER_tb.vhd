----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:34:58
-- Design Name: 
-- Module Name: SYNCHRONIZER_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity SYNCHRONIZER_tb is
end SYNCHRONIZER_tb;

architecture Behavioral of SYNCHRONIZER_tb is
    --Declaracion del componente
    component SYNCHRONIZER
        generic(
            NUM_MONEDAS: positive:= 4;
            NUM_REFRESCOS: positive:= 2
        );
        port(
            CLK: in std_logic;
            AS_MONEDAS: in std_logic_vector (NUM_MONEDAS - 1 downto 0); 
            AS_PAGAR: in std_logic;
            AS_TIPO_REFRESCO: in std_logic_vector (NUM_REFRESCOS - 1 downto 0);
            S_MONEDAS: out std_logic_vector (NUM_MONEDAS - 1 downto 0);
            S_PAGAR: out std_logic;
            S_TIPO_REFRESCO: out std_logic_vector (NUM_REFRESCOS - 1 downto 0)
        );
    end component;
    
    --Señales y constantes de testeo
    constant NUM_MONEDAS: positive:= 4;
    constant NUM_REFRESCOS: positive:= 2;
    signal CLK: std_logic;
    signal AS_MONEDAS: std_logic_vector (NUM_MONEDAS - 1 downto 0); 
    signal AS_PAGAR: std_logic;
    signal AS_TIPO_REFRESCO: std_logic_vector (NUM_REFRESCOS - 1 downto 0);
    signal S_MONEDAS: std_logic_vector (NUM_MONEDAS - 1 downto 0);
    signal S_PAGAR: std_logic;
    signal S_TIPO_REFRESCO: std_logic_vector (NUM_REFRESCOS - 1 downto 0);
    constant CLOCK_PERIOD: time:= 10 ns;       
begin
    UUT: SYNCHRONIZER 
        generic map(  
            NUM_REFRESCOS => NUM_REFRESCOS,
            NUM_MONEDAS => NUM_MONEDAS
            )
        port map(  
            CLK => CLK,
            AS_MONEDAS => AS_MONEDAS,
            AS_PAGAR => AS_PAGAR,
            AS_TIPO_REFRESCO => AS_TIPO_REFRESCO,
            S_MONEDAS => S_MONEDAS,
            S_PAGAR => S_PAGAR,
            S_TIPO_REFRESCO => S_TIPO_REFRESCO
            );
            
    --Señal de reloj                                
    CLK_TREATMENT: process
    begin
        CLK <= '0';
        wait for 0.5 * CLOCK_PERIOD;
        
        CLK <= '1';
        wait for 0.5 * CLOCK_PERIOD;
    end process;
            
    --Testeo Synchronizer                       
    STIMULUS: process
    begin
        AS_MONEDAS <= "0000";
        AS_PAGAR <= '0';
        AS_TIPO_REFRESCO <= "00";
        wait for CLOCK_PERIOD * 1.25;
        
        AS_MONEDAS <= "0100";
        AS_PAGAR <= '1';
        AS_TIPO_REFRESCO <= "10";
        wait for CLOCK_PERIOD * 1.25;
        
        --Mensajes en caso de error
        assert S_MONEDAS = "0100"
            report "S_MONEDAS should be '0100'";
        assert S_PAGO = '1'
            report "S_PAGO should be '1'";
        assert S_TIPO_REFRESCO = "10";
            report "S_TIPO_REFRESCO should be '10'";
            
        AS_MONEDAS <= "0001";
        AS_PAGAR <= '0';
        AS_TIPO_REFRESCO <= "01";
        wait for CLOCK_PERIOD * 2.25;
        
        --Mensajes en caso de error    
        assert S_MONEDAS = "0001"
            report "S_MONEDAS should be '0001'";
        assert S_PAGO = '0'
            report "S_PAGO should be '0'";
        assert S_TIPO_REFRESCO = "01";
            report "S_TIPO_REFRESCO should be '01'";
            
        assert false
            report "SUCCCES: Simulation finished"
            severity failure;
        
    end process;
end Behavioral;
