#!/usr/bin/env bash

# ~~~~ libraries (absolute path) ~~~~
UVM_HOME="/home/whirck/1800.2-2017-1.0/src"
VERILATOR_HOME="/home/whirck/Tools/Verilator/verilator/bin"

# ~~~~ local dir (relative path) ~~~~
SRC_DIR="00_rtl"
TEST_DIR="01_tb"
TOP_TB_MODULE="tbench_top"
UVM_TESTNAME="dut_model_test"
WAVEFILE="testwave.vcd"

printf "\n\n| ~~~~~~~~ Verilator venv ~~~~~~~~~ |\n"
	python3 -m venv .venv
	source .venv/bin/activate

printf "\n\n| ~~~~~~~~~~~ Testing ~~~~~~~~~~~ |\n"
	make test UVM_HOME=$UVM_HOME SEED=42

printf "\n\n| ~~~~~~~~~~~ linting ~~~~~~~~~~~ |\n"
	make lint UVM_HOME=$UVM_HOME
	
printf "\n\n| ~~~~~~~~~~~ waveform ~~~~~~~~~~~ |\n"
	gtkwave $WAVEFILE

printf "\n\n| ~~~~~~~~~~~ clean up and exit~~~~~~~~~~~ |\n"
	make clean
	#rm $WAVEFILE
