module modulo_5 (
  input clk,
  input reset,
  input val_i,
  output logic [2:0] mod
);
  logic [2:0] curState;
  logic [2:0] nextState;

  assign mod = !reset ? 0 : curState;

  always_comb begin
    case (curState)
      0: nextState = val_i ? 1 : 0;
      1: nextState = val_i ? 3 : 2;
      2: nextState = val_i ? 0 : 4;
      3: nextState = val_i ? 2 : 1;
      4: nextState = val_i ? 4 : 3;
      default : nextState = 0;
    endcase
  end

  always_ff @(posedge clk) begin
    if (!reset) begin
      curState <= 0;
    end else begin
      curState <= nextState;
    end
  end

endmodule