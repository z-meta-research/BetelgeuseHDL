
`timescale 1 ns / 1 ps

	module AXIRMSDetector_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line
		
		// Parameters of Axi Master Bus Interface RF_OUT
		parameter integer C_AXIS_TDATA_WIDTH	= 256,

		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 4
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line
        input wire axis_aclk,
        input wire axis_aresetn,

		// Ports of Axi Slave Bus Interface RF_IN
		output wire  rf_in_tready,
		input wire [C_AXIS_TDATA_WIDTH-1 : 0] rf_in_tdata,
		input wire  rf_in_tvalid,

		// Ports of Axi Master Bus Interface RF_OUT
		output wire  rf_out_tvalid,
		output wire [C_AXIS_TDATA_WIDTH-1 : 0] rf_out_tdata,
		input wire  rf_out_tready,

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
		input wire  s00_axi_rready
	);

    assign rf_out_tdata = rf_in_tdata;
    assign rf_in_tready = rf_out_tready;
    assign rf_out_tvalid = rf_in_tvalid;

    localparam N_WORDS = C_AXIS_TDATA_WIDTH / 16;


// Instantiation of Axi Bus Interface S00_AXI
	AXIRMSDetector_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) AXIRMSDetector_v1_0_S00_AXI_inst (
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
	wire [47:0] squares[N_WORDS-1:0];
	wire rst;
    genvar i;
    assign rst = ~axis_aresetn;
    
    assign rf_out_tdata = rf_in_tdata;
    assign rf_out_tvalid = rf_in_tvalid;
    assign rf_in_tready = rf_out_tready;
    
    for(i = 0; i < N_WORDS; i = i + 1)
    begin
        wire [15:0] sample;
        
        assign sample = rf_in_tdata[16*i+:16];
    
        DSP48E2 #(
            // Feature Control Attributes: Data Path Selection
            .AMULTSEL("AD"), // Selects A input to multiplier (A, AD)
            .A_INPUT("DIRECT"), // Selects A input source, "DIRECT" (A port) or "CASCADE" (ACIN port)
            .BMULTSEL("AD"), // Selects B input to multiplier (AD, B)
            .B_INPUT("DIRECT"), // Selects B input source, "DIRECT" (B port) or "CASCADE" (BCIN port)
            .PREADDINSEL("B"), // Selects input to pre-adder (A, B)
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
            .P(squares[i]), // 48-bit output: Primary data
            // Control inputs: Control Inputs/Status Bits
            .ALUMODE(4'b0000), // 4-bit input: ALU control
            .CARRYINSEL(3'b000), // 3-bit input: Carry select
            .CLK(axis_aclk), // 1-bit input: Clock
            .INMODE(5'b00000), // 5-bit input: INMODE control
            .OPMODE(9'b11_000_01_01), // 9-bit input: Operation mode
            // Data inputs: Data Ports
            .A(30'b0), // 30-bit input: A data
            .B({ {2{sample[15]}}, sample}), // 18-bit input: B data
            .C(48'b0), // 48-bit input: C data
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
    end

	// User logic ends

endmodule
