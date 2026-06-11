/*
You are provided a module with the following declaration:
  module dut ( input clk ) ;
Write a testbench that creates one instance of module dut (with any instance name), and create a clock signal to drive the module's clk input. The clock has a period of 10 ps. The clock should be initialized to zero with its first transition being 0 to 1.
*/

`timescale 1ps / 1ps 
module top_module ();
    reg clk;
    initial clk = 0;
    always begin
        #5 clk = ~clk;
    end
    
    dut u_dut(
        .clk(clk)
    );

endmodule
