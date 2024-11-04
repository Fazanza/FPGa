module clk_div_8 (
  input clk,
  input rst,
  output logic clk_div_8
);
  logic [1:0] counter;

  always @(posedge clk) begin
    if (!rst) begin
      counter <= 2'b00;
    end else begin
      counter <= counter + 1;
    end
  end

  always @(posedge clk) begin
    if (!rst) begin
      clk_div_8 <= 2'b00;
    end else if (counter == 3'b11) begin
      clk_div_8 <= ~clk_div_8;
    end
  end
endmodule