module arbiter #(
  ISIZE = 8
) (
  input [ISIZE-1:0] reqs,
  output logic [ISIZE-1:0] gnts
);
  logic [ISIZE-1:0] reqs_r;
  wand [ISIZE-1:0] prio;

  genvar i;
  for (i = 0; i < ISIZE; i++) begin
    assign reqs_r[ISIZE-1-i] = reqs[i];
    assign gnts[ISIZE-1-i]   = prio[i];
  end
  for (i = 0; i < ISIZE-1; i++) begin
    assign prio[ISIZE-1:i] = {{(ISIZE-1-i){~reqs_r[i]}}, reqs_r[i]};
  end
  assign prio[ISIZE-1] = reqs_r[ISIZE-1];
endmodule