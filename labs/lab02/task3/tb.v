module tb;
    reg [1:0] t_a,t_b;
    reg exp_gt,exp_lt,exp_eq;
    wire t_gt,t_lt,t_eq;

    comp2 DUT (
        .A  (t_a),
        .B  (t_b),
        .GT (t_gt),
        .LT (t_lt),
        .EQ (t_eq)
    );

    string vcd_file;
    initial begin
        if ($value$plusargs("vcd=%s", vcd_file)) begin
            $dumpfile(vcd_file);
            $dumpvars(0, DUT);
        end
    end
    
    integer i,j, errors;
    initial begin
        errors=0;
        for (i=0;i<4;i=i+1) begin
            t_a= i[1:0];
            for (j=0;j<4;j=j+1) begin
                t_b=j[1:0];
                exp_eq=(t_a==t_b);
                exp_gt=(t_a>t_b);
                exp_lt=(t_a<t_b);
                #5;
                if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
                    $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",$time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
                    errors = errors + 1;
                end
            end
        end
        $display("Test completed with %0d errors, %0d out of 16 successful.",errors,16-errors);
        $finish;
    end
endmodule