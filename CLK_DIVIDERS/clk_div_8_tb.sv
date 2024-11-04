`timescale 1ns/1ns

module clk_div_8_tb();
  glbl glbl();

	logic clk=0;
	always #5 clk = ~clk;  // Create clock with period=10

  logic rst;
  logic clk_div_8;

  clk_div_8 o(
    .rst(rst),
    .clk(clk),
    .clk_div_8(clk_div_8)
  );

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, clk_div_8_tb);
    @(negedge clk) begin
      rst = 1'b0;
    end
    @(negedge clk) begin
      #1 rst = 1'b1;
    end
    #2000
    $finish;
  end
endmodule