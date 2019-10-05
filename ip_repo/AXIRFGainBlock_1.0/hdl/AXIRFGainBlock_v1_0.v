
`timescale 1 ns / 1 ps

	module AXIRFGainBlock_v1_0 #
	(
		// Users to add parameters here
        parameter integer INITIAL_SCALE = 32'h0001_0000,
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4,

		// Parameters of Axi Slave Bus Interface RF_IN
		parameter integer C_AXI_STREAM_TDATA_WIDTH	= 256
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
		input wire  axis_aclk,
		input wire  axis_aresetn,
		
		output wire  rf_in_tready,
		input wire [C_AXI_STREAM_TDATA_WIDTH-1 : 0] rf_in_tdata,
		input wire  rf_in_tvalid,

		// Ports of Axi Master Bus Interface RF_OUT
		output wire  rf_out_tvalid,
		output wire [C_AXI_STREAM_TDATA_WIDTH-1 : 0] rf_out_tdata,
		input wire  rf_out_tready
	);

    localparam N_DSP = C_AXI_STREAM_TDATA_WIDTH / 16;

    wire scale_valid;
    wire [31:0] scale_axilite;
    wire [31:0] scale_sync;
    reg [31:0] scale;
    reg scale_send;
    wire scale_recv;
	
    // Instantiation of Axi Bus Interface S00_AXI
	AXIRFGainBlock_v1_0_S00_AXI # ( 
	    .INITIAL_SCALE(INITIAL_SCALE),
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) AXIRFGainBlock_v1_0_S00_AXI_inst (
	    .scale(scale_axilite),
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

	// Add user logic here
    xpm_cdc_handshake #(
        .DEST_EXT_HSK(0),
        .DEST_SYNC_FF(2),
        .INIT_SYNC_FF(0),
        .SIM_ASSERT_CHK(1),
        .SRC_SYNC_FF(2),
        .WIDTH(32))
        scale_handshake(
            .dest_clk(axis_aclk),
            .dest_out(scale_sync),
            .dest_req(scale_valid),
            .src_clk(s00_axi_aclk),
            .src_in(scale_axilite),
            .src_send(scale_send),
            .src_rcv(scale_recv)
        );

    reg [31:0] last_scale_axilite;

    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn) begin
            scale_send <= 1'b0;
            last_scale_axilite <= 32'b0;
        end else if (scale_send) begin
            scale_send <= ~scale_recv;
        end else if (~scale_recv && scale_axilite != last_scale_axilite) begin
            scale_send <= 1;
            last_scale_axilite <= scale_axilite;
        end
    end

    genvar i;
    
    generate
        for (i = 0; i < N_DSP; i = i + 1) begin
            mult16_30 macc(.clk(axis_aclk), .rst(~axis_aresetn),
                .scale(scale),
                .stream_in(rf_in_tvalid ? rf_in_tdata[16*i+:16] : 16'b0), 
                .stream_out(rf_out_tdata[16*i+:16]));
        end
    endgenerate

    reg [2:0] valid_r;
    
    always @(posedge axis_aclk)
    begin
        if (~axis_aresetn) begin
            valid_r <= 3'b0;
        end else begin
            valid_r <= { valid_r[1:0], rf_in_tvalid };
        end
    end

    assign rf_in_tready = 1;
    assign rf_out_tvalid = valid_r[2];

    always @(posedge axis_aclk) 
    begin
        if (scale_valid)
            scale <= scale_sync;        
    end

	// User logic ends

	endmodule
