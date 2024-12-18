module apr(
    input logic [7:0] A,
    input logic [7:0] B,
    output logic [7:0] A_OUT,
    output logic [7:0] B_OUT
 );

    assign A_OUT = A[7] ? ~A + 1'b1 : A;
    assign B_OUT = B[7] ? ~B + 1'b1 : B;

endmodule
