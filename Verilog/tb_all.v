`timescale 1ns/1ps

module tb_cla_adder_5bit_exhaustive;

    // DUT inputs
    reg clk;
    reg rst;
    reg [4:0] a;
    reg [4:0] b;

    // DUT outputs
    wire [4:0] sum;
    wire cout;

    // Reference model outputs
    reg [5:0] expected;

    // Instantiate the DUT
    cla_adder_5bit uut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );

    // Clock generation (period = 10 ns)
    always #5 clk = ~clk;

    integer i, j, k;
    integer error_count = 0;

    // Dump waveforms for GTKWave
    initial begin
        $dumpfile("cla_adder_5bit_exhaustive.vcd");
        $dumpvars(0, tb_cla_adder_5bit_exhaustive);
    end

    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        a = 0;
        b = 0;

        // Apply reset
        #20;
        rst = 0;

        $display("Starting exhaustive 5-bit CLA verification...");
        $display("Note: c0 is always 0 as per project specification");
        $display("-----------------------------------------------------------");
        $display("   Time |   a   |   b   | sum | cout | expected_sum | PASS?");
        $display("-----------------------------------------------------------");

        // Run all 1024 input combinations (cin always 0)
        for (i = 0; i < 32; i = i + 1) begin
            for (j = 0; j < 32; j = j + 1) begin
                a = i[4:0];
                b = j[4:0];

                // Apply input
                #10;

                // Wait for registered output (one extra clock cycle delay)
                #10;

                // Compute expected result (cin = 0)
                expected = a + b;


                // Display result
                $display("%6t | %05b | %05b | %05b |  %b  |    %06b    | %s",
                         $time, a, b, sum, cout, expected,
                         (({cout, sum} == expected) ? "PASS" : "FAIL"));

                // Check correctness
                if ({cout, sum} !== expected) begin
                    error_count = error_count + 1;
                end
            end
        end

        // Final summary
        $display("-----------------------------------------------------------");
        if (error_count == 0)
            $display("✅ All 1024 test cases PASSED successfully!");
        else
            $display("❌ %0d test cases FAILED!", error_count);

        $display("-----------------------------------------------------------");
        $finish;
    end

endmodule
