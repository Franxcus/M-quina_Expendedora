----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:34:02
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SYNCHRONIZER is
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
end SYNCHRONIZER;

architecture Behavioral of SYNCHRONIZER is
    --Señales de registro
    signal REG_1_MONEDAS: std_logic_vector(NUM_MONEDAS - 1 downto 0);
    signal REG_1_PAGAR: std_logic;
    signal REG_1_TIPO_REFRESCO: std_logic_vector (NUM_REFRESCOS - 1 downto 0);

    signal REG_2_MONEDAS: std_logic_vector(NUM_MONEDAS - 1 downto 0);
    signal REG_2_PAGAR: std_logic;
    signal REG_2_TIPO_REFRESCO: std_logic_vector (NUM_REFRESCOS - 1 downto 0);
    
begin

    REGISTRO_1:process(CLK)
    begin
        if rising_edge(CLK) then
            REG_1_MONEDAS <= AS_MONEDAS;
            REG_1_PAGAR <= AS_PAGAR;
            REG_1_TIPO_REFRESCO <= AS_TIPO_REFRESCO;
        end if;
    end process;
    
    REGISTRO_2:process(CLK)
    begin
        if rising_edge(CLK) then
            REG_2_MONEDAS <= REG_1_MONEDAS;
            REG_2_PAGAR <= REG_1_PAGAR;
            REG_2_TIPO_REFRESCO <= REG_1_TIPO_REFRESCO;
        end if;
    end process;
    --Salidas sincronizadas
    S_MONEDAS <= REG_2_MONEDAS;
    S_PAGAR <= REG_2_PAGAR;
    S_TIPO_REFRESCO <= REG_2_TIPO_REFRESCO;
    
end Behavioral;
