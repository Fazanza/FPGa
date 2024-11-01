`timescale 1ns/1ps

module synchronous_fifo_tb;

  // Parameters
  parameter ASIZE = 16;
  parameter DSIZE = 8;
  parameter ABITS = $clog2(ASIZE);

  // Testbench signals
  reg clk, rstn;
  reg wr_en, rd_en;
  reg [DSIZE-1:0] din;
  wire full, empty;
  wire [DSIZE-1:0] dout;

  // Instantiate the FIFO
  synchronous_fifo #(.ASIZE(ASIZE), .DSIZE(DSIZE), .ABITS(ABITS)) uut (
    .clk(clk),
    .rstn(rstn),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .full(full),
    .empty(empty),
    .dout(dout)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns period clock
  end

  // Test sequence
  initial begin
    // Initialize signals
    rstn = 0;
    wr_en = 0;
    rd_en = 0;
    din = 0;

    // Reset the FIFO
    #10 rstn = 1;
    #10 rstn = 0;

    // Additional write and read to ensure proper operation
    #10 din = 8'hAA;
    wr_en = 1;
    @(posedge clk);
    wr_en = 0;

    #10 $stop;
  end

endmodule
