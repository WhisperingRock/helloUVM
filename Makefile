SHELL := /usr/bin/env bash

# Note : `make test TEST=another_test SEED=42` for indiv tests
# Note : `make test UVM_HOME=/your/local/uvm/path/1800.2-2017-1.0/src` 

# Tools and paths can be overridden:
# make UVM_HOME=/opt/uvm test
VERILATOR ?= verilator
UVM_HOME ?= $(CURDIR)/../1800.2-2017-1.0/src

SRC_DIR  ?= 00_rtl
TEST_DIR ?= 01_tb

TOP_TB_MODULE ?= tbench_top
TEST           ?= dut_model_test
SEED           ?= 1

BUILD_DIR ?= obj_dir
JOBS      ?= $(shell nproc 2>/dev/null || sysctl -n hw.ncpu)

RTL_FILES := $(wildcard $(SRC_DIR)/*.sv)
TB_FILES  := $(wildcard $(TEST_DIR)/*.sv) #CEW : might want to include svh here

UVM_FILES := $(UVM_HOME)/uvm_pkg.sv

VERILATOR_FLAGS := \
	-Wno-fatal \
	--binary \
	-j $(JOBS) \
	--top-module $(TOP_TB_MODULE) \
	--Mdir $(BUILD_DIR) \
	+incdir+$(UVM_HOME) \
	+incdir+$(SRC_DIR) \
	+incdir+$(TEST_DIR) \
	+define+UVM_NO_DPI

SOURCES := \
	$(UVM_FILES) \
	$(RTL_FILES) \
	$(TB_FILES)

.PHONY: all compile test regression lint clean version

all: test

version:
	$(VERILATOR) --version

compile:
	$(VERILATOR) $(VERILATOR_FLAGS) $(SOURCES)

test: compile
	./$(BUILD_DIR)/V$(TOP_TB_MODULE) \
		+UVM_TESTNAME=$(TEST) \
		+ntb_random_seed=$(SEED)

regression:
	@for seed in 1 2 3 4 5; do \
		$(MAKE) test TEST=$(TEST) SEED=$$seed || exit $$?; \
	done

lint:
	$(VERILATOR) \
		--lint-only \
		-Wall \
		-wno-fatal \					# warning not fatal
		--top-module $(TOP_TB_MODULE) \
		+incdir+$(UVM_HOME) \
		+incdir+$(SRC_DIR) \
		+incdir+$(TEST_DIR) \
		$(SOURCES)

clean:
	rm -rf $(BUILD_DIR)
