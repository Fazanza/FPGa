.PHONY: all sim synth clean

SHELL := /bin/bash -o pipefail

# Change this one line
var ?= dcache

DUT ?= $(var).sv
SYNTH_TIMEOUT ?= 60
XILINX_CELLS_URL ?= https://github.com/Xilinx/XilinxUnisimLibrary.git
XILINX_CELLS_DIR ?= XilinxUnisimLibrary/verilog/src
IVERILOG ?= /opt/homebrew/bin/iverilog
YOSYS ?= /opt/homebrew/bin/yosys

all: sim synth gatesim

sim: $(var)-sim
	./$< +VCDFILE=sim.vcd +VCDLEVEL=0 | tee sim.log

$(var)-sim: $(var)_tb.sv ${DUT} | ${XILINX_CELLS_DIR}
	${IVERILOG} -g2005-sv -s $(var)_tb -y ${XILINX_CELLS_DIR} -o $@ $^

synth: $(var).netlist.v

$(var).netlist.v: ${DUT}
	${YOSYS} -p 'synth_xilinx -top $(var)' -p stat $< -L synth.log -o $@

${XILINX_CELLS_DIR}:
	git clone ${XILINX_CELLS_URL}

gatesim: ./$(var)-gatesim
	./$< +VCDFILE=gatesim.vcd +VCDLEVEL=1 | tee gatesim.log

$(var)-gatesim: $(var)_tb.sv $(var).netlist.v | ${XILINX_CELLS_DIR}
	${IVERILOG} -g2005-sv -s $(var)_tb -DGATESIM -y ${XILINX_CELLS_DIR} -y ${XILINX_CELLS_DIR}/unisims -o $@ $^

clean:
	$(RM) $(var)-sim sim.log sim.vcd
	$(RM) $(var)-gatesim gatesim.log gatesim.vcd
	$(RM) $(var).netlist.v synth.log
	$(RM) -r XilinxUnisimLibrary
