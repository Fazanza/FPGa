`timescale 1ns/1ns

module clk_div_7 (
  input  rst,
  input  clk_in,
  output logic clk_out7
);
  logic [2:0] mod_7;
  logic clk_n;

  always @(posedge clk_in) begin
    if (!rst || mod_7 == 3'd6) begin
      mod_7 <= 0;
    end else begin
      mod_7 <= mod_7 + 1'b1;
    end
  end

  always @(negedge clk_in) begin
      clk_n <= mod_7[2];
  end

  assign clk_out7 = mod_7[2] || clk_n;

endmodule