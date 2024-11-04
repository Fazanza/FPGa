`timescale 1ns/1ns

module pattern_101_tb;
  glbl glbl();

  logic clk;
  logic rst;
  logic val_i;
  logic val_o;

  int i;

  pattern_101 dut (
    .clk(clk),
    .rst(rst),
    .val_i(val_i),
    .val_o(val_o)
  );

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, pattern_101_tb);
  end

  initial begin
    clk = 0;
    rst = 1'b1;
    #10;
    rst = 1'b0;
    for (i = 0; i < 30; i++) begin
      val_i = $urandom % 2;
      #10;
    end
    $finish;
  end

  always begin
    #5; clk = ~clk;
  end

endmodule