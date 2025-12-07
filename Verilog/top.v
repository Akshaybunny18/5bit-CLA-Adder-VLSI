module top(
    input  wire clk,
    input  wire rst,

    // Switch inputs from FPGA
    input  wire sw15, sw14, sw13, sw12, sw11,   // A inputs (MSB→LSB)
    input  wire sw10, sw9, sw8, sw7, sw6,       // B inputs (MSB→LSB)

    output wire [15:0] leds ,                     // LEDs
    output wire [5:0] pmoda   // new (Oscilloscope output on PMODA)
);

    // Form A and B from switches
    wire [4:0] sw_a = {sw15, sw14, sw13, sw12, sw11};
    wire [4:0] sw_b = {sw10, sw9, sw8, sw7, sw6};

    wire [4:0] sum;
    wire cout;

    // CLA
    cla_adder_5bit dut (
        .clk(clk),
        .rst(rst),
        .a(sw_a),
        .b(sw_b),
        .sum(sum),
        .cout(cout)
    );

    // LED mapping
    assign leds[15:11] = sw_a;   // A on LED15..11
    assign leds[10:6]  = sw_b;   // B on LED10..6
    assign leds[5]     = cout;   // carry
    assign leds[4:0]   = sum;    // sum bits

    // new (Oscilloscope output on PMODA)  
    assign pmoda[0] = sum[0]; // s0
    assign pmoda[1] = sum[1]; // s1
    assign pmoda[2] = sum[2]; // s2
    assign pmoda[3] = sum[3]; // s3
    assign pmoda[4] = sum[4]; // s4
    assign pmoda[5] = cout;   // s5 (carry)

endmodule

