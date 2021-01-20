# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set C_AXI_DATA_OUT_START_COUNT [ipgui::add_param $IPINST -name "C_AXI_DATA_OUT_START_COUNT" -parent ${Page_0}]
  set_property tooltip {Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.} ${C_AXI_DATA_OUT_START_COUNT}

  set C_AXI_STREAM_TDATA_WIDTH [ipgui::add_param $IPINST -name "C_AXI_STREAM_TDATA_WIDTH" -widget comboBox]
  set_property tooltip {TDATA Width} ${C_AXI_STREAM_TDATA_WIDTH}
  ipgui::add_param $IPINST -name "USE_URAM" -widget comboBox

}

proc update_PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH { PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH } {
	# Procedure called to update C_AXI_STREAM_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH { PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH } {
	# Procedure called to validate C_AXI_STREAM_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.INITIAL_DELAY { PARAM_VALUE.INITIAL_DELAY } {
	# Procedure called to update INITIAL_DELAY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INITIAL_DELAY { PARAM_VALUE.INITIAL_DELAY } {
	# Procedure called to validate INITIAL_DELAY
	return true
}

proc update_PARAM_VALUE.USE_URAM { PARAM_VALUE.USE_URAM } {
	# Procedure called to update USE_URAM when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.USE_URAM { PARAM_VALUE.USE_URAM } {
	# Procedure called to validate USE_URAM
	return true
}

proc update_PARAM_VALUE.C_AXI_DATA_OUT_START_COUNT { PARAM_VALUE.C_AXI_DATA_OUT_START_COUNT } {
	# Procedure called to update C_AXI_DATA_OUT_START_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_AXI_DATA_OUT_START_COUNT { PARAM_VALUE.C_AXI_DATA_OUT_START_COUNT } {
	# Procedure called to validate C_AXI_DATA_OUT_START_COUNT
	return true
}


proc update_MODELPARAM_VALUE.C_AXI_DATA_OUT_START_COUNT { MODELPARAM_VALUE.C_AXI_DATA_OUT_START_COUNT PARAM_VALUE.C_AXI_DATA_OUT_START_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXI_DATA_OUT_START_COUNT}] ${MODELPARAM_VALUE.C_AXI_DATA_OUT_START_COUNT}
}

proc update_MODELPARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH { MODELPARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.USE_URAM { MODELPARAM_VALUE.USE_URAM PARAM_VALUE.USE_URAM } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.USE_URAM}] ${MODELPARAM_VALUE.USE_URAM}
}

proc update_MODELPARAM_VALUE.INITIAL_DELAY { MODELPARAM_VALUE.INITIAL_DELAY PARAM_VALUE.INITIAL_DELAY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INITIAL_DELAY}] ${MODELPARAM_VALUE.INITIAL_DELAY}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

