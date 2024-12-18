module fifomem #(
  parameter DATASIZE = 8,
  parameter ADDRSIZE = 4
) (
  input                 wclken, wfull, wclk
  input [DATASIZE-1:0]  wdata,
  input [ADDRSIZE-1:0]  waddr, raddr,
  output [DATASIZE-1:0] rdata,
);

  localparam DEPTH = 1 << ADDRSIZE;
  reg [DATASIZE-1:0] mem [DEPTH-1:0];

  assign rdata = mem[raddr];

  always @(posedge wclk) begin
    if (wclken & !wfull) begin
      mem[waddr] <= wdata;
    end
  end

endmodule