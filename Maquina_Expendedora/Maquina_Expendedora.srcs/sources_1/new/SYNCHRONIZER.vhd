----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2024 13:01:21
-- Design Name: 
-- Module Name: SYNCHRONIZER - Behavioral
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

entity SYNCHRONIZER is
    generic(
        N_REFRESCOS: positive;
        N_MONEDAS: positive
    );
    port(
        CLK: in std_logic;
        ASYNC_MONEDAS: in std_logic_vector(N_MONEDAS - 1 downto 0);
        ASYNC_PAGO: in std_logic;
        ASYNC_TIPO_REFRESCO: in std_logic_vector(N_REFRESCOS - 1 downto 0);
        SYNC_MONEDAS: out std_logic_vector(N_MONEDAS - 1 downto 0);
        SYNC_PAGO: out std_logic;
        SYNC_TIPO_REFRESCO: out std_logic_vector(N_REFRESCOS - 1 downto 0)
    );
end SYNCHRONIZER;

architecture Behavioral of SYNCHRONIZER is
    signal REG_1_MONEDAS: std_logic_vector(N_MONEDAS - 1 downto 0);
    signal REG_1_PAGO: std_logic;
    signal REG_1_TIPO_REFRESCO: std_logic_vector(N_REFRESCOS - 1 downto 0);
    signal REG_2_MONEDAS: std_logic_vector(N_MONEDAS - 1 downto 0);
    signal REG_2_PAGO: std_logic;
    signal REG_2_TIPO_REFRESCO: std_logic_vector(N_REFRESCOS - 1 downto 0);
begin
    REGISTRO_1: process(CLK)
    begin
        if rising_edge(CLK) then
            REG_1_MONEDAS <= ASYNC_MONEDAS;
            REG_1_PAGO <= ASYNC_PAGO;
            REG_1_TIPO_REFRESCO <= ASYNC_TIPO_REFRESCO;
        end if;            
    end process;
    
    REGISTRO_2: process(CLK)
    begin
        if rising_edge(CLK) then
            REG_2_MONEDAS <= REG_1_MONEDAS;
            REG_2_PAGO <= REG_1_PAGO;
            REG_2_TIPO_REFRESCO <= REG_1_TIPO_REFRESCO;
        end if;            
    end process;
    
    SYNC_MONEDAS <= REG_2_MONEDAS;
    SYNC_PAGO <= REG_2_PAGO;
    SYNC_TIPO_REFRESCO <= REG_2_TIPO_REFRESCO;
    
end Behavioral;
