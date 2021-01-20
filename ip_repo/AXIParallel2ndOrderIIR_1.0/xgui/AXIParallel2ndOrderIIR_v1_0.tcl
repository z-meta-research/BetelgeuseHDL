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

  ipgui::add_param $IPINST -name "INIT_A0"
  ipgui::add_param $IPINST -name "INIT_A1"
  ipgui::add_param $IPINST -name "INIT_A2"
  ipgui::add_param $IPINST -name "INIT_A3"
  ipgui::add_param $IPINST -name "INIT_A4"
  ipgui::add_param $IPINST -name "INIT_A5"
  ipgui::add_param $IPINST -name "INIT_A6"
  ipgui::add_param $IPINST -name "INIT_A7"
  ipgui::add_param $IPINST -name "INIT_A8"
  ipgui::add_param $IPINST -name "INIT_A9"
  ipgui::add_param $IPINST -name "INIT_A10"
  ipgui::add_param $IPINST -name "INIT_A11"
  ipgui::add_param $IPINST -name "INIT_A12"
  ipgui::add_param $IPINST -name "INIT_A13"
  ipgui::add_param $IPINST -name "INIT_A14"
  ipgui::add_param $IPINST -name "INIT_A15"
  ipgui::add_param $IPINST -name "INIT_A16"
  ipgui::add_param $IPINST -name "INIT_A17"
  ipgui::add_param $IPINST -name "INIT_A18"
  ipgui::add_param $IPINST -name "INIT_A19"
  ipgui::add_param $IPINST -name "INIT_A20"
  ipgui::add_param $IPINST -name "INIT_A21"
  ipgui::add_param $IPINST -name "INIT_A22"
  ipgui::add_param $IPINST -name "INIT_A23"
  ipgui::add_param $IPINST -name "INIT_A24"
  ipgui::add_param $IPINST -name "INIT_A25"
  ipgui::add_param $IPINST -name "INIT_A26"
  ipgui::add_param $IPINST -name "INIT_A27"
  ipgui::add_param $IPINST -name "INIT_A28"
  ipgui::add_param $IPINST -name "INIT_A29"
  ipgui::add_param $IPINST -name "INIT_A30"
  ipgui::add_param $IPINST -name "INIT_A31"
  ipgui::add_param $IPINST -name "INIT_A32"
  ipgui::add_param $IPINST -name "INIT_B0"
  ipgui::add_param $IPINST -name "INIT_B1"

}

