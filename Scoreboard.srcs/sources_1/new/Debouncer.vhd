library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Debouncer is
    Generic (
    clock_period : time := 10 ns;
    reg_width : integer := 16
    );
    Port ( 
           clk : in STD_LOGIC;
           input_signal : in STD_LOGIC;
           debounced_signal : out STD_LOGIC; -- Debounced output signal
           reg_out : out STD_LOGIC_VECTOR(reg_width-1 downto 0)
           );
end Debouncer;

architecture Behavioral of Debouncer is
    signal debounce_reg : STD_LOGIC_VECTOR(reg_width-1 downto 0) := (others => '0');
    
begin
    process(input_signal,clk)
    begin
        if rising_edge(clk) then
        for i in 0 to reg_width-1 loop --De-Queue Shift Register
            if i < reg_width-1 then
                debounce_reg(i) <= debounce_reg(i+1);
            else
                debounce_reg(i) <= input_signal;
            end if;
        end loop;
        end if;
        if debounce_reg = (debounce_reg'range => '1') then
          report "ALL REGISTERS ARE 111111111";
          debounced_signal <= '1';
        else
            debounced_signal <= '0';
        end if;
        reg_out <= debounce_reg;
    end process;
end Behavioral;