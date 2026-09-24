/*
*
*
*
*/

module dut(dut_if dif);
	// ~~~~ imports ~~~~
	import uvm_pkg::*;

	// ~~~~ dummy implementation ~~~~
	always @(posedge dif.clk) begin
		`uvm_info(
			"",
			$sformatf("DUT received cmd=%b, addr=%d, data=%d",
				dif.cmd, dif.addr, dif.data),
			UVM_MEDIUM
		)
	end

endmodule
