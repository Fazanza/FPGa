module sync_fifo_2_input #(
  DATAWIDTH = 8,
  DEPTH = 8
) (
  input clk,
  input rst,
  input wr_en,
  input wr_en_2,
  input rd_en,
  input [DATAWIDTH-1:0] wr_data,
  input [DATAWIDTH-1:0] wr_data_2,
  ouput logic [DATAWIDTH-1:0] data
  output logic full,
  output logic empty
);

  localparam DEPTH_2 = $clog2(DEPTH);

  logic [DEPTH_2:0] wr_ptr, rd_ptr;
  logic one_from_full, fill_two;
  logic [DATAWIDTH-1:0] mem [DEPTH-1:0];

  assign full = ({~wr_ptr[DEPTH_2], wr_ptr[DEPTH_2-1:0]} == rd_ptr);
  assign one_from_full = (({~wr_ptr[DEPTH_2], wr_ptr[DEPTH_2-1:0]} + 1) == rd_ptr);
  assign empty = (wr_ptr == rd_ptr);
  assign fill_two = (wr_en & wr_en_2);

  always @(posedge clk) begin
    if (rst) begin
      mem <= 0;
      wr_ptr <= 0;
      rd_ptr <= 0;
    end else begin
      if (!empty & rd_en) begin
        data <= mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
      end
      if (!full) begin
        if (fill_two & !one_from_full) begin
          
        end

      end
    end
  end

endmodule