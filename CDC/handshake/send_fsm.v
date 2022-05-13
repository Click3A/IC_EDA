module asend_fsm(
    output aready,
    input  asend,
    input  aack,
    input  aclk,arst_n
);

parameter BUSY = 1'b0, READY = 1'b1;
reg state,next_state;

always@(posedge aclk or negedge arst_n)begin
    if(!rst_n)
        state <= READY;
    else
        state <= next_state;
end

always@(*)begin
    case(state)
        READY:if(asend) next_state <= BUSY;
              else      next_state <= READY;
        BUSY: if(aack)  next_state <= READY;
              else      next_state <= BUSY;
        default:        next_state <= READY;
    endcase
end

 assign aready = state;

endmodule
