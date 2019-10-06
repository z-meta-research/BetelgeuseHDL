`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/14/2019 06:30:15 PM
// Design Name: 
// Module Name: DDL_tb
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


module DDL_tb(

    );
    
    reg aclk;
    reg arstn;
    reg axilite_aclk;
    reg axilite_aresetn;
    
    reg[255:0] data_in;
    wire[255:0] data_out;
    wire valid_out;
    wire ready_in;
    
    
    DigitalDelayLine_v1_0 ddl(.aclk(aclk), .aresetn(arstn),
        .axi_data_in_tdata(data_in),
        .axi_data_in_tvalid(1'b1),
        .axi_data_in_tready(ready_in),
        .axi_data_out_tdata(data_out),
        .axi_data_out_tready(1'b1),
        .axi_data_out_tvalid(valid_out),
        .s00_axi_aclk(axilite_aclk),
        .s00_axi_aresetn(axilite_aresetn),
        .s00_axi_wvalid(1'b0),
        .s00_axi_awvalid(1'b0));
    
    always #5 aclk <= ~aclk;
    always #10 axilite_aclk <= ~axilite_aclk;
    
    always @(posedge aclk)
    begin
        if (~arstn)
            data_in <= { 16'd7, 16'd6, 16'd5, 16'd4, 16'd3, 16'd2, 16'd1, 16'd0, 16'd7, 16'd6, 16'd5, 16'd4, 16'd3, 16'd2, 16'd1, 16'd0 };
        else
            data_in <= { data_in[255:240] - 16'b1, data_in[239:224] - 16'b1,
                         data_in[223:208] - 16'b1, data_in[207:192] - 16'b1,
                         data_in[191:176] - 16'b1, data_in[175:160] - 16'b1,
                         data_in[159:144] - 16'b1, data_in[143:128] - 16'b1,
                         data_in[127:112] + 16'b1, data_in[111:96] + 16'b1,
                         data_in[95:80] + 16'b1, data_in[79:64] + 16'b1,
                         data_in[63:48] + 16'b1, data_in[47:32] + 16'b1,
                         data_in[31:16] + 16'b1, data_in[15:0] + 16'b1 };
    end
    
    initial
    begin
        aclk <= 0;
        arstn <= 0;
        axilite_aclk <= 0;
        axilite_aresetn <= 0;

        #100 arstn <= 1; axilite_aresetn <= 1;
        
    end
endmodule