proc update_PARAM_VALUE.C_AXIS_TDATA_WIDTH { PARAM_VALUE.C_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_AXIS_TDATA_WIDTH { PARAM_VALUE.C_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.INIT_A0 { PARAM_VALUE.INIT_A0 } {
	# Procedure called to update INIT_A0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A0 { PARAM_VALUE.INIT_A0 } {
	# Procedure called to validate INIT_A0
	return true
}

proc update_PARAM_VALUE.INIT_A1 { PARAM_VALUE.INIT_A1 } {
	# Procedure called to update INIT_A1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A1 { PARAM_VALUE.INIT_A1 } {
	# Procedure called to validate INIT_A1
	return true
}

proc update_PARAM_VALUE.INIT_A10 { PARAM_VALUE.INIT_A10 } {
	# Procedure called to update INIT_A10 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A10 { PARAM_VALUE.INIT_A10 } {
	# Procedure called to validate INIT_A10
	return true
}

proc update_PARAM_VALUE.INIT_A11 { PARAM_VALUE.INIT_A11 } {
	# Procedure called to update INIT_A11 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A11 { PARAM_VALUE.INIT_A11 } {
	# Procedure called to validate INIT_A11
	return true
}

proc update_PARAM_VALUE.INIT_A12 { PARAM_VALUE.INIT_A12 } {
	# Procedure called to update INIT_A12 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A12 { PARAM_VALUE.INIT_A12 } {
	# Procedure called to validate INIT_A12
	return true
}

proc update_PARAM_VALUE.INIT_A13 { PARAM_VALUE.INIT_A13 } {
	# Procedure called to update INIT_A13 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A13 { PARAM_VALUE.INIT_A13 } {
	# Procedure called to validate INIT_A13
	return true
}

proc update_PARAM_VALUE.INIT_A14 { PARAM_VALUE.INIT_A14 } {
	# Procedure called to update INIT_A14 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A14 { PARAM_VALUE.INIT_A14 } {
	# Procedure called to validate INIT_A14
	return true
}

proc update_PARAM_VALUE.INIT_A15 { PARAM_VALUE.INIT_A15 } {
	# Procedure called to update INIT_A15 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A15 { PARAM_VALUE.INIT_A15 } {
	# Procedure called to validate INIT_A15
	return true
}

proc update_PARAM_VALUE.INIT_A16 { PARAM_VALUE.INIT_A16 } {
	# Procedure called to update INIT_A16 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A16 { PARAM_VALUE.INIT_A16 } {
	# Procedure called to validate INIT_A16
	return true
}

proc update_PARAM_VALUE.INIT_A17 { PARAM_VALUE.INIT_A17 } {
	# Procedure called to update INIT_A17 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A17 { PARAM_VALUE.INIT_A17 } {
	# Procedure called to validate INIT_A17
	return true
}

proc update_PARAM_VALUE.INIT_A18 { PARAM_VALUE.INIT_A18 } {
	# Procedure called to update INIT_A18 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A18 { PARAM_VALUE.INIT_A18 } {
	# Procedure called to validate INIT_A18
	return true
}

proc update_PARAM_VALUE.INIT_A19 { PARAM_VALUE.INIT_A19 } {
	# Procedure called to update INIT_A19 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A19 { PARAM_VALUE.INIT_A19 } {
	# Procedure called to validate INIT_A19
	return true
}

proc update_PARAM_VALUE.INIT_A2 { PARAM_VALUE.INIT_A2 } {
	# Procedure called to update INIT_A2 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A2 { PARAM_VALUE.INIT_A2 } {
	# Procedure called to validate INIT_A2
	return true
}

proc update_PARAM_VALUE.INIT_A20 { PARAM_VALUE.INIT_A20 } {
	# Procedure called to update INIT_A20 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A20 { PARAM_VALUE.INIT_A20 } {
	# Procedure called to validate INIT_A20
	return true
}

proc update_PARAM_VALUE.INIT_A21 { PARAM_VALUE.INIT_A21 } {
	# Procedure called to update INIT_A21 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A21 { PARAM_VALUE.INIT_A21 } {
	# Procedure called to validate INIT_A21
	return true
}

proc update_PARAM_VALUE.INIT_A22 { PARAM_VALUE.INIT_A22 } {
	# Procedure called to update INIT_A22 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A22 { PARAM_VALUE.INIT_A22 } {
	# Procedure called to validate INIT_A22
	return true
}

proc update_PARAM_VALUE.INIT_A23 { PARAM_VALUE.INIT_A23 } {
	# Procedure called to update INIT_A23 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A23 { PARAM_VALUE.INIT_A23 } {
	# Procedure called to validate INIT_A23
	return true
}

proc update_PARAM_VALUE.INIT_A24 { PARAM_VALUE.INIT_A24 } {
	# Procedure called to update INIT_A24 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A24 { PARAM_VALUE.INIT_A24 } {
	# Procedure called to validate INIT_A24
	return true
}

proc update_PARAM_VALUE.INIT_A25 { PARAM_VALUE.INIT_A25 } {
	# Procedure called to update INIT_A25 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A25 { PARAM_VALUE.INIT_A25 } {
	# Procedure called to validate INIT_A25
	return true
}

proc update_PARAM_VALUE.INIT_A26 { PARAM_VALUE.INIT_A26 } {
	# Procedure called to update INIT_A26 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A26 { PARAM_VALUE.INIT_A26 } {
	# Procedure called to validate INIT_A26
	return true
}

proc update_PARAM_VALUE.INIT_A27 { PARAM_VALUE.INIT_A27 } {
	# Procedure called to update INIT_A27 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A27 { PARAM_VALUE.INIT_A27 } {
	# Procedure called to validate INIT_A27
	return true
}

proc update_PARAM_VALUE.INIT_A28 { PARAM_VALUE.INIT_A28 } {
	# Procedure called to update INIT_A28 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A28 { PARAM_VALUE.INIT_A28 } {
	# Procedure called to validate INIT_A28
	return true
}

proc update_PARAM_VALUE.INIT_A29 { PARAM_VALUE.INIT_A29 } {
	# Procedure called to update INIT_A29 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A29 { PARAM_VALUE.INIT_A29 } {
	# Procedure called to validate INIT_A29
	return true
}

proc update_PARAM_VALUE.INIT_A3 { PARAM_VALUE.INIT_A3 } {
	# Procedure called to update INIT_A3 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A3 { PARAM_VALUE.INIT_A3 } {
	# Procedure called to validate INIT_A3
	return true
}

proc update_PARAM_VALUE.INIT_A30 { PARAM_VALUE.INIT_A30 } {
	# Procedure called to update INIT_A30 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A30 { PARAM_VALUE.INIT_A30 } {
	# Procedure called to validate INIT_A30
	return true
}

proc update_PARAM_VALUE.INIT_A31 { PARAM_VALUE.INIT_A31 } {
	# Procedure called to update INIT_A31 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A31 { PARAM_VALUE.INIT_A31 } {
	# Procedure called to validate INIT_A31
	return true
}

proc update_PARAM_VALUE.INIT_A32 { PARAM_VALUE.INIT_A32 } {
	# Procedure called to update INIT_A32 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A32 { PARAM_VALUE.INIT_A32 } {
	# Procedure called to validate INIT_A32
	return true
}

proc update_PARAM_VALUE.INIT_A4 { PARAM_VALUE.INIT_A4 } {
	# Procedure called to update INIT_A4 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A4 { PARAM_VALUE.INIT_A4 } {
	# Procedure called to validate INIT_A4
	return true
}

proc update_PARAM_VALUE.INIT_A5 { PARAM_VALUE.INIT_A5 } {
	# Procedure called to update INIT_A5 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A5 { PARAM_VALUE.INIT_A5 } {
	# Procedure called to validate INIT_A5
	return true
}

proc update_PARAM_VALUE.INIT_A6 { PARAM_VALUE.INIT_A6 } {
	# Procedure called to update INIT_A6 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A6 { PARAM_VALUE.INIT_A6 } {
	# Procedure called to validate INIT_A6
	return true
}

proc update_PARAM_VALUE.INIT_A7 { PARAM_VALUE.INIT_A7 } {
	# Procedure called to update INIT_A7 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A7 { PARAM_VALUE.INIT_A7 } {
	# Procedure called to validate INIT_A7
	return true
}

proc update_PARAM_VALUE.INIT_A8 { PARAM_VALUE.INIT_A8 } {
	# Procedure called to update INIT_A8 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A8 { PARAM_VALUE.INIT_A8 } {
	# Procedure called to validate INIT_A8
	return true
}

proc update_PARAM_VALUE.INIT_A9 { PARAM_VALUE.INIT_A9 } {
	# Procedure called to update INIT_A9 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_A9 { PARAM_VALUE.INIT_A9 } {
	# Procedure called to validate INIT_A9
	return true
}

proc update_PARAM_VALUE.INIT_B0 { PARAM_VALUE.INIT_B0 } {
	# Procedure called to update INIT_B0 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_B0 { PARAM_VALUE.INIT_B0 } {
	# Procedure called to validate INIT_B0
	return true
}

proc update_PARAM_VALUE.INIT_B1 { PARAM_VALUE.INIT_B1 } {
	# Procedure called to update INIT_B1 when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.INIT_B1 { PARAM_VALUE.INIT_B1 } {
	# Procedure called to validate INIT_B1
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


proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH PARAM_VALUE.C_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.INIT_A0 { MODELPARAM_VALUE.INIT_A0 PARAM_VALUE.INIT_A0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A0}] ${MODELPARAM_VALUE.INIT_A0}
}

proc update_MODELPARAM_VALUE.INIT_A1 { MODELPARAM_VALUE.INIT_A1 PARAM_VALUE.INIT_A1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A1}] ${MODELPARAM_VALUE.INIT_A1}
}

