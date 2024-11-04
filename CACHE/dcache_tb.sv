module dcache_tb;
  glbl glbl();

  input clk;
  input reset;

  dcache dut (
    .clk(clk),
    .reset(reset)
  );

  initial begin
    $finish;
  end
endmodule