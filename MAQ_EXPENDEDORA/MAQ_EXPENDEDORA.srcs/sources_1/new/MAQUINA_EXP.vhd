----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2023 15:20:43
-- Design Name: 
-- Module Name: MAQ_EXP - Structural
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

entity MAQ_EXP is
    Generic(
        NUM_MONEDAS: POSITIVE := 4;
        NUM_REFRESCOS: POSITIVE := 2;
        NUM_ESTADOS: POSITIVE := 4;
        NUM_SEGMENTOS: POSITIVE := 7;
        NUM_DISPLAYS: POSITIVE := 9; -- 8 Y EL PUNTO DECIMAL
        TAM_CUENTA: POSITIVE := 5;
        TAM_CODE: POSITIVE := 5; -- INCLUYE NUMEROS 0-9 Y ALGUNAS LETRAS   
        PRESCALER_DIV: POSITIVE := 18   
    );
    
    Port(
        CLK : in STD_LOGIC;
        RESET : in STD_LOGIC;
        PAGAR : in STD_LOGIC;
        MONEDAS : in STD_LOGIC_VECTOR (NUM_MONEDAS - 1 downto 0);
        TIPO_REFRESCO : in STD_LOGIC_VECTOR (NUM_REFRESCOS - 1 downto 0);
        ERROR : out STD_LOGIC;
        REFRESCO_OUT : out STD_LOGIC;
        ESTADOS: out STD_LOGIC_VECTOR (NUM_ESTADOS - 1 downto 0);
        SEGMENTOS: out STD_LOGIC_VECTOR(NUM_SEGMENTOS - 1 downto 0);
        DIGCTRL: out STD_LOGIC_VECTOR(NUM_DISPLAYS - 1 downto 0)
     );
     
end MAQ_EXP;

architecture Estructural of MAQ_EXP is

component SYNCHRNZR is
    Generic(
        NUM_REFRESCOS: POSITIVE;
        NUM_MONEDAS: POSITIVE      
    );
    Port(
        CLK : in STD_LOGIC;
        ASYNC_MONEDAS: in STD_LOGIC_VECTOR (NUM_MONEDAS - 1 downto 0); 
        ASYNC_PAGAR: in STD_LOGIC;
        ASYNC_TIPO_REFRESCO: in STD_LOGIC_VECTOR (NUM_REFRESCOS - 1 downto 0);
        SYNCD_MONEDAS: out STD_LOGIC_VECTOR (NUM_MONEDAS - 1 downto 0);
        SYNCD_PAGAR: out STD_LOGIC;
        SYNCD_TIPO_REFRESCO: out STD_LOGIC_VECTOR (NUM_REFRESCOS - 1 downto 0)
     );
end component;

component EDGE_DETECTOR is
    Generic(
        NUM_MONEDAS: POSITIVE      
    );
    Port(
        CLK : in STD_LOGIC;
        MONEDAS_IN : in STD_LOGIC_VECTOR(NUM_MONEDAS - 1 downto 0); -- 6 bits de se?ales de entrada.
        EDGE_MONEDAS : out STD_LOGIC_VECTOR(NUM_MONEDAS - 1 downto 0) -- Salida de detecci?n de flanco.
    );
end component;

component COUNTER is
    Generic(
        NUM_MONEDAS: POSITIVE;
        NUM_REFRESCOS: POSITIVE;
        TAM_CUENTA: POSITIVE      
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
        NUM_REFRESCOS: POSITIVE;
        NUM_ESTADOS: POSITIVE;
        NUM_DISPLAYS: POSITIVE;
        TAM_CODE: POSITIVE           
    );
    Port( 
        CLK : in STD_LOGIC;
        PAGAR : in STD_LOGIC;
        PAGO_OK : in STD_LOGIC;
        TIPO_REFRESCO: in STD_LOGIC_VECTOR (NUM_REFRESCOS - 1 downto 0);
        ERROR_COUNTER : in STD_LOGIC;
        CONTROL_IN : in STD_LOGIC_VECTOR (NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0);
        CODE_IN:in STD_LOGIC_VECTOR (TAM_CODE * NUM_ESTADOS - 1 downto 0);
        RESET : in STD_LOGIC;
        ERROR : out STD_LOGIC;
        REFRESCO_OUT : out STD_LOGIC;
        ESTADOS_OUT : out STD_LOGIC_VECTOR(NUM_ESTADOS - 1 downto 0);
        CONTROL_OUT : out STD_LOGIC_VECTOR (NUM_DISPLAYS - 1 downto 0);
        CODE_OUT: out STD_LOGIC_VECTOR (TAM_CODE - 1 downto 0)
    );
