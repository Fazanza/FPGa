// Transferring from a slow to fast clock domain
module pulse_synchronizer (
  input clkA,
  input rstA,
  input data,

  input clkB,
  input rstB,
  output data
);
  logic clkA_ff;
  logic clkB_ff1, clkB_ff2, clkB_ff3;

  always @(posedge clkA) begin
    if (rstA) begin
      clkA_ff <= 0;
    end else begin
      clkA_ff <= data;
    end
  end

  always @(posedge clkB) begin
    if (rstB) begin
      clkB_ff1 <= 0;
      clkB_ff2 <= 0;
      clkB_ff3 <= 0;
    end else begin
      clkB_ff1 <= clkA_ff;
      clkB_ff2 <= clkB_ff1;
      clkB_ff3 <= clkB_ff2;
    end
  end

  assign data = (!clkB_ff3 && clkB_ff2);

endmodule

// Transferring from fast to slow time domain
module pulse_synchronizer (
  input rstA,
  input clkA,
  input data,

  input rstB,
  input clkB,
  output data_o
);
  // Utilize an XOR gate because u have to capture both directions
  logic clkA_ff;
  logic clkB_ff1, clkB_ff2, clkB_ff3;

  always @(posedge clk) begin
    if (rstA) begin
      clkA_ff <= 0;
    end else if (data) begin
      // Utilize a toggle-FF to hold the value long enough
      // for the slower clock domain
      clkA_ff <= ~clkA_ff;
    end
  end

  always @(posedge clk) begin
    if (rstB) begin
      clkB_ff1 <= 0;
      clkB_ff2 <= 0;
      clkB_ff3 <= 0;
    end else begin
      clkB_ff1 <= clkA_ff;
      clkB_ff2 <= clkB_ff1;
      clkB_ff3 <= clkB_ff2;
    end
  end

  assign data_o = (clkB_ff3 ^ clkB_ff2);

endmodule