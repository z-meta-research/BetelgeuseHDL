
`timescale 1 ns / 1 ps

module muladd
(
    input wire clk,
    input wire rst,
    input wire signed [15:0] sample,
    input wire signed [29:0] const,
    input wire signed [47:0] insum,
    output wire signed [47:0] out
);

        DSP48E2 #(
            // Feature Control Attributes: Data Path Selection
            .AMULTSEL("A"), // Selects A input to multiplier (A, AD)
            .A_INPUT("DIRECT"), // Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
            .BMULTSEL("B"), // Selects B input to multiplier (AD, B)
            .B_INPUT("DIRECT"), // Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
            .PREADDINSEL("A"), // Selects input to pre-adder (A, B)
            .RND(48'h000000000000), // Rounding Constant
            .USE_MULT("MULTIPLY"), // Select multiplier usage (DYNAMIC, MULTIPLY, NONE)
            .USE_SIMD("ONE48"), // SIMD selection (FOUR12, ONE48, TWO24)
            .USE_WIDEXOR("FALSE"), // Use the Wide XOR function (FALSE, TRUE)
            .XORSIMD("XOR24_48_96"), // Mode of operation for the Wide XOR (XOR12, XOR24_48_96)
            // Pattern Detector Attributes: Pattern Detection Configuration
            .AUTORESET_PATDET("NO_RESET"), // NO_RESET, RESET_MATCH, RESET_NOT_MATCH
            .AUTORESET_PRIORITY("RESET"), // Priority of AUTORESET vs. CEP (CEP, RESET).
            .MASK(48'h3fffffffffff), // 48-bit mask value for pattern detect (1=ignore)
            .PATTERN(48'h000000000000), // 48-bit pattern match for pattern detect
            .SEL_MASK("MASK"), // C, MASK, ROUNDING_MODE1, ROUNDING_MODE2
            .SEL_PATTERN("PATTERN"), // Select pattern value (C, PATTERN)
            .USE_PATTERN_DETECT("NO_PATDET"), // Enable pattern detect (NO_PATDET, PATDET)
            // Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
            .IS_ALUMODE_INVERTED(4'b0000), // Optional inversion for ALUMODE
            .IS_CARRYIN_INVERTED(1'b0), // Optional inversion for CARRYIN
            .IS_CLK_INVERTED(1'b0), // Optional inversion for CLK
            .IS_INMODE_INVERTED(5'b00000), // Optional inversion for INMODE
            .IS_OPMODE_INVERTED(9'b000000000), // Optional inversion for OPMODE
            .IS_RSTALLCARRYIN_INVERTED(1'b0), // Optional inversion for RSTALLCARRYIN
            .IS_RSTALUMODE_INVERTED(1'b0), // Optional inversion for RSTALUMODE
            .IS_RSTA_INVERTED(1'b0), // Optional inversion for RSTA
            .IS_RSTB_INVERTED(1'b0), // Optional inversion for RSTB
            .IS_RSTCTRL_INVERTED(1'b0), // Optional inversion for RSTCTRL
            .IS_RSTC_INVERTED(1'b0), // Optional inversion for RSTC
            .IS_RSTD_INVERTED(1'b0), // Optional inversion for RSTD
            .IS_RSTINMODE_INVERTED(1'b0), // Optional inversion for RSTINMODE
            .IS_RSTM_INVERTED(1'b0), // Optional inversion for RSTM
            .IS_RSTP_INVERTED(1'b0), // Optional inversion for RSTP
            // Register Control Attributes: Pipeline Register Configuration
            .ACASCREG(0), // Number of pipeline stages between A/ACIN and ACOUT (0-2)
            .ADREG(0), // Pipeline stages for pre-adder (0-1)
            .ALUMODEREG(0), // Pipeline stages for ALUMODE (0-1)
            .AREG(0), // Pipeline stages for A (0-2)
            .BCASCREG(0), // Number of pipeline stages between B/BCIN and BCOUT (0-2)
            .BREG(0), // Pipeline stages for B (0-2)
            .CARRYINREG(0), // Pipeline stages for CARRYIN (0-1)
            .CARRYINSELREG(0), // Pipeline stages for CARRYINSEL (0-1)
            .CREG(0), // Pipeline stages for C (0-1)
            .DREG(0), // Pipeline stages for D (0-1)
            .INMODEREG(0), // Pipeline stages for INMODE (0-1)
            .MREG(0), // Multiplier pipeline stages (0-1)
            .OPMODEREG(0), // Pipeline stages for OPMODE (0-1)
            .PREG(0) // Number of pipeline stages for P (0-1)
        )
        DSP48E2_inst (
            // Control outputs: Control Inputs/Status Bits
            //.OVERFLOW(OVERFLOW), // 1-bit output: Overflow in add/acc
            //.PATTERNBDETECT(PATTERNBDETECT), // 1-bit output: Pattern bar detect
            //.PATTERNDETECT(PATTERNDETECT), // 1-bit output: Pattern detect
            //.UNDERFLOW(UNDERFLOW), // 1-bit output: Underflow in add/acc
            // Data outputs: Data Ports
            .P(out), // 48-bit output: Primary data
            // Control inputs: Control Inputs/Status Bits
            .ALUMODE(4'b0000), // 4-bit input: ALU control
            .CARRYINSEL(3'b000), // 3-bit input: Carry select
            .CLK(clk), // 1-bit input: Clock
            .INMODE(5'b00000), // 5-bit input: INMODE control
            .OPMODE(9'b11_000_01_01), // 9-bit input: Operation mode
            // Data inputs: Data Ports
            .A(const), // 30-bit input: A data
            .B({ {2{sample[15]}}, sample}), // 18-bit input: B data
            .C(insum), // 48-bit input: C data
            .CARRYIN(1'b0), // 1-bit input: Carry-in
            .D(27'b0), // 27-bit input: D data
            // Reset/Clock Enable inputs: Reset/Clock Enable Inputs
            .CEA1(1'b0), // 1-bit input: Clock enable for 1st stage AREG
            .CEA2(1'b1), // 1-bit input: Clock enable for 2nd stage AREG
            .CEAD(1'b1), // 1-bit input: Clock enable for ADREG
            .CEALUMODE(1'b1), // 1-bit input: Clock enable for ALUMODE
            .CEB1(1'b0), // 1-bit input: Clock enable for 1st stage BREG
            .CEB2(1'b1), // 1-bit input: Clock enable for 2nd stage BREG
            .CEC(1'b1), // 1-bit input: Clock enable for CREG
            .CECARRYIN(1'b1), // 1-bit input: Clock enable for CARRYINREG
            .CECTRL(1'b1), // 1-bit input: Clock enable for OPMODEREG and CARRYINSELREG
            .CED(1'b1), // 1-bit input: Clock enable for DREG
            .CEINMODE(1'b1), // 1-bit input: Clock enable for INMODEREG
            .CEM(1'b1), // 1-bit input: Clock enable for MREG
            .CEP(1'b1), // 1-bit input: Clock enable for PREG
            .RSTA(rst), // 1-bit input: Reset for AREG
            .RSTALLCARRYIN(rst), // 1-bit input: Reset for CARRYINREG
            .RSTALUMODE(rst), // 1-bit input: Reset for ALUMODEREG
            .RSTB(rst), // 1-bit input: Reset for BREG
            .RSTC(rst), // 1-bit input: Reset for CREG
            .RSTCTRL(rst), // 1-bit input: Reset for OPMODEREG and CARRYINSELREG
            .RSTD(rst), // 1-bit input: Reset for DREG and ADREG
            .RSTINMODE(rst), // 1-bit input: Reset for INMODEREG        
            .RSTM(rst), // 1-bit input: Reset for MREG
            .RSTP(rst) // 1-bit input: Reset for PREG
        );        
   
endmodule

module muladdrnd
(
    input wire clk,
    input wire rst,
    input wire signed [15:0] sample,
    input wire signed [29:0] const,
    input wire signed [47:0] insum,
    output wire signed [47:0] out
);

        DSP48E2 #(
            // Feature Control Attributes: Data Path Selection
            .AMULTSEL("A"), // Selects A input to multiplier (A, AD)
            .A_INPUT("DIRECT"), // Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
            .BMULTSEL("B"), // Selects B input to multiplier (AD, B)
            .B_INPUT("DIRECT"), // Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
            .PREADDINSEL("A"), // Selects input to pre-adder (A, B)
            .RND(48'h000000007FFF), // Rounding Constant
            .USE_MULT("MULTIPLY"), // Select multiplier usage (DYNAMIC, MULTIPLY, NONE)
            .USE_SIMD("ONE48"), // SIMD selection (FOUR12, ONE48, TWO24)
            .USE_WIDEXOR("FALSE"), // Use the Wide XOR function (FALSE, TRUE)
            .XORSIMD("XOR24_48_96"), // Mode of operation for the Wide XOR (XOR12, XOR24_48_96)
            // Pattern Detector Attributes: Pattern Detection Configuration
            .AUTORESET_PATDET("NO_RESET"), // NO_RESET, RESET_MATCH, RESET_NOT_MATCH
            .AUTORESET_PRIORITY("RESET"), // Priority of AUTORESET vs. CEP (CEP, RESET).
            .MASK(48'h3fffffffffff), // 48-bit mask value for pattern detect (1=ignore)
            .PATTERN(48'h000000000000), // 48-bit pattern match for pattern detect
            .SEL_MASK("MASK"), // C, MASK, ROUNDING_MODE1, ROUNDING_MODE2
            .SEL_PATTERN("PATTERN"), // Select pattern value (C, PATTERN)
            .USE_PATTERN_DETECT("NO_PATDET"), // Enable pattern detect (NO_PATDET, PATDET)
            // Programmable Inversion Attributes: Specifies built-in programmable inversion on specific pins
            .IS_ALUMODE_INVERTED(4'b0000), // Optional inversion for ALUMODE
            .IS_CARRYIN_INVERTED(1'b0), // Optional inversion for CARRYIN
            .IS_CLK_INVERTED(1'b0), // Optional inversion for CLK
            .IS_INMODE_INVERTED(5'b00000), // Optional inversion for INMODE
            .IS_OPMODE_INVERTED(9'b000000000), // Optional inversion for OPMODE
            .IS_RSTALLCARRYIN_INVERTED(1'b0), // Optional inversion for RSTALLCARRYIN
            .IS_RSTALUMODE_INVERTED(1'b0), // Optional inversion for RSTALUMODE
            .IS_RSTA_INVERTED(1'b0), // Optional inversion for RSTA
            .IS_RSTB_INVERTED(1'b0), // Optional inversion for RSTB
            .IS_RSTCTRL_INVERTED(1'b0), // Optional inversion for RSTCTRL
            .IS_RSTC_INVERTED(1'b0), // Optional inversion for RSTC
            .IS_RSTD_INVERTED(1'b0), // Optional inversion for RSTD
            .IS_RSTINMODE_INVERTED(1'b0), // Optional inversion for RSTINMODE
            .IS_RSTM_INVERTED(1'b0), // Optional inversion for RSTM
            .IS_RSTP_INVERTED(1'b0), // Optional inversion for RSTP
            // Register Control Attributes: Pipeline Register Configuration
            .ACASCREG(0), // Number of pipeline stages between A/ACIN and ACOUT (0-2)
            .ADREG(0), // Pipeline stages for pre-adder (0-1)
            .ALUMODEREG(0), // Pipeline stages for ALUMODE (0-1)
            .AREG(0), // Pipeline stages for A (0-2)
            .BCASCREG(0), // Number of pipeline stages between B/BCIN and BCOUT (0-2)
            .BREG(0), // Pipeline stages for B (0-2)
            .CARRYINREG(0), // Pipeline stages for CARRYIN (0-1)
            .CARRYINSELREG(0), // Pipeline stages for CARRYINSEL (0-1)
            .CREG(0), // Pipeline stages for C (0-1)
            .DREG(0), // Pipeline stages for D (0-1)
            .INMODEREG(0), // Pipeline stages for INMODE (0-1)
            .MREG(0), // Multiplier pipeline stages (0-1)
            .OPMODEREG(0), // Pipeline stages for OPMODE (0-1)
            .PREG(1) // Number of pipeline stages for P (0-1)
        )
        DSP48E2_inst (
            // Control outputs: Control Inputs/Status Bits
            //.OVERFLOW(OVERFLOW), // 1-bit output: Overflow in add/acc
            //.PATTERNBDETECT(PATTERNBDETECT), // 1-bit output: Pattern bar detect
            //.PATTERNDETECT(PATTERNDETECT), // 1-bit output: Pattern detect
            //.UNDERFLOW(UNDERFLOW), // 1-bit output: Underflow in add/acc
            // Data outputs: Data Ports
            .P(out), // 48-bit output: Primary data
            // Control inputs: Control Inputs/Status Bits
            .ALUMODE(4'b0000), // 4-bit input: ALU control
            .CARRYINSEL(3'b111), // 3-bit input: Carry select
            .CLK(clk), // 1-bit input: Clock
            .INMODE(5'b00000), // 5-bit input: INMODE control
            .OPMODE(9'b10_011_01_01), // 9-bit input: Operation mode
            // Data inputs: Data Ports
            .A(const), // 30-bit input: A data
            .B({ {2{sample[15]}}, sample}), // 18-bit input: B data
            .C(insum), // 48-bit input: C data
            .CARRYIN(1'b0), // 1-bit input: Carry-in
            .D(27'b0), // 27-bit input: D data
            // Reset/Clock Enable inputs: Reset/Clock Enable Inputs
            .CEA1(1'b0), // 1-bit input: Clock enable for 1st stage AREG
            .CEA2(1'b1), // 1-bit input: Clock enable for 2nd stage AREG
            .CEAD(1'b1), // 1-bit input: Clock enable for ADREG
            .CEALUMODE(1'b1), // 1-bit input: Clock enable for ALUMODE
            .CEB1(1'b0), // 1-bit input: Clock enable for 1st stage BREG
            .CEB2(1'b1), // 1-bit input: Clock enable for 2nd stage BREG
            .CEC(1'b1), // 1-bit input: Clock enable for CREG
            .CECARRYIN(1'b1), // 1-bit input: Clock enable for CARRYINREG
            .CECTRL(1'b1), // 1-bit input: Clock enable for OPMODEREG and CARRYINSELREG
            .CED(1'b1), // 1-bit input: Clock enable for DREG
            .CEINMODE(1'b1), // 1-bit input: Clock enable for INMODEREG
            .CEM(1'b1), // 1-bit input: Clock enable for MREG
            .CEP(1'b1), // 1-bit input: Clock enable for PREG
            .RSTA(rst), // 1-bit input: Reset for AREG
            .RSTALLCARRYIN(rst), // 1-bit input: Reset for CARRYINREG
            .RSTALUMODE(rst), // 1-bit input: Reset for ALUMODEREG
            .RSTB(rst), // 1-bit input: Reset for BREG
            .RSTC(rst), // 1-bit input: Reset for CREG
            .RSTCTRL(rst), // 1-bit input: Reset for OPMODEREG and CARRYINSELREG
            .RSTD(rst), // 1-bit input: Reset for DREG and ADREG
            .RSTINMODE(rst), // 1-bit input: Reset for INMODEREG        
            .RSTM(rst), // 1-bit input: Reset for MREG
            .RSTP(rst) // 1-bit input: Reset for PREG
        );        
   
endmodule

module AXIParallel2ndOrderIIR_v1_0 #
(
    // Users to add parameters here
    // User parameters ends
    // Do not modify the parameters beyond this line


    // Parameters of Axi Slave Bus Interface S00_AXI
    parameter integer C_S00_AXI_DATA_WIDTH	= 32,
    parameter integer C_S00_AXI_ADDR_WIDTH	= 9,

    // Parameters of Axi Slave Bus Interface S00_AXIS
    parameter integer C_AXIS_TDATA_WIDTH	= 256,
    
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

    // Ports of Axi Slave Bus Interface S00_AXIS
    input wire  axis_aclk,
    input wire  axis_aresetn,
    
    output wire  s00_axis_tready,
    input wire [C_AXIS_TDATA_WIDTH-1 : 0] s00_axis_tdata,
    input wire  s00_axis_tvalid,

    // Ports of Axi Master Bus Interface M00_AXIS
    output wire  m00_axis_tvalid,
    output wire [C_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
    input wire  m00_axis_tready
);
	// Add user logic here
	localparam SAMPLE_WIDTH = 16;
	localparam N_SAMPLES    = C_AXIS_TDATA_WIDTH/SAMPLE_WIDTH;
    localparam N_x = 33;
    localparam N_y = 2;
    localparam A_WIDTH=30;
    localparam B_WIDTH=30;
    
    genvar i, j;
    
    wire bypass_aximm;
    wire bypass;    
    wire [N_x*A_WIDTH-1:0] a_aximm;
    wire [N_y*B_WIDTH-1:0] b_aximm;
    wire [N_x-1:0] a_valid, a_send, a_recv;
    reg [N_x-1:0] a_updated;
    wire [N_y-1:0] b_valid, b_send, b_recv;
    reg [N_y-1:0] b_updated;
    wire [N_x*A_WIDTH-1:0] a_sync;
    wire [N_y*B_WIDTH-1:0] b_sync;
    reg signed [A_WIDTH-1:0] a[N_x - 1:0];
    reg signed [B_WIDTH-1:0] b[N_y - 1:0];
    
// Instantiation of Axi Bus Interface S00_AXI
	AXIParallel2ndOrderIIR_v1_0_S00_AXI # (
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) AXIParallel2ndOrderIIR_v1_0_S00_AXI_inst (
        .bypass(bypass_aximm),
        .a(a_aximm),
        .a_send(a_send),
        .a_recv(a_recv),
        .b(b_aximm),
        .b_send(b_send),
        .b_recv(b_recv),
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
	
	
	xpm_cdc_single #(
	   .SRC_INPUT_REG(1)
	) bypass_cdc (
	   .dest_clk(axis_aclk),
	   .dest_out(bypass),
	   .src_clk(s00_axi_aclk),
	   .src_in(bypass_aximm));
	
	
	for (i = 0; i < N_x; i = i + 1) begin   
        // Add user logic here
        xpm_cdc_handshake #(
            .DEST_EXT_HSK(0),
            .DEST_SYNC_FF(2),
            .INIT_SYNC_FF(0),
            .SIM_ASSERT_CHK(1),
            .SRC_SYNC_FF(2),
            .WIDTH(30))
            scale_handshake(
                .dest_clk(axis_aclk),
                .dest_out(a_sync[A_WIDTH*i+:A_WIDTH]),
                .dest_req(a_valid[i]),
                .src_clk(s00_axi_aclk),
                .src_in(a_aximm[A_WIDTH*i+:A_WIDTH]),
                .src_send(a_send[i]),
                .src_rcv(a_recv[i])
            );
            
        always @(posedge axis_aclk) 
            if (~axis_aresetn) begin
                a[i] <= {A_WIDTH{1'b0}};
                a_updated[i] <= 1'b0; 
            end else if (a_valid[i] || ~a_updated[i]) begin
                a[i] <= a_sync[A_WIDTH * i+:A_WIDTH];
                a_updated[i] <= 1'b1;
            end
    end	
    
	for (i = 0; i < N_y; i = i + 1) begin   
        // Add user logic here
        xpm_cdc_handshake #(
            .DEST_EXT_HSK(0),
            .DEST_SYNC_FF(2),
            .INIT_SYNC_FF(0),
            .SIM_ASSERT_CHK(1),
            .SRC_SYNC_FF(2),
            .WIDTH(30))
            scale_handshake(
                .dest_clk(axis_aclk),
                .dest_out(b_sync[B_WIDTH*i+:B_WIDTH]),
                .dest_req(b_valid[i]),
                .src_clk(s00_axi_aclk),
                .src_in(b_aximm[B_WIDTH*i+:B_WIDTH]),
                .src_send(b_send[i]),
                .src_rcv(b_recv[i])
            );

        always @(posedge axis_aclk) 
            if (~axis_aresetn) begin
                b[i] <= {B_WIDTH{1'b0}};
                b_updated[i] <= 1'b0; 
            end else if (b_valid[i] || ~b_updated[i]) begin
                b[i] <= b_sync[B_WIDTH * i+:B_WIDTH];
                b_updated[i] <= 1'b1;
            end
    end	
    
    wire [C_AXIS_TDATA_WIDTH-1:0] rf_in_raw, rf_in;
    wire [C_AXIS_TDATA_WIDTH-1:0] rf_out;
    wire rf_in_valid;
    wire rf_in_rd_busy;
    wire rf_in_wr_busy;
    wire rf_out_valid;
    wire rf_out_rd_busy;
    wire rf_out_wr_busy;

    reg [5:0] cnt;
    wire ready = (cnt == 6'b0);
    
    always @(posedge axis_aclk)
    begin
        if (~axis_aresetn) begin
            cnt <= 6'h3F;
        end else if (cnt != 6'b0) begin
            cnt <= cnt - 1;
        end 
    end

    assign s00_axis_tready = axis_aresetn;
    assign m00_axis_tvalid = 1'b1;
    
    
    localparam FILTER_WIDTH=(N_x+N_SAMPLES);
    
    reg [48*N_SAMPLES-1:0] sysbus [N_x:0];
    reg [FILTER_WIDTH*SAMPLE_WIDTH-1:0] sampbus [N_x-1:0];
    
    always @(posedge axis_aclk) sysbus[0] <= {48*N_SAMPLES{1'b0}};
    always @(posedge axis_aclk) sampbus[0] <= ~axis_aresetn ? {FILTER_WIDTH*N_SAMPLES{1'b0}} : 
        { s00_axis_tdata, sampbus[0][SAMPLE_WIDTH*N_SAMPLES+:SAMPLE_WIDTH*(FILTER_WIDTH-N_SAMPLES)] };

    for (i = 1; i < N_x; i = i + 1)
    begin
        always @(posedge axis_aclk) sampbus[i] <= ~axis_aresetn ? {FILTER_WIDTH*N_SAMPLES{1'b0}} : sampbus[i-1];
    end
    
    localparam WINDOW_WIDTH=N_SAMPLES*SAMPLE_WIDTH;
    wire [WINDOW_WIDTH-1:0] sampwindow[N_x-1:0];
    
    // First 3 for SLA
    for (i = 0; i < N_x; i = i + 1)
    begin
        integer sample_base = (FILTER_WIDTH-N_SAMPLES-i) * SAMPLE_WIDTH;
        assign sampwindow[i] = sampbus[i][sample_base+:WINDOW_WIDTH];
        
        for (j = 0; j < N_SAMPLES; j = j + 1)
        begin
            wire [47:0] out;
            
            muladd ma(.clk(axis_aclk), .rst(~axis_aresetn),
                    .sample(sampwindow[i][SAMPLE_WIDTH*j+:16]),
                    .const(a[i]),
                    .insum(sysbus[i][48*j+:48]),
                    .out(out)
                    );
                    
            always @(posedge axis_aclk) sysbus[i+1][48*j+:48] <= ready ? out : 48'b0;
        end
    end

    wire [47:0] axs[N_SAMPLES-1:0];
    
    for (i = 0; i < N_SAMPLES; i = i + 1) 
    begin
        assign axs[i] = sysbus[N_x][48*i+:48];
    end        
    
    wire [48-1:0] b1y_out [N_SAMPLES-1:0];
        
    // Discrete form denominator taps
    localparam Y0_TAP_OFFSET=16;
    localparam Y1_TAP_OFFSET=32;
    // Now, the last cycles Y is at 2*N_SAMPLES+i
    // So 2*N_SAMPLES+i-Y0_TAP_OFFSET is where our tap should be
    localparam Y0_OFFSET=3*N_SAMPLES-Y0_TAP_OFFSET;
    localparam Y1_OFFSET=3*N_SAMPLES-Y1_TAP_OFFSET;
    
    wire [SAMPLE_WIDTH-1:0] y0[N_SAMPLES-1:0];
    reg [SAMPLE_WIDTH-1:0] y1[N_SAMPLES-1:0];
    
    for (i = 0; i < N_SAMPLES; i = i + 1)
    begin
        assign y0[i] = b1y_out[i][31:16];
        always @(posedge axis_aclk) y1[i] <= y0[i];
    end
    
    for (i = 0; i < N_SAMPLES; i = i + 1)
    begin
        wire signed [47:0] b0y_out;
        
        muladd b0ma(.clk(axis_aclk), .rst(~axis_aresetn),
            .sample(y0[i]),
            .const(b[0]),
            .insum(sysbus[N_x][48*i+:48]),
            .out(b0y_out));
            
        muladdrnd b1ma(.clk(axis_aclk), .rst(~axis_aresetn),
            .sample(y1[i]),
            .const(b[1]),
            .insum(b0y_out),
            .out(b1y_out[i]));
    end
    
    for (i = 0; i < N_SAMPLES; i = i + 1)
    begin
        assign m00_axis_tdata[16*i+:16] = bypass ? s00_axis_tdata[16*i+:16] : y0[i];
    end    
    
	// User logic ends

endmodule
