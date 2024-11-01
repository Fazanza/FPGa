module wptr_full #(
  parameter ADDRSIZE = 4
) (
  input                     winc, wclk, wrst_n,
  input      [ADDRSIZE:0]   wq2_rptr,
  output reg                wfull,
  output     [ADDRSIZE-1:0] waddr,
  output reg [ADDRSIZE:0]   wq2_rptr
);
  reg  [ADDRSIZE:0] wbin;
  reg wfull_val;
  wire [ADDRSIZE:0] wgratnext, wbinnext;

  // GRAYSTYLE2 pointer
  always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n) {wbin, wptr} <= 0;
    else         {wbin, wptr} <= {wbinnext, wgratnext};
  end

  assign waddr = wbin[ADDRSIZE-1:0];

  assign wbinnext = wbin + (winc & ~wfull);
  assign wgraynext = (wbinnext >> 1) ^ wbinnext;

  // FULL_VAL
  assign wfull_val = (wgraynext=={~wq2_rptr[ADDRSIZE:ADDRSIZE-1],
                                   wq2_rptr[ADDRSIZE-2:0]});
  always @(posedge wclk or negedge wrst_n) begin
    if (!wrst_n) w_full <= 1'b0;
    else         w_full <= wfull_val;
  end
endmodule