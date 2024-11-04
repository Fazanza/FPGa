module one_hot_tb;
  glbl glbl();

  localparam INPUT_WIDTH = 16;

  logic [INPUT_WIDTH-1:0] val_in;
  logic is_one_hot;

  one_hot
`ifndef GATESIM
#(
  .INPUT_WIDTH(INPUT_WIDTH))
`endif
dut (
  .val_in(val_in),
  .is_one_hot(is_one_hot)
);

 task display_result;
    input [INPUT_WIDTH-1:0] value;
    input expected;
    begin
      $display("Input: %b, Expected: %b, Output: %b", value, expected, is_one_hot);
    end
  endtask

  initial begin
    // Test with valid one-hot values
    $display("Testing valid one-hot values...");
    val_in = 16'b0000_0000_0000_0001; #10; display_result(val_in, 1);
    val_in = 16'b0000_0000_0000_0010; #10; display_result(val_in, 1);
    val_in = 16'b0000_0000_0001_0000; #10; display_result(val_in, 1);
    val_in = 16'b1000_0000_0000_0000; #10; display_result(val_in, 1);

    // Test with non-one-hot values
    $display("Testing non-one-hot values...");
    val_in = 16'b0000_0000_0000_0000; #10; display_result(val_in, 0); // All zeroes
    val_in = 16'b0000_0000_0000_0011; #10; display_result(val_in, 0); // Multiple bits set
    val_in = 16'b0000_0000_1100_0000; #10; display_result(val_in, 0); // Multiple bits set
    val_in = 16'b1111_1111_1111_1111; #10; display_result(val_in, 0); // All bits set

    // Additional edge cases
    $display("Testing edge cases...");
    val_in = 16'b0000_0000_0000_1000; #10; display_result(val_in, 1); // One-hot in middle
    val_in = 16'b0100_0000_0000_0000; #10; display_result(val_in, 1); // One-hot near high end

    $display("All tests completed.");
    $finish;
  end

endmodule