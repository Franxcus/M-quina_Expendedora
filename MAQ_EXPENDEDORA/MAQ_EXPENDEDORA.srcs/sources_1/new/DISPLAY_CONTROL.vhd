----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:27:50
-- Design Name: 
-- Module Name: DISPLAY_CONTROL - Behavioral
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
USE ieee.STD_LOGIC_UNSIGNED.ALL;

entity DISPLAY_CONTROL is
    Generic(
        TAM_CUENTA: positive:= 5;
        NUM_REFRESCOS: positive:= 2;
        TAM_CODE: positive:= 5;
        NUM_ESTADOS: positive:= 4;
        NUM_DISPLAYS: positive:= 9
    );
    Port(
        CUENTA : in std_logic_vector (TAM_CUENTA - 1 downto 0);
        TIPO_REFRESCO: in std_logic_vector (NUM_REFRESCOS - 1 downto 0);
        PRECIOS: in std_logic_vector(NUM_REFRESCOS * TAM_CUENTA - 1 downto 0);
        CLK : in std_logic;
        CODE : out std_logic_vector (TAM_CODE * NUM_ESTADOS - 1 downto 0);
        CONTROL : out std_logic_vector(NUM_DISPLAYS * NUM_ESTADOS - 1 downto 0)
    );
end DISPLAY_CONTROL;

architecture Behavioral of DISPLAY_CONTROL is

--Arrays que contienen todos los controles y codes de los estados
type CONTROL_TOTAL is array (0 to NUM_ESTADOS - 1) of std_logic_vector(NUM_DISPLAYS - 1 downto 0);
type CODE_TOTAL is array(0 to NUM_ESTADOS - 1) of std_logic_vector(TAM_CODE - 1 downto 0);

--Señales de registro
signal CONTROL_SIG : CONTROL_TOTAL;
signal CODE_SIG : CODE_TOTAL;

begin

