module fib (
  input clk,
  input rst,
  input [4:0] size,
  input input_valid,
  output logic valid_out,
  output logic [31:0] fib_out
);
  logic [4:0] counter;
  logic val_in_occur;
  logic [31:0] val_a, val_b;

  assign valid_out = (counter == 5'b00000 & val_in_occur);

  always @(posedge clk) begin
    if (rst || valid_out) begin
      counter <= 5'b00000;
      val_in_occur <= 1'b0;
    end else if (input_valid) begin
      counter <= size;
      val_in_occur <= 1'b1;
    end else begin
      counter <= counter - 1;
    end
  end

  always @(posedge clk) begin
    if (rst) begin
      val_a <= 0;
      val_b <= 0;
    end else begin
      val_b <= val_a + val_b;
      val_a <= val_b;
  end
end

endmodule