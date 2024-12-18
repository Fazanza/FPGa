module sync_w2r #(
  parameter ADDRSIZE = 4
) (
  input [ADDRSIZE:0] wptr,
  input              rclk, rrst_n,
  output logic [ADDRSIZE:0] rq2_wptr
);

  logic [ADDRSIZE:0] rq1_wptr;

  always @(posedge rclk) begin
    if (rrst_n) begin
      rq1_wptr <= 0;
      rq2_wptr <= 0;
    end else begin
      rq1_wptr <= wptr;
      rq2_wptr <= rq1_wptr;
    end
  end

endmodule