
`timescale 1 ns / 1 ps

	module AXIParallel4TapIIR_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 6,

		// Parameters of Axi Slave Bus Interface RF_IN
		parameter integer C_RF_IN_TDATA_WIDTH	= 32,

		// Parameters of Axi Master Bus Interface RF_OUT
		parameter  C_RF_OUT_START_DATA_VALUE	= 32'hAA000000,
		parameter  C_RF_OUT_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_RF_OUT_ADDR_WIDTH	= 32,
		parameter integer C_RF_OUT_DATA_WIDTH	= 32,
		parameter integer C_RF_OUT_TRANSACTIONS_NUM	= 4
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready,

		// Ports of Axi Slave Bus Interface RF_IN
		input wire  rf_in_aclk,
		input wire  rf_in_aresetn,
		output wire  rf_in_tready,
		input wire [C_RF_IN_TDATA_WIDTH-1 : 0] rf_in_tdata,
		input wire [(C_RF_IN_TDATA_WIDTH/8)-1 : 0] rf_in_tstrb,
		input wire  rf_in_tlast,
		input wire  rf_in_tvalid,

		// Ports of Axi Master Bus Interface RF_OUT
		input wire  rf_out_init_axi_txn,
		output wire  rf_out_error,
		output wire  rf_out_txn_done,
		input wire  rf_out_aclk,
		input wire  rf_out_aresetn,
		output wire [C_RF_OUT_ADDR_WIDTH-1 : 0] rf_out_awaddr,
		output wire [2 : 0] rf_out_awprot,
		output wire  rf_out_awvalid,
		input wire  rf_out_awready,
		output wire [C_RF_OUT_DATA_WIDTH-1 : 0] rf_out_wdata,
		output wire [C_RF_OUT_DATA_WIDTH/8-1 : 0] rf_out_wstrb,
		output wire  rf_out_wvalid,
		input wire  rf_out_wready,
		input wire [1 : 0] rf_out_bresp,
		input wire  rf_out_bvalid,
		output wire  rf_out_bready,
		output wire [C_RF_OUT_ADDR_WIDTH-1 : 0] rf_out_araddr,
		output wire [2 : 0] rf_out_arprot,
		output wire  rf_out_arvalid,
		input wire  rf_out_arready,
		input wire [C_RF_OUT_DATA_WIDTH-1 : 0] rf_out_rdata,
		input wire [1 : 0] rf_out_rresp,
		input wire  rf_out_rvalid,
		output wire  rf_out_rready
	);
// Instantiation of Axi Bus Interface S00_AXI
	AXIParallel4TapIIR_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) AXIParallel4TapIIR_v1_0_S00_AXI_inst (
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

// Instantiation of Axi Bus Interface RF_IN
	AXIParallel4TapIIR_v1_0_RF_IN # ( 
		.C_S_AXIS_TDATA_WIDTH(C_RF_IN_TDATA_WIDTH)
	) AXIParallel4TapIIR_v1_0_RF_IN_inst (
		.S_AXIS_ACLK(rf_in_aclk),
		.S_AXIS_ARESETN(rf_in_aresetn),
		.S_AXIS_TREADY(rf_in_tready),
		.S_AXIS_TDATA(rf_in_tdata),
		.S_AXIS_TSTRB(rf_in_tstrb),
		.S_AXIS_TLAST(rf_in_tlast),
		.S_AXIS_TVALID(rf_in_tvalid)
	);

// Instantiation of Axi Bus Interface RF_OUT
	AXIParallel4TapIIR_v1_0_RF_OUT # ( 
		.C_M_START_DATA_VALUE(C_RF_OUT_START_DATA_VALUE),
		.C_M_TARGET_SLAVE_BASE_ADDR(C_RF_OUT_TARGET_SLAVE_BASE_ADDR),
		.C_M_AXI_ADDR_WIDTH(C_RF_OUT_ADDR_WIDTH),
		.C_M_AXI_DATA_WIDTH(C_RF_OUT_DATA_WIDTH),
		.C_M_TRANSACTIONS_NUM(C_RF_OUT_TRANSACTIONS_NUM)
	) AXIParallel4TapIIR_v1_0_RF_OUT_inst (
		.INIT_AXI_TXN(rf_out_init_axi_txn),
		.ERROR(rf_out_error),
		.TXN_DONE(rf_out_txn_done),
		.M_AXI_ACLK(rf_out_aclk),
		.M_AXI_ARESETN(rf_out_aresetn),
		.M_AXI_AWADDR(rf_out_awaddr),
		.M_AXI_AWPROT(rf_out_awprot),
		.M_AXI_AWVALID(rf_out_awvalid),
		.M_AXI_AWREADY(rf_out_awready),
		.M_AXI_WDATA(rf_out_wdata),
		.M_AXI_WSTRB(rf_out_wstrb),
		.M_AXI_WVALID(rf_out_wvalid),
		.M_AXI_WREADY(rf_out_wready),
		.M_AXI_BRESP(rf_out_bresp),
		.M_AXI_BVALID(rf_out_bvalid),
		.M_AXI_BREADY(rf_out_bready),
		.M_AXI_ARADDR(rf_out_araddr),
		.M_AXI_ARPROT(rf_out_arprot),
		.M_AXI_ARVALID(rf_out_arvalid),
		.M_AXI_ARREADY(rf_out_arready),
		.M_AXI_RDATA(rf_out_rdata),
		.M_AXI_RRESP(rf_out_rresp),
		.M_AXI_RVALID(rf_out_rvalid),
		.M_AXI_RREADY(rf_out_rready)
	);

	// Add user logic here

	// User logic ends

	endmodule
