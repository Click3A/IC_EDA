`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/13 20:16:19
// Design Name: 
// Module Name: flop
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


module flop(
input a,
input clk,
input rst_n,
output reg b
    );

wire c;
assign c = a^b;
always @(posedge clk or negedge rst_n ) begin
    if(!rst_n)
    b <= 0;
    else
    b <= c;
end

endmodule
