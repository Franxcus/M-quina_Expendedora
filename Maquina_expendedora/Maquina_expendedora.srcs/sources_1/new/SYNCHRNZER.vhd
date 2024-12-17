
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2023 15:20:43
-- Design Name: 
-- Module Name: SYNCHRNZR - Behavioral
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

entity SYNCHRNZR is
    Generic(
        NUM_TIPO_REFRESCOS: POSITIVE;
        NUM_MONEDAS: POSITIVE      
    );
    Port(
        CLK : in STD_LOGIC;
        AS_MONEDAS: in STD_LOGIC_VECTOR (NUM_MONEDAS - 1 downto 0); 
        AS_PAGAR: in STD_LOGIC;
        AS_TIPO_REFRESCO: in STD_LOGIC_VECTOR (NUM_TIPO_REFRESCOS - 1 downto 0);
        S_MONEDAS: out STD_LOGIC_VECTOR (NUM_MONEDAS - 1 downto 0);
        S_PAGAR: out STD_LOGIC;
        S_TIPO_REFRESCO: out STD_LOGIC_VECTOR (NUM_TIPO_REFRESCOS - 1 downto 0)
     );
end SYNCHRNZR;

architecture Behavioral of SYNCHRNZR is

    SIGNAL REG_1_MONEDAS: STD_LOGIC_VECTOR(NUM_MONEDAS - 1 downto 0);
    SIGNAL REG_1_PAGAR: STD_LOGIC;
    SIGNAL REG_1_TIPO: STD_LOGIC_VECTOR (NUM_TIPO_REFRESCOS - 1 downto 0);

    SIGNAL REG_2_MONEDAS: STD_LOGIC_VECTOR(NUM_MONEDAS - 1 downto 0);
    SIGNAL REG_2_PAGAR: STD_LOGIC;
    SIGNAL REG_2_TIPO: STD_LOGIC_VECTOR (NUM_TIPO_REFRESCOS - 1 downto 0);
    
begin

    registro_1:PROCESS(CLK)
    BEGIN
        IF rising_edge(CLK) then
            REG_1_MONEDAS <= AS_MONEDAS;
            REG_1_PAGAR <= AS_PAGAR;
            REG_1_TIPO <= AS_TIPO_REFRESCO;
        END IF;
    END PROCESS;
    
    registro_2:PROCESS(CLK)
    BEGIN
        IF rising_edge(CLK) then
            REG_2_MONEDAS <= REG_1_MONEDAS;
            REG_2_PAGAR <= REG_1_PAGAR;
            REG_2_TIPO <= REG_1_TIPO;
        END IF;
    END PROCESS;
    
    S_MONEDAS <= REG_2_MONEDAS;
    S_PAGAR <= REG_2_PAGAR;
    S_TIPO_REFRESCO <= REG_2_TIPO;
    
end Behavioral;
