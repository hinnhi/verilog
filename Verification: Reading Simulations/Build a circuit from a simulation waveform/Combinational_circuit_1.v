/*
module top_module (
    input a,
    input b,
    output q );//

    assign q = 0; // Fix me

endmodule
*/

module top_module (
    input a,
    input b,
    output q 
  );

    assign q = a & b;\

endmodule
