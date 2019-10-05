
`timescale 1 ns / 1 ps

	module AXIParallel2ndOrderIIR_v1_0_S00_AXI #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line

		// Width of S_AXI data bus
		parameter integer C_S_AXI_DATA_WIDTH	= 32,
		// Width of S_AXI address bus
		parameter integer C_S_AXI_ADDR_WIDTH	= 9,
		parameter integer A_WIDTH               = 30,
		parameter integer B_WIDTH               = 30,
        parameter integer N_x                   = 33,
        parameter integer N_y                   = 2,
        parameter integer INIT_A0               = 65511,
        parameter integer INIT_A1               = -45,
        parameter integer INIT_A2               = -30,
        parameter integer INIT_A3               = -9,
        parameter integer INIT_A4               = 14,
        parameter integer INIT_A5               = 34,
        parameter integer INIT_A6               = 47,
        parameter integer INIT_A7               = 50,
        parameter integer INIT_A8               = 42,
        parameter integer INIT_A9               = 26,
        parameter integer INIT_A10              = 4,
        parameter integer INIT_A11              = -18,
        parameter integer INIT_A12              = -37,
        parameter integer INIT_A13              = -48,
        parameter integer INIT_A14              = -49,
        parameter integer INIT_A15              = -39,
        parameter integer INIT_A16              = -56575,
        parameter integer INIT_A17              = 39,
        parameter integer INIT_A18              = 49,
        parameter integer INIT_A19              = 48,
        parameter integer INIT_A20              = 37,
        parameter integer INIT_A21              = 18,
        parameter integer INIT_A22              = -4,
        parameter integer INIT_A23              = -26,
        parameter integer INIT_A24              = -42,
        parameter integer INIT_A25              = -49,
        parameter integer INIT_A26              = -46,
        parameter integer INIT_A27              = -33,
        parameter integer INIT_A28              = -14,
        parameter integer INIT_A29              = 9,
        parameter integer INIT_A30              = 30,
        parameter integer INIT_A31              = 44,
        parameter integer INIT_A32              = 64767,
        parameter integer INIT_B0               = 56575,
        parameter integer INIT_B1               = -64742        
	)
	(
		// Users to add ports here
        output wire bypass,
        output wire [3:0] y_offset,
        output wire [A_WIDTH*N_x-1:0] a,
        output reg [N_x-1:0] a_send,
        input wire [N_x-1:0] a_recv,
        output wire [B_WIDTH*N_y-1:0] b,
        output reg [N_y-1:0] b_send,
        input wire [N_y-1:0] b_recv,
        
		// User ports ends
		// Do not modify the ports beyond this line

		// Global Clock Signal
		input wire  S_AXI_ACLK,
		// Global Reset Signal. This Signal is Active LOW
		input wire  S_AXI_ARESETN,
		// Write address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
		// Write channel Protection type. This signal indicates the
    		// privilege and security level of the transaction, and whether
    		// the transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_AWPROT,
		// Write address valid. This signal indicates that the master signaling
    		// valid write address and control information.
		input wire  S_AXI_AWVALID,
		// Write address ready. This signal indicates that the slave is ready
    		// to accept an address and associated control signals.
		output wire  S_AXI_AWREADY,
		// Write data (issued by master, acceped by Slave) 
		input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
		// Write strobes. This signal indicates which byte lanes hold
    		// valid data. There is one write strobe bit for each eight
    		// bits of the write data bus.    
		input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
		// Write valid. This signal indicates that valid write
    		// data and strobes are available.
		input wire  S_AXI_WVALID,
		// Write ready. This signal indicates that the slave
    		// can accept the write data.
		output wire  S_AXI_WREADY,
		// Write response. This signal indicates the status
    		// of the write transaction.
		output wire [1 : 0] S_AXI_BRESP,
		// Write response valid. This signal indicates that the channel
    		// is signaling a valid write response.
		output wire  S_AXI_BVALID,
		// Response ready. This signal indicates that the master
    		// can accept a write response.
		input wire  S_AXI_BREADY,
		// Read address (issued by master, acceped by Slave)
		input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
		// Protection type. This signal indicates the privilege
    		// and security level of the transaction, and whether the
    		// transaction is a data access or an instruction access.
		input wire [2 : 0] S_AXI_ARPROT,
		// Read address valid. This signal indicates that the channel
    		// is signaling valid read address and control information.
		input wire  S_AXI_ARVALID,
		// Read address ready. This signal indicates that the slave is
    		// ready to accept an address and associated control signals.
		output wire  S_AXI_ARREADY,
		// Read data (issued by slave)
		output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
		// Read response. This signal indicates the status of the
    		// read transfer.
		output wire [1 : 0] S_AXI_RRESP,
		// Read valid. This signal indicates that the channel is
    		// signaling the required read data.
		output wire  S_AXI_RVALID,
		// Read ready. This signal indicates that the master can
    		// accept the read data and response information.
		input wire  S_AXI_RREADY
	);

	// AXI4LITE signals
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
	reg  	axi_awready;
	reg  	axi_wready;
	reg [1 : 0] 	axi_bresp;
	reg  	axi_bvalid;
	reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
	reg  	axi_arready;
	reg [C_S_AXI_DATA_WIDTH-1 : 0] 	axi_rdata;
	reg [1 : 0] 	axi_rresp;
	reg  	axi_rvalid;

	// Example-specific design signals
	// local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	// ADDR_LSB is used for addressing 32/64 bit registers/memories
	// ADDR_LSB = 2 for 32 bits (n downto 2)
	// ADDR_LSB = 3 for 64 bits (n downto 3)
	localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
	localparam integer OPT_MEM_ADDR_BITS = 3;

    localparam A_BASE = 8'h10;
    localparam B_BASE = 8'h40;


	reg [C_S_AXI_DATA_WIDTH-1:0]	ctrl_reg;
	reg [C_S_AXI_DATA_WIDTH-1:0]	a_reg[N_x-1:0];
	reg [C_S_AXI_DATA_WIDTH-1:0]	b_reg[N_y-1:0];
	reg [C_S_AXI_DATA_WIDTH-1:0]	a_out_reg[N_x-1:0];
	reg [C_S_AXI_DATA_WIDTH-1:0]	b_out_reg[N_y-1:0];

	wire	 slv_reg_rden;
	wire	 slv_reg_wren;
	reg [C_S_AXI_DATA_WIDTH-1:0]	 reg_data_out;
	integer	 byte_index;
	reg	 aw_en;
	
	
	genvar i;

    assign bypass = ctrl_reg[0];
    assign y_offset = ctrl_reg[7:4];

    for (i = 0; i < N_x; i = i + 1) begin
        assign a[i*A_WIDTH+:A_WIDTH] = a_out_reg[i];
        reg ready;
        
        always @(posedge S_AXI_ACLK) begin
            if (~S_AXI_ARESETN) begin
                a_out_reg[i] <= {A_WIDTH{1'b0}};
                ready <= 1'b0;
                a_send[i] <= {A_WIDTH{1'b0}};
            end else if (ready) begin
                if (a_send[i]) begin
                    if (a_recv[i]) begin
                        a_send[i] <= 1'b0;
                    end
                end else if (~a_recv[i]) begin
                    if (a_reg[i] != a_out_reg[i]) begin
                        a_out_reg[i] <= a_reg[i];
                        a_send[i] <= 1'b1;
                    end
                end
            end else if (~a_recv[i]) begin
                a_send[i] <= 1'b1;
                ready <= 1'b1;
            end
        end
    end

    for (i = 0; i < N_y; i = i + 1) begin
        assign b[i*B_WIDTH+:B_WIDTH] = b_out_reg[i];
        reg ready;

        always @(posedge S_AXI_ACLK) begin
            if (~S_AXI_ARESETN) begin
                b_out_reg[i] <= {A_WIDTH{1'b0}};
                ready <= 1'b0;
                b_send[i] <= 1'b0;
            end else if (ready) begin
                if (b_send[i]) begin
                    if (b_recv[i]) begin
                        b_send[i] <= 1'b0;
                    end
                end else if (~b_recv[i]) begin
                    if (b_reg[i] != b_out_reg[i]) begin
                        b_out_reg[i] <= b_reg[i];
                        b_send[i] <= 1'b1;
                    end
                end
            end else if (~b_recv[i]) begin
                b_send[i] <= 1'b1;
                ready <= 1'b1;
            end
        end
    end
    
	// I/O Connections assignments

	assign S_AXI_AWREADY	= axi_awready;
	assign S_AXI_WREADY	= axi_wready;
	assign S_AXI_BRESP	= axi_bresp;
	assign S_AXI_BVALID	= axi_bvalid;
	assign S_AXI_ARREADY	= axi_arready;
	assign S_AXI_RDATA	= axi_rdata;
	assign S_AXI_RRESP	= axi_rresp;
	assign S_AXI_RVALID	= axi_rvalid;
	// Implement axi_awready generation
	// axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	// de-asserted when reset is low.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awready <= 1'b0;
	      aw_en <= 1'b1;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // slave is ready to accept write address when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_awready <= 1'b1;
	          aw_en <= 1'b0;
	        end
	        else if (S_AXI_BREADY && axi_bvalid)
	            begin
	              aw_en <= 1'b1;
	              axi_awready <= 1'b0;
	            end
	      else           
	        begin
	          axi_awready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_awaddr latching
	// This process is used to latch the address when both 
	// S_AXI_AWVALID and S_AXI_WVALID are valid. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_awaddr <= 0;
	    end 
	  else
	    begin    
	      if (~axi_awready && S_AXI_AWVALID && S_AXI_WVALID && aw_en)
	        begin
	          // Write Address latching 
	          axi_awaddr <= S_AXI_AWADDR;
	        end
	    end 
	end       

	// Implement axi_wready generation
	// axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	// S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	// de-asserted when reset is low. 

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_wready <= 1'b0;
	    end 
	  else
	    begin    
	      if (~axi_wready && S_AXI_WVALID && S_AXI_AWVALID && aw_en )
	        begin
	          // slave is ready to accept write data when 
	          // there is a valid write address and write data
	          // on the write address and data bus. This design 
	          // expects no outstanding transactions. 
	          axi_wready <= 1'b1;
	        end
	      else
	        begin
	          axi_wready <= 1'b0;
	        end
	    end 
	end       

	// Implement memory mapped register select and write logic generation
	// The write data is accepted and written to memory mapped registers when
	// axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	// select byte enables of slave registers while writing.
	// These registers are cleared when reset (active low) is applied.
	// Slave register write enable is asserted when valid address and data are available
	// and the slave is ready to accept the write address and write data.
	assign slv_reg_wren = axi_wready && S_AXI_WVALID && axi_awready && S_AXI_AWVALID;

    wire [C_S_AXI_ADDR_WIDTH-3:0] wreg_no;
    wire [C_S_AXI_ADDR_WIDTH-3:0] rreg_no;

    assign wreg_no = axi_awaddr[C_S_AXI_ADDR_WIDTH-1:ADDR_LSB];
    assign rreg_no = axi_araddr[C_S_AXI_ADDR_WIDTH-1:ADDR_LSB];

    wire [31:0] awreg_no = wreg_no - A_BASE;
    wire [31:0] arreg_no = rreg_no - A_BASE;
    

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
            ctrl_reg <= 32'b1; // Start with bypass enabled
            a_reg[0]<=INIT_A0;
            a_reg[1]<=INIT_A1;
            a_reg[2]<=INIT_A2;
            a_reg[3]<=INIT_A3;
            a_reg[4]<=INIT_A4;
            a_reg[5]<=INIT_A5;
            a_reg[6]<=INIT_A6;
            a_reg[7]<=INIT_A7;
            a_reg[8]<=INIT_A8;
            a_reg[9]<=INIT_A9;
            a_reg[10]<=INIT_A10;
            a_reg[11]<=INIT_A11;
            a_reg[12]<=INIT_A12;
            a_reg[13]<=INIT_A13;
            a_reg[14]<=INIT_A14;
            a_reg[15]<=INIT_A15;
            a_reg[16]<=INIT_A16;
            a_reg[17]<=INIT_A17;
            a_reg[18]<=INIT_A18;
            a_reg[19]<=INIT_A19;
            a_reg[20]<=INIT_A20;
            a_reg[21]<=INIT_A21;
            a_reg[22]<=INIT_A22;
            a_reg[23]<=INIT_A23;
            a_reg[24]<=INIT_A24;
            a_reg[25]<=INIT_A25;
            a_reg[26]<=INIT_A26;
            a_reg[27]<=INIT_A27;
            a_reg[28]<=INIT_A28;
            a_reg[29]<=INIT_A29;
            a_reg[30]<=INIT_A30;
            a_reg[31]<=INIT_A31;
            a_reg[32]<=INIT_A32;
            b_reg[0]<=INIT_B0;
            b_reg[1]<=INIT_B1;
        end 
	  else begin
	    if (slv_reg_wren)
	      begin
	        if ( wreg_no == 0 ) begin
	            for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                ctrl_reg[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	        end else if ( wreg_no >= A_BASE && wreg_no < A_BASE + N_x ) begin
                for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                a_reg[wreg_no-A_BASE][(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	        end else if ( wreg_no >= B_BASE && wreg_no < B_BASE + N_y ) begin
                for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
	              if ( S_AXI_WSTRB[byte_index] == 1 ) begin
	                // Respective byte enables are asserted as per write strobes 
	                // Slave register 0
	                b_reg[wreg_no-B_BASE][(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
	              end  
	        end
	      end
	  end
	end    

	// Implement write response logic generation
	// The write response and response valid signals are asserted by the slave 
	// when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	// This marks the acceptance of address and indicates the status of 
	// write transaction.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_bvalid  <= 0;
	      axi_bresp   <= 2'b0;
	    end 
	  else
	    begin    
	      if (axi_awready && S_AXI_AWVALID && ~axi_bvalid && axi_wready && S_AXI_WVALID)
	        begin
	          // indicates a valid write response is available
	          axi_bvalid <= 1'b1;
	          axi_bresp  <= 2'b0; // 'OKAY' response 
	        end                   // work error responses in future
	      else
	        begin
	          if (S_AXI_BREADY && axi_bvalid) 
	            //check if bready is asserted while bvalid is high) 
	            //(there is a possibility that bready is always asserted high)   
	            begin
	              axi_bvalid <= 1'b0; 
	            end  
	        end
	    end
	end   

	// Implement axi_arready generation
	// axi_arready is asserted for one S_AXI_ACLK clock cycle when
	// S_AXI_ARVALID is asserted. axi_awready is 
	// de-asserted when reset (active low) is asserted. 
	// The read address is also latched when S_AXI_ARVALID is 
	// asserted. axi_araddr is reset to zero on reset assertion.

	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_arready <= 1'b0;
	      axi_araddr  <= 32'b0;
	    end 
	  else
	    begin    
	      if (~axi_arready && S_AXI_ARVALID)
	        begin
	          // indicates that the slave has acceped the valid read address
	          axi_arready <= 1'b1;
	          // Read address latching
	          axi_araddr  <= S_AXI_ARADDR;
	        end
	      else
	        begin
	          axi_arready <= 1'b0;
	        end
	    end 
	end       

	// Implement axi_arvalid generation
	// axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	// S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	// data are available on the axi_rdata bus at this instance. The 
	// assertion of axi_rvalid marks the validity of read data on the 
	// bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	// is deasserted on reset (active low). axi_rresp and axi_rdata are 
	// cleared to zero on reset (active low).  
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rvalid <= 0;
	      axi_rresp  <= 0;
	    end 
	  else
	    begin    
	      if (axi_arready && S_AXI_ARVALID && ~axi_rvalid)
	        begin
	          // Valid read data is available at the read data bus
	          axi_rvalid <= 1'b1;
	          axi_rresp  <= 2'b0; // 'OKAY' response
	        end   
	      else if (axi_rvalid && S_AXI_RREADY)
	        begin
	          // Read data is accepted by the master
	          axi_rvalid <= 1'b0;
	        end                
	    end
	end    

	// Implement memory mapped register select and read logic generation
	// Slave register read enable is asserted when valid address is available
	// and the slave is ready to accept the read address.
	assign slv_reg_rden = axi_arready & S_AXI_ARVALID & ~axi_rvalid;
	always @(*)
	begin
        if (rreg_no == 0) begin
           reg_data_out <= ctrl_reg;
        end else if (rreg_no >= A_BASE && rreg_no < A_BASE + N_x) begin
           reg_data_out <= a_reg[rreg_no-A_BASE];
        end else if (rreg_no >= B_BASE && rreg_no < B_BASE + N_y) begin
           reg_data_out <= b_reg[rreg_no-B_BASE];
        end else begin
           reg_data_out <= 0;
        end
	end

	// Output register or memory read data
	always @( posedge S_AXI_ACLK )
	begin
	  if ( S_AXI_ARESETN == 1'b0 )
	    begin
	      axi_rdata  <= 0;
	    end 
	  else
	    begin    
	      // When there is a valid read address (S_AXI_ARVALID) with 
	      // acceptance of read address by the slave (axi_arready), 
	      // output the read dada 
	      if (slv_reg_rden)
	        begin
	          axi_rdata <= reg_data_out;     // register read data
	        end   
	    end
	end    

	// Add user logic here

	// User logic ends

	endmodule
