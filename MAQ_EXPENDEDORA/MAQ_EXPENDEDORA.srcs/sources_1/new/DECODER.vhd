----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:25:49
-- Design Name: 
-- Module Name: DECODER - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DECODER is
    generic(
        TAM_CODE: POSITIVE:= 5;
        NUM_SEGMENTOS: POSITIVE:= 7      
    );
    port(
        CODE : in std_logic_vector(TAM_CODE - 1 downto 0);
        SEGMENTOS : out std_logic_vector(NUM_SEGMENTOS - 1 downto 0)
    );
end entity DECODER;


architecture Behavioral of DECODER is
begin

with CODE select
    SEGMENTOS <= "0000001" when "00000",
    "1001111" when "00001",
    "0010010" when "00010",
    "0000110" when "00011",
    "1001100" when "00100",
    "0100100" when "00101",
    "0100000" when "00110",
    "0001111" when "00111",
    "0000000" when "01000",
    "0000100" when "01001",
    "0001000" when "10000", -- LETRA A
    "1000010" when "10001", -- LETRA D
    "0110000" when "10010", -- LETRA E
    "0111000" when "10011", -- LETRA F
    "1110001" when "10100", -- LETRA L
    "1100010" when "10101", -- LETRA O
    "0011000" when "10110", -- LETRA P
    "1111010" when "10111", -- LETRA R
    "1110000" when "11000", -- LETRA T
    "1100011" when "11001", -- LETRA U
    "1111110" when others;
end architecture Behavioral;
