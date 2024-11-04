module synchronous_fifo #(
  parameter ASIZE = 16,
  parameter DSIZE = 8
) (
  input clk, rstn,
  input wr_en, rd_en,
  input [DSIZE-1:0] din,
  output full, empty,
  output logic [DSIZE-1:0] dout
);
  localparam ABITS = $clog2(ASIZE);

  logic [DSIZE-1:0] mem [ASIZE-1:0];
  logic [ABITS:0] wr_ptr, rd_ptr;

  assign full = ({~wr_ptr[ABITS], wr_ptr[ABITS-1:0]} == rd_ptr);
  assign empty = (wr_ptr == rd_ptr);

  always @(posedge clk) begin
    if (rstn) begin
      wr_ptr <= {ABITS{1'b0}};
      rd_ptr <= {ABITS{1'b0}};
    end else begin
      if (!full & wr_en) begin
        mem[wr_ptr] <= din;
        wr_ptr <= wr_ptr + 1;
      end
      if (!empty & rd_en) begin
        dout <= mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
      end
    end
  end

endmodule
