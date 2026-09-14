`timescale 1ns / 1ps

module tb_bus_mux_grant;

    // Testbench Signals (Inputs to DUT are reg, Outputs are wire)
    reg  [31:0] req0_data;
    reg  [31:0] req1_data;
    reg  [31:0] req2_data;
    reg  [31:0] req3_data;
    reg  [3:0]  grant;
    wire [31:0] bus_out;

    // Instantiate the Design Under Test (DUT)
    bus_mux_grant uut (
        .req0_data(req0_data),
        .req1_data(req1_data),
        .req2_data(req2_data),
        .req3_data(req3_data),
        .grant(grant),
        .bus_out(bus_out)
    );

    // Initial block for stimulus generation and dumping waveforms
    initial begin
        // Setup GTKWave dump files
        $dumpfile("bus_mux_grant.vcd");
        $dumpvars(0, tb_bus_mux_grant);

        // Monitor outputs in terminal console
        $monitor("Time=%0t | Grant=%b | Out=0x%h", $time, grant, bus_out);

        // 1. Initialize input data for each requester
        req0_data = 32'hAAAA_AAAA;
        req1_data = 32'hBBBB_BBBB;
        req2_data = 32'hCCCC_CCCC;
        req3_data = 32'hDDDD_DDDD;
        grant     = 4'b0000; // No grant initially

        #10;
        // 2. Grant Requester 0
        grant = 4'b0001;
        #10;

        // 3. Grant Requester 1
        grant = 4'b0010;
        #10;

        // 4. Grant Requester 2
        grant = 4'b0100;
        #10;

        // 5. Grant Requester 3
        grant = 4'b1000;
        #10;

        // 6. Reset Grant to 0 (Idle Check)
        grant = 4'b0000;
        #10;

        // Finish simulation
        $finish;
    end

endmodule
