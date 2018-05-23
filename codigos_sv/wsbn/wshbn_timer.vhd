-- // +FHDR------------------------------------------------------------------------
-- // -----------------------------------------------------------------------------
-- // FILE NAME      : riscv_div
-- // AUTHOR         : caram
-- // AUTHOR'S EMAIL : caram@cin.ufpe.br
-- // -----------------------------------------------------------------------------
-- // RELEASE HISTORY
-- // VERSION 	DATE         AUTHOR		DESCRIPTION
-- // 1.0		2015-01-18   caram   	Initial version
-- // -----------------------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


ENTITY wshbn_timer IS 
PORT(
	CLK_I	: IN STD_LOGIC;
	RST_I : IN STD_LOGIC;
	ADR_I : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	DAT_I : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	DAT_O : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	WE_I	: IN STD_LOGIC;
	STB_I : IN STD_LOGIC;
	ACK_O : OUT STD_LOGIC;
	CYC_I : IN STD_LOGIC;
	---
	interrupt : OUT STD_LOGIC
);
END wshbn_timer;

ARCHITECTURE v1 OF wshbn_timer IS

SIGNAL tmr_ctrl: STD_LOGIC_VECTOR(7 DOWNTO 0):=(OTHERS=>'0'); ---    | 7| 6|  5 | 4 | 3 | 2 |  TMR0 INT EN |  TMR0 EN    
SIGNAL mtime0 : STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS=>'0');
SIGNAL mtime0cmp : STD_LOGIC_VECTOR(31 DOWNTO 0):=(OTHERS =>'0');

SIGNAL tmr_ctrl_wen : STD_LOGIC:='0';
SIGNAL mtime0cmp_wen : STD_LOGIC:='0';


SIGNAL reg_wren  : STD_LOGIC:='0';
--SIGNAL reg_rden  : STD_LOGIC:='0';
SIGNAL r_ack_o   : STD_LOGIC:='0'; 
SIGNAL out_reg : STD_LOGIC_VECTOR(15 DOWNTO 0):=(others => '0');
SIGNAL in_reg : STD_LOGIC_VECTOR(15 DOWNTO 0):=(others => '0');

BEGIN

reg_wren <= CYC_I and STB_I and WE_I;
--reg_rden <= CYC_I and STB_I and (not WE_I);
ACK_O <= r_ack_o;


tmr_ctrl_wen  <= reg_wren and  ((NOT ADR_I(3)) AND (NOT ADR_I(2)) AND (NOT ADR_I(1)) AND (NOT ADR_I(0))) ; -- 00h
mtime0cmp_wen <= reg_wren and  ((NOT ADR_I(3)) AND (NOT ADR_I(2)) AND (NOT ADR_I(1)) AND ( ADR_I(0))) ; -- 01h

-- SLAVE SÍNCRONO : ACK NO CLK SEGUINTE
PROCESS(CLK_I, CYC_I, STB_I, r_ack_o)
BEGIN
	IF(RISING_EDGE(CLK_I)) THEN
		r_ack_o <= CYC_I AND STB_I AND NOT(r_ack_o);
	END IF;
END PROCESS;

PROCESS(tmr_ctrl_wen,tmr_ctrl, clk_I, rst_I, DAT_I)
BEGIN
IF(rst_I = '1') THEN
	tmr_ctrl <= "00000000";
ELSE
	IF(RISING_EDGE(clk_I)) THEN
		IF(tmr_ctrl_wen = '1') THEN
			tmr_ctrl <= DAT_I(7 DOWNTO 0);
		END IF;
	END IF;
END IF;
END PROCESS;

PROCESS(mtime0cmp,mtime0cmp_wen, clk_I, rst_I, DAT_I)
BEGIN
IF(rst_I = '1') THEN
	mtime0cmp <= (others => '0');
ELSE
	IF(RISING_EDGE(clk_I)) THEN
		IF(mtime0cmp_wen = '1') THEN
			mtime0cmp <= DAT_I;
		END IF;
	END IF;
END IF;
END PROCESS;


PROCESS(mtime0, clk_I, rst_I, DAT_I,tmr_ctrl)
BEGIN
IF(tmr_ctrl(0) = '0' or rst_i = '1') THEN
	mtime0 <= (others => '0');
ELSE
	IF(RISING_EDGE(clk_I)) THEN
		IF( tmr_ctrl(0) = '1') THEN
		  IF(mtime0 <= mtime0cmp)then
			mtime0 <= mtime0 + '1';
		  END IF;
	   end if;
	END IF;
END IF;
END PROCESS;

PROCESS(mtime0,mtime0cmp,tmr_ctrl)
BEGIN
IF(mtime0 = mtime0cmp)THEN
	interrupt <= '1' and tmr_ctrl(0);
ELSE
	interrupt <= '0';
END IF;
END PROCESS;



DAT_O <= X"00000000";-- & pio_0_in; --X"2AAA"; -- in_reg; 


END V1;
