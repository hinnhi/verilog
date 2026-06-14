/*
module top_module (input a, input b, input c, output out);//

    andgate inst1 ( a, b, c, out );

endmodule
*/

module top_module (input a, input b, input c, output out);
	wire out_t;
    assign out = ~out_t;
    andgate inst1 ( out_t ,a, b, c,1,1);

endmodule
