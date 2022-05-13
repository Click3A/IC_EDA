module receive_fsm(
    output bvalid,
    input  req,
    input  bload,
    input  bclk,brst_n
);

parameter RECEIVE = 1'b1 ,WAIT = 1'b0;
reg state,next;

always@(posedge bclk or negedge brst_n)beign
    if(!rst_n)
        state <= WAIT;
    else
        state <= next;
end

always@(*)begin
    case(state)
        RECEIVE:if(bload) next <= WAIT;
                else      next <= RECEIVE;
        WAIT   :if(req)   next <= RECEIVE;
                else      next <= WAIT;
        default:          next <= WAIT;
    endcase
end

 assign bvalid = state;

endmodule
