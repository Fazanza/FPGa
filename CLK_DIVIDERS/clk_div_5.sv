module clk_div_5 (
  input clk,
  input rst,
  output logic clk_div_5
);

  logic [3:0] mod_5;
  logic neg_c;

  always @(posedge clk) begin
    if (!rst || mod_5 == 3'b100) begin
      mod_5 <= 3'b000;
    end else begin
      mod_5 <= mod_5 + 1;
    end
  end

  always @(negedge clk) begin
    neg_c <= mod_5[1];
  end

  assign clk_div_5 = mod_5[1] || neg_c;
endmodule