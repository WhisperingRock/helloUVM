class dut_model_env extends uvm_env;

	// ~~ register our env with uvm_factory automation ~~
	`uvm_component_utils(dut_model_env)

	// ~~ declare a handle for the driver ~~
	dut_driver m_drv;

	// ~~ methods ~~
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction


	// ~~ instantiate the driver in build phase ~~
	function void build_phase(uvm_phase phase);
		
		// ~ integrate phase into higher-level ~
		super.build_phase(phase);

		// ~ create driver object and add to uvm tree ~
		m_drv = dut_driver::type_id::create("m_drv", this);

	endfunction

endclass : dut_model_env
