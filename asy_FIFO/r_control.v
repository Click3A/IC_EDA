module r_control
#(parameter DATASIZE = 8,
  parameter ADDSIZE  = 8)

  (
      input rclk,rrst_n,rinc,
      input [ADDSIZE   :0] wptr,
      output[ADDSIZE -1:0] raddr,
      output rempty,
      output[ADDSIZE   :0] rptr
  );

  reg[ADDSIZE:0]  rd_cnt;
  reg[ADDSIZE:0]  wptr_reg1,wptr_reg2;
  localparam DEPTH = 1<<ADDSIZE;


  always@(posedge rclk or negedge rrst_n)begin
      if(!rrst_n)begin
          wptr_reg1 <= 0;
          wptr_reg2 <= 0;
      end
      else begin
          wptr_reg1 <= wptr;
          wptr_reg2 <= wptr_reg1;
      end
  end


  always@(posedge rclk or negedge rrst_n)begin//默认写时钟来的时候进一个数据
      if(!rrst_n)
          rd_cnt <= 0;
      else if(rinc&&!rempty)begin
          if(rd_cnt==DEPTH)
              rd_cnt <= 0;
          else
          rd_cnt <= rd_cnt + 1'b1;
      end
      else
          rd_cnt <= 0;
  end


  assign raddr = rd_cnt[DATASIZE-1:0];//输出地址
  assign rptr  = (rd_cnt>>1)^rd_cnt;//格雷码转换
  assign rempty = (rptr==wptr_reg2[ADDSIZE:0]);//读空信号的产生

endmodule