proc update_MODELPARAM_VALUE.INIT_A2 { MODELPARAM_VALUE.INIT_A2 PARAM_VALUE.INIT_A2 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A2}] ${MODELPARAM_VALUE.INIT_A2}
}

proc update_MODELPARAM_VALUE.INIT_A3 { MODELPARAM_VALUE.INIT_A3 PARAM_VALUE.INIT_A3 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A3}] ${MODELPARAM_VALUE.INIT_A3}
}

proc update_MODELPARAM_VALUE.INIT_A4 { MODELPARAM_VALUE.INIT_A4 PARAM_VALUE.INIT_A4 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A4}] ${MODELPARAM_VALUE.INIT_A4}
}

proc update_MODELPARAM_VALUE.INIT_A5 { MODELPARAM_VALUE.INIT_A5 PARAM_VALUE.INIT_A5 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A5}] ${MODELPARAM_VALUE.INIT_A5}
}

proc update_MODELPARAM_VALUE.INIT_A6 { MODELPARAM_VALUE.INIT_A6 PARAM_VALUE.INIT_A6 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A6}] ${MODELPARAM_VALUE.INIT_A6}
}

proc update_MODELPARAM_VALUE.INIT_A7 { MODELPARAM_VALUE.INIT_A7 PARAM_VALUE.INIT_A7 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A7}] ${MODELPARAM_VALUE.INIT_A7}
}

