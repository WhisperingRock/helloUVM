class dut_driver extends uvm_driver;

	// ~ register dut_driver for factory automation ~
	`uvm_component_utils(dut_driver)

	// ~ virtual interface ~
	virtual dut_if dut_vi;

	// ~ boilerplate for constructor ~
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	// ~ build-phase constructs ~
	function void build_phase(uvm_phase phase);

		// try to retrieve (get) the virtual interface from the configuration database
		//                     ~ type ~       ~ caller | path |  name   | value ~
		if(!uvm_config_db #(virtual dut_if)::get(this,    ""  , "dut_if", dut_vi))
			`uvm_error("", "uvm_config_db::get failed")
	endfunction

	// ~ run phase : wiggle them pins ~
	task run_phase(uvm_phase phase);
		forever begin
			@(posedge dut_vi.clk) begin
				dut_vi.cmd		<= $urandom;
				dut_vi.addr 	<= $urandom;
				dut_vi.data 	<= $urandom;
			end
		end
	endtask

endclass

