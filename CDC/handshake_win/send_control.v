`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/13 20:37:40
// Design Name: 
// Module Name: send_control
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


module send_control
#(parameter WIDTH_D = 8)
(
    input  [WIDTH_D-1:0]adata,
    input  aclk,
    input  arst_n,
    input  asend,
    input  b_ack,             
    output reg[WIDTH_D-1:0] dout,
    output aready,
    output a_req
);

wire ena;
wire aack;
always @(posedge aclk or negedge arst_n) begin
    if(!arst_n)
        dout <= 0;
    else if(ena)
        dout <= adata;
    else
        dout <= dout;
end

pulse_gen pg(.d(b_ack),.clk(aclk),.rst_n(arst_n),.pulse(aack));
localparam READY=1'b1 , BUSY=1'b0 ;
reg state,next;

always @(posedge aclk or negedge arst_n) begin
    if(!arst_n)
        state <= READY;
    else
        state <= next;
end

always@(*)begin
    case(state)
        READY:
            if(asend) next<=BUSY;
            else      next<=READY;
        BUSY :
            if(aack)  next<=READY;
            else      next<=BUSY;
        default:      next<=READY;
    endcase
end
assign aready = state;
assign ena    = asend&aready;

flop flop(.a(ena),.clk(aclk),.rst_n(arst_n),.b(a_req));


endmodule
