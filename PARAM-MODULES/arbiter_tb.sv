`timescale 1ns/1ps

module arbiter_tb;
  glbl glbl ();

  localparam ISIZE = 8;

  logic [ISIZE-1:0] reqs;
  logic [ISIZE-1:0] gnts;

  arbiter
`ifndef GATESIM
  #(
    .ISIZE(ISIZE))
`endif
    dut (
    .reqs(reqs),
    .gnts(gnts)
  );

  initial begin
    reqs = 8'h00;
    #10
    $display("gnts: %0b", gnts);
    reqs = 8'h1F;
    #10
    $display("gnts: %0b", gnts);
    reqs = 8'h3A;
    #10
    $display("gnts: %0b", gnts);
    reqs = 8'h0A;
    #10
    $display("gnts: %0b", gnts);
    reqs = 8'h04;
    #10
    $display("gnts: %0b", gnts);
    reqs = 8'h1F;
    #10
    $display("gnts: %0b", gnts);
    $finish;
  end
endmodule
