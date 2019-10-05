
`timescale 1 ns / 1 ps

	module DigitalDelayLine_v1_0 #
	(
		// Users to add parameters here
		parameter integer INITIAL_BYPASS   = 1'b0,
		parameter integer INITIAL_DELAY    = 12'd250,

		// User parameters ends
		// Do not modify the parameters beyond this line
		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4,

		// Parameters of Axi Slave Bus Interface AXI_DATA_IN
		parameter integer C_AXI_STREAM_TDATA_WIDTH	= 256,
		
		// Parameters of Axi Master Bus Interface AXI_DATA_OUT
		parameter integer C_AXI_DATA_OUT_START_COUNT	= 32,
		
		parameter integer USE_URAM = 0
	)
	(
		// Users to add ports here
        input wire aclk,
        input wire aresetn,
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

		// Ports of Axi Slave Bus Interface AXI_DATA_IN
		output wire  axi_data_in_tready,
		input wire [C_AXI_STREAM_TDATA_WIDTH-1 : 0] axi_data_in_tdata,
		input wire  axi_data_in_tvalid,

		// Ports of Axi Master Bus Interface AXI_DATA_OUT
		output wire  axi_data_out_tvalid,
		output wire [C_AXI_STREAM_TDATA_WIDTH-1 : 0] axi_data_out_tdata,
		input wire  axi_data_out_tready
	);


    localparam N_URAM = C_AXI_STREAM_TDATA_WIDTH / 64;
    localparam N_BRAM = C_AXI_STREAM_TDATA_WIDTH / 64;
    localparam N_ADDR = USE_URAM ? 12 : 11;
    localparam MAX_ADDR = {N_ADDR{1'b1}};        

	// Add user logic here
	reg [N_ADDR-1:0] waddr;
	wire [N_ADDR-1:0] raddr;
	wire [7*N_URAM-1:0] unused;    
	wire axilite_valid;
	wire bypass_axilite;
	wire bypass_sync;
	reg bypass;
    wire [31:0] delay_axilite;
    wire [31:0] delay_sync;
    reg [31:0] delay;
    reg delay_send;
    wire delay_recv;
	
	wire [C_AXI_STREAM_TDATA_WIDTH-1:0] din;
	wire [C_AXI_STREAM_TDATA_WIDTH-1:0] dout;
	
	reg [10:0] bringup_count;

    wire ready;
    wire [N_URAM - 1: 0] tvalid_out;
        
    wire [17:0] we;
    
    localparam WAIT = 3'd0;
    localparam INIT = 3'd1;
    localparam RUN = 3'd7;
    
    reg[2:0] state;
    
    reg[127:0] last_write;
    
    // Instantiation of Axi Bus Interface S00_AXI
	AXIDigitalDelayLine_v1_0_S00_AXI # (
	    .INITIAL_BYPASS(INITIAL_BYPASS), 
	    .INITIAL_DELAY(INITIAL_DELAY),
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) AXIDigitalDelayLine_v1_0_S00_AXI_inst (
	    .bypass(bypass_axilite),
	    .delay(delay_axilite),
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
        .WIDTH(33))
        delay_handshake(
            .dest_clk(aclk),
            .dest_out({bypass_sync, delay_sync}),
            .dest_req(axilite_valid),
            .src_clk(s00_axi_aclk),
            .src_in({bypass_axilite, delay_axilite}),
            .src_send(delay_send),
            .src_rcv(delay_recv)
        );

    reg [31:0] last_delay_axilite;
    
    always @(posedge s00_axi_aclk)
    begin
        if (~s00_axi_aresetn) begin
            delay_send <= 1'b0;
            last_delay_axilite <= 32'b0;
        end else if (delay_send) begin
            delay_send <= ~delay_recv;
        end else if (~delay_recv && delay_axilite != last_delay_axilite) begin
            delay_send <= 1;
            last_delay_axilite <= delay_axilite;
        end
    end
    
    always @(posedge aclk) 
    begin
        if (axilite_valid) begin
            delay <= delay_sync;
            bypass <= bypass_sync;        
        end
    end
    
    assign axi_data_in_tready = ready;
    assign axi_data_out_tvalid = (ready & ~bypass) ? &tvalid_out : axi_data_in_tvalid;
    assign axi_data_out_tdata = (ready & ~bypass) ? dout : axi_data_in_tdata;
    
    assign ready = (state == RUN);
    assign din = (state == RUN) ? axi_data_in_tdata : {C_AXI_STREAM_TDATA_WIDTH{1'b0}};
    assign we = (state == INIT) ? 18'b0 : {18{1'b1}};

    assign raddr = waddr - delay;    

    always @(posedge aclk)
    begin
        if (~aresetn) begin
            bringup_count <= 100;
            state <= WAIT;
            waddr <= 0;
        end else
            case (state)
            WAIT: 
            begin
                if (bringup_count > 0) 
                    bringup_count <= bringup_count - 1;
                else
                    state <= INIT;        
            end 
            INIT:
            begin
                if (waddr == MAX_ADDR) begin
                    waddr <= delay;
                    state <= RUN;
                end else begin
                    waddr <= waddr + 1;
                end
            end
            RUN:
            begin
                waddr <= waddr + 1;
            end
            endcase    
    end
    
    genvar i;
    
    generate
        if (USE_URAM) 
        begin
            for (i = 0; i < N_URAM; i = i + 1)
            begin
                URAM288_BASE #(.AUTO_SLEEP_LATENCY(8),            // Latency requirement to enter sleep mode   
                          .AVG_CONS_INACTIVE_CYCLES(10),     // Average concecutive inactive cycles when is SLEEP mode for power
                                                             // estimation   
                          .BWE_MODE_A("PARITY_INDEPENDENT"), // Port A Byte write control   
                          .BWE_MODE_B("PARITY_INDEPENDENT"), // Port B Byte write control   
                          .EN_AUTO_SLEEP_MODE("FALSE"),      // Enable to automatically enter sleep mode   
                          .EN_ECC_RD_A("FALSE"),             // Port A ECC encoder   
                          .EN_ECC_RD_B("FALSE"),             // Port B ECC encoder   
                          .EN_ECC_WR_A("FALSE"),             // Port A ECC decoder   
                          .EN_ECC_WR_B("FALSE"),             // Port B ECC decoder   
                          .IREG_PRE_A("TRUE"),              // Optional Port A input pipeline registers   
                          .IREG_PRE_B("FALSE"),              // Optional Port B input pipeline registers   
                          .IS_CLK_INVERTED(1'b0),            // Optional inverter for CLK   
                          .IS_EN_A_INVERTED(1'b0),           // Optional inverter for Port A enable   
                          .IS_EN_B_INVERTED(1'b0),           // Optional inverter for Port B enable   
                          .IS_RDB_WR_A_INVERTED(1'b0),       // Optional inverter for Port A read/write select
                          .IS_RDB_WR_B_INVERTED(1'b0),       // Optional inverter for Port B read/write select   
                          .IS_RST_A_INVERTED(1'b0),          // Optional inverter for Port A reset   
                          .IS_RST_B_INVERTED(1'b0),          // Optional inverter for Port B reset   
                          .OREG_A("FALSE"),                  // Optional Port A output pipeline registers   
                          .OREG_B("TRUE"),                   // Optional Port B output pipeline registers   
                          .OREG_ECC_A("FALSE"),              // Port A ECC decoder output   
                          .OREG_ECC_B("FALSE"),              // Port B output ECC decoder   
                          //.REG_CAS_A("FALSE"),               // Optional Port A cascade register   
                          //.REG_CAS_B("FALSE"),               // Optional Port B cascade register   
                          .RST_MODE_A("ASYNC"),               // Port A reset mode   
                          .RST_MODE_B("ASYNC"),               // Port B reset mode   
                          //.SELF_ADDR_A(11'h000),             // Port A self-address value   
                          //.SELF_ADDR_B(11'h000),             // Port B self-address value   
                          //.SELF_MASK_A(11'h7ff),             // Port A self-address mask   
                          //.SELF_MASK_B(11'h7ff),             // Port B self-address mask   
                          .USE_EXT_CE_A("FALSE"),            // Enable Port A external CE inputs for output registers   
                          .USE_EXT_CE_B("FALSE")             // Enable Port B external CE inputs for output registers)
                    ) delay_data_fifo(.CLK(aclk),
                    .ADDR_A({11'b0, waddr}), .ADDR_B({ 11'b0, raddr }), 
                    .BWE_A(we[8:0]), .BWE_B(9'h000),
                    .DIN_A({ 7'b0, axi_data_in_tvalid, din[64*i+:64] }), .DIN_B(71'h0),
                    /* .DOUT_A(), */ .DOUT_B({unused[7*i+:7], tvalid_out[i], axi_data_out_tdata[64*i+:64]}),
                    .EN_A(state == RUN), .EN_B(state == RUN),
                    .INJECT_DBITERR_A(1'b0), .INJECT_DBITERR_B(1'b0),  
                    .INJECT_SBITERR_A(1'b0), .INJECT_SBITERR_B(1'b0),  
                    .OREG_CE_A(1'b0), .OREG_CE_B(1'b0),
                    .OREG_ECC_CE_A(1'b0),
                    .OREG_ECC_CE_B(1'b0),           // 1-bit input: Port B ECC decoder output register clock enable   
                    .RDB_WR_A(1'b1),                     // 1-bit input: Port A read/write select   
                    .RDB_WR_B(1'b0),                     // 1-bit input: Port B read/write select   
                    .RST_A(~aresetn),            // 1-bit input: Port A asynchronous or synchronous reset for                                            
                                                             // output registers   
                    .RST_B(~aresetn),           // 1-bit input: Port B asynchronous or synchronous reset for                                            
                                                             // output registers   
                    .SLEEP(1'b0)                            // 1-bit input: Dynamic power gating control
                    );
            end
        end else begin
            for (i = 0; i < N_BRAM; i = i + 1) 
            begin
                delay_fifo delay_data_fifo(.clka(aclk),
                    .ena(state == RUN),
                    .wea(1'b1),
                    .addra(waddr),
                    .dina({axi_data_in_tvalid, din[64*i+:64]}),
                    .clkb(aclk),
                    .enb(state == RUN),
                    .addrb(raddr),
                    .doutb({tvalid_out[i], dout[64*i+:64]}));
            end
        end
    endgenerate
	

        
	// User logic ends

	endmodule
