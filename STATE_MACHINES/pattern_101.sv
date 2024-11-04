module pattern_101 (
  input clk,
  input rst,
  input val_i,
  output logic val_o
);

  logic [1:0] cur_state, next_state;

  always @(*) begin
    case (cur_state)
      2'b00: next_state = val_i ? 2'b01 : 2'b00;
      2'b01: next_state = val_i ? 2'b00 : 2'b10;
      2'b10: next_state = val_i ? 2'b01 : 2'b00;
      default: next_state <= 2'b00;
    endcase
  end

  always @(posedge clk) begin
    if (rst) begin
      cur_state <= 0;
      val_o <= 0;
    end else begin
      cur_state <= next_state;
      val_o <= (cur_state == 2'b10) & val_i;
    end
  end

endmodule