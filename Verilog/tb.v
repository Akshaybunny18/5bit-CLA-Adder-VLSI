`timescale 1ns/1ps

module tb_cla_adder_5bit;

    // DUT inputs
    reg clk;
    reg rst;
    reg [4:0] a;
    reg [4:0] b;

    // DUT outputs
    wire [4:0] sum;
    wire cout;

    // Instantiate DUT
    cla_adder_5bit uut (
        .clk(clk),
        .rst(rst),
        .a(a),
        .b(b),
        .sum(sum),
        .cout(cout)
    );

    // Clock generation: 10 ns period (100 MHz)
    always #5 clk = ~clk;

    // Dump waveforms for GTKWave
    initial begin
        $dumpfile("cla_adder_5bit.vcd");
        $dumpvars(0, tb_cla_adder_5bit);
    end

    // Test procedure
    initial begin
        // Initialize
        clk = 0;
        rst = 1;
        a = 0;
        b = 0;
        
        // Apply reset for 2 clock cycles
        #20;
        rst = 0;
        
        // Test case 1: Simple add
        a = 5'b00011;   // 3
        b = 5'b00101;   // 5
        #20;
        
        // Test case 2: Larger numbers
        a = 5'b01111;   // 15
        b = 5'b00001;   // 1
        #20;

        // Test case 3: More larger numbers
        a = 5'b10101;   // 21
        b = 5'b01011;   // 11
        #20;

        // Test case 4: All ones (carry overflow check)
        a = 5'b11111;   // 31
        b = 5'b11111;   // 31
        #20;

        // Test case 5: Random pattern
        a = 5'b10010;
        b = 5'b01101;
        #20;

        // End simulation
        #20;
        $finish;
    end

    // Monitor results
    initial begin
        $display("Time\tclk\trst\ta\tb\t|\tsum\tcout");
        $monitor("%0t\t%b\t%b\t%05b\t%05b\t|\t%05b\t%b", 
                 $time, clk, rst, a, b, sum, cout);
    end
endmodule