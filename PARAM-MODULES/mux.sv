/* MUX sel is set on a counter */
/*
module mux #(
  DATAWIDTH = 4,
  SELECT_WIDTH = 4
) (
  input [DATAWIDTH*SELECT_WIDTH-1:0] din,
  input [$clog2(SELECT_WIDTH)-1:0]   sel,
  output logic [DATAWIDTH-1:0]      dout
);
  assign dout = din[sel*DATAWIDTH +: DATAWIDTH];
endmodule
*/

/* MUX using one-hot encoding */
module mux #(
  DATAWIDTH = 4,
  SELECT_WIDTH = 4
) (
  input [DATAWIDTH*SELECT_WIDTH-1:0] din,
  input [SELECT_WIDTH-1:0]           sel,
  output logic [DATAWIDTH-1:0]      dout
);
  logic [DATAWIDTH-1:0] internal;

  always_comb begin
    internal = {DATAWIDTH{1'b0}};
    for (int i = 0; i < SELECT_WIDTH; ++i) begin
      internal |= din[DATAWIDTH*i +: DATAWIDTH] & {DATAWIDTH{sel[i]}};
    end
  end

  assign dout = internal;
endmodule
