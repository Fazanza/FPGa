`timescale 1ns/1ps

/* Normal Mux */
/*
module mux_tb;
  glbl glbl ();

  localparam DATAWIDTH = 4;
  localparam SELECT_WIDTH = 4;

  logic [DATAWIDTH*SELECT_WIDTH-1:0] din;
  logic [$clog2(SELECT_WIDTH)-1:0]   sel;
  logic [DATAWIDTH-1:0]             dout;

  mux
`ifndef GATESIM
  #(
    .DATAWIDTH(DATAWIDTH),
    .SELECT_WIDTH(SELECT_WIDTH))
`endif
  dut (
    .din(din),
    .sel(sel),
    .dout(dout)
  );

    initial begin
      din = 16'h0000;
      sel = 2'b00;
      #10;
      $display("Dout: %0b", dout);
      din = 16'hABCD;
      sel = 2'b00;
      #10;
      $display("Dout: %0b", dout);
      sel = 2'b01;
      #10;
      $display("Dout: %0b", dout);
      sel = 2'b10;
      #10;
      $display("Dout: %0b", dout);
      sel = 2'b11;
      #10;
      $display("Dout: %0b", dout);
      $finish;
    end
endmodule
*/

/* One-Hot Encoding */
module mux_tb;
  glbl glbl ();

  localparam DATAWIDTH = 4;
  localparam SELECT_WIDTH = 4;

  logic [DATAWIDTH*SELECT_WIDTH-1:0] din;
  logic [SELECT_WIDTH-1:0]           sel;
  logic [DATAWIDTH-1:0]             dout;

  mux
`ifndef GATESIM
  #(
    .DATAWIDTH(DATAWIDTH),
    .SELECT_WIDTH(SELECT_WIDTH))
`endif
  dut (
    .din(din),
    .sel(sel),
    .dout(dout)
  );

  initial begin
      din = 16'h0000;
      sel = 4'b0000;
      #10;
      $display("Dout: %0b", dout);
      din = 16'hABCD;
      sel = 4'b0001;
      #10;
      $display("Dout: %0b", dout);
      sel = 4'b0010;
      #10;
      $display("Dout: %0b", dout);
      sel = 4'b0100;
      #10;
      $display("Dout: %0b", dout);
      sel = 4'b1000;
      #10;
      $display("Dout: %0b", dout);
      $finish;
    end
endmodule
