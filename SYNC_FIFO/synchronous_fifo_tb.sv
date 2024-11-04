`timescale 1ns/1ps

module synchronous_fifo_tb;

  glbl glbl ();

	localparam ASIZE = 4;
	localparam DSIZE = 8;

	logic clk;
	logic rstn;
	logic wr_en;
	logic rd_en;
	logic [DSIZE-1:0] din;
	logic [DSIZE-1:0] dout;
	logic full;
	logic empty;

	synchronous_fifo
`ifndef GATESIM
	#(
		.ASIZE(ASIZE),
		.DSIZE(DSIZE))
`endif
	dut (
		.clk(clk),
		.rstn(rstn),
		.wr_en(wr_en),
		.rd_en(rd_en),
		.din(din),
		.dout(dout),
		.full(full),
		.empty(empty)
	);

	initial begin
		clk = 1'b0;
		forever begin
			#1 clk = ~clk;
		end
	end

	initial begin
		wr_en = 1'b0;
		rd_en = 1'b0;
		rstn  = 1'b1;
		din   = 1'b0;

		#5 rstn = 1'b0;
		for (int i = 0; i < ASIZE + 1; i++) begin
			$display("Full: %0b, Empty: %0b", full, empty);
			write_data(i);
		end;

		#10;
		$finish;
	end

	task write_data(input [DSIZE-1:0] value);
		begin
			if (!full) begin
				@(posedge clk);
				din = value;
				wr_en = 1;
				@(posedge clk);
				wr_en = 0;
			end else begin
				$display("FIFO is full");
			end
		end
	endtask

endmodule
