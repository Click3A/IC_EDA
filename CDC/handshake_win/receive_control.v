`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/13 21:08:56
// Design Name: 
// Module Name: receive_control
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


module receive_control
#(parameter WIDTH_D = 8)
(
    input  [WIDTH_D-1:0]bdata,
    input  bclk,
    input  brst_n,
    input  bload,
    input  a_req,
    output reg[WIDTH_D-1:0]dout,
    output reg b_ack,
    output bvalid
);

wire ena;
wire req;
always @(posedge bclk or negedge brst_n) begin
    if(!brst_n)
        dout <= 0;
    else if(ena)
        dout <= bdata;
    else
        dout <= dout;
end

pulse_gen pg(.d(a_req),.clk(bclk),.rst_n(brst_n),.pulse(req));
localparam RECEIVE=1'b1 , WAIT=1'b0 ;
reg state,next;

always @(posedge bclk or negedge brst_n)begin
    if(!brst_n)
        state <= WAIT;
    else
        state <= next;
end

always@(*)begin
    case(state)
        RECEIVE:
            if(bload) next<=WAIT;
            else      next<=RECEIVE;
        WAIT :
            if(req)  next<=RECEIVE;
            else      next<=WAIT;
        default:      next<=RECEIVE;
    endcase
end
assign bvalid = state;
assign ena    = bload&bvalid;
/*always @(posedge bclk or negedge brst_n) begin
    if(!brst_n)
        ena<=1'b0;
    else if(bload&&bvalid)
        ena<=~ena;
    else
        ena<=ena;
end
*/

always @(posedge bclk or negedge brst_n) begin
    if(!brst_n)
        b_ack <= 0;
    else if(ena)
        b_ack <= ~b_ack;
    else
        b_ack <= b_ack;
end


endmodule
