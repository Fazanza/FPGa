`timescale 1ns/1ps

module align_tb();
  logic [31:0] value_i;
  logic [7:0]  sel;
  logic [31:0] value_o;

  align dut (
    .value_i(value_i),
    .sel(sel),
    .value_o(value_o)
  );

  initial begin
    value_i = {32{1'b0}};
    sel = {8{1'b0}};
    #10
    $display("value_o: %0b", value_o);
    value_i = 32'h12345678;
    sel = 8'b01010101;
    #10
    $display("value_o: %0b", value_o);
    sel = 8'b00110011;
    #10
    $display("value_o: %0b", value_o);
    sel = 8'b10001000;
    #10
    $display("value_o: %0b", value_o);
    $finish;
  end
endmodule