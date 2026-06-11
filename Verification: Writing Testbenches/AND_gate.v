/*
You are given the following AND gate you wish to test:

module andgate (
    input [1:0] in,
    output out
);

Write a testbench that instantiates this AND gate and tests all 4 input combinations
*/

`timescale 1ps / 1ps
module top_module();
    reg [1:0] in;
    wire out;
    
    initial begin
        in = 2'b00;
        #10;
        in = 2'b01;
        #10;
        in = 2'b10;
        #10;
        in = 2'b11;
    end
    andgate u_andgate(
        .in(in),
        .out(out)
    );

endmodule
