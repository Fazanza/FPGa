// Used to pass an n-bit pointer from the write clock domain to
// the read clock domain through a pair of registers that are clocked
// by the FIFO read clock

module sync_w2r #(
  parameter ADDRSIZE = 4
) (
  input [ADDRSIZE:0]  wptr,
  input               rclk, rrsnt_n,
  output [ADDRSIZE:0] rq2_wptr
);

  reg [ADDRSIZE:0] rq1_wptr;

  always @(posedge rclk or negedge rrst_n) begin
    if (!rrst_n) {rq2_wptr, rq1_wptr} <= 0;
    else         {rq2_wptr, rq1_wptr} <= {rq1_wptr, wptr};
  end
endmodule