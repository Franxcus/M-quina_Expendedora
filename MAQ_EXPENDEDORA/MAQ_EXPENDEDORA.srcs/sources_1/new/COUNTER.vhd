----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:23:47
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
    generic(
        NUM_MONEDAS: positive:= 4;
        NUM_REFRESCOS: positive:= 2;
        TAM_CUENTA: positive:= 5      
    );
    port(
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
    --Array que contiene el precio de los refrescos
    type ARRAY_PRECIOS is ARRAY (0 to NUM_REFRESCOS - 1) of std_logic_vector(TAM_CUENTA - 1 downto 0);
        
    --Señales de registro
    signal REG_CUENTA: std_logic_vector(TAM_CUENTA - 1 downto 0) := (others => '0');
    signal REG_ERROR: std_logic;
    signal REG_PAGO_OK: std_logic;
    signal LISTA_PRECIOS: ARRAY_PRECIOS := ("01010","01101"); 
    signal REG_REFRESCO_ACTUAL: std_logic_vector(NUM_REFRESCOS - 1 downto 0); 
begin
    process(CLK, CE, RESET)
    begin 
            if RESET = '1' then 
                REG_CUENTA <= (others => '0');  --Se reinicia la cuenta a 0euros
                REG_REFRESCO_ACTUAL <= TIPO_REFRESCO; --Se reinicia el tipo de refresco seleccionado
            elsif rising_edge(CLK) then
                if CE = '1' then
                    if REG_REFRESCO_ACTUAL /= "00" then
                        --Suma Monedas
                        if MONEDAS = "0001" then 
                            REG_CUENTA <= REG_CUENTA + "00001";  -- +10centimos
                        elsif MONEDAS = "0010" then
                            REG_CUENTA <= REG_CUENTA + "00010";  -- +20centimos
                        elsif MONEDAS = "0100" then
                            REG_CUENTA <= REG_CUENTA + "00101";  -- +50centimos
                        elsif MONEDAS = "1000" then
                            REG_CUENTA <= REG_CUENTA + "01010";  -- +1euro
                        end if;
                    end if;        
                end if;
            end if;
        
        --Comprobacion Euros Introducidos y Precio de los Refrescos
        if REG_REFRESCO_ACTUAL = "01" then
            if REG_CUENTA > LISTA_PRECIOS(0) then
                REG_ERROR <= '1';  --Se ha introducido mas de 1€
                REG_PAGO_OK <= '0';
            elsif REG_CUENTA = LISTA_PRECIOS(0) then
                REG_PAGO_OK <= '1'; --Se ha introducido la cantidad correcta
                REG_ERROR <= '0';
            elsif REG_CUENTA < LISTA_PRECIOS(0) then
                REG_PAGO_OK <= '0';
                REG_ERROR <= '0'; --No se ha introducido la cantidad suficiente
            end if;
            
         elsif REG_REFRESCO_ACTUAL = "10" then
            if REG_CUENTA > LISTA_PRECIOS(1) then
                REG_ERROR <= '1';  --Se ha introducido mas de 1,30euros
                REG_PAGO_OK <= '0';
            elsif REG_CUENTA = LISTA_PRECIOS(1) then
                REG_PAGO_OK <= '1'; --Se ha introducido la cantidad correcta
                REG_ERROR <= '0';
            elsif REG_CUENTA < LISTA_PRECIOS(1) then
                REG_PAGO_OK <= '0';
                REG_ERROR <= '0'; --No se ha introducido la cantidad suficiente
            end if;
         end if;
end process;
 
ERROR <= REG_ERROR;
PAGO_OK <= REG_PAGO_OK;
CUENTA <= REG_CUENTA;
PRECIOS <= LISTA_PRECIOS(1) & LISTA_PRECIOS(0);
REFRESCO_ACTUAL <= REG_REFRESCO_ACTUAL;

end Behavioral;
