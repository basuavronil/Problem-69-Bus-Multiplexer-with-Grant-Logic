module bus_mux_grant (
    input  wire [31:0] req0_data,
    input  wire [31:0] req1_data,
    input  wire [31:0] req2_data,
    input  wire [31:0] req3_data,
    input  wire [3:0]  grant,
    output reg  [31:0] bus_out
);

    always @(*) begin
        if (grant[0])
            bus_out = req0_data;
        else if (grant[1])
            bus_out = req1_data;
        else if (grant[2])
            bus_out = req2_data;
        else if (grant[3])
            bus_out = req3_data;
        else
            bus_out = 32'b0;
    end

endmodule
