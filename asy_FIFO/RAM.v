
module RAM
#(parameter ADDSIZE  = 8,//能够存储256个数据
  parameter DATASIZE = 8 //每个数据位宽为8位
 )
 (
  input  [ADDSIZE-1:0]  waddr,raddr,
  input  [DATASIZE-1:0] wdata,
  input  wclk,wclken,wfull,
  input  rclk,rclken,
  output reg[DATASIZE-1:0] rdata
 );

 localparam DEPTH = 1<<ADDSIZE;      //深度的表示
 reg [DATASIZE-1:0] mem [0:DEPTH-1];//存储数组

 always@(posedge wclk)begin
     if(wclken&&!wfull)
         mem[waddr]<= wdata;
     else
         mem[waddr]<= 8'd0;
 end

 always@(posedge rclk)begin
     if(rclken)
         rdata <= mem[raddr];
     else
         rdata <= 8'd0;
 end
endmodule

