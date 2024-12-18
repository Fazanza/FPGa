`timescale 1ns/1ps

module apr_tb;

  glbl glbl ();

	logic rstn;
	logic [7:0] A;
	logic [7:0] B;
	logic [7:0] A_OUT;
	logic [7:0] B_OUT;

	apr dut(
		.A(A),
		.B(B),
		.A_OUT(A_OUT),
		.B_OUT(B_OUT)
	);

	initial begin
		A = 8'h00;
		B = 8'h00;

		#5 rstn = 1'b0;
		for (int i = 0; i <= 255; i++) begin
			A = i; B = i;
			$display("A: %b, B: %b", A, B);
			$display("A_OUT: %b, B_OUT: %b", A_OUT, B_OUT);
			#5;
		end;

		#10;
		$finish;
	end
endmodule
