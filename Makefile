#
# Makefile for Cards Against Humanity Hand Generator
# 
# Author: Scott Lawson (C) 2016
#

SRC_DIR ?= src

COMPILE_CMD = vlog
#COMPILE_FLAGS = -mfcu 

SIMULATE_CMD = vsim
SIMULATE_FLAGS = -c  -do "run -all" -sv_seed random

LOG ?= cah.log

SRC_FILES = $(SRC_DIR)/cah.sv

SIM_MODULES = CAH

compile:

	$(COMPILE_CMD) $(COMPILE_FLAGS) $(SRC_FILES) | tee -a $(LOG)

sim:
	$(SIMULATE_CMD) $(SIMULATE_FLAGS) $(SIM_MODULES) | tee -a $(LOG)

all:
	$(MAKE) clean 
	$(MAKE) compile | tee -a $(LOG)
	$(MAKE) sim | tee -a $(LOG)

clean:
	rm -rf work transcript vish_stacktrace.vstf $(LOG)

