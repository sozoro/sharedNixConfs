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
      capital-p = "open";
      capital-q = "straight";
      capital-r = "straight-open";
      capital-z = "straight-serifless-with-horizontal-crossbar";
      a = "double-storey-toothless-corner";
      b = "toothless-corner";
      d = "toothless-corner-serifless";
      f = "flat-hook";
      g = "single-storey-earless-corner-flat-hook";
      i = "hooky-bottom";
      j = "flat-hook-serifed";
      k = "symmetric-touching-serifless";
      l = "zshaped";
      m = "earless-single-arch-short-leg";
      n = "earless-corner-straight";
      p = "earless-corner";
      q = "earless-corner";
      r = "compact";
      t = "cross";
      u = "toothless-corner";
      z = "straight-serifless-with-horizontal-crossbar";
      zero = "dotted";
      two = "straight-neck";
      four = "open";
      seven = "straight-crossbar";
      asterisk = "penta-low";
      brace = "straight";
      ampersand = "upper-open";
      percent = "dots";
      question = "corner-flat-hooked";
      punctuation-dot = "square";
    };
  };
  set = "IosevkaCustom";
}
