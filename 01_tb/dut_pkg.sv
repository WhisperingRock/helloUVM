package dut_pkg;
	
	import uvm_pkg::*;

	// ~~ general ~~
	`include "uvm_macros.svh"
	
	// ~~ uvm : _test specific (lowest modules first) ~~
	`include "dut_driver.svh"
	`include "dut_model_env.svh"
	`include "dut_model_test.svh"

endpackage : dut_pkg
