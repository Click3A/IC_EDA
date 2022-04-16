module adder(
    input clk,
    input reset,
    input [3:0]a,
    input [3:0]b,
    output reg[7:0]c
);


    always@(posedge clk or posedge reset)begin
        if(reset)
            c <= 0;
        else
            c <= a+b;
    end
endmodule
