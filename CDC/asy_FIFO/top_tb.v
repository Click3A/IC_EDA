module top_sb();

 reg wclk,rclk,rst_n,winc,rinc;
 reg  [7:0]wdata;
 wire [7:0]rdata;
 wire full,empty;

 fifo_top utt(
 .wclk(wclk),
 .rclk(rclk),
 .rst_n(rst_n),
 .wdata(wdata),
 .rdata(rdata),
 .full(full),
 .empty(empty),
 .winc(winc),
 .rinc(rinc)
 );

 initial begin
    wclk = 1;
    rclk = 1;
    winc = 1;
    rinc = 0;
 end
 always #20 wclk = ~wclk;
 always #10 rclk = ~rclk;

 initial begin
     rst_n = 0;
     #20;
     rst_n = 1;
     #20;
     repeat(300)begin
         #20;
         wdata = $random%256;
     end
     rinc = 1;
     #200000;
     $finish;
 end

 initial	begin
	$fsdbDumpfile("tb.fsdb");//这个是产生名为tb.fsdb的文件
	$fsdbDumpvars;
end

endmodule



