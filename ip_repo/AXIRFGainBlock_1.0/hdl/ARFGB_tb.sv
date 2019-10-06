`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2019 06:57:55 AM
// Design Name: 
// Module Name: ARFGB_tb
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


module ARFGB_tb(
        
    );
    reg aclk;
    reg aresetn;
    reg axilite_aclk;
    reg axilite_aresetn;
    
    reg [31:0] axilite_wdata;
    reg [3:0] axilite_awaddr;
    reg axilite_awvalid;
    reg axilite_wvalid;
    reg [3:0] axilite_wstrb;
    
    reg [255:0] samples_in;
    wire [255:0] samples_out;
    AXIRFGainBlock_v1_0 gb(
        .s00_axi_aclk(axilite_aclk), .s00_axi_aresetn(axilite_aresetn),
        .s00_axi_wdata(axilite_wdata), .s00_axi_awaddr(axilite_awaddr), .s00_axi_wstrb(axilite_wstrb),
        .s00_axi_awvalid(axilite_awvalid), .s00_axi_wvalid(axilite_wvalid),
        .axis_aclk(aclk), .axis_aresetn(aresetn),
        .rf_in_tdata(samples_in), .rf_in_tvalid(1),
        .rf_out_tdata(samples_out), .rf_out_tready(1));
    
    
    initial
    begin
        aclk <= 0;
        axilite_aclk <= 0;
        aresetn <= 0;
        axilite_aresetn <= 0;
        axilite_wvalid <= 0;
        axilite_awvalid <= 0;
        
        samples_in <= 256'h0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_FFFF_0000_8000_1000_0064;
        
        #100 aresetn <= 1; axilite_aresetn <= 1;

        repeat (20) @(posedge axilite_aclk);
        
        axilite_wdata <= 32'h000A_0000;
        axilite_awaddr <= 4'b0;
        axilite_wstrb <= 4'b1111;
        axilite_awvalid <= 1'b1;
        axilite_wvalid <= 1'b1;
        
        @(posedge axilite_aclk);
    end
    
    always #5 aclk = ~aclk;
    always #5 axilite_aclk = ~axilite_aclk;
    
   
    
endmodule
