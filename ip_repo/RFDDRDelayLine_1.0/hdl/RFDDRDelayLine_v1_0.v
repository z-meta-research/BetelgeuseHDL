
`timescale 1 ns / 1 ps

	module RFDDRDelayLine_v1_0 #
	(
		// Users to add parameters here
        parameter C_DDR_WINDOW_BASE = 32'h0000_0000,
        parameter C_DDR_WINDOW_SIZE = 32'h0080_0000,
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Master Bus Interface DDR_AXI
		parameter  C_DDR_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_DDR_AXI_BURST_LEN	= 16,
		parameter integer C_DDR_AXI_ID_WIDTH	= 1,
		parameter integer C_DDR_AXI_ADDR_WIDTH	= 32,
		parameter integer C_DDR_AXI_DATA_WIDTH	= 512,
		parameter integer C_DDR_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_DDR_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_DDR_AXI_WUSER_WIDTH	= 0,
		parameter integer C_DDR_AXI_RUSER_WIDTH	= 0,
		parameter integer C_DDR_AXI_BUSER_WIDTH	= 0,

		parameter integer C_AXIS_TDATA_WIDTH	= 256
	)
	(
		// Users to add ports here
        input wire ddr_ready,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Master Bus Interface DDR_AXI
		input wire  ddr_axi_aclk,
		input wire  ddr_axi_aresetn,
		output wire [C_DDR_AXI_ID_WIDTH-1 : 0] ddr_axi_awid,
		output wire [C_DDR_AXI_ADDR_WIDTH-1 : 0] ddr_axi_awaddr,
		output wire [7 : 0] ddr_axi_awlen,
		output wire [2 : 0] ddr_axi_awsize,
		output wire [1 : 0] ddr_axi_awburst,
		output wire  ddr_axi_awlock,
		output wire [3 : 0] ddr_axi_awcache,
		output wire [2 : 0] ddr_axi_awprot,
		output wire [3 : 0] ddr_axi_awqos,
		output wire [C_DDR_AXI_AWUSER_WIDTH-1 : 0] ddr_axi_awuser,
		output wire  ddr_axi_awvalid,
		input wire  ddr_axi_awready,
		output wire [C_DDR_AXI_DATA_WIDTH-1 : 0] ddr_axi_wdata,
		output wire [C_DDR_AXI_DATA_WIDTH/8-1 : 0] ddr_axi_wstrb,
		output wire  ddr_axi_wlast,
		output wire [C_DDR_AXI_WUSER_WIDTH-1 : 0] ddr_axi_wuser,
		output wire  ddr_axi_wvalid,
		input wire  ddr_axi_wready,
		input wire [C_DDR_AXI_ID_WIDTH-1 : 0] ddr_axi_bid,
		input wire [1 : 0] ddr_axi_bresp,
		input wire [C_DDR_AXI_BUSER_WIDTH-1 : 0] ddr_axi_buser,
		input wire  ddr_axi_bvalid,
		output wire  ddr_axi_bready,
		output wire [C_DDR_AXI_ID_WIDTH-1 : 0] ddr_axi_arid,
		output wire [C_DDR_AXI_ADDR_WIDTH-1 : 0] ddr_axi_araddr,
		output wire [7 : 0] ddr_axi_arlen,
		output wire [2 : 0] ddr_axi_arsize,
		output wire [1 : 0] ddr_axi_arburst,
		output wire  ddr_axi_arlock,
		output wire [3 : 0] ddr_axi_arcache,
		output wire [2 : 0] ddr_axi_arprot,
		output wire [3 : 0] ddr_axi_arqos,
		output wire [C_DDR_AXI_ARUSER_WIDTH-1 : 0] ddr_axi_aruser,
		output wire  ddr_axi_arvalid,
		input wire  ddr_axi_arready,
		input wire [C_DDR_AXI_ID_WIDTH-1 : 0] ddr_axi_rid,
		input wire [C_DDR_AXI_DATA_WIDTH-1 : 0] ddr_axi_rdata,
		input wire [1 : 0] ddr_axi_rresp,
		input wire  ddr_axi_rlast,
		input wire [C_DDR_AXI_RUSER_WIDTH-1 : 0] ddr_axi_ruser,
		input wire  ddr_axi_rvalid,
		output wire  ddr_axi_rready,

		// Ports of Axi Slave Bus Interface RF_IN
		input wire  axis_aclk,
		input wire  axis_aresetn,
		output wire  rf_in_tready,
		input wire [C_AXIS_TDATA_WIDTH-1 : 0] rf_in_tdata,
		input wire  rf_in_tvalid,

		// Ports of Axi Master Bus Interface RF_OUT
		output wire  rf_out_tvalid,
		output wire [C_AXIS_TDATA_WIDTH-1 : 0] rf_out_tdata,
		input wire  rf_out_tready
	);
	
    reg  ddr_axi_init_axi_txn;
    wire  ddr_axi_txn_done;
    wire  ddr_axi_error;
    wire ddr_axi_ready;

    wire din_valid;
    wire din_pempty;
    wire din_pfull;
    wire din_aximm_busy;
    wire din_axis_busy;
    wire din_wr_en;
    wire din_rd_en;
    wire [C_AXIS_TDATA_WIDTH-1:0] din_axis_data;
    wire [C_DDR_AXI_DATA_WIDTH-1:0] din_aximm_data;
    wire din_full;
    wire din_empty;
    
    wire dout_valid;
    wire dout_pempty;
    wire dout_aximm_busy;
    wire dout_axis_busy;
    wire dout_wr_en;
    wire dout_rd_en;
    wire [C_AXIS_TDATA_WIDTH-1:0] dout_axis_data;
    wire [C_DDR_AXI_DATA_WIDTH-1:0] dout_aximm_data;
    wire dout_full;
    wire dout_empty;    

	always @(posedge ddr_axi_aclk)
	begin
	   ddr_axi_init_axi_txn <= 0;
	end
	
// Instantiation of Axi Bus Interface DDR_AXI
	RFDDRDelayLine_v1_0_DDR_AXI # ( 
		.C_M_TARGET_SLAVE_BASE_ADDR(C_DDR_AXI_TARGET_SLAVE_BASE_ADDR),
		.C_M_AXI_BURST_LEN(C_DDR_AXI_BURST_LEN),
		.C_M_AXI_ID_WIDTH(C_DDR_AXI_ID_WIDTH),
		.C_M_AXI_ADDR_WIDTH(C_DDR_AXI_ADDR_WIDTH),
		.C_M_AXI_DATA_WIDTH(C_DDR_AXI_DATA_WIDTH),
		.C_M_AXI_AWUSER_WIDTH(C_DDR_AXI_AWUSER_WIDTH),
		.C_M_AXI_ARUSER_WIDTH(C_DDR_AXI_ARUSER_WIDTH),
		.C_M_AXI_WUSER_WIDTH(C_DDR_AXI_WUSER_WIDTH),
		.C_M_AXI_RUSER_WIDTH(C_DDR_AXI_RUSER_WIDTH),
		.C_M_AXI_BUSER_WIDTH(C_DDR_AXI_BUSER_WIDTH)
	) RFDDRDelayLine_v1_0_DDR_AXI_inst (
	    .ddr_ready(ddr_ready),
	    .rdy(ddr_axi_ready),

        .fifo_wr_en(din_wr_en),
        .fifo_wr_busy(din_aximm_busy),
        .fifo_wr_data(din_aximm_data),
        .fifo_wr_full(din_full),
        .fifo_wr_pfull(din_pfull),

        .fifo_rd_en(dout_rd_en),
        .fifo_rd_busy(dout_aximm_busy),
        .fifo_rd_data(dout_aximm_data),
        .fifo_rd_pempty(dout_pempty),
        .fifo_rd_empty(dout_empty),    
    

		.INIT_AXI_TXN(ddr_axi_init_axi_txn),
		.TXN_DONE(ddr_axi_txn_done),
		.ERROR(ddr_axi_error),
		.M_AXI_ACLK(ddr_axi_aclk),
		.M_AXI_ARESETN(ddr_axi_aresetn),
		.M_AXI_AWID(ddr_axi_awid),
		.M_AXI_AWADDR(ddr_axi_awaddr),
		.M_AXI_AWLEN(ddr_axi_awlen),
		.M_AXI_AWSIZE(ddr_axi_awsize),
		.M_AXI_AWBURST(ddr_axi_awburst),
		.M_AXI_AWLOCK(ddr_axi_awlock),
		.M_AXI_AWCACHE(ddr_axi_awcache),
		.M_AXI_AWPROT(ddr_axi_awprot),
		.M_AXI_AWQOS(ddr_axi_awqos),
		.M_AXI_AWUSER(ddr_axi_awuser),
		.M_AXI_AWVALID(ddr_axi_awvalid),
		.M_AXI_AWREADY(ddr_axi_awready),
		.M_AXI_WDATA(ddr_axi_wdata),
		.M_AXI_WSTRB(ddr_axi_wstrb),
		.M_AXI_WLAST(ddr_axi_wlast),
		.M_AXI_WUSER(ddr_axi_wuser),
		.M_AXI_WVALID(ddr_axi_wvalid),
		.M_AXI_WREADY(ddr_axi_wready),
		.M_AXI_BID(ddr_axi_bid),
		.M_AXI_BRESP(ddr_axi_bresp),
		.M_AXI_BUSER(ddr_axi_buser),
		.M_AXI_BVALID(ddr_axi_bvalid),
		.M_AXI_BREADY(ddr_axi_bready),
		.M_AXI_ARID(ddr_axi_arid),
		.M_AXI_ARADDR(ddr_axi_araddr),
		.M_AXI_ARLEN(ddr_axi_arlen),
		.M_AXI_ARSIZE(ddr_axi_arsize),
		.M_AXI_ARBURST(ddr_axi_arburst),
		.M_AXI_ARLOCK(ddr_axi_arlock),
		.M_AXI_ARCACHE(ddr_axi_arcache),
		.M_AXI_ARPROT(ddr_axi_arprot),
		.M_AXI_ARQOS(ddr_axi_arqos),
		.M_AXI_ARUSER(ddr_axi_aruser),
		.M_AXI_ARVALID(ddr_axi_arvalid),
		.M_AXI_ARREADY(ddr_axi_arready),
		.M_AXI_RID(ddr_axi_rid),
		.M_AXI_RDATA(ddr_axi_rdata),
		.M_AXI_RRESP(ddr_axi_rresp),
		.M_AXI_RLAST(ddr_axi_rlast),
		.M_AXI_RUSER(ddr_axi_ruser),
		.M_AXI_RVALID(ddr_axi_rvalid),
		.M_AXI_RREADY(ddr_axi_rready)
	);

	// Add user logic here


if (1) 
begin    
    // Bypass
    assign rf_in_tready = rf_out_tready;
    assign rf_out_tdata = rf_in_tdata;
    assign rf_out_tvalid = rf_in_tvalid;    
end else begin
    assign rf_in_tready = ddr_axi_ready & ~dout_axis_busy & ~din_axis_busy;
    
    assign rf_out_tdata = dout_axis_data;
    assign din_axis_data = rf_in_tdata;
    
    assign dout_wr_en = rf_in_tready;
    assign din_rd_en = rf_in_tready;
end

    // Data coming from DDR
    ddr_in_fifo ddr_in(.wr_clk(ddr_axi_aclk),
        .rd_clk(axis_aclk),
        .srst(ddr_axi_aresetn),
        .valid(din_valid),
        .prog_full(din_pfull),
        .prog_empty(din_pempty),
        .wr_rst_busy(din_aximm_busy),
        .rd_rst_busy(din_axis_busy),
        .wr_en(din_wr_en),
        .rd_en(din_rd_en),
        .din(din_aximm_data),
        .dout(dout_axis_data),
        .full(din_full),
        .empty(din_empty));
        
    // Data going to DDR    
    ddr_out_fifo ddr_out(.wr_clk(axis_aclk),
        .rd_clk(ddr_axi_aclk),
        .prog_empty(dout_pempty),
        .wr_rst_busy(dout_axis_busy),
        .rd_rst_busy(dout_aximm_busy),
        .wr_en(dout_wr_en),
        .rd_en(dout_rd_en),
        .din(dout_axis_data),
        .dout(dout_aximm_data),
        .full(dout_full),
        .empty(dout_empty));

	// User logic ends

	endmodule
