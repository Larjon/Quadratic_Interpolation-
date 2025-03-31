`include "quadra.vh"

module quadra_top
(
    input  ck_t clk,
    input  rs_t rst_b,
    input  x_t  x,
    input  dv_t x_dv,
    output y_t  y,
    output dv_t y_dv
);
    // Pipeline data valid (3 stages):
    dv_t dv_p0, dv_p1, dv_p2;

    always_ff @(posedge clk)
    if (!rst_b) begin
        dv_p0 <= '0;
        dv_p1 <= '0;
        dv_p2 <= '0;
    end
    else begin
        dv_p0 <= x_dv;
        dv_p1 <= dv_p0;
        dv_p2 <= dv_p1;
    end

    // <challenge!>
    x_t   x_d0;
    y_t   y_d2;

    always_ff @(posedge clk)
    if (!rst_b)
        x_d0 <= '0;
    else if (x_dv)
        x_d0 <= x;

    // Instantiate core module:
    quadra u_quadra (
        .x   (x_d0),
        .y   (y_d2)
    );

    // Outputs:
    always_comb y_dv = dv_p2;
    always_comb y    = y_d2;

endmodule
