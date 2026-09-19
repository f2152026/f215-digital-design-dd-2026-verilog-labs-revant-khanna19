module tb;
    reg  [3:0] t_a, t_b;
    reg        t_op;
    reg  [3:0] exp_result;
    wire [3:0] result;

    alu DUT (
        .a      (t_a),
        .b      (t_b),
        .op     (t_op),
        .result (result)
    );

    string vcd_file;
    initial begin
        if ($value$plusargs("vcd=%s", vcd_file)) begin
            $dumpfile(vcd_file);
            $dumpvars(0, DUT);
        end
    end

    integer op_idx, i, j, errors, total_tests;
    initial begin
        errors = 0;
        total_tests = 0;
        for (op_idx = 0; op_idx < 2; op_idx = op_idx + 1) begin
            t_op = op_idx[0];
            for (i = 0; i < 8; i = i + 1) begin
                t_a = i[3:0];
                for (j = 0; j < 8; j = j + 1) begin
                    t_b = j[3:0];
                    if (t_op == 1'b0)
                        exp_result = t_a + t_b;
                    else
                        exp_result = t_a - t_b;
                    #5;
                    total_tests = total_tests + 1;
                    if (result !== exp_result) begin
                        $display("FAIL at time %0t: op=%b a=%b (%0d) b=%b (%0d) | got result=%b (%0d) expected=%b (%0d)",
                                 $time, t_op, t_a, t_a, t_b, t_b, result, result, exp_result, exp_result);
                        errors = errors + 1;
                    end
                end
            end
        end

        t_a = 4'd5;
        t_b = 4'd2;
        t_op = 1'b0;
        t_op = 1'b1;
        exp_result = t_a - t_b;
        #5;
        total_tests = total_tests + 1;
        if (result !== exp_result) begin
            $display("FAIL (Sensitivity check) at time %0t: op switch failed while holding operands constant. got=%0d expected=%0d",
                     $time, result, exp_result);
            errors = errors + 1;
        end
        $display("Test completed with %0d errors out of %0d tests.", errors, total_tests);
        $finish;
    end
endmodule