`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/13 19:42:52
// Design Name: 
// Module Name: tb
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


module tb();

    reg  [7:0]adata;
    reg  aclk;
    reg  arst_n;
    reg  asend;    
    reg  bclk;
    reg  brst_n;
    reg  bload;
    wire [7:0]dout;
    wire aready;
    wire bvalid;    

top utt
(
    .adata(adata),
    .aclk(aclk),
    .arst_n(arst_n),
    .asend(asend),          
    .bclk(bclk),
    .brst_n(brst_n),
    .bload(bload),
    .dout(dout),
    .aready(aready), 
    .bvalid(bvalid) 
);



initial aclk = 0;
initial bclk = 0;
always #10 aclk = ~aclk;
always #14 bclk = ~bclk;

initial begin
    asend = 1;
    bload = 1;
    arst_n = 0;
    brst_n = 0;
    #20;
    arst_n = 1;
    brst_n = 1;
    #20;
end

initial begin
    repeat(15)begin
        adata = {$random}%256;
        #100;
    end
    $finish;
end

    initial	begin
	    $fsdbDumpfile("tb.fsdb");//这个是产生名为tb.fsdb的文件
	    $fsdbDumpvars;
    end

endmodule
