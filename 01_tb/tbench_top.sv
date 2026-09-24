module tbench_top;

	// ~~ imports ~~
	import uvm_pkg::*;
	import dut_pkg::*;

	// ~~ interfaces ~~
	dut_if dut_if1();

	// ~~ DUT instance ~~
	dut dut1(
		.dif(dut_if1)
	);	

	// ~~ heartbeat ~~
	initial begin
		dut_if1.clk = 0;
		forever #5 dut_if1.clk = ~dut_if1.clk;
	end

	// ~~ testing ~~
	initial begin
	
		// ~ add the virtual interface to the config database using name/value pair ~
		//                 ~ type ~          caller | path |  name  | value 
		uvm_config_db #(virtual dut_if)::set( null,   "*",  "dut_if", dut_if1);

		// ~ call $finish upon finishing last objection rather than run off ~
		//uvm_top.finish_on_completion = 1;
		//uvm_root::get().finish_on_completion = 1;

		// ~ enter tests ~
		run_test("dut_model_test");
	end

endmodule
