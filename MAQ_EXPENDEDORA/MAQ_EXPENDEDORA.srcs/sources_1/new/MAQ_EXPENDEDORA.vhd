----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:23:28
-- Design Name: 
-- Module Name: MAQ_EXPENDEDORA - Behavioral
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

entity MAQ_EXPENDEDORA is
    generic(
        NUM_MONEDAS: positive := 4;
        NUM_REFRESCOS: positive := 2;
        NUM_ESTADOS: positive := 4;
        NUM_SEGMENTOS: positive := 7;
        NUM_DISPLAYS: positive := 9; -- 8 Y EL PUNTO DECIMAL
        TAM_CUENTA: positive := 5;
        TAM_CODE: positive := 5; -- INCLUYE NUMEROS 0-9 Y ALGUNAS LETRAS   
        PRESCALER_DIV: positive := 18   
    );
    
    port(
        CLK: in std_logic;
        RESET: in std_logic;
        PAGAR: in std_logic;
        MONEDAS: in std_logic_vector(NUM_MONEDAS - 1 downto 0);
        TIPO_REFRESCO: in std_logic_vector (NUM_REFRESCOS - 1 downto 0);
        ERROR: out std_logic;
        REFRESCO_OUT: out std_logic;
        ESTADOS: out std_logic_vector(NUM_ESTADOS - 1 downto 0);
        SEGMENTOS: out std_logic_vector(NUM_SEGMENTOS - 1 downto 0);
        DIGCTRL: out std_logic_vector(NUM_DISPLAYS - 1 downto 0)
     );
     
end MAQ_EXPENDEDORA;

architecture Estructural of MAQ_EXPENDEDORA is

component SYNCHRONIZER is
    Generic(
        NUM_REFRESCOS: POSITIVE;
        NUM_MONEDAS: POSITIVE      
    );
    Port(
        CLK: in std_logic;
        AS_MONEDAS: in std_logic_vector(NUM_MONEDAS - 1 downto 0); 
        AS_PAGAR: in std_logic;
        AS_TIPO_REFRESCO: in std_logic_vector(NUM_REFRESCOS - 1 downto 0);
        S_MONEDAS: out std_logic_vector(NUM_MONEDAS - 1 downto 0);
        S_PAGAR: out std_logic;
        S_TIPO_REFRESCO: out std_logic_vector(NUM_REFRESCOS - 1 downto 0)
     );
end component;

component EDGE_DETECTOR is
    Generic(
        NUM_MONEDAS: positive      
    );
    Port(
        CLK: in std_logic;
        MONEDAS_IN: in std_logic_vector(NUM_MONEDAS - 1 downto 0); -- 6 bits de se?ales de entrada.
        EDGE_MONEDAS: out std_logic_vector(NUM_MONEDAS - 1 downto 0) -- Salida de detecci?n de flanco.
    );
end component;

component COUNTER is
    Generic(
        NUM_MONEDAS: positive;
        NUM_REFRESCOS: positive;
        TAM_CUENTA: positive      
    );
    Port(
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

component FSM is
    Generic(
        NUM_REFRESCOS: positive;
        NUM_ESTADOS: positive;
        NUM_DISPLAYS: positive;
        TAM_CODE: positive           
    );
    Port( 
        CLK: in std_logic;
        PAGAR: in std_logic;
        PAGO_OK: in std_logic;
        TIPO_REFRESCO: in std_logic_vector(NUM_REFRESCOS - 1 downto 0);
        ERROR_COUNTER: in std_logic;
        CONTROL_IN: in std_logic_vector(NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0);
        CODE_IN:in std_logic_vector(TAM_CODE * NUM_ESTADOS - 1 downto 0);
        RESET: in std_logic;
        ERROR: out std_logic;
        REFRESCO_OUT: out std_logic;
        ESTADOS_OUT: out std_logic_vector(NUM_ESTADOS - 1 downto 0);
        CONTROL_OUT: out std_logic_vector(NUM_DISPLAYS - 1 downto 0);
        CODE_OUT: out std_logic_vector(TAM_CODE - 1 downto 0)
    );
end component;

component DISPLAY_CONTROL is
    Generic(
        TAM_CUENTA: positive;
        NUM_REFRESCOS: positive;
        TAM_CODE: positive;
        NUM_ESTADOS: positive;
        NUM_DISPLAYS: positive
    );
    Port(
        CUENTA: in std_logic_vector(TAM_CUENTA - 1 downto 0);
        TIPO_REFRESCO: in std_logic_vector(NUM_REFRESCOS - 1 downto 0);
        PRECIOS: in std_logic_vector(NUM_REFRESCOS * TAM_CUENTA - 1 downto 0);
        CLK: in std_logic;
        CODE: out std_logic_vector(TAM_CODE * NUM_ESTADOS - 1 downto 0);
        CONTROL: out std_logic_vector(NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0)
    );
end component;

component DECODER is
    Generic(
         TAM_CODE: positive;
         NUM_SEGMENTOS: positive      
    );
    Port(
        CODE: IN std_logic_vector(TAM_CODE - 1 DOWNTO 0);
        SEGMENTOS: OUT std_logic_vector(NUM_SEGMENTOS - 1 DOWNTO 0)
    );
end component;

component PRESCALER is
generic(
    PRESCALER_DIV: positive      
);
Port(
    CLK: in std_logic;
    CLK_OUT: out std_logic
);
end component;

signal AUX1: std_logic_vector(NUM_MONEDAS - 1 downto 0); --Conecta MONEDAS[] de SYNC con el EDGE_DETECTOR
signal AUX2: std_logic_vector(NUM_MONEDAS - 1 downto 0); --Conecta MONEDAS[] de EDGE_DET con el COUNTER
signal AUX3: std_logic; --Conecta PAGO_OK del COUNTER con la FSM
signal AUX4: std_logic; --Conec0ta ERROR del COUNTER con la FSM
signal AUX5: std_logic; --Conecta PAGAR del SYNC con el COUNTER y la FSM
signal AUX6: std_logic_vector(NUM_REFRESCOS - 1 downto 0); --Conecta TIPO_TEFRSCO del SYNC con el COUNTER
signal AUX7: std_logic_vector(TAM_CUENTA - 1 downto 0); --Conecta CUENTA del counter con CUENTA del DISPLAY_CONTROL
signal AUX8: std_logic_vector(TAM_CODE * NUM_ESTADOS - 1 downto 0); --Conecta CODE del DISPLAY_CTRL con CODE de la FSM
signal AUX9: std_logic_vector(NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0); --Conecta CONTROL del DISPLAY_CONTROL con CONTROL de la FSM
signal AUX10: std_logic_vector(NUM_REFRESCOS * TAM_CUENTA - 1 downto 0); --Conecta PRECIOS del contador con el DISPLAY_CONTROL
signal AUX11: std_logic_vector(TAM_CODE - 1 downto 0); --Conecta CODE_OUT de la FSM con code del DECODER 
signal AUX12: std_logic_vector(NUM_REFRESCOS - 1 downto 0); --Conecta REFRESCO_ACTUAL del counter con DISPLAY_CTRL Y LA FSM

signal AUX_CLK: std_logic; --Conecta CLK_OUT del prescaler con la entrada CLK de DISPLAY_CONTROL
--signal SEGMENTOS: std_logic_vector(6 downto 0); --Salida del DECODER que le llega al display)
--signal DIGCTRL:  std_logic_vector(8 downto 0); --Salida de la FSM que controla que display se ha encendido y el punto decimal
begin 

