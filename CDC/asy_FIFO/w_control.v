
//地址用二进制，指针用格雷码

module w_control
#(parameter DATASIZE = 8,
  parameter ADDSIZE  = 8)

  (
      input wclk,wrst_n,winc,
      input [ADDSIZE   :0] rptr,
      output[ADDSIZE -1:0] waddr,
      output wfull,
      output[ADDSIZE   :0] wptr
  );

  reg[ADDSIZE:0]  addr_cnt;
  wire[ADDSIZE:0] addr_cnt_next;
  reg[ADDSIZE:0]  rptr_reg1,rptr_reg2;
  localparam DEPTH = 1<<ADDSIZE;


  always@(posedge wclk or negedge wrst_n)begin
      if(!wrst_n)begin
          rptr_reg1 <= 0;
          rptr_reg2 <= 0;
      end
      else begin
          rptr_reg1 <= rptr;
          rptr_reg2 <= rptr_reg1;
      end
  end


  always@(posedge wclk or negedge wrst_n)begin//默认写时钟来的时候进一个数据
    if(!wrst_n)
        addr_cnt <= 0;
    else
        addr_cnt <= addr_cnt_next;
  end

  assign addr_cnt_next = addr_cnt + (winc&&!wfull);

  assign waddr = addr_cnt[DATASIZE-1:0];//输出地址
  assign wptr  = (addr_cnt_next>>1)^addr_cnt_next;//格雷码转换,没有初始态
  assign wfull = (wptr=={~rptr_reg2[ADDSIZE:ADDSIZE-1],rptr_reg2[ADDSIZE-2:0]})?1:0;//注意点1，写满信号的产生

endmodule