proc update_MODELPARAM_VALUE.INIT_A8 { MODELPARAM_VALUE.INIT_A8 PARAM_VALUE.INIT_A8 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A8}] ${MODELPARAM_VALUE.INIT_A8}
}

proc update_MODELPARAM_VALUE.INIT_A9 { MODELPARAM_VALUE.INIT_A9 PARAM_VALUE.INIT_A9 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A9}] ${MODELPARAM_VALUE.INIT_A9}
}

proc update_MODELPARAM_VALUE.INIT_A10 { MODELPARAM_VALUE.INIT_A10 PARAM_VALUE.INIT_A10 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A10}] ${MODELPARAM_VALUE.INIT_A10}
}

proc update_MODELPARAM_VALUE.INIT_A11 { MODELPARAM_VALUE.INIT_A11 PARAM_VALUE.INIT_A11 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A11}] ${MODELPARAM_VALUE.INIT_A11}
}

proc update_MODELPARAM_VALUE.INIT_A12 { MODELPARAM_VALUE.INIT_A12 PARAM_VALUE.INIT_A12 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A12}] ${MODELPARAM_VALUE.INIT_A12}
}

proc update_MODELPARAM_VALUE.INIT_A13 { MODELPARAM_VALUE.INIT_A13 PARAM_VALUE.INIT_A13 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A13}] ${MODELPARAM_VALUE.INIT_A13}
}

proc update_MODELPARAM_VALUE.INIT_A14 { MODELPARAM_VALUE.INIT_A14 PARAM_VALUE.INIT_A14 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A14}] ${MODELPARAM_VALUE.INIT_A14}
}

proc update_MODELPARAM_VALUE.INIT_A15 { MODELPARAM_VALUE.INIT_A15 PARAM_VALUE.INIT_A15 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A15}] ${MODELPARAM_VALUE.INIT_A15}
}

proc update_MODELPARAM_VALUE.INIT_A16 { MODELPARAM_VALUE.INIT_A16 PARAM_VALUE.INIT_A16 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A16}] ${MODELPARAM_VALUE.INIT_A16}
}

proc update_MODELPARAM_VALUE.INIT_A17 { MODELPARAM_VALUE.INIT_A17 PARAM_VALUE.INIT_A17 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A17}] ${MODELPARAM_VALUE.INIT_A17}
}

