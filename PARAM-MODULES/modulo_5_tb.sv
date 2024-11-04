`timescale 1ns/1ps
module modulo_5_tb();
    glbl glbl();

    logic clk;
    logic rst_n;
    logic b;
    logic [2:0] mod;

    always #5 clk = ~clk;

    modulo_5 m(
        .clk(clk),
        .reset(rst_n),
        .val_i(b),
        .mod(mod)
    );

    bit [9:0] sum;
    bit [2:0] mod_5;

    initial begin
        sum = 0;
        clk = 0;
        @(negedge clk) begin
            rst_n = 1'b0;
        end
        @(negedge clk) begin
            rst_n = 1'b1;
            b = $random % 2;
            sum = 2*sum + b;
            mod_5 = sum % 5;
        end
        repeat(5)@(negedge clk) begin
            b = $random % 2;
            sum = 2*sum + b;
            mod_5 = sum % 5;
            $display("module: %d, sum: %b", mod, b);
        end
        $finish;
    end

endmodule