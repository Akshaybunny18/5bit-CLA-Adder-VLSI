module dff(
    input wire clk,
    input wire rst,
    input wire d,
    output reg q
);
always @(posedge clk) begin
    if (rst)
        q <= 0;
    else
        q <= d;
end
endmodule

module pg_logic (
    input wire [4:0] a,
    input wire [4:0] b,
    output wire [4:0] p,    
    output wire [4:0] g        
);
    assign p   = a ^ b;   
    assign g   = a & b; 
endmodule


module cla_carry (
    input wire [4:0] p,
    input wire [4:0] g,
    output wire [5:0] c
);
    wire [4:0] g_bar;
    wire t2_1, t3_1, t3_2, t4_1, t4_2, t4_3, t5_1, t5_2, t5_3, t5_4;
    
    assign c[0] = 1'b0;
    assign c[1] = g[0];
    
    // Invert g signals
    not(g_bar[1], g[1]);
    not(g_bar[2], g[2]);
    not(g_bar[3], g[3]);
    not(g_bar[4], g[4]);
    
    // c[2] = g[1] | (p[1] & g[0])
    nand(t2_1, p[1], g[0]);
    nand(c[2], g_bar[1], t2_1);

    // c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0])
    nand(t3_1, p[2], g[1]);
    nand(t3_2, p[2], p[1], g[0]);
    nand(c[3], g_bar[2], t3_1, t3_2);

    // c[4] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0])
    nand(t4_1, p[3], g[2]);
    nand(t4_2, p[3], p[2], g[1]);
    nand(t4_3, p[3], p[2], p[1], g[0]);
    nand(c[4], g_bar[3], t4_1, t4_2, t4_3);
    
    // c[5] = g[4] | (p[4] & g[3]) | (p[4] & p[3] & g[2]) | (p[4] & p[3] & p[2] & g[1]) | (p[4] & p[3] & p[2] & p[1] & g[0])
    nand(t5_1, p[4], g[3]);
    nand(t5_2, p[4], p[3], g[2]);
    nand(t5_3, p[4], p[3], p[2], g[1]);
    nand(t5_4, p[4], p[3], p[2], p[1], g[0]);
    nand(c[5], g_bar[4], t5_1, t5_2, t5_3, t5_4);
endmodule


module cla_adder_5bit (
    input wire clk,
    input wire rst,
    input wire [4:0] a,
    input wire [4:0] b,
    output wire [4:0] sum,
    output wire cout
);

    wire [4:0] a_reg, b_reg;
    wire [4:0] p, g;
    wire [5:0] c;
    wire [4:0] sum_int;
    wire cout_int;
    
    dff dff_a0 (.clk(clk), .rst(rst), .d(a[0]), .q(a_reg[0]));
    dff dff_a1 (.clk(clk), .rst(rst), .d(a[1]), .q(a_reg[1]));
    dff dff_a2 (.clk(clk), .rst(rst), .d(a[2]), .q(a_reg[2]));
    dff dff_a3 (.clk(clk), .rst(rst), .d(a[3]), .q(a_reg[3]));
    dff dff_a4 (.clk(clk), .rst(rst), .d(a[4]), .q(a_reg[4]));
    
    dff dff_b0 (.clk(clk), .rst(rst), .d(b[0]), .q(b_reg[0]));
    dff dff_b1 (.clk(clk), .rst(rst), .d(b[1]), .q(b_reg[1]));
    dff dff_b2 (.clk(clk), .rst(rst), .d(b[2]), .q(b_reg[2]));
    dff dff_b3 (.clk(clk), .rst(rst), .d(b[3]), .q(b_reg[3]));
    dff dff_b4 (.clk(clk), .rst(rst), .d(b[4]), .q(b_reg[4]));
    
    pg_logic pg (
        .a(a_reg),
        .b(b_reg),
        .p(p),
        .g(g)
    );
    
    cla_carry cla (
        .p(p),
        .g(g),
        .c(c)
    );
    assign sum_int = p ^ c[4:0];
    assign cout_int = c[5];
    
    dff dff_sum0 (.clk(clk), .rst(rst), .d(sum_int[0]), .q(sum[0]));
    dff dff_sum1 (.clk(clk), .rst(rst), .d(sum_int[1]), .q(sum[1]));
    dff dff_sum2 (.clk(clk), .rst(rst), .d(sum_int[2]), .q(sum[2]));
    dff dff_sum3 (.clk(clk), .rst(rst), .d(sum_int[3]), .q(sum[3]));
    dff dff_sum4 (.clk(clk), .rst(rst), .d(sum_int[4]), .q(sum[4]));
    dff dff_cout (.clk(clk), .rst(rst), .d(cout_int), .q(cout));
    
endmodule
