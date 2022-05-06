module ram_tb();
 reg[7:0] waddr,raddr;
 reg[7:0] wdata;
 reg      wclk,wclken,wfull;
 reg      rclk,rclken;
 wire[7:0]rdata;

 RAM utt(
 .waddr(waddr),
 .raddr(raddr),
 .wdata(wdata),
 .wclk(wclk),
 .wclken(wclken),
 .wfull(wfull),
 .rclk(rclk),
 .rclken(rclken),
 .rdata(rdata)
 );

 initial begin
     wclk = 1;
     wclken = 1;
     rclk = 1;
     rclken = 1;
 end
 always #10 wclk = ~wclk;
 always #20 rclk = ~rclk;

 initial begin
     wfull = 0;
     waddr = 0;
     raddr = 0;
     #20;
     repeat(100)begin
       #20;
       fork
       waddr = waddr + 1'b1;
       wdata = $random%256;
       join
     end
     repeat(50)begin
       #40;
       raddr = raddr + 1'b1;
     end
     #200;
     $finish;
 end

initial	begin
	$fsdbDumpfile("tb.fsdb");//这个是产生名为tb.fsdb的文件
	$fsdbDumpvars;
end

endmodule
