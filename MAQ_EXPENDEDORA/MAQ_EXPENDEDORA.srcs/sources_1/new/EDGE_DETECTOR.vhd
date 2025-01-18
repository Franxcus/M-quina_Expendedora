----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:29:47
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

entity EDGE_DETECTOR is
    Generic(
        NUM_MONEDAS: positive:= 4      
    );
    Port(
        CLK: in std_logic;
        MONEDAS_IN: in std_logic_vector(NUM_MONEDAS - 1 downto 0); --  Entrada monedas 
        EDGE_MONEDAS: out std_logic_vector(NUM_MONEDAS - 1 downto 0) -- Salida de detecci?n de flanco.
    );
end EDGE_DETECTOR;

architecture Behavioral of EDGE_DETECTOR is
    --Señal de registro
    signal MONEDAS_ANTERIORES: std_logic_vector(NUM_MONEDAS - 1 downto 0) := (others => '0');
begin
    process(CLK)
    begin
        if rising_edge (CLK) then
          if MONEDAS_IN /= MONEDAS_ANTERIORES then
              EDGE_MONEDAS <= MONEDAS_IN;
          else
              EDGE_MONEDAS <= (others => '0');
          end if;
          MONEDAS_ANTERIORES <= MONEDAS_IN;
        end if;
    end process;
end Behavioral;

