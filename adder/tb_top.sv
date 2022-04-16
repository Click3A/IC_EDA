module tb_top;
    bit clk;
    bit reset;
    always # 10 clk = ~clk;

    initial begin
        reset = 1;
        #20;
        reset = 0;
    end

    intf i_intf(clk,reset);
    test t1(i_intf);

    adder DUT(
        .clk(i_intf.clk),
        .reset(i_intf.reset),
        .a(i_intf.a),
        .b(i_intf.b),
        .c(i_intf.c)
    );

    initial	begin
	    $fsdbDumpfile("tb.fsdb");//这个是产生名为tb.fsdb的文件
	    $fsdbDumpvars;
    end
endmodule
