`timescale 1ns / 1ps
//`define CHECK_AXIMM
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/05/2019 02:09:26 PM
// Design Name: 
// Module Name: IIR_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module quick_iir
(
    input wire clk,
    input wire rst,
    input wire [16*19-1:0] xin,
    input wire [16*2-1:0] yin,
    output reg [15:0] yout        
);
    integer x[18:0];
    integer y[1:0];
    
    integer a[18:0];
    integer b[1:0];
    
    integer ax[18:0];
    integer by[1:0];
        
    integer ysum;
    integer ybiased;
    
    initial
    begin
        a[18]<=65545;
        a[17]<=17;
        a[16]<=17;
        a[15]<=16;
        a[14]<=15;
        a[13]<=14;
        a[12]<=12;
        a[11]<=11;
        a[10]<=9;
        a[9]<=7;
        a[8]<=5;
        a[7]<=3;
        a[6]<=0;
        a[5]<=-2;
        a[4]<=-4;
        a[3]<=-6;
        a[2]<=-8;
        a[1]<=-365773;
        a[0]<=408169;
        b[1]<=365713;
        b[0]<=-408223;
    end
    
    genvar i;
    
    for (i = 0; i < 19; i = i + 1) assign x[i] = xin[16*i+:16];
    for (i = 0; i < 2; i = i + 1) assign y[i] = yin[16*i+:16];
    for (i = 0; i < 19; i = i + 1) assign ax[i] = x[i] * a[i];
    for (i = 0; i < 2; i = i + 1) assign by[i] = y[i] * b[i];
 
    assign ysum = (
            ax[0] + ax[1] + ax[2] + ax[3] +
            ax[4] + ax[5] + ax[6] + ax[7] +
            ax[8] + ax[9] + ax[10] + ax[11] +
            ax[12] + ax[13] + ax[14] + ax[15] +
            ax[16] + ax[17] + ax[18] +
            by[0] + by[1]
            );
            
    assign ybiased = (ysum < 0) ? ysum + 32'hFFFF : ysum;
    
    always @(posedge clk) yout <= rst ? 0 : ybiased[31:16];
        

endmodule