process(CLK)
begin
    if rising_edge (CLK) then 
    
        case CONTROL_SIG(0) is --PROD 1 / PROD 2
            when "111101111" =>
                CONTROL_SIG(0) <= "111011111";
                CODE_SIG(0) <= "10001"; --LETRA D
            when "111011111" =>
                CONTROL_SIG(0) <= "110111111";
                CODE_SIG(0) <= "10101"; --LETRA O
            when "110111111" =>
                CONTROL_SIG(0) <= "101111111";
                CODE_SIG(0) <= "10111"; --LETRA R
            when "101111111" =>
                CONTROL_SIG(0) <= "011111111";
                CODE_SIG(0) <= "10110"; --LETRA P
            when others =>
                CONTROL_SIG(0) <= "111101111";
                if TIPO_REFRESCO = "01" then
                    CODE_SIG(0) <= "00001"; --Numero del producto
                elsif TIPO_REFRESCO = "10" then
                    CODE_SIG(0) <= "00010"; --Numero del producto
                else CODE_SIG(0) <= "11111"; --ningun producto seleccionado
                end if;          
        end case;
        
        case CONTROL_SIG(1) is --Muestra el precio del refresco y lo que falta por pagar
            when "111111101" =>
                CONTROL_SIG(1) <= "111111011";
                --Muestra el primer decimal del precio que falta por pagar
                --Por ejemplo si faltan 70cents por pagar muestra un 7
                if TIPO_REFRESCO = "01" then
                    if PRECIOS(TAM_CUENTA - 1 downto 0) - CUENTA >= "01010" then
                        CODE_SIG(1) <= PRECIOS(TAM_CUENTA - 1 downto 0) - "01010" - CUENTA;
                    else 
                        CODE_SIG(1) <= PRECIOS(TAM_CUENTA - 1 downto 0) - CUENTA;
                    end if;
                 elsif TIPO_REFRESCO = "10" then
                    if PRECIOS((TAM_CUENTA*2) - 1 downto TAM_CUENTA) - CUENTA >= "01010" then
                        CODE_SIG(1) <= PRECIOS((TAM_CUENTA*2) - 1 downto TAM_CUENTA) - "01010" - CUENTA;
                    else 
                        CODE_SIG(1) <= PRECIOS((TAM_CUENTA*2) - 1 downto TAM_CUENTA) - CUENTA;
                    end if;
                end if;                      
                --DP <= '1';
            when "111111011" =>
                CONTROL_SIG(1) <= "111110110";
                --Se muestra la unidad del precio(en euros) que falta por pagar
                --Por ejemplo si se tiene que pagar menos de 1euro, se mostrara un 0
                if TIPO_REFRESCO = "01" then
                    if PRECIOS(TAM_CUENTA - 1 downto 0) - CUENTA >= "01010" then
                        CODE_SIG(1) <= "00001";
                    else CODE_SIG(1) <= "00000";
                    end if;
                elsif TIPO_REFRESCO = "10" then
                    if PRECIOS((TAM_CUENTA*2) - 1 downto TAM_CUENTA) - CUENTA >= "01010" then
                        CODE_SIG(1) <= "00001";
                    else CODE_SIG(1) <= "00000";
                    end if;
                end if;
                --DP <= '0'; 
            when "111110110" =>
                CONTROL_SIG(1) <= "111011111";
                 --Se muestra el segundo decimal del precio del refresco que siempre es 0
                CODE_SIG(1) <= "00000"; 
                --DP <= '1';
            when "111011111" =>
                CONTROL_SIG(1) <= "110111111";
                if TIPO_REFRESCO = "01" then
                    --Se muestra el primer decimal del precio de 1.00euros (10 - 10)
                    CODE_SIG(1) <= PRECIOS(TAM_CUENTA - 1 downto 0) - "01010"; 
                elsif TIPO_REFRESCO = "10" then
                    --Se muestra el primer decimal del precio de 1.30euros (13 - 10)
                    CODE_SIG(1) <= PRECIOS((TAM_CUENTA*2) - 1 downto TAM_CUENTA)- "01010";
                end if;
                --DP <= '1';
            when "110111111" =>
                CONTROL_SIG(1) <= "101111110";
                --Se muestra la unidad del precio del refresco: 1euro siempre
                CODE_SIG(1) <= "00001"; 
                --DP <= '0';
            when others =>
                CONTROL_SIG(1) <= "111111101";
                CODE_SIG(1) <= "00000";
                --DP <= '1';
        end case;
        
        case CONTROL_SIG(2) is --El refresco ha salido correctamente: OUT 1 / OUT 2
            when "111011111" =>
                CONTROL_SIG(2) <= "110111111";
                CODE_SIG(2) <= "11000"; --LETRA T
            when "110111111" =>
                CONTROL_SIG(2) <= "101111111";
                CODE_SIG(2) <= "11001"; --LETRA U
            when "101111111" =>
                CONTROL_SIG(2) <= "011111111";
                CODE_SIG(2) <= "10101"; --LETRA O
            when others =>
                CONTROL_SIG(2) <= "111011111";
                if TIPO_REFRESCO = "01" then
                    CODE_SIG(2) <= "00001"; --NUMERO DEL REFRESCO (1)      
                elsif TIPO_REFRESCO = "10" then
                    CODE_SIG(2) <= "00010"; --NUMERO DEL REFRESCO (2) 
                end if; 
        end case;
        
        case CONTROL_SIG(3) IS --Se ha sobrepasado el precio del refresco
            when "11101111"&'1' =>
                CONTROL_SIG(3) <= "11011111"&'1';
                CODE_SIG(3) <= "00001"; --LETRA I/1
            when "11011111"&'1' =>
                CONTROL_SIG(3) <= "10111111"&'1';
                CODE_SIG(3) <= "10000"; --LETRA A
            when "10111111"&'1' =>
                CONTROL_SIG(3) <= "01111111"&'1';
                CODE_SIG(3) <= "10011"; --LETRA F
            when others =>
                CONTROL_SIG(3) <= "11101111"&'1';
                CODE_SIG(3) <= "10100"; --LETRA L
        end case;
        
    end if; 
    
CONTROL <= CONTROL_SIG(3)&CONTROL_SIG(2)&CONTROL_SIG(1)&CONTROL_SIG(0);  
CODE <= CODE_SIG(3)&CODE_SIG(2)&CODE_SIG(1)&CODE_SIG(0);   
            
end process;
end Behavioral;