proc update_MODELPARAM_VALUE.INIT_A18 { MODELPARAM_VALUE.INIT_A18 PARAM_VALUE.INIT_A18 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A18}] ${MODELPARAM_VALUE.INIT_A18}
}

proc update_MODELPARAM_VALUE.INIT_A19 { MODELPARAM_VALUE.INIT_A19 PARAM_VALUE.INIT_A19 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A19}] ${MODELPARAM_VALUE.INIT_A19}
}

proc update_MODELPARAM_VALUE.INIT_A20 { MODELPARAM_VALUE.INIT_A20 PARAM_VALUE.INIT_A20 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A20}] ${MODELPARAM_VALUE.INIT_A20}
}

proc update_MODELPARAM_VALUE.INIT_A21 { MODELPARAM_VALUE.INIT_A21 PARAM_VALUE.INIT_A21 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A21}] ${MODELPARAM_VALUE.INIT_A21}
}

proc update_MODELPARAM_VALUE.INIT_A22 { MODELPARAM_VALUE.INIT_A22 PARAM_VALUE.INIT_A22 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A22}] ${MODELPARAM_VALUE.INIT_A22}
}

proc update_MODELPARAM_VALUE.INIT_A23 { MODELPARAM_VALUE.INIT_A23 PARAM_VALUE.INIT_A23 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A23}] ${MODELPARAM_VALUE.INIT_A23}
}

proc update_MODELPARAM_VALUE.INIT_A24 { MODELPARAM_VALUE.INIT_A24 PARAM_VALUE.INIT_A24 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A24}] ${MODELPARAM_VALUE.INIT_A24}
}

proc update_MODELPARAM_VALUE.INIT_A25 { MODELPARAM_VALUE.INIT_A25 PARAM_VALUE.INIT_A25 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A25}] ${MODELPARAM_VALUE.INIT_A25}
}

proc update_MODELPARAM_VALUE.INIT_A26 { MODELPARAM_VALUE.INIT_A26 PARAM_VALUE.INIT_A26 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A26}] ${MODELPARAM_VALUE.INIT_A26}
}

proc update_MODELPARAM_VALUE.INIT_A27 { MODELPARAM_VALUE.INIT_A27 PARAM_VALUE.INIT_A27 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A27}] ${MODELPARAM_VALUE.INIT_A27}
}

proc update_MODELPARAM_VALUE.INIT_A28 { MODELPARAM_VALUE.INIT_A28 PARAM_VALUE.INIT_A28 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A28}] ${MODELPARAM_VALUE.INIT_A28}
}

proc update_MODELPARAM_VALUE.INIT_A29 { MODELPARAM_VALUE.INIT_A29 PARAM_VALUE.INIT_A29 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A29}] ${MODELPARAM_VALUE.INIT_A29}
}

proc update_MODELPARAM_VALUE.INIT_A30 { MODELPARAM_VALUE.INIT_A30 PARAM_VALUE.INIT_A30 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A30}] ${MODELPARAM_VALUE.INIT_A30}
}

proc update_MODELPARAM_VALUE.INIT_A31 { MODELPARAM_VALUE.INIT_A31 PARAM_VALUE.INIT_A31 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A31}] ${MODELPARAM_VALUE.INIT_A31}
}

proc update_MODELPARAM_VALUE.INIT_A32 { MODELPARAM_VALUE.INIT_A32 PARAM_VALUE.INIT_A32 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_A32}] ${MODELPARAM_VALUE.INIT_A32}
}

proc update_MODELPARAM_VALUE.INIT_B0 { MODELPARAM_VALUE.INIT_B0 PARAM_VALUE.INIT_B0 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_B0}] ${MODELPARAM_VALUE.INIT_B0}
}

proc update_MODELPARAM_VALUE.INIT_B1 { MODELPARAM_VALUE.INIT_B1 PARAM_VALUE.INIT_B1 } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.INIT_B1}] ${MODELPARAM_VALUE.INIT_B1}
}

