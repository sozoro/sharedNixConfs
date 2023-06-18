{ pkgs ? import <nixpkgs> {}, ... }:
pkgs.iosevka.override {
  privateBuildPlan = {
    family          = "Iosevka Custom";
    spacing         = "fontconfig-mono";
    variants.design = {
      capital-b = "standard-interrupted-serifless";
      capital-g = "toothless-corner-serifless-hookless";
      capital-i = "short-serifed";
      capital-k = "symmetric-touching-serifless";
      capital-p = "open-serifless";
      capital-q = "straight";
      capital-r = "straight-open-serifless";
      capital-z = "straight-serifless-with-horizontal-crossbar";
      a = "double-storey-toothless-corner";
      b = "toothless-corner-serifless";
      d = "toothless-corner-serifless";
      f = "flat-hook-serifless";
      g = "single-storey-flat-hook-earless-corner";
      i = "hooky-bottom";
      j = "flat-hook-serifed";
      k = "symmetric-touching-serifless";
      l = "zshaped";
      m = "earless-single-arch-short-leg-serifless";
      n = "earless-corner-straight-serifless";
      p = "earless-corner-serifless";
      q = "earless-corner-straight-serifless";
      r = "compact-serifless";
      t = "cross";
      u = "toothless-corner-serifless";
      z = "straight-serifless-with-horizontal-crossbar";
      zero = "dotted";
      two = "straight-neck";
      four = "open";
      seven = "straight-serifless-crossbar";
      punctuation-dot = "square";
      asterisk = "penta-low";
      brace = "straight";
      ampersand = "upper-open";
      percent = "dots";
      question = "corner-flat-hooked";
    };
  };
  set = "IosevkaCustom";
}
