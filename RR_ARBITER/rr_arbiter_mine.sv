module rr_arbiter_mine (
  input clk,
  input rst,
  input [3:0] gnt,
  output [3:0] reqs
);

  logic [3:0] mask, next_mask;

  always_ff @(posedge clk) begin
    if (rst) mask <= 4'hF;
    else     mask <= next_mask;
  end

  always_comb begin
    next_mask = mask;
    if (gnt[3])       next_mask <= 4'b0111;
    else if (gnt[2])  next_mask <= 4'b0011;
    else if (gnt[1])  next_mask <= 4'b0001;
    else if (gnt[0])  next_mask  <= 4'b0000;
  end

  logic [3:0] mask_req;
  assign mask_req = (next_mask) & gnt;

  logic [3:0] mask_gnt;
  logic [3:0] arbiter_gnt;

  arbiter #(4) maskedGnt(.gnt(mask_req), .req(mask_gnt));
  arbiter #(4) unmaskedGnt(.gnt(gnt), .req(arbiter_gnt));

  assign req = (|mask_req) ? mask_gnt : arbiter_gnt;

endmodule

module arbiter #(
  parameter SIZE = 4
) (
  input [SIZE-1:0] gnt,
  output logic [SIZE-1:0] req
);
  logic [SIZE-1:0] gnt_r
  wand [SIZE-1:0] req_r;

  genvar i;
  for (i = 0; i < SIZE; i++) begin
    assign gnt_r[SIZE-1-i] = gnt[i];
    assign req[SIZE-1-i]   = req_r[i];
  end
  for (i = 0; i < SIZE-1; i++) begin
    assign req_r[SIZE-1:i] = {{(SIZE-1-i){~gnt_r[i]}}, gnt_r[i]};
  end
  assign req_r[SIZE-1] = gnt_r[SIZE-1];
endmodule