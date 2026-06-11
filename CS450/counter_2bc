/*
Build a two-bit saturating counter.
The counter increments (up to a maximum of 3) when train_valid = 1 and train_taken = 1. It decrements (down to a minimum of 0) when train_valid = 1 and train_taken = 0. When not training (train_valid = 0), the counter keeps its value unchanged.
areset is an asynchronous reset that resets the counter to weakly not-taken (2'b01). Output state[1:0] is the two-bit counter value.
*/

module top_module(
    input clk,
    input areset,
    input train_valid,
    input train_taken,
    output reg [1:0] state
);
    localparam 	SNT = 2'b00,
    			WNT = 2'b01,
    			 WT = 2'b10,
    			 ST = 2'b11;
    
    reg [1:0] next;
    
    always @(*) begin
        case(state)
            SNT: next = train_taken ? WNT : SNT;
            WNT: next = train_taken ? WT  : SNT;
            WT:  next = train_taken ? ST  : WNT;
            ST:  next = train_taken ? ST  :  WT;
            default: next = WNT;
        endcase
    end
    
    always @(posedge clk or posedge areset) begin
        if(areset) state <= WNT;
        else state <= train_valid ? next : state;
    end

endmodule
