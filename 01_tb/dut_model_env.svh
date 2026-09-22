class dut_model_env extends uvm_env;

	// ~~ register our env with uvm_factory automation ~~
	`uvm_component_utils(dut_model_env)

	// ~~ methods ~~
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

endclass : dut_model_env
