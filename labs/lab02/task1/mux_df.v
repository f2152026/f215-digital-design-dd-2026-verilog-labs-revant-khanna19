// mux_df.v
// 2-to-1 multiplexer, DATAFLOW style.
//
// This file does not compile as-is. Find the bug and fix it before moving on.
// Hint: think carefully about which port should be a net and which should be
// a variable in dataflow modeling.

module mux_df (
  input  wire i0,
  input  wire i1,
  input  wire s,
  output wire y
);

  assign y = s ? i1 : i0;

endmodule