`include "quadra.vh"

module square (
    input  x2_t x2,
    output sq_t sq
);
    assign sq = x2 * x2; // u0.17 * u0.17 = u0.34
endmodule
