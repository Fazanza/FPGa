# FPGa

### FINISHED
- FIFO
- ARBITER
- ALIGN (Serial)
- MUX
- MOD 5
- CLK Dividers

### TODO:
- RR_Arbiter
- Fractional CLK didivers
- read/valid protocol

## General Questions
#### Difference between generate and for-loop verilog keywords?
- Generate for loops will generate an instance for each iteration
  - Code below will cause for 3 different always blocks to be generated, making it harder
  for the synthsis tool to optimize the logic
```
genvar i;
for (i = 0; i < 3; i = i + 1) begin
  always @(posedge sysclk) begin
    temp[i] <= 1'b0;
  end
end
```

#### always vs. always_ff vs. always_comb
- **always** is general purpose used for either sequential or combinational
- **always_ff** is used for sequential logic
- **always_comb** is used strictly for combinational logic