SYNC: SYNCHRONIZER 
GENERIC MAP(
    NUM_REFRESCOS => NUM_REFRESCOS,
    NUM_MONEDAS => NUM_MONEDAS
    )
PORT MAP(
    CLK => CLK,
    AS_TIPO_REFRESCO => TIPO_REFRESCO,
    AS_PAGAR => PAGAR,
    AS_MONEDAS => MONEDAS,
    S_MONEDAS => AUX1,
    S_PAGAR => AUX5,
    S_TIPO_REFRESCO => AUX6
    );

EDGE: EDGE_DETECTOR 
GENERIC MAP(
    NUM_MONEDAS => NUM_MONEDAS
    )
PORT MAP(
    CLK => CLK,
    MONEDAS_IN => AUX1,
    EDGE_MONEDAS => AUX2
    );

CTR: COUNTER 
GENERIC MAP(
    NUM_MONEDAS => NUM_MONEDAS,
    TAM_CUENTA => TAM_CUENTA,
    NUM_REFRESCOS => NUM_REFRESCOS
    )
PORT MAP(
    CLK => CLK,
    CE => AUX5,
    RESET => RESET,
    TIPO_REFRESCO => AUX6,
    MONEDAS => AUX2,
    PAGO_OK => AUX3,
    PRECIOS => AUX10,
    ERROR => AUX4,
    CUENTA => AUX7,
    REFRESCO_ACTUAL => AUX12
    );

CONTROL: DISPLAY_CONTROL 
GENERIC MAP(
    TAM_CUENTA => TAM_CUENTA,
    NUM_REFRESCOS => NUM_REFRESCOS,
    NUM_ESTADOS => NUM_ESTADOS,
    TAM_CODE => TAM_CODE,
    NUM_DISPLAYS => NUM_DISPLAYS
)
PORT MAP(
    CUENTA => AUX7,
    TIPO_REFRESCO => AUX12,
    PRECIOS => AUX10,
    CLK => AUX_CLK,
    CODE => AUX8,
    CONTROL => AUX9
);

MAQ_ESTADOS: FSM
GENERIC MAP(
    NUM_REFRESCOS => NUM_REFRESCOS,
    NUM_ESTADOS => NUM_ESTADOS,
    NUM_DISPLAYS => NUM_DISPLAYS,
    TAM_CODE => TAM_CODE
    )
PORT MAP(
    CLK => CLK,
    PAGAR => AUX5, 
    PAGO_OK => AUX3,
    TIPO_REFRESCO => AUX12,
    ERROR_COUNTER => AUX4,
    CODE_IN => AUX8,
    CONTROL_IN => AUX9,
    RESET => RESET,
    ERROR => ERROR,
    REFRESCO_OUT => REFRESCO_OUT,
    ESTADOS_OUT => ESTADOS,
    CONTROL_OUT => DIGCTRL,
    CODE_OUT => AUX11
);

DECODE: DECODER 
GENERIC MAP(
    TAM_CODE => TAM_CODE,
    NUM_SEGMENTOS => NUM_SEGMENTOS
)
PORT MAP(
    CODE => AUX11,
    SEGMENTOS => SEGMENTOS
);

PRESC: PRESCALER
GENERIC MAP(
    PRESCALER_DIV => PRESCALER_DIV
)
PORT MAP(
    CLK => CLK,
    CLK_OUT => AUX_CLK
);

end Estructural;