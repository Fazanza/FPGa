module rptr_empty #(
  parameter ASIZE = 4
) (
  input                     rinc, rclk, rrst_n,
  input [ADDRSIZE:0]        rq2_wptr,
  output logic              rempty,
  output     [ADDRSIZE-1:0] raddr,
  output logic [ADDRSIZE:0] rptr
);

  logic [ADDRSIZE:0] rbin;
  logic              rempty_val;
  logic [ADDRSIZE:0] rgraynext, rbinnext;

  assign raddr = rbin[ADDRSIZE-1:0];
  assign rbinnext = rbin + (rinc & ~rempty);
  assign rgraynext = (rbinnext >> 1) ^ rbinnext;

  always @(posedge rclk) begin
    if (rrst_n) begin
      rbin <= 0;
      rptr <= 0;
    end else begin
      rbin <= rbinnext;
      rptr <= rgraynext;
    end
  end

  assign rempty_val = (rgraynext == rq2_wptr);

  always @(posedge rclk) begin
    if (rrst_n) rempty <= 1'b1;
    else        rempty <= rempty_val;
  end

endmodule