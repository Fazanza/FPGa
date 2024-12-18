module rr_arbiter (
  input logic clk,
  input logic reset,
  input logic [3:0] req_i,
  output logic [3:0] gnt_o
);

  logic [3:0] mask_q;
  logic [3:0] next_mask;

  always_ff @(posedge clk) begin
    if (reset) begin
      mask_q <= 4'hF;
    end else begin
      mask_q <= next_mask;
    end
  end

  always_comb begin
    next_mask = mask_q;
    if (gnt[0]) next_mask = 4'b1110;
    else if (gnt[1]) next_mask = 4'b1100;
    else if (gnt[2]) next_mask = 4'b1000;
    else if (gnt[3]) next_mask = 4'b0000;
  end

  logic [3:0] mask_req;
  assign mask_req = req_i & mask_q;

  logic [3:0] mask_gnt;
  logic [3:0] raw_gnt;

  arbiter #(4) maskedGnt(.req_i(mask_req), .gnt_o(mask_gnt));
  arbiter #(4) rawGnt   (.req_i(req_i), .gnt_o(raw_gnt));
  assign gnt_o = |mask_req ? mask_gnt : raw_gnt;

endmodule

module arbiter #(
  parameter NUMPORTS = 4
) (
  input [NUMPORTS-1:0] req_i,
  output logic [NUMPORTS-1:0] gnt_o
);

  assign gnt_o[0] = req_i[0];

  genvar i;
  for (i = 1; i < NUMPORTS; i++) begin
    assign gnt_o[i] = req_i[o] & ~(|gnt_o[i-1:0]);
  end

endmodule