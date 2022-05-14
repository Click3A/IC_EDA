`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/13 20:17:26
// Design Name: 
// Module Name: pulse_gen
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


module pulse_gen(
input d,
input clk,
input rst_n,
output pulse
    );
reg dr1,dr2;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
    {dr2,dr1}<=2'b0;
    else
    {dr2,dr1}<={dr1,d};
end

assign pulse = dr2^dr1;

endmodule
