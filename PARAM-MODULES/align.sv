module align (
  input        [31:0] value_i,
  input        [7:0]  sel,
  output logic [31:0] value_o
);
  /* Maybe there is a way to do this in log(n) using
     some sort of shifting method with Tree */
  logic [2:0] cnt;
  integer i;

  always_ff @(*) begin
    value_o = 0;
    cnt = 0;
    for (i = 0; i < 8; i++) begin
      if (sel[i]) begin
        value_o[cnt*4 +: 4] = value_i[i*4 +: 4];
        cnt = cnt + 1;
      end
    end
  end
endmodule