module IIR_tb(

    );
    
    localparam DEBUG=0;
    
    reg clk;
    reg resetn;
    reg [15:0] x[15:0];
    wire [15:0] y[15:0];
    wire [255:0] samples;
    wire [255:0] samples_out;
    reg sample_valid;

    reg aximm_aclk;
    reg aximm_aresetn;
    
    reg [9:0] aximm_awaddr;
    reg [9:0] aximm_araddr;
    reg aximm_awvalid;
    wire aximm_awready;
    reg [31:0] aximm_wdata;
    wire [31:0] aximm_rdata;
    wire aximm_arready;
    reg aximm_wvalid;
    wire aximm_rvalid;
    wire aximm_wready;
    reg aximm_bready;
    reg aximm_arvalid;
     
    AXIParallel2ndOrderIIR_v1_0 iir(.axis_aclk(clk), .axis_aresetn(resetn),
        .s00_axis_tdata(samples), .s00_axis_tvalid(sample_valid),
        .m00_axis_tdata(samples_out),
        .s00_axi_aclk(aximm_aclk),
        .s00_axi_aresetn(aximm_aresetn),
        .s00_axi_awaddr(aximm_awaddr),
        .s00_axi_awprot(3'b0),
        .s00_axi_awvalid(aximm_awvalid),
        .s00_axi_awready(aximm_awready),
        .s00_axi_wdata(aximm_wdata),
        .s00_axi_wstrb(4'b1111),
        .s00_axi_wvalid(aximm_wvalid),
        .s00_axi_wready(aximm_wready),
        .s00_axi_bready(aximm_bready),
        .s00_axi_araddr(aximm_araddr),
        .s00_axi_arvalid(aximm_arvalid),
        .s00_axi_rvalid(aximm_rvalid),
        .s00_axi_rdata(aximm_rdata),       
        .s00_axi_arready(aximm_arready),
        .s00_axi_rready(1'b1)
       );
        
    always #2 clk = ~clk;
    always #5 aximm_aclk = ~aximm_aclk;

    if (DEBUG) begin
        reg [255:0] lasty;
        reg [255:0] last_samples;
        reg [255:0] llsamples;
        wire [255:0] cheaty;
        wire [15:0] cly[15:0];
        wire [15:0] cy[15:0];
        wire [15:0] cllx[15:0];
        wire [15:0] clx[15:0];
        wire [15:0] cx[15:0];
               
        wire [3*256-1:0] xvec = { samples, last_samples, llsamples };
        wire [2*256-1:0] yvec = { cheaty, lasty };
    
        // 3 * 16 * 16
        // (3 * 16 - 15 - 19 + i) * 16
    
        always @(posedge clk) llsamples <= last_samples;
        always @(posedge clk) last_samples <= samples;
        always @(posedge clk) lasty <= cheaty;
    
        genvar i;
    
        for (i = 0; i < 16; i++)
        begin
            assign cx[i] = samples[16*i+:16];
            assign clx[i] = last_samples[16*i+:16];
            assign cllx[i] = llsamples[16*i+:16];
            assign cy[i] = cheaty[16*i+:16];
            assign cly[i] = lasty[16*i+:16];
        end
        
        for (i = 0; i < 16; i++)
        begin
            quick_iir qiir(.clk(clk), .rst(~resetn), 
                .xin(xvec[16*(i+14)+:19*16]), 
                .yin(yvec[16*(i+14)+:2*16]), 
                .yout(cheaty[16*i+:16]));
        end
    end    
    
    integer i, j;
    real t;

    genvar g;

    for (g = 0; g < 16; g = g + 1)
    begin
        assign samples[16*g+:16] = x[g];
        assign y[g] = samples_out[16*g+:16];
    end
    
    reg signed [15:0] xout;
    reg signed [15:0] yout;

    integer sub;
    
    always #0.250 
    begin
           xout = x[sub]; 
           yout = y[sub];
           sub = (sub < 15) ? sub + 1 : 0;
    end
    
    // 1/4G 1/100M
    // For each 250ps beat...
    localparam OMEGA = 295_000_000.0 * 2 * 3.1415926 / 4_000_000_000.0;

    always @(posedge aximm_aclk) if (aximm_rvalid) $display("AXI READ: ", aximm_rdata);

    task axi_read;
    input [31:0] addr;
    begin
        aximm_araddr <= addr;
        aximm_arvalid <= 1;
        wait(aximm_arready);
        @(posedge aximm_aclk);
        aximm_arvalid <= 0;
        @(posedge aximm_aclk);         
    end
    endtask
    
    task axi_write;
    input [31:0] addr;
    input [31:0] data;
    begin
        aximm_awaddr <=addr;
        aximm_awvalid <= 1;
        aximm_wdata <= data;
        aximm_wvalid <= 1;        
        wait (aximm_awready && aximm_wready);
        @(posedge aximm_aclk);
        aximm_awvalid <= 0;
        aximm_wvalid <= 0;
        @(posedge aximm_aclk);         
    end
    endtask
    
    initial
    begin
        clk <= 1'b1;
        resetn <= 1'b0;
        sub <= 0;
        
        for (i = 0; i < 16; i = i + 1) x[i] <= 0;
        sample_valid <= 1'b1;
        aximm_aclk <= 1'b0;
        aximm_aresetn <= 1'b0;
        aximm_awaddr <= 6'b0;
        aximm_awvalid <= 1'b0;
        aximm_wdata <= 32'b0;
        aximm_wvalid <= 1'b0;
        aximm_bready <= 1'b1;

        repeat (3) @(posedge aximm_aclk);
        aximm_aresetn <= 1'b1;

        repeat (50) @(posedge clk);
        resetn <= 1'b1;
 
        repeat (3) @(posedge aximm_aclk);
`ifdef CHECK_AXIMM
        axi_read(0);
        for(i = 0; i < 128; i++) begin
            axi_read(i*4);
        end
`endif        
        axi_write(0,0);
   
    
        repeat (100) @(posedge clk);

        x[0] <= 16'h2000;
        //samples <= 256'h0004_0003_0002_0001;
        @(posedge clk);
        x[0] <= 16'b0;
        
        repeat (40) @(posedge clk);
        
        t = 0.0;
        
        for (i = 0; i < 100; i++) begin
            for (j = 0; j < 16; j++) begin
                x[j] = $floor(16000.0 * $sin(t));
                t = t + OMEGA; 
            end
            @(posedge clk);    
        end
        
        for (i = 0; i < 16; i = i + 1) x[i] <= 0;
        repeat (25) @(posedge clk);
        
        $finish;
    end
        
endmodule
