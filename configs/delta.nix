{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [ pkgs.delta ];

  programs.git = {
    enable = true;
    config = {
      pager = {
        show = "delta --diff-highlight --features classic";
        diff = "delta --diff-highlight --features classic";
      };
      "delta \"classic\"" = {
        file-style                    = "raw";
        file-decoration-style         = "normal";
        hunk-header-style             = "raw";
        hunk-header-decoration-style  = "normal";
        keep-plus-minus-markers       = "true";
        true-color                    = "always";
        minus-style                   = "normal \"#3f0001\"";
        minus-non-emph-style          = "normal \"#3f0001\"";
        minus-emph-style              = "normal \"#901011\"";
        minus-empty-line-marker-style = "normal \"#3f0001\"";
        plus-style                    = "normal \"#002800\"";
        plus-non-emph-style           = "normal \"#002800\"";
        plus-emph-style               = "normal \"#006000\"";
        plus-empty-line-marker-style  = "normal \"#002800\"";
        syntax-theme                  = "1337";
      };
      "delta \"no-pm\"" = {
        keep-plus-minus-markers = "false";
      };
      "delta" = {
        features = "classic";
      };
    };
  };
}
