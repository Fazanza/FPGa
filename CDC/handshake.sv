module handshake (
  input clkA,
  input pulseA,
  input clkB,
  output logic val
);

  logic clkA_ff;
  logic clkA_ff_recv1, clkA_ff_recv2;
  logic clkA_mux_o_1, clkA_mux_o_2;

  logic clkB_ff1, clkB_ff2, clkB_ff3;

  assign clkA_mux_o_1 = pulseA ? 1'b1 : clkA_mux_o_2;
  assign clkA_mux_o_2 = clkA_ff_recv2 ? clkA_ff : 1'b0;

  always @(posedge clkA) begin
    // Send signal
    clkA_ff <= clkA_mux_o_1;
    // recv signal
    clkA_ff_recv1 <= clkB_ff3;
    clkA_ff_recv2 <= clkA_ff_recv1;
  end

  assign val = (!clkB_ff3 && clkB_ff2);

  always @(posedge clkB) begin
    clkB_ff1 <= clkA_ff;
    clkB_ff2 <= clkB_ff1;
    clkB_ff3 <= clkB_ff2;
  end


endmodule