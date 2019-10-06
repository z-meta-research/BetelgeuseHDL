`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2019 09:26:20 PM
// Design Name: 
// Module Name: RFSA_tb
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


module RFSA_tb(

    );
    
    reg aclk;
    reg aresetn;
    wire main_ready;
    wire sub_ready;
    wire rf_valid;
    reg [255:0] sub_data_in;
    reg [255:0] main_data_in;
    wire [255:0] rf_data_out;
    
        
    RFStreamAdder_v1_0 #(.N_SUB_STREAMS(2)) sa(.axis_aclk(aclk),
                          .axis_aresetn(aresetn),
                          .s00_axi_aclk(aclk),
                          .s00_axi_aresetn(aresetn),
                          .axi_main_in_tdata(main_data_in),
                          .axi_main_in_tvalid(1'b1),
                          .axi_main_in_tready(main_ready),
                          .axi_sub0_in_tdata(sub_data_in),
                          .axi_sub0_in_tvalid(1'b1),
                          .axi_sub0_in_tready(sub_ready),
                          .axi_sub1_in_tdata(sub_data_in),
                          .axi_sub1_in_tvalid(1'b1),
                          .axi_sub1_in_tready(sub_ready),
                          .axi_rf_out_tdata(rf_data_out),
                          .axi_rf_out_tvalid(rf_valid),
                          .axi_rf_out_tready(1'b1)
                          );

    always @(posedge aclk)
    begin
        if (~aresetn) begin
            main_data_in <= { 16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFF, 16'hFFFFF, 
                              16'h0100, 16'h0100, 16'h0100, 16'h0100, 16'h0100, 16'h0100, 16'h0100, 16'h0100 };
            sub_data_in <= { 
                             16'h8000, 16'h8001, 16'h8002, 16'h8003, 16'd3, 16'd2, 16'd1, 16'd0,
                             16'h8000, 16'h8001, 16'h8002, 16'h8003, 16'd3, 16'd2, 16'd1, 16'd0
                             };
        end else begin
            sub_data_in <= { 
                             sub_data_in[255:240] + 16'b1, sub_data_in[239:224] + 16'b1,
                             sub_data_in[223:208] + 16'b1, sub_data_in[207:192] + 16'b1,
                             sub_data_in[191:176] + 16'b1, sub_data_in[175:160] + 16'b1,
                             sub_data_in[159:144] + 16'b1, sub_data_in[143:128] + 16'b1,
                             sub_data_in[127:112] + 16'b1, sub_data_in[111:96] + 16'b1,
                             sub_data_in[95:80] + 16'b1, sub_data_in[79:64] + 16'b1,
                             sub_data_in[63:48] + 16'b1, sub_data_in[47:32] + 16'b1,
                             sub_data_in[31:16] + 16'b1, sub_data_in[15:0] + 16'b1 
                           };
        end
    end

    always #5 aclk <= ~aclk;
                          
    initial
    begin
        aclk <= 0;
        aresetn <= 0;
        
        #100 aresetn <= 1;
        
        repeat(1000) @(posedge aclk);
        
        $finish();
    end                      
endmodule
