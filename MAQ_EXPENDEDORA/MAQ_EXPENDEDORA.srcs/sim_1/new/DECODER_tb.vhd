----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.01.2025 13:26:40
-- Design Name: 
-- Module Name: DECODER_tb - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DECODER_tb is
end;

architecture bench of DECODER_tb is

  component DECODER
      generic(
           TAM_CODE: POSITIVE:= 5;
           NUM_SEGMENTOS: POSITIVE:= 7      
      );
      port(
          CODE: in std_logic_vector(TAM_CODE - 1 downto 0);
          SEGMENTOS: out std_logic_vector(NUM_SEGMENTOS - 1 downto 0)
      );
  end component;
  
  --Señales y constantes de testeo
  constant TAM_CODE: POSITIVE := 5;
  constant NUM_SEGMENTOS: POSITIVE := 7;
  signal CODE: std_logic_vector(TAM_CODE - 1 downto 0);
  signal SEGMENTOS: std_logic_vector(NUM_SEGMENTOS - 1 downto 0) ;

begin

  UUT: DECODER
    generic map( 
        TAM_CODE => TAM_CODE,
        NUM_SEGMENTOS => NUM_SEGMENTOS
        )
    port map( 
        CODE => CODE,
        SEGMENTOS => SEGMENTOS 
        );

  STIMULUS: process
  begin
      CODE <= "00000";
      ASSERT SEGMENTOS = "0000001"
        REPORT "SEGMENTOS SHOULD BE 0000001.";
      WAIT FOR 10 ns;
      
      CODE <= "00101";
      ASSERT SEGMENTOS = "0100100"
        REPORT "SEGMENTOS SHOULD BE 0100100.";
      WAIT FOR 10 ns;
      
      CODE <= "10000";
      ASSERT SEGMENTOS = "0001000"
        REPORT "SEGMENTOS SHOULD BE 0001000.";
      WAIT FOR 10 ns;
      
      CODE <= "10011";
      ASSERT SEGMENTOS = "0111000"
        REPORT "SEGMENTOS SHOULD BE 0111000.";
      WAIT FOR 10 ns;
      
      CODE <= "11001";
      ASSERT SEGMENTOS = "1100011"
        REPORT "SEGMENTOS SHOULD BE 1100011.";
      WAIT FOR 10 ns;
      
      assert false
      report "Success: simulation finished."
      severity failure;

    wait;
  end process;

end;