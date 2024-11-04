module replacement (
  input logic clk,
  input logic reset,
  input logic [31:0] addr,
  input logic [31:0] wdata,
  input logic write_enable,
  output logic [31:0] rdata,
  output logic hit
);
  parameter CACHE_SIZE = 16;
  parameter BLOCK_SIZE = 4;
  parameter SETS = CACHE_SIZE / BLOCK_SIZE;
  parameter WAY = 4;

  logic [31:0] cache_data[WAY-1:0][SETS-1:0];
  logic [31:0]  cache_tag[WAY-1:0][SETS-1:0];
  logic             valid[WAY-1:0][SETS-1:0];
  logic mru_bits[WAY-1:0][SETS-1:0];

  logic [1:0] index;
  logic [31:0] tag;
  logic hit_detected;

  assign index = addr[3:2];
  assign tag =   addr[31:4];