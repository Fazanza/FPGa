module clk_div_3 (
  input clk,
  input rst,
  output logic clk_div_3
);

  logic [1:0] mod_3;
  logic neg_c;

  always @(posedge clk) begin
    if (!rst || mod_3 == 2'b10) begin
      mod_3 <= 2'b00;
    end else begin
      mod_3 <= mod_3 + 1;
    end
  end

  always @(negedge clk) begin
    neg_c <= mod_3[1];
  end

  assign clk_div_3 = mod_3[1] || neg_c;
endmodule