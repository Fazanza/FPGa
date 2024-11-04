module one_hot #(
  INPUT_WIDTH = 16 // Assume power of two
) (
  input [INPUT_WIDTH-1:0] val_in,
  output logic is_one_hot
);

  assign is_one_hot = (val_in != 0) && ((val_in & (val_in - 1)) == 0);

endmodule