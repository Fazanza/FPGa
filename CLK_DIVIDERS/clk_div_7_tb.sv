`timescale 1ns/1ns

module clk_div_7_tb();
  glbl glbl();

	logic clk=0;
	always #5 clk = ~clk;  // Create clock with period=10
// A testbench
  logic rst;
  logic clk_out;

  clk_div_7 o(
    .rst(rst),
    .clk_in(clk),
    .clk_out7(clk_out)
  );

//end
  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, clk_div_7_tb);
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