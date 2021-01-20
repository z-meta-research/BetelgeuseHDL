create_pblock pblock_adc_conversion
add_cells_to_pblock [get_pblocks pblock_adc_conversion] [get_cells -quiet [list ChannelSimulator_i/Channel1/axis_clock_converter_0 ChannelSimulator_i/Channel1/axis_dwidth_converter_0 ChannelSimulator_i/clk_wiz_0/inst/clkout1_buf ChannelSimulator_i/clk_wiz_0/inst/plle4_adv_inst ChannelSimulator_i/proc_sys_reset_0]]
resize_pblock [get_pblocks pblock_adc_conversion] -add {SLICE_X81Y0:SLICE_X118Y57}
resize_pblock [get_pblocks pblock_adc_conversion] -add {DSP48E2_X15Y0:DSP48E2_X22Y21}
resize_pblock [get_pblocks pblock_adc_conversion] -add {RAMB18_X8Y0:RAMB18_X11Y21}
resize_pblock [get_pblocks pblock_adc_conversion] -add {RAMB36_X8Y0:RAMB36_X11Y10}

create_pblock pblock_DAC_229
add_cells_to_pblock [get_pblocks pblock_DAC_229] [get_cells -quiet [list ChannelSimulator_i/proc_sys_reset_1]]
resize_pblock [get_pblocks pblock_DAC_229] -add {CLOCKREGION_X2Y5:CLOCKREGION_X5Y5}

create_pblock pblock_delay_line
resize_pblock [get_pblocks pblock_delay_line] -add {CLOCKREGION_X0Y5:CLOCKREGION_X0Y5}

create_pblock pblock_IIR1
resize_pblock [get_pblocks pblock_IIR1] -add {SLICE_X50Y180:SLICE_X80Y239}
resize_pblock [get_pblocks pblock_IIR1] -add {DSP48E2_X9Y72:DSP48E2_X14Y95}
resize_pblock [get_pblocks pblock_IIR1] -add {RAMB18_X5Y72:RAMB18_X7Y95}
resize_pblock [get_pblocks pblock_IIR1] -add {RAMB36_X5Y36:RAMB36_X7Y47}
create_pblock pblock_chan1_DigitalDelayLine_1
create_pblock pblock_chan1_post_IIR
add_cells_to_pblock [get_pblocks pblock_chan1_post_IIR] [get_cells -quiet [list ChannelSimulator_i/Channel1/AXIRandomStream_0 ChannelSimulator_i/Channel1/AXIReflection_0 ChannelSimulator_i/Channel1/RFStreamAdder_1]]
resize_pblock [get_pblocks pblock_chan1_post_IIR] -add {CLOCKREGION_X1Y4:CLOCKREGION_X3Y4}

create_pblock pblock_pre_iir
add_cells_to_pblock [get_pblocks pblock_pre_iir] [get_cells -quiet [list ChannelSimulator_i/Channel1/AXIRFGainBlock_0 ChannelSimulator_i/Channel1/GainEqualizer ChannelSimulator_i/Channel1/axis_register_slice_0]]
resize_pblock [get_pblocks pblock_pre_iir] -add {CLOCKREGION_X3Y1:CLOCKREGION_X3Y2}


create_pblock IIR_stage2
resize_pblock [get_pblocks IIR_stage2] -add {SLICE_X38Y180:SLICE_X49Y239}
resize_pblock [get_pblocks IIR_stage2] -add {DSP48E2_X7Y72:DSP48E2_X8Y95}
resize_pblock [get_pblocks IIR_stage2] -add {RAMB18_X4Y72:RAMB18_X4Y95}
resize_pblock [get_pblocks IIR_stage2] -add {RAMB36_X4Y36:RAMB36_X4Y47}



