`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/25/2019 11:30:42 AM
// Design Name: 
// Module Name: ARS_tb
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


module ARS_tb(

    );
   
    reg clk;
    reg rstn;
    wire [255:0] tdata;
    reg [2:0] cnt;
    
    always #1 clk <= ~clk;
    
    AXIRandomStream ars(.axis_aclk(clk), .axis_aresetn(rstn),
        .axis_rand_out_tready(1),
        .axis_rand_out_tdata(tdata));
   
    always @(posedge clk) 
        if (~rstn)
        begin
            cnt <= 7;
        end else begin
            if (cnt != 0) begin
                cnt <= cnt - 1;
            end else begin
                $display("%4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x %4.4x", 
                        tdata[15:0], tdata[31:16], tdata[47:32], tdata[63:48],
                        tdata[79:64], tdata[95:80], tdata[111:96], tdata[127:112],
                        tdata[143:128], tdata[159:144], tdata[175:160], tdata[191:176],
                        tdata[207:192], tdata[223:208], tdata[239:224], tdata[255:240]);
            end
        end
   
    initial
    begin
        clk <= 0;
        rstn <= 0;
        
        repeat(10) @(posedge clk);
        rstn <= 1;
        
        repeat(1000) @(posedge clk);
        
        $finish;
    end
        
endmodule
