/*
`define ICACHE_NUM_BANKS 2
`define ICACHE_LINES_PER_BANK 16
`define ICACHE_TAG_BITS (13 - `ICACHE_LINE_BITS - `ICACHE_BANK_BITS)
*/
// Assume 32 bit ISA
`define BLOCK_SIZE  8      // 64 bits
`define DCACHE_SIZE 256
`define NUM_WAYS    4
`define NUM_SETS    (`DCACHE_SIZE / `NUM_WAYS / `BLOCK_SIZE)
`define DCACHE_TAG_BITS (32 - $clog2(`NUM_SETS) - $clog2(`BLOCK_SIZE))
`define SET_BITS   $clog2(`NUM_SETS)
`define BLOCK_BITS $clog2(`BLOCK_SIZE)

// Represents one block of entries
typedef struct packed {
  logic [`BLOCK_SIZE*8-1:0] data;
  logic [`DCACHE_TAG_BITS-1:0] tag;
  logic valid;
} DCACHE_ENTRY;

module dcache (
  input clk,
  input reset,
  input [31:0] addr,
  input        read_en,
  input        write_en,
  input [BLOCK_SIZE*8-1:0] write_data

  output logic [7:0] data_out,
  output logic       data_out_valid,
  output logic       request_to_mm
);

  DCACHE_ENTRY [`NUM_SETS-1:0][`NUM_WAYS-1:0] dcache_data;
  logic index;

  assign index = addr[`BLOCK_BITS +: `SET_BITS];

  always_ff @(posedge clk) begin
    if (reset) begin
      dcache_data <= 0;
    end else begin
      if (read_en) begin
        for (int i = 0; i < `NUM_WAYS; ++i) begin
          if (dcache_data[index][i] == addr) begin

          end
        end
    end
  end



endmodule

/*
typedef struct packed {
    logic [63:0]                 data;
    // (13 bits) since only need 16 bits to access all memory and 3 are the offset
    logic [`ICACHE_TAG_BITS-1:0] tag;
    logic [`ICACHE_TAG_BITS-1:0] issued_tag;
    logic                        issued;
    logic                        valid;
    logic [3:0]                  mem_tag;
} ICACHE_ENTRY;
*/