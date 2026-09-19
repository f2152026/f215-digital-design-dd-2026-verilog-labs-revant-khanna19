// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  reg [2:0] t_sel;
  wire [7:0] t_dout;
  // TODO: instantiate DUT here
  lut #(.WIDTH(8), .DEPTH(8)) DUT (
  .sel  (t_sel),
  .dout (t_dout)
);


  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end
  
  integer i;
  initial begin
    // TODO: apply different input combinations
    for (i = 0; i < 8; i = i + 1) begin
      t_sel = i[2:0];
      #5;
    end
    #5 $finish;
  end

  initial
    $monitor($time, " Sel=%d | Dout=%d", t_sel, t_dout); // change as required

endmodule
