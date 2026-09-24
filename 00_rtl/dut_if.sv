/*
* Interface for DUT : 
*
*
*/

interface dut_if();
	logic 		clk;
	logic 		reset;
	logic		cmd;
	logic [7:0]	addr;
	logic [7:0]	data;
endinterface
