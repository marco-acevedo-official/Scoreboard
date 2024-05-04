library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity Scoreboard_Final is
    Generic (
        clock_period_F : time := 10 ns;
        reg_width_F : integer := 16
    );
    Port (
        clk_F, rst_F, inc_FR, dec_FR: in std_logic;
        pmod : out STD_LOGIC_VECTOR(7 downto 0)
    );
    --pmod "gfedcbaP" where P is display select
end Scoreboard_Final;

architecture Connections of Scoreboard_Final is
	constant displayTime : time := 20000 ns;
	signal	inc_f, dec_f : std_logic := '0';
	signal	seg7disp1_F, seg7disp0_F: unsigned(6 downto 0) := (others => '0');
	signal	bcd1_out_F, bcd0_out_F : std_logic_vector(3 downto 0) := (others => '0');
	signal	reg_out_inc_F : STD_LOGIC_VECTOR(reg_width_F-1 downto 0) := (others => '0');
    signal	reg_out_dec_F : STD_LOGIC_VECTOR(reg_width_F-1 downto 0) := (others => '0');
    signal intra_pmod : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	
begin

	INCREASE_Filter : entity work.Button_Filter
	generic map(clock_period => clock_period_F, reg_width => reg_width_F )
	port map(
			clockin => clk_F,
			resetin => rst_F,
			raw_input => inc_FR,
			clean_output => inc_f,
			deb_reg_out => reg_out_inc_F
	);
	
	DECREASE_Filter : entity work.Button_Filter
	generic map(clock_period => clock_period_F, reg_width => reg_width_F )
	port map(
			clockin => clk_F,
			resetin => rst_F,
			raw_input => dec_FR,
			clean_output => dec_f,
			deb_reg_out => reg_out_dec_F
	);
	
	SCOREBOARD : entity work.Scoreboard
	generic map(clock_period => clock_period_F, reg_width => reg_width_F )
	port map(
			clk => clk_F,
			rst => rst_F,
			inc => inc_f,
			dec => dec_f,
			seg7disp1 => seg7disp1_F,
			seg7disp0 => seg7disp0_F,
			bcd1_out => bcd1_out_F,
			bcd0_out => bcd0_out_F
	);
	
	alternateDisplay:process
	begin
	--pmod "gfedcbaP" where P is display select
	intra_pmod <= 
		
	end process;
	pmod <= intra_pmod;
end Connections;