`include "quadra.vh"

module quadra
(
    input  x_t x,     // u1.23
    output y_t y      // s2.23
);
    x1_t x1 = x;
    x2_t x2 = x;

    a_t a;
    b_t b;
    c_t c;

    sq_t sq;

    lut u_lut (
        .x1 (x1[23:17]),
        .a  (a),
        .b  (b),
        .c  (c)
    );

    square u_square (
        .x2 (x2),
        .sq (sq)
    );

    logic signed [63:0] b_mul_x;
    logic signed [95:0] c_mul_sq;

    logic signed [63:0] b_scaled;
    logic signed [63:0] c_scaled;
    logic signed [63:0] a_ext;
    logic signed [63:0] y_full;    

    always_comb begin
        b_mul_x  = b * x2;
        b_scaled = b_mul_x >>> 28;

        c_mul_sq  = c * sq;
        c_scaled  = c_mul_sq >>> 51;

        a_ext = {{32{a[31]}}, a} >>> 5;

        y_full = a_ext + b_scaled + c_scaled;
    end

    assign y = y_full[23:0];

endmodule
