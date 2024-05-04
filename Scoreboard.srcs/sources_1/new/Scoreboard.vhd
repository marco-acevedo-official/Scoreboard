library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Scoreboard is
    generic(
        clock_period : time := 10 ns;
        reg_width : integer := 16
    );
    port(
        clk, rst, inc, dec: in std_logic;
        seg7disp1, seg7disp0: out unsigned(6 downto 0);
        bcd1_out, bcd0_out : out std_logic_vector(3 downto 0)--Debug
    );
end Scoreboard;

architecture Behavioral of Scoreboard is

    type sevsegarray is array (0 to 9) of unsigned(6 downto 0);
    constant seg7Rom: sevsegarray := ("0111111", "0000110", "1011011", "1001111", "1100110", "1101101", "1111100","0000111", "1111111", "1100111"); -- active high with "gfedcba" order
    
    signal State : integer range 0 to 1;
    signal rstcnt : integer range 0 to 4 := 0;
    signal count : integer   :=  1;
    signal tmp  : std_logic := '0';
    signal clock_out : std_logic := '0';
    signal BCD1, BCD0 : unsigned(3 downto 0) := "0000"; -- BCD Value of each Display
    
    begin
    
    bcd1_out <= std_logic_vector(bcd1);
    bcd0_out <= std_logic_vector(bcd0);
    
    process(clk, tmp)
    begin
        if (clk'event and clk='1') then
            count <= count + 1;
            tmp <= NOT tmp;
            if (count = 10000000) then
                tmp <= NOT tmp;
                count <= 1;
                report "Count to HIGH, RESET";
            end if;
        end if;
        clock_out <= tmp;
    end process;
     
    process(clock_out)
    begin
        if clock_out'event and clock_out = '1' then--if1
            case State is
            when 0 =>
                BCD1 <= "0000"; BCD0 <= "0000";
                rstcnt <= 0;
                State <= 1;
            when 1 =>
                if rst = '1' then
                    if rstcnt = 4 then
                        State <= 0;
                    else rstcnt <= rstcnt + 1;
                    end if;
    
                elsif inc = '1' and dec = '0' then
                report "Increase Button Detected";
                    rstcnt <= 0;
                    if BCD0 < "1001" then
                        BCD0 <= BCD0 + 1;
                    elsif BCD1 < "1001" then
                        BCD1 <= BCD1 + 1;
                        BCD0 <= "0000";
                    end if;
    
                elsif dec = '1' and inc = '0' then
                     report "Decrease Button Detected";
                    rstcnt <= 0;
                    if BCD0 > "0000" then
                        BCD0 <= BCD0 - 1;
                    elsif BCD1 > "0000" then
                        BCD1 <= BCD1 - 1;
                        BCD0 <= "1001";
                    end if;
    
                elsif (inc = '1' and dec = '1') or (inc = '0' and dec = '0') then
                    rstcnt <= 0;
                end if;
    
            end case;
        end if;--if1
    end process;
    
    seg7disp0 <= seg7rom(to_integer(BCD0));
    seg7disp1 <= seg7rom(to_integer(BCD1));

end Behavioral;