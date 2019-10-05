
`timescale 1 ns / 1 ps

	module RFDDRDelayLine_v1_0_DDR_AXI #
	(
		// Users to add parameters here
        parameter C_DDR_WINDOW_BASE = 32'h0000_0000,
        parameter C_DDR_WINDOW_SIZE = 32'h0080_0000,
		// User parameters ends
		// Do not modify the parameters beyond this line

		// Base address of targeted slave
		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		// Burst Length. Supports 1, 2, 4, 8, 16, 32, 64, 128, 256 burst lengths
		parameter integer C_M_AXI_BURST_LEN	= 16,
		// Thread ID Width
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		// Width of Address Bus
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		// Width of Data Bus
		parameter integer C_M_AXI_DATA_WIDTH	= 512,
		// Width of User Write Address Bus
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		// Width of User Read Address Bus
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		// Width of User Write Data Bus
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		// Width of User Read Data Bus
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		// Width of User Response Bus
		parameter integer C_M_AXI_BUSER_WIDTH	= 0
	)
	(
		// Users to add ports here
	    input wire ddr_ready,
	    output reg rdy,

        output reg fifo_wr_en,
        input wire fifo_wr_busy,
        output wire [C_M_AXI_DATA_WIDTH-1 : 0] fifo_wr_data,
        input wire fifo_wr_full,
        input wire fifo_wr_pfull,

        output reg fifo_rd_en,
        input wire fifo_rd_busy,
        input wire [C_M_AXI_DATA_WIDTH-1 : 0] fifo_rd_data,
        input wire fifo_rd_pempty,
        input wire fifo_rd_empty,  
		// User ports ends
		// Do not modify the ports beyond this line

		// Initiate AXI transactions
		input wire  INIT_AXI_TXN,
		// Asserts when transaction is complete
		output wire  TXN_DONE,
		// Asserts when ERROR is detected
		output reg  ERROR,
		// Global Clock Signal.
		input wire  M_AXI_ACLK,
		// Global Reset Singal. This Signal is Active Low
		input wire  M_AXI_ARESETN,
		// Master Interface Write Address ID
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID,
		// Master Interface Write Address
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		// Burst length. The burst length gives the exact number of transfers in a burst
		output wire [7 : 0] M_AXI_AWLEN,
		// Burst size. This signal indicates the size of each transfer in the burst
		output wire [2 : 0] M_AXI_AWSIZE,
		// Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
		output wire [1 : 0] M_AXI_AWBURST,
		// Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
		output wire  M_AXI_AWLOCK,
		// Memory type. This signal indicates how transactions
    // are required to progress through a system.
		output wire [3 : 0] M_AXI_AWCACHE,
		// Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_AWPROT,
		// Quality of Service, QoS identifier sent for each write transaction.
		output wire [3 : 0] M_AXI_AWQOS,
		// Optional User-defined signal in the write address channel.
		output wire [C_M_AXI_AWUSER_WIDTH-1 : 0] M_AXI_AWUSER,
		// Write address valid. This signal indicates that
    // the channel is signaling valid write address and control information.
		output wire  M_AXI_AWVALID,
		// Write address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
		input wire  M_AXI_AWREADY,
		// Master Interface Write Data.
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		// Write strobes. This signal indicates which byte
    // lanes hold valid data. There is one write strobe
    // bit for each eight bits of the write data bus.
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		// Write last. This signal indicates the last transfer in a write burst.
		output wire  M_AXI_WLAST,
		// Optional User-defined signal in the write data channel.
		output wire [C_M_AXI_WUSER_WIDTH-1 : 0] M_AXI_WUSER,
		// Write valid. This signal indicates that valid write
    // data and strobes are available
		output wire  M_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    // can accept the write data.
		input wire  M_AXI_WREADY,
		// Master Interface Write Response.
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
		// Write response. This signal indicates the status of the write transaction.
		input wire [1 : 0] M_AXI_BRESP,
		// Optional User-defined signal in the write response channel
		input wire [C_M_AXI_BUSER_WIDTH-1 : 0] M_AXI_BUSER,
		// Write response valid. This signal indicates that the
    // channel is signaling a valid write response.
		input wire  M_AXI_BVALID,
		// Response ready. This signal indicates that the master
    // can accept a write response.
		output wire  M_AXI_BREADY,
		// Master Interface Read Address.
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
		// Read address. This signal indicates the initial
    // address of a read burst transaction.
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		// Burst length. The burst length gives the exact number of transfers in a burst
		output wire [7 : 0] M_AXI_ARLEN,
		// Burst size. This signal indicates the size of each transfer in the burst
		output wire [2 : 0] M_AXI_ARSIZE,
		// Burst type. The burst type and the size information, 
    // determine how the address for each transfer within the burst is calculated.
		output wire [1 : 0] M_AXI_ARBURST,
		// Lock type. Provides additional information about the
    // atomic characteristics of the transfer.
		output wire  M_AXI_ARLOCK,
		// Memory type. This signal indicates how transactions
    // are required to progress through a system.
		output wire [3 : 0] M_AXI_ARCACHE,
		// Protection type. This signal indicates the privilege
    // and security level of the transaction, and whether
    // the transaction is a data access or an instruction access.
		output wire [2 : 0] M_AXI_ARPROT,
		// Quality of Service, QoS identifier sent for each read transaction
		output wire [3 : 0] M_AXI_ARQOS,
		// Optional User-defined signal in the read address channel.
		output wire [C_M_AXI_ARUSER_WIDTH-1 : 0] M_AXI_ARUSER,
		// Write address valid. This signal indicates that
    // the channel is signaling valid read address and control information
		output wire  M_AXI_ARVALID,
		// Read address ready. This signal indicates that
    // the slave is ready to accept an address and associated control signals
		input wire  M_AXI_ARREADY,
		// Read ID tag. This signal is the identification tag
    // for the read data group of signals generated by the slave.
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
		// Master Read Data
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		// Read response. This signal indicates the status of the read transfer
		input wire [1 : 0] M_AXI_RRESP,
		// Read last. This signal indicates the last transfer in a read burst
		input wire  M_AXI_RLAST,
		// Optional User-defined signal in the read address channel.
		input wire [C_M_AXI_RUSER_WIDTH-1 : 0] M_AXI_RUSER,
		// Read valid. This signal indicates that the channel
    // is signaling the required read data.
		input wire  M_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    // accept the read data and response information.
		output wire  M_AXI_RREADY
	);

if (0) begin
	// function called clogb2 that returns an integer which has the
	//value of the ceiling of the log base 2

	  // function called clogb2 that returns an integer which has the 
	  // value of the ceiling of the log base 2.                      
	  function integer clogb2 (input integer bit_depth);              
	  begin                                                           
	    for(clogb2=0; bit_depth>0; clogb2=clogb2+1)                   
	      bit_depth = bit_depth >> 1;                                 
	    end                                                           
	  endfunction                                                     

	// C_TRANSACTIONS_NUM is the width of the index counter for 
	// number of write or read transaction.
	 localparam integer C_TRANSACTIONS_NUM = clogb2(C_M_AXI_BURST_LEN-1);

	// Burst length for transactions, in C_M_AXI_DATA_WIDTHs.
	// Non-2^n lengths will eventually cause bursts across 4K address boundaries.
	 localparam integer C_MASTER_LENGTH	= 12;
	// total number of burst transfers is master length divided by burst length and burst size
	 localparam integer C_NO_BURSTS_REQ = C_MASTER_LENGTH-clogb2((C_M_AXI_BURST_LEN*C_M_AXI_DATA_WIDTH/8)-1);
	// Example State machine to initialize counter, initialize write transactions, 
	// initialize read transactions and comparison of read data with the 
	// written data words.


	// AXI4LITE signals
	//AXI4 internal temp signals
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awvalid;
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	axi_wdata;
	reg  	axi_wlast;
	reg  	axi_wvalid;
	reg  	axi_bready;
	reg [C_M_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arvalid;
	reg  	axi_rready;
	//write beat count in a burst
	reg [C_TRANSACTIONS_NUM : 0] 	write_index;
	//read beat count in a burst
	reg [C_TRANSACTIONS_NUM : 0] 	read_index;
	//size of C_M_AXI_BURST_LEN length burst in bytes
	wire [C_TRANSACTIONS_NUM+2 : 0] 	burst_size_bytes;
	//The burst counters are used to track the number of burst transfers of C_M_AXI_BURST_LEN burst length needed to transfer 2^C_MASTER_LENGTH bytes of data.
	reg [C_NO_BURSTS_REQ : 0] 	write_burst_counter;
	reg [C_NO_BURSTS_REQ : 0] 	read_burst_counter;
	reg  	start_single_burst_write;
	reg  	start_single_burst_read;
	reg  	writes_done;
	reg  	reads_done;
	reg  	error_reg;
	reg  	compare_done;
	reg  	read_mismatch;
	reg  	burst_write_active;
	reg  	burst_read_active;
	reg [C_M_AXI_DATA_WIDTH-1 : 0] 	expected_rdata;
	//Interface response error flags
	wire  	write_resp_error;
	wire  	read_resp_error;
	wire  	wnext;
	wire  	rnext;
	reg  	init_txn_ff;
	reg  	init_txn_ff2;
	reg  	init_txn_edge;
	wire  	init_txn_pulse;


	// I/O Connections assignments

	//The AXI address is a concatenation of the target base address + active offset range
	assign M_AXI_AWADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_awaddr;
	//Burst LENgth is number of transaction beats, minus 1
	assign M_AXI_AWLEN	= C_M_AXI_BURST_LEN - 1;
	//Size should be C_M_AXI_DATA_WIDTH, in 2^SIZE bytes, otherwise narrow bursts are used
	assign M_AXI_AWSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	//INCR burst type is usually used, except for keyhole bursts
	//Read Address (AR)
	assign M_AXI_ARID	= 'b0;
	assign M_AXI_ARADDR	= C_M_TARGET_SLAVE_BASE_ADDR + axi_araddr;
	//Burst LENgth is number of transaction beats, minus 1
	assign M_AXI_ARLEN	= C_M_AXI_BURST_LEN - 1;
	//Size should be C_M_AXI_DATA_WIDTH, in 2^n bytes, otherwise narrow bursts are used
	assign M_AXI_ARSIZE	= clogb2((C_M_AXI_DATA_WIDTH/8)-1);
	//INCR burst type is usually used, except for keyhole bursts
	assign M_AXI_ARBURST	= 2'b01;
	assign M_AXI_ARLOCK	= 1'b0;
	//Update value to 4'b0011 if coherent accesses to be used via the Zynq ACP port. Not Allocated, Modifiable, not Bufferable. Not Bufferable since this example is meant to test memory, not intermediate cache. 
	assign M_AXI_ARCACHE	= 4'b0010;
	assign M_AXI_ARPROT	= 3'h0;
	assign M_AXI_ARQOS	= 4'h0;
	assign M_AXI_ARUSER	= 'b1;
	assign M_AXI_ARVALID	= axi_arvalid;
	//Read and Read Response (R)
	assign M_AXI_RREADY	= axi_rready;
	//Example design I/O
	assign TXN_DONE	= compare_done;
	//Burst size in bytes
	assign burst_size_bytes	= C_M_AXI_BURST_LEN * C_M_AXI_DATA_WIDTH/8;
	assign init_txn_pulse	= (!init_txn_ff2) && init_txn_ff;

end


	// Add user logic here
    
    localparam W_RESET  = 5'd0;
    localparam W_WAIT   = 5'd1;
    localparam W_BEGIN  = 5'd2;
    localparam W_XFER   = 5'd3;
    localparam W_FIN    = 5'd4;
    localparam W_BWAIT  = 5'd5;
    
    localparam R_RESET  = 5'd0;
    localparam R_WAIT   = 5'd1;
    localparam R_BEGIN  = 5'd2;
    localparam R_XFER   = 5'd3;
    localparam R_FIN    = 5'd4;
    localparam R_BWAIT  = 5'd5;

    
    reg [4:0] m_state;
    reg [4:0] r_state;
    reg [4:0] w_state;
    
    reg fill;
    reg wr_req;
    reg wr_ack;
    reg rd_req;
    reg rd_ack;
    reg [7:0] burst_len;
    reg [7:0] burst_cnt;
    reg [31:0] waddr;
    reg [31:0] raddr;

	assign M_AXI_AWID = 0;
	assign M_AXI_AWADDR = waddr + C_DDR_WINDOW_BASE;
	assign M_AXI_AWSIZE = 3'h4;
    assign M_AXI_AWLEN = burst_len - 1;	
    assign M_AXI_AWBURST = 2'h1; // INCR
    assign M_AXI_AWLOCK = 1'b0;
    assign M_AXI_AWCACHE = 4'h0;
    assign M_AXI_AWPROT = 3'h0;
    assign M_AXI_AWQOS = 4'h0;
    assign M_AXI_AWUSER = {C_M_AXI_AWUSER_WIDTH{1'b0}};
    assign M_AXI_AWVALID = (w_state == W_BEGIN);
    assign M_AXI_WDATA = fill ? 512'b0 : fifo_rd_data;
    assign M_AXI_WSTRB = {C_M_AXI_DATA_WIDTH/8{1'b1}};
    assign M_AXI_WVALID = ((w_state == W_BEGIN) || (w_state == W_XFER) || (w_state == W_FIN));
    assign M_AXI_WLAST = (w_state == W_FIN);
    assign M_AXI_WUSER = {C_M_AXI_WUSER_WIDTH{1'b0}};
    assign M_AXI_BREADY = 1'b1;

	assign M_AXI_ARID	= 0;
	assign M_AXI_ARADDR	= raddr + C_DDR_WINDOW_BASE;
	assign M_AXI_ARLEN  = burst_len - 1;
	assign M_AXI_ARSIZE	= 3'h4;
	assign M_AXI_ARBURST	= 2'b01; // INCR
	assign M_AXI_ARLOCK	= 1'b0;
	assign M_AXI_ARCACHE	= 4'b0000;
	assign M_AXI_ARPROT	= 3'h0;
	assign M_AXI_ARQOS	= 4'h0;
	assign M_AXI_ARUSER	= 'b1;
	assign M_AXI_ARVALID = (r_state == R_BEGIN);
	assign M_AXI_RREADY	= 1'b1;
    assign fifo_wr_data = M_AXI_RDATA;

    always @(posedge M_AXI_ACLK)
    begin
        if (~M_AXI_ARESETN) begin
            w_state <= W_RESET;
        end else begin
            case (w_state)
                W_RESET: begin
                    w_state <= W_WAIT;
                    wr_ack <= 1'b0;
                end
                W_WAIT: begin
                    if (wr_req && M_AXI_WREADY) begin
                        wr_ack <= 1'b1;
                        w_state <= W_BEGIN;
                        fifo_rd_en <= 1'b1;
                        burst_cnt <= burst_len - 1;
                    end else begin
                        wr_ack <= 1'b0;
                        w_state <= W_WAIT;
                    end
                end
                W_BEGIN: begin
                    w_state <= W_XFER;
                end
                W_XFER: begin
                    if (burst_cnt == 1) begin
                        fifo_rd_en <= 1'b0;
                        w_state <= W_FIN;
                    end else begin
                        burst_cnt <= burst_cnt - 1;
                        w_state <= W_XFER;
                    end
                end
                W_FIN: begin
                    wr_ack <= 1'b0;
                    w_state <= W_BWAIT;
                end    
                W_BWAIT: begin
                    if (M_AXI_BVALID) begin
                        // Check for error
                        w_state <= W_WAIT;
                    end else begin
                        w_state <= W_BWAIT;
                    end
                end
            endcase
        end
    end

    always @(posedge M_AXI_ACLK)
    begin
        if (~M_AXI_ARESETN) begin
            r_state <= W_RESET;
        end else begin
            case (r_state)
                R_RESET: begin
                    r_state <= W_WAIT;
                    rd_ack <= 1'b0;
                end
                R_WAIT: begin
                    if (rd_req && M_AXI_RREADY) begin
                        rd_ack <= 1'b1;
                        r_state <= W_BEGIN;
                        fifo_wr_en <= 1'b1;
                    end else begin
                        rd_ack <= 1'b0;
                        r_state <= W_WAIT;
                    end
                end
                R_BEGIN: begin
                    r_state <= R_XFER;
                end
                R_XFER: begin
                    rd_ack <= 1'b0;
                    if (M_AXI_RLAST == 1) begin
                        // CHeck RRESP
                        fifo_wr_en <= 1'b0;
                        r_state <= R_WAIT;
                    end else begin
                        burst_cnt <= burst_cnt - 1;
                        r_state <= R_XFER;
                    end
                end
            endcase
        end
    end
    
    localparam M_RESET = 5'd0;
    localparam M_INIT_WAIT = 5'd1;
    localparam M_INITIAL_FILL = 5'd2;
    localparam M_INITIAL_FILL_WAIT = 5'd3;
    localparam M_RUN = 5'd4;
    
    localparam delay_count = 32'h0040_0000;
    
    localparam BURST_LENGTH = 8'd16;
    
    always @(posedge M_AXI_ACLK)
    begin
        if (~M_AXI_ARESETN) begin
            m_state <= M_RESET;
            rdy <= 0;
            fill <= 1;
        end else begin
            case (m_state)
                M_RESET: begin
                    m_state <= M_INIT_WAIT;
                end
                M_INIT_WAIT: begin
                    if (ddr_ready && ~wr_ack) begin
                        waddr <= 0;
                        fill <= 1;
                        m_state <= M_INITIAL_FILL;
                        burst_len <= BURST_LENGTH;
                    end else begin
                        m_state <= M_INIT_WAIT;
                    end
                end
                M_INITIAL_FILL: begin
                    if (wr_ack) begin
                        wr_req <= 1'b0;
                    end else if (~wr_req) begin
                        if (waddr + BURST_LENGTH < C_DDR_WINDOW_SIZE) begin
                            waddr <= waddr + BURST_LENGTH;
                            m_state <= M_INITIAL_FILL;
                            wr_req <= 1;
                        end else begin
                            waddr <= delay_count - BURST_LENGTH;
                            raddr <= -BURST_LENGTH & ~(C_DDR_WINDOW_SIZE - 1);
                            raddr <= 0;
                            fill <= 0;
                            m_state <= M_RUN;
                        end
                    end else begin
                        // This is really an error...
                        m_state <= M_INITIAL_FILL;
                    end
                end
                M_RUN: begin
                    if (wr_ack) begin
                        wr_req <= 0;
                    end else if (~fifo_wr_pfull && ~wr_ack) begin
                        waddr <= (waddr + BURST_LENGTH) & ~(C_DDR_WINDOW_SIZE - 1);
                        wr_req <= 1;
                    end
                    
                    if (rd_ack) begin
                        rd_req <= 0;
                    end else if (~fifo_rd_pempty && ~rd_ack) begin
                        raddr <= (raddr + BURST_LENGTH) & ~(C_DDR_WINDOW_SIZE - 1);
                        rd_req <= 1;
                    end
                    
                    m_state <= M_RUN;
                end
            endcase
        end
    end
    
    
	// User logic ends

	endmodule