end component;

component DISPLAY_CONTROL is
    Generic(
        TAM_CUENTA: POSITIVE;
        N_REFRESCOS: POSITIVE;
        TAM_CODE: POSITIVE;
        N_ESTADOS: POSITIVE;
        N_DISPLAYS: POSITIVE
    );
    Port(
        CUENTA : in STD_LOGIC_VECTOR (TAM_CUENTA - 1 downto 0);
        TIPO_REFRESCO: in STD_LOGIC_VECTOR (NUM_REFRESCOS - 1 downto 0);
        PRECIOS: in STD_LOGIC_VECTOR(NUM_REFRESCOS * TAM_CUENTA - 1 downto 0);
        CLK : in STD_LOGIC;
        CODE : out STD_LOGIC_VECTOR (TAM_CODE * NUM_ESTADOS - 1 downto 0);
        CONTROL : out STD_LOGIC_VECTOR (NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0)
    );
end component;

component DECODER is
    Generic(
         TAM_CODE: POSITIVE;
         NUM_SEGMENTOS: POSITIVE      
    );
    Port(
        CODE : IN std_logic_vector(TAM_CODE - 1 DOWNTO 0);
        SEGMENTOS : OUT std_logic_vector(NUM_SEGMENTOS - 1 DOWNTO 0)
    );
end component;

component PRESCALER is
generic(
    PRESCALER_DIV: POSITIVE      
);
Port(
    CLK : in STD_LOGIC;
    CLK_OUT : out STD_LOGIC
);
end component;

signal AUX1: std_logic_vector (NUM_MONEDAS - 1 downto 0); --Conecta MONEDAS[] de SYNC con el EDGE_DETECTOR
signal AUX2: std_logic_vector (NUM_MONEDAS - 1 downto 0); --Conecta MONEDAS[] de EDGE_DET con el COUNTER
signal AUX3: std_logic; --Conecta PAGO_OK del COUNTER con la FSM
signal AUX4: std_logic; --Conec0ta ERROR del COUNTER con la FSM
signal AUX5: std_logic; --Conecta PAGAR del SYNC con el COUNTER y la FSM
signal AUX6: std_logic_vector (NUM_REFRESCOS - 1 downto 0); --Conecta TIPO_TEFRSCO del SYNC con el COUNTER
signal AUX7: std_logic_vector (TAM_CUENTA - 1 downto 0); --Conecta CUENTA del counter con CUENTA del DISPLAY_CONTROL
signal AUX8: std_logic_vector (TAM_CODE * NUM_ESTADOS - 1 downto 0); --Conecta CODE del DISPLAY_CTRL con CODE de la FSM
signal AUX9: std_logic_vector (NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0); --Conecta CONTROL del DISPLAY_CONTROL con CONTROL de la FSM
signal AUX10: std_logic_vector(NUM_REFRESCOS * TAM_CUENTA - 1 downto 0); --Conecta PRECIOS del contador con el DISPLAY_CONTROL
signal AUX11: std_logic_vector(TAM_CODE - 1 downto 0); --Conecta CODE_OUT de la FSM con code del DECODER 
signal AUX12: std_logic_vector (NUM_REFRESCOS - 1 downto 0); --Conecta REFRESCO_ACTUAL del counter con DISPLAY_CTRL Y LA FSM

signal AUX_CLK: std_logic; --Conecta CLK_OUT del prescaler con la entrada CLK de DISPLAY_CONTROL
--signal SEGMENTOS: std_logic_vector(6 downto 0); --Salida del DECODER que le llega al display)
--signal DIGCTRL:  std_logic_vector(8 downto 0); --Salida de la FSM que controla que display se ha encendido y el punto decimal
begin 
 

SYNC: SYNCHRNZR
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
    SYNCD_TIPO_REFRESCO => AUX6
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

CLK_DIV: PRESCALER
GENERIC MAP(
    PRESCALER_DIV => PRESCALER_DIV
)
PORT MAP(
    CLK => CLK,
    CLK_OUT => AUX_CLK
);

end Estructural;