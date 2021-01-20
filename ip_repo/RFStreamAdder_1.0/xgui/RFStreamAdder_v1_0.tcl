# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  set C_S00_AXI_DATA_WIDTH [ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0} -widget comboBox]
  set_property tooltip {Width of S_AXI data bus} ${C_S00_AXI_DATA_WIDTH}
  set C_S00_AXI_ADDR_WIDTH [ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}]
  set_property tooltip {Width of S_AXI address bus} ${C_S00_AXI_ADDR_WIDTH}
  ipgui::add_param $IPINST -name "C_S00_AXI_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S00_AXI_HIGHADDR" -parent ${Page_0}
  set C_AXI_RF_OUT_START_COUNT [ipgui::add_param $IPINST -name "C_AXI_RF_OUT_START_COUNT" -parent ${Page_0}]
  set_property tooltip {Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.} ${C_AXI_RF_OUT_START_COUNT}

  ipgui::add_param $IPINST -name "C_AXI_STREAM_TDATA_WIDTH" -widget comboBox
  ipgui::add_param $IPINST -name "N_SUB_STREAMS"
  ipgui::add_param $IPINST -name "INITIAL_SCALE0"
  ipgui::add_param $IPINST -name "INITIAL_SCALE1"
  ipgui::add_param $IPINST -name "INITIAL_SCALE2"
  ipgui::add_param $IPINST -name "INITIAL_SCALE3"
  ipgui::add_param $IPINST -name "INITIAL_BYPASS"

}

proc update_PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH { PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH } {
	# Procedure called to update C_AXI_STREAM_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH { PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH } {
	# Procedure called to validate C_AXI_STREAM_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.INITIAL_BYPASS { PARAM_VALUE.INITIAL_BYPASS } {
	# Procedure called to update INITIAL_BYPASS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INITIAL_BYPASS { PARAM_VALUE.INITIAL_BYPASS } {
	# Procedure called to validate INITIAL_BYPASS
	return true
}

proc update_PARAM_VALUE.INITIAL_SCALE0 { PARAM_VALUE.INITIAL_SCALE0 } {
	# Procedure called to update INITIAL_SCALE0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INITIAL_SCALE0 { PARAM_VALUE.INITIAL_SCALE0 } {
	# Procedure called to validate INITIAL_SCALE0
	return true
}

proc update_PARAM_VALUE.INITIAL_SCALE1 { PARAM_VALUE.INITIAL_SCALE1 } {
	# Procedure called to update INITIAL_SCALE1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INITIAL_SCALE1 { PARAM_VALUE.INITIAL_SCALE1 } {
	# Procedure called to validate INITIAL_SCALE1
	return true
}

proc update_PARAM_VALUE.INITIAL_SCALE2 { PARAM_VALUE.INITIAL_SCALE2 } {
	# Procedure called to update INITIAL_SCALE2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INITIAL_SCALE2 { PARAM_VALUE.INITIAL_SCALE2 } {
	# Procedure called to validate INITIAL_SCALE2
	return true
}

proc update_PARAM_VALUE.INITIAL_SCALE3 { PARAM_VALUE.INITIAL_SCALE3 } {
	# Procedure called to update INITIAL_SCALE3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INITIAL_SCALE3 { PARAM_VALUE.INITIAL_SCALE3 } {
	# Procedure called to validate INITIAL_SCALE3
	return true
}

proc update_PARAM_VALUE.N_SUB_STREAMS { PARAM_VALUE.N_SUB_STREAMS } {
	# Procedure called to update N_SUB_STREAMS when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.N_SUB_STREAMS { PARAM_VALUE.N_SUB_STREAMS } {
	# Procedure called to validate N_SUB_STREAMS
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to update C_S00_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to validate C_S00_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to update C_S00_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to validate C_S00_AXI_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_AXI_RF_OUT_START_COUNT { PARAM_VALUE.C_AXI_RF_OUT_START_COUNT } {
	# Procedure called to update C_AXI_RF_OUT_START_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_AXI_RF_OUT_START_COUNT { PARAM_VALUE.C_AXI_RF_OUT_START_COUNT } {
	# Procedure called to validate C_AXI_RF_OUT_START_COUNT
	return true
}


proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_AXI_RF_OUT_START_COUNT { MODELPARAM_VALUE.C_AXI_RF_OUT_START_COUNT PARAM_VALUE.C_AXI_RF_OUT_START_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXI_RF_OUT_START_COUNT}] ${MODELPARAM_VALUE.C_AXI_RF_OUT_START_COUNT}
}

proc update_MODELPARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH { MODELPARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_AXI_STREAM_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.N_SUB_STREAMS { MODELPARAM_VALUE.N_SUB_STREAMS PARAM_VALUE.N_SUB_STREAMS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.N_SUB_STREAMS}] ${MODELPARAM_VALUE.N_SUB_STREAMS}
}

proc update_MODELPARAM_VALUE.INITIAL_SCALE0 { MODELPARAM_VALUE.INITIAL_SCALE0 PARAM_VALUE.INITIAL_SCALE0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INITIAL_SCALE0}] ${MODELPARAM_VALUE.INITIAL_SCALE0}
}

proc update_MODELPARAM_VALUE.INITIAL_SCALE1 { MODELPARAM_VALUE.INITIAL_SCALE1 PARAM_VALUE.INITIAL_SCALE1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INITIAL_SCALE1}] ${MODELPARAM_VALUE.INITIAL_SCALE1}
}

proc update_MODELPARAM_VALUE.INITIAL_SCALE2 { MODELPARAM_VALUE.INITIAL_SCALE2 PARAM_VALUE.INITIAL_SCALE2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INITIAL_SCALE2}] ${MODELPARAM_VALUE.INITIAL_SCALE2}
}

proc update_MODELPARAM_VALUE.INITIAL_SCALE3 { MODELPARAM_VALUE.INITIAL_SCALE3 PARAM_VALUE.INITIAL_SCALE3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INITIAL_SCALE3}] ${MODELPARAM_VALUE.INITIAL_SCALE3}
}

proc update_MODELPARAM_VALUE.INITIAL_BYPASS { MODELPARAM_VALUE.INITIAL_BYPASS PARAM_VALUE.INITIAL_BYPASS } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INITIAL_BYPASS}] ${MODELPARAM_VALUE.INITIAL_BYPASS}
}

