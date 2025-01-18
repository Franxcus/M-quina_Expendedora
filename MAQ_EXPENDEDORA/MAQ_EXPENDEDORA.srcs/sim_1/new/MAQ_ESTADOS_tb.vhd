---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:38:50
-- Design Name: 
-- Module Name: MAQ_ESTADOS_tb - Behavioral
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

entity FSM_tb is
end;

architecture bench of FSM_tb is

  component FSM
      generic(
          NUM_REFRESCOS: positive:= 2;
          NUM_ESTADOS: positive:= 4;
          NUM_DISPLAYS: positive:= 9;
          TAM_CODE: positive:= 5           
      );
      port( 
          CLK: in std_logic;
          PAGAR: in std_logic;
          PAGO_OK: in std_logic;
          TIPO_REFRESCO: in std_logic_vector(NUM_REFRESCOS - 1 downto 0);
          ERROR_COUNTER: in std_logic;
          CONTROL_IN: in std_logic_vector(NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0);
          CODE_IN: in std_logic_vector(TAM_CODE * NUM_ESTADOS - 1 downto 0);
          RESET: in std_logic;
          ERROR: out std_logic;
          REFRESCO_OUT: out std_logic;
          ESTADOS_OUT: out std_logic_vector(NUM_ESTADOS - 1 downto 0);
          CONTROL_OUT: out std_logic_vector (NUM_DISPLAYS - 1 downto 0);
          CODE_OUT: out std_logic_vector(TAM_CODE - 1 downto 0)
      );
  end component;

  --Señales y constantes de testeo
  constant NUM_REFRESCOS: positive := 2;
  constant NUM_ESTADOS: positive := 4;
  constant NUM_DISPLAYS: positive := 9;
  constant TAM_CODE: positive := 5;
  signal CLK: std_logic;
  signal PAGAR: std_logic;
  signal PAGO_OK: std_logic;
  signal TIPO_REFRESCO: std_logic_vector (NUM_REFRESCOS - 1 downto 0);
  signal ERROR_COUNTER: std_logic;
  signal CONTROL_IN: std_logic_vector (NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0);
  signal CODE_IN: std_logic_vector (TAM_CODE * NUM_ESTADOS - 1 downto 0);
  signal RESET: std_logic;
  signal ERROR: std_logic;
  signal REFRESCO_OUT: std_logic;
  signal ESTADOS_OUT: std_logic_vector(NUM_ESTADOS - 1 downto 0);
  signal CONTROL_OUT: std_logic_vector (NUM_DISPLAYS - 1 downto 0);
  signal CODE_OUT: std_logic_vector (TAM_CODE - 1 downto 0) ;

  constant CLOCK_PERIOD: time := 10 ns;

begin

  UUT: FSM 
    generic map( 
        NUM_REFRESCOS => NUM_REFRESCOS,
        NUM_ESTADOS => NUM_ESTADOS,
        NUM_DISPLAYS => NUM_DISPLAYS,
        TAM_CODE => TAM_CODE
        )
    port map(
        CLK => CLK,
        PAGAR => PAGAR,
        PAGO_OK => PAGO_OK,
        TIPO_REFRESCO => TIPO_REFRESCO,
        ERROR_COUNTER => ERROR_COUNTER,
        CONTROL_IN => CONTROL_IN,
        CODE_IN => CODE_IN,
        RESET => RESET,
        ERROR => ERROR,
        REFRESCO_OUT => REFRESCO_OUT,
        ESTADOS_OUT => ESTADOS_OUT,
        CONTROL_OUT => CONTROL_OUT,
        CODE_OUT => CODE_OUT );

   CLK_TREATMENT: process
   begin

    CLK <= '0';
    wait for 0.5 * clock_period;

    CLK <= '1';
    wait for 0.5 * clock_period;

   end process;

  stimulus: process
  begin
  
    --Se inicializan las entradas
    PAGAR <= '0';
    ERROR_COUNTER <= '0';
    PAGO_OK <= '0';
    TIPO_REFRESCO <= (OTHERS => '0');
    RESET <= '0'; --REset pulsado
    CODE_IN <= (OTHERS => '0');
    CONTROL_IN <= (OTHERS => '0');
    WAIT FOR CLOCK_PERIOD;
    
    RESET <= '1';
    PAGAR <= '1';
    ASSERT ESTADOS_OUT <= "0001"
        REPORT "ESTADOS SHOULD BE 0001";
    WAIT FOR CLOCK_PERIOD;
    
    --Se pasa al estado de pago una vez hemos seleccionado un refresco y PAGAR esta a 1
    TIPO_REFRESCO <= "01";
    WAIT FOR CLOCK_PERIOD;
    ASSERT ESTADOS_OUT <= "0010"
        REPORT "ESTADO SHOULD BE 0010";
    
    --El contador da la orden de que se ha completado el pago y se pasa al estado 3
    PAGO_OK <= '1';
    WAIT FOR CLOCK_PERIOD;
    ASSERT ESTADOS_OUT <= "0100" AND REFRESCO_OUT <= '1'
        REPORT "ESTADOS SHOULD BE 0100 AND REFRESCO_OUT 1";
        
    --Se pasa al estado de reposo poniendo PAGAR a 0
    PAGAR <= '0'; --Tambien se resetea el contador
    PAGO_OK <= '0';
    WAIT FOR CLOCK_PERIOD;
    
    PAGAR <= '1';
    WAIT FOR CLOCK_PERIOD;
     
    ERROR_COUNTER <= '1';
    WAIT FOR CLOCK_PERIOD;
    ASSERT ESTADOS_OUT <= "1000" AND ERROR <='1'
       REPORT "ESTADOS SHOULD BE 1000 AND ERROR 1";
    
    assert false
    report "Success: simulation finished."
    severity failure;

    wait;
  end process;


end;
