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

  reg[ADDSIZE:0]  rd_cnt;//感觉可以只用n-1位
  wire[ADDSIZE:0] rd_cnt_next;
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
      else
        rd_cnt <= rd_cnt_next;
  end

  assign rd_cnt_next = rd_cnt + (rinc&&!rempty);//这种写法第一次见，记着,把即将读取的地址发送出去，而不是发送正在读取的地址

  assign raddr = rd_cnt[DATASIZE-1:0];//输出地址
  assign rptr  = (rd_cnt_next>>1)^rd_cnt_next;//格雷码转换
  assign rempty = (rptr==wptr_reg2[ADDSIZE:0])?1:0;//读空信号的产生

endmodule
