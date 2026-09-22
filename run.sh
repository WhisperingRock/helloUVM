#!/usr/bin/env bash

# ~~~~ libraries (absolute path) ~~~~
UVM_HOME="/home/whirck/1800.2-2017-1.0/src"
VERILATOR_HOME="/home/whirck/Tools/Verilator/verilator/bin"

# ~~~~ local dir (relative path) ~~~~
SRC_DIR="00_rtl"
TEST_DIR="01_tb"
TOP_TB_MODULE="tbench_top"
UVM_TESTNAME="dut_model_test"

printf "\n\n| ~~~~~~~~ Verilator venv ~~~~~~~~~ |\n"
	python3 -m venv .venv
	source .venv/bin/activate

printf "\n\n| ~~~~~~~~~~~ build sim ~~~~~~~~~~~ |\n"
	verilator -Wno-fatal --binary -j $(nproc) \
		--top-module $TOP_TB_MODULE	\
		+incdir+$UVM_HOME 			\
		+incdir+$VERILATOR_HOME		\
		+incdir+$SRC_DIR			\
		+incdir+$TEST_DIR			\
	   	+define+UVM_NO_DPI 			\
		$UVM_HOME/uvm_pkg.sv 		\
		./$TEST_DIR/dut_pkg.sv		\
		./$TEST_DIR/tb.sv

printf "\n\n| ~~~~~~~~~~~ exec sim ~~~~~~~~~~~ |\n"
	./obj_dir/V$TOP_TB_MODULE +$UVM_TESTNAME
