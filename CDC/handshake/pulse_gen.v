module pulse_gen(
    output pulse,
    output reg[7:0]d_out,
    input  clk,rst_n,
    input  [7:0]d_in
);

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        d_out <= 0;
    else
        d_out <= d_in;
end

assign pulse = d_out^d_in;

endmodule

