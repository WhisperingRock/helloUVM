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

	// ~~ testing ~~
	initial begin
		run_test("dut_model_test");
	end

endmodule
