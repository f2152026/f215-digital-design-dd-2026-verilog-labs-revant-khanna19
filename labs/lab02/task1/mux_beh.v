// mux_beh.v
// 2-to-1 multiplexer, BEHAVIORAL style.
//
// This file does not compile as-is. Find the bug and fix it before moving on.
// Hint: think carefully about which port should be a net and which should be
// a variable in behavioral modeling.

module mux_beh (
  input       i0,
  input       i1,
  input       s,
  output reg y
);

  always @(*) begin
    if (s)
      y = i1;
    else
      y = i0;
  end

endmodule
