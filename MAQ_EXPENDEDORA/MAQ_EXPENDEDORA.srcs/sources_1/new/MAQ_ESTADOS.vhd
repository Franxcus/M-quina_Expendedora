---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:37:44
-- Design Name: 
-- Module Name: MAQ_ESTADOS - Behavioral
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

entity FSM is
    generic(
        NUM_REFRESCOS: POSITIVE:= 2;
        NUM_ESTADOS: POSITIVE:= 4;
        NUM_DISPLAYS: POSITIVE:= 9;
        TAM_CODE: POSITIVE:= 5           
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
        CONTROL_OUT: out std_logic_vector(NUM_DISPLAYS - 1 downto 0);
        CODE_OUT: out std_logic_vector(TAM_CODE - 1 downto 0)
    );
end FSM;

architecture Behavioral of FSM is

type STATES is (S0,S1,S2,S3);
signal CURRENT_STATE: STATES := S0;
signal NEXT_STATE: STATES;

begin

    STATE_REGISTER: process(RESET, CLK)
    begin
        if RESET = '0' then
            CURRENT_STATE <= S0;
        elsif rising_edge(CLK) then
            CURRENT_STATE <= NEXT_STATE;
        end if;
    end process;
    
    NEXTSTATE: process(CLK) --, PAGAR, PAGO_OK, ERROR_COUNTER, CURRENT_STATE)
    begin
        NEXT_STATE <= CURRENT_STATE;
        case CURRENT_STATE is 
            when S0 =>
                if PAGAR = '1' and TIPO_REFRESCO /= "00" then
                    NEXT_STATE <= S1;
                end if;                
            when S1 =>
                if PAGO_OK = '1' then
                    NEXT_STATE <= S2;
                elsif ERROR_COUNTER = '1' then
                    NEXT_STATE <= S3;
                end if;                
            when S2 =>
                if PAGAR = '0' then
                    NEXT_STATE <= S0;
                end if;           
            when S3 =>
                if RESET = '0' then
                    NEXT_STATE <= S0;
                end if;            
        end case;
    end process;
    
    OUTPUT_CONTROL: process(CLK, CURRENT_STATE)
    begin
        case CURRENT_STATE is 
            when S0 =>
                ERROR <= '0';
                REFRESCO_OUT <= '0';
                ESTADOS_OUT <= "0001";
                CONTROL_OUT <= CONTROL_IN(NUM_DISPLAYS - 1 DOWNTO 0);
                CODE_OUT <= CODE_IN(TAM_CODE - 1 DOWNTO 0);
                
            when S1 =>
                ERROR <= '0';
                REFRESCO_OUT <= '0';
                ESTADOS_OUT  <= "0010";
                CONTROL_OUT <= CONTROL_IN((NUM_DISPLAYS * 2) - 1 DOWNTO NUM_DISPLAYS);
                CODE_OUT <= CODE_IN((TAM_CODE * 2) - 1 DOWNTO TAM_CODE);
            when S2 =>
                ERROR <= '0';
                REFRESCO_OUT <= '1';
                ESTADOS_OUT <= "0100";
                CONTROL_OUT <= CONTROL_IN((NUM_DISPLAYS * 3) - 1 DOWNTO NUM_DISPLAYS * 2);
                CODE_OUT <= CODE_IN((TAM_CODE * 3) - 1 DOWNTO TAM_CODE * 2);
            when S3 =>
                ERROR <= '1';
                REFRESCO_OUT <= '0';
                ESTADOS_OUT <= "1000";
                CONTROL_OUT <= CONTROL_IN((NUM_DISPLAYS * 4) - 1 DOWNTO NUM_DISPLAYS * 3);
                CODE_OUT <= CODE_IN((TAM_CODE * 4) - 1 DOWNTO TAM_CODE * 3);
        end case;
    end process;

end Behavioral;
