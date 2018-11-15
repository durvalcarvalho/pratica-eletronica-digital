library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity decoder is
    Port (  result : in UNSIGNED (7 downto 0);
            codigo: in STD_LOGIC_VECTOR(3 DOWNTO 0);
            result_BCD_milhar: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            result_BCD_centena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            result_BCD_dezena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            result_BCD_unidade: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end decoder;

architecture Behavioral of decoder is

-- decoder para binario - BCD
component bin_decoder is
    Port (  result : in UNSIGNED (7 downto 0);
            bin_BCD_unidade: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            bin_BCD_dezena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            bin_BCD_centena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            bin_BCD_milhar: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end component;

-- decoder para decimal - BCD
component dec_decoder is
    Port (  result : in UNSIGNED (7 downto 0);
            dec_BCD_unidade: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            dec_BCD_dezena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            dec_BCD_centena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            dec_BCD_milhar: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end component;

-- decoder para hexa - bcd
component hexa_decoder is
    Port (  result : in UNSIGNED (7 downto 0);
            hexa_BCD_unidade: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            hexa_BCD_dezena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            hexa_BCD_centena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            hexa_BCD_milhar: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end component;

-- decoder para octal - bcd
component octal_decoder is
    Port (  result : in UNSIGNED (7 downto 0);
            oct_BCD_unidade: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            oct_BCD_dezena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            oct_BCD_centena: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            oct_BCD_milhar: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end component;

signal decimal_result_unidade: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal decimal_result_dezena: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal decimal_result_centena: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal decimal_result_milhar: STD_LOGIC_VECTOR(3 DOWNTO 0);

signal octal_result_unidade: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal octal_result_dezena: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal octal_result_centena: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal octal_result_milhar: STD_LOGIC_VECTOR(3 DOWNTO 0);

signal hexadecimal_result_unidade: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal hexadecimal_result_dezena: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal hexadecimal_result_centena: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal hexadecimal_result_milhar: STD_LOGIC_VECTOR(3 DOWNTO 0);

signal binario_result_unidade: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal binario_result_dezena: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal binario_result_centena: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal binario_result_milhar: STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

bin_decod: bin_decoder PORT MAP(result, binario_result_unidade, binario_result_dezena, binario_result_centena, binario_result_milhar);
dec_decod: dec_decoder PORT MAP(result, decimal_result_unidade, decimal_result_dezena, decimal_result_centena, decimal_result_milhar);
hex_decod: hexa_decoder PORT MAP(result, hexadecimal_result_unidade, hexadecimal_result_dezena, hexadecimal_result_centena, hexadecimal_result_milhar);
oct_decod: octal_decoder PORT MAP(result, octal_result_unidade, octal_result_dezena, octal_result_centena, octal_result_milhar);

find_codigo: process(codigo)
    begin
        case codigo is
            WHEN "00" =>
                result_BCD_unidade <= decimal_result_unidade;
                result_BCD_dezena  <= decimal_result_dezena;
                result_BCD_centena <= decimal_result_centena;
                result_BCD_milhar  <= decimal_result_milhar;
            WHEN "01" =>
                result_BCD_unidade <= hexadecimal_result_unidade;
                result_BCD_dezena  <= hexadecimal_result_dezena;
                result_BCD_centena <= hexadecimal_result_centena;
                result_BCD_milhar  <= hexadecimal_result_milhar; 
            WHEN "10" =>
                result_BCD_unidade <= binario_result_unidade;
                result_BCD_dezena  <= binario_result_dezena;
                result_BCD_centena <= binario_result_centena;
                result_BCD_milhar  <= binario_result_milhar;
            WHEN "11" =>
                result_BCD_unidade <= octal_result_unidade;
                result_BCD_dezena  <= octal_result_dezena;
                result_BCD_centena <= octal_result_centena;
                result_BCD_milhar  <= octal_result_milhar;
        end case;
end process;

end Behavioral;
