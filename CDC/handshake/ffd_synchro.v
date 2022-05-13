module ffd_sychro(
    input  clk,
    input  rst_n,
    input  valid_i,
    output valid_o
);

reg[1:0]synchro;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)
        synchro <= 2'd0;
    else
        synchro <= {synchro[0],valid_i};
end

assign valid_o = synchro[1];

endmodule


