----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.12.2023 15:20:43
-- Design Name: 
-- Module Name: COUNTER - Behavioral
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
use IEEE.numeric_std .ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity COUNTER is 
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
  
end COUNTER;

architecture Behavioral of COUNTER is

    -- SE DEFINE UN SUBTIPO DEL PRECIO DEL REFRESCO
    subtype PRECIO is std_logic_vector(TAM_CUENTA - 1 downto 0);

    -- SE DEFINE EL ARRAY QUE CONTENDR� TODOS LOS PRECIOS DE LOS REFRESCOS 
    type VECTOR_PRECIOS is ARRAY (0 to NUM_REFRESCOS - 1) of PRECIO;    
    
    signal CUENTA_SIG: std_logic_vector(TAM_CUENTA - 1 downto 0) := (OTHERS => '0'); -- va sumando las monedas introducidas
    signal ERROR_SIG: std_logic;
    signal PAGO_OK_SIG: std_logic;
    signal LISTA_PRECIOS: VECTOR_PRECIOS := ("01010","01101"); 
    signal REFRESCO_ACTUAL_SIG: std_logic_vector(NUM_REFRESCOS - 1 downto 0);
    
begin

process(CLK, RESET)
    begin 
    
            if (RESET='0' OR CE='0') then 
                CUENTA_SIG <= (OTHERS => '0');  -- Inicializo la cuenta
                REFRESCO_ACTUAL_SIG <= TIPO_REFRESCO;
                -- Reiniciamos el refresco elegido
            elsif rising_edge(CLK) AND CE='1' then
                -- Podemos cambiar el tipo de refresco solo cuando no hemos empezado a pagar
                    if REFRESCO_ACTUAL_SIG /= "00" then
                        -- Empezamos a contar una vez hemos elegido el refresco
                        -- Suma la moneda introducida al contador CUENTA_SIG
                        if MONEDAS = "0001" then 
                            CUENTA_SIG <= CUENTA_SIG + "00001";  -- +10cents
                        elsif MONEDAS = "0010" then
                            CUENTA_SIG <= CUENTA_SIG + "00010";  -- +20cents
                        elsif MONEDAS = "0100" then
                            CUENTA_SIG <= CUENTA_SIG + "00101";  -- +50cents
                        elsif MONEDAS = "1000" then
                            CUENTA_SIG <= CUENTA_SIG + "01010";  -- +1�
                        end if;
                end if;
            end if;
        
        -- Comprobamos el estado del dinero
        if REFRESCO_ACTUAL_SIG = "01" then
            if CUENTA_SIG > LISTA_PRECIOS(0) then
                ERROR_SIG <= '1';  -- Me he pasado de 1 euro
                PAGO_OK_SIG <= '0';
            elsif CUENTA_SIG = LISTA_PRECIOS(0) then
                PAGO_OK_SIG <= '1'; -- He introducido lo correcto
                ERROR_SIG <= '0';
            elsif CUENTA_SIG < LISTA_PRECIOS(0) then
                PAGO_OK_SIG <= '0';
                ERROR_SIG <= '0'; -- No he metido suficiente 
            end if;
            
         elsif REFRESCO_ACTUAL_SIG = "10" then           
            if CUENTA_SIG > LISTA_PRECIOS(1) then
                ERROR_SIG <= '1';  -- Me he pasado de 1.30#�
                PAGO_OK_SIG <= '0';
            elsif CUENTA_SIG = LISTA_PRECIOS(1) then
                PAGO_OK_SIG <= '1'; -- He introducido lo correcto
                ERROR_SIG <= '0';
            elsif CUENTA_SIG < LISTA_PRECIOS(1) then
                PAGO_OK_SIG <= '0';
                ERROR_SIG <= '0'; -- No he metido suficiente 
            end if;
         end if;
        
end process;
 
ERROR <= ERROR_SIG;
PAGO_OK <= PAGO_OK_SIG;
CUENTA <= CUENTA_SIG;
PRECIOS <= LISTA_PRECIOS(1) & LISTA_PRECIOS(0);
REFRESCO_ACTUAL <= REFRESCO_ACTUAL_SIG;

end Behavioral;
