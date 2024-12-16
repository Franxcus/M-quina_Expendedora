
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
        N_REFRESCOS: POSITIVE;
        N_MONEDAS: POSITIVE      
    );
    Port(
        CLK : in STD_LOGIC;
        AS_MONEDAS: in STD_LOGIC_VECTOR (N_MONEDAS - 1 downto 0); 
        AS_PAGAR: in STD_LOGIC;
        AS_TIPO_REFRESCO: in STD_LOGIC_VECTOR (N_REFRESCOS - 1 downto 0);
        S_MONEDAS: out STD_LOGIC_VECTOR (N_MONEDAS - 1 downto 0);
        S_PAGAR: out STD_LOGIC;
        S_TIPO_REFRESCO: out STD_LOGIC_VECTOR (N_REFRESCOS - 1 downto 0)
     );
end SYNCHRNZR;

architecture Behavioral of SYNCHRNZR is

    SIGNAL SREG_1_MONEDAS: STD_LOGIC_VECTOR(N_MONEDAS - 1 downto 0);
    SIGNAL SREG_1_PAGAR: STD_LOGIC;
    SIGNAL SREG_1_TIPO: STD_LOGIC_VECTOR (N_REFRESCOS - 1 downto 0);

    SIGNAL SREG_2_MONEDAS: STD_LOGIC_VECTOR(N_MONEDAS - 1 downto 0);
    SIGNAL SREG_2_PAGAR: STD_LOGIC;
    SIGNAL SREG_2_TIPO: STD_LOGIC_VECTOR (N_REFRESCOS - 1 downto 0);
    
begin

    registro_1:PROCESS(CLK)
    BEGIN
        IF rising_edge(CLK) then
            SREG_1_MONEDAS <= AS_MONEDAS;
            SREG_1_PAGAR <= AS_PAGAR;
            SREG_1_TIPO <= AS_TIPO_REFRESCO;
        END IF;
    END PROCESS;
    
    registro_2:PROCESS(CLK)
    BEGIN
        IF rising_edge(CLK) then
            SREG_2_MONEDAS <= SREG_1_MONEDAS;
            SREG_2_PAGAR <= SREG_1_PAGAR;
            SREG_2_TIPO <= SREG_1_TIPO;
        END IF;
    END PROCESS;
    
    S_MONEDAS <= SREG_2_MONEDAS;
    S_PAGAR <= SREG_2_PAGAR;
    S_TIPO_REFRESCO <= SREG_2_TIPO;
    
end Behavioral;
