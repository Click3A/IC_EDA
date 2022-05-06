module fifo_top
#(parameter ADDSIZE  = 8,//能够存储256个数据
  parameter DATASIZE = 8 //每个数据位宽为8位
 )
(
 input wclk,rclk,rst_n,winc,rinc,
 input [DATASIZE-1:0]wdata,
 output[DATASIZE-1:0]rdata,
 output full,empty
);

wire[ADDSIZE-1:0]waddr;
wire[ADDSIZE-1:0]raddr;
wire[ADDSIZE:0]rptr;
wire[ADDSIZE:0]wptr;

RAM ut1(
 .waddr(waddr),
 .raddr(raddr),
 .wdata(wdata),
 .wclk(wclk),
 .wclken(1'b1),
 .wfull(full),
 .rempty(empty),
 .rclk(rclk),
 .rclken(1'b1),
 .rdata(rdata)
 );

w_control ut2(
 .wclk(wclk),
 .wrst_n(rst_n),
 .winc(winc),
 .rptr(rptr),
 .waddr(waddr),
 .wfull(full),
 .wptr(wptr)
);

r_control ut3(
 .rclk(rclk),
 .rrst_n(rst_n),
 .rinc(rinc),
 .wptr(wptr),
 .raddr(raddr),
 .rempty(empty),
 .rptr(rptr)
 );

 endmodule
