`include "quadra.vh"

module quadra (
    input  a_t   a,
    input  b_t   b,
    input  c_t   c,
    input  x2_t  x2,
    input  sq_t  x2_sq,
    output y_t   y
);
    
    logic signed [65:0] a_term = $signed(a) * $signed({1'b0, x2_sq});
    
    logic signed [48:0] b_term = $signed(b) * $signed({1'b0, x2});
    
    logic signed [65:0] c_ext = $signed(c) <<< 34;    // s4.28 -> s4.62
    logic signed [65:0] b_term_ext = $signed(b_term) <<< 17;
    
    logic signed [65:0] sum = a_term + b_term_ext + c_ext;
    
    assign y = {sum[65], sum[64], sum[61:39]};

    always_comb begin
        $display("");
        $display("          === DEBUG START ===");
        $display("[COEFFS] a=0x%h (s4.28)=%0.6f", a, $itor($signed(a))*(2.0**-28));
        $display("         b=0x%h (s4.28)=%0.6f", b, $itor($signed(b))*(2.0**-28));
        $display("         c=0x%h (s4.28)=%0.6f", c, $itor($signed(c))*(2.0**-28));
        $display("[INPUTS] x2=17'b%b (u0.17)=%0.6f", x2, $itor(x2)*(2.0**-17));
        $display("         x2_sq=34'b%b (u0.34)=%0.6f", x2_sq, $itor(x2_sq)*(2.0**-34));
        $display("[TERMS]  a_term=0x%h (%0.6f)", a_term, $itor($signed(a_term))*(2.0**-62));
        $display("         b_term=0x%h (%0.6f)", b_term, $itor($signed(b_term))*(2.0**-45));
        $display("         c_ext=0x%h (%0.6f)", c_ext, $itor($signed(c_ext))*(2.0**-62));
        $display(" [SUM]   0x%h (%0.6f)", sum, $itor($signed(sum))*(2.0**-62));
        $display(" [OUT]   y= 0x%h (s2.23)= %0.6f", y, $itor($signed(y))*(2.0**-23));
        $display("          === DEBUG END ===\n");
    end
endmodule
