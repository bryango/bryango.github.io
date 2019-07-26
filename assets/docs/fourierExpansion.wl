<< MaTeX`;
ClearAll[Evaluate[Context[] <> "*"]];
S[x_, n_] := (8/Pi)*Sum[(k/((2*k)^2 - 1))*Sin[2*k*x], {k, 1, n}];

texStyle = {FontFamily -> "Euclid"};
Manipulate[
 Plot[
  S[x, n], {x, -.5, \[Pi] + .5},
  PlotRange -> {-1.2, 1.2},
  AxesStyle -> Directive[Dashing[Large], GrayLevel[.3]],
  BaseStyle -> Directive[texStyle, FontSize -> 16, Black],
  ImageSize -> Large,
  Ticks -> {
    {
      {0, Row[{Style["x", Italic], " = 0"}]},
      {Pi, Row[{Style["x", Italic], " = \[Pi]"}], .62}
    }, None},
  TicksStyle -> Directive[FontSize -> 24, Alignment -> Bottom],
  PlotLabel -> Row[{
     MaTeX[
      "\\frac{8}{\\pi} \\sum _{k=1}^n \\frac{k}{(2 k)^2-1} \
\\sin\\left( 2kx \\right),\\ ",
      Magnification -> 1.5],
     Style["n", texStyle, Italic, FontSize -> 20], " = ", n}]],
 {n, 1, 45, 1}]
