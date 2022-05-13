`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/13 21:21:44
// Design Name: 
// Module Name: top
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


module top
#(parameter WIDTH_D = 8)
(
    input  [WIDTH_D-1:0]adata,
    input  aclk,
    input  arst_n,
    input  asend,            
    input  bclk,
    input  brst_n,
    input  bload,
    output [WIDTH_D-1:0]dout,
    output aready,  
    output bvalid
);


wire[WIDTH_D-1:0]data;
wire a_req,b_ack;

send_control sc1
(
    .adata(adata),
    .aclk(aclk),
    .arst_n(arst_n),
    .asend(asend),
    .b_ack(b_ack),             
    .dout(data),
    .aready(aready),
    .a_req(a_req)
);

receive_control rc1
(
    .bdata(data),
    .bclk(bclk),
    .brst_n(brst_n),
    .bload(bload),
    .a_req(a_req),
    .dout(dout),
    .b_ack(b_ack),
    .bvalid(bvalid)
);


endmodule
