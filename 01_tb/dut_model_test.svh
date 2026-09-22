class dut_model_test extends uvm_test;

	// ~~~~ register with uvm_factory ~~~~
	`uvm_component_utils(dut_model_test)

	// ~~~~ class members ~~~~
	dut_model_env m_env;

	// ~~~~ methods ~~~~
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	// ~~~~ phases ~~~~
	
	// ~~ Build (first) Phase ~~
	// Note : instantiate (and overwrite) our env using factory method 'create' ~~
	// Note : its recommended to use factory methods to overwrite phases
	function void build_phase(uvm_phase phase);
		m_env = dut_model_env::type_id::create("m_env", this);
	endfunction

	// ~~ Run Phase (second) ~~
	// Note : uses `task` over `function` because run phase consumes time 
	task run_phase(uvm_phase phase);

		// ~ let tb know we're starting test ~
		phase.raise_objection(this);

		// ~ testing ~
		#10; 
		`uvm_info("", "Hello World", UVM_MEDIUM)

		// ~ let tb know we're done testing ~
		phase.drop_objection(this);

	endtask

endclass : dut_model_test
