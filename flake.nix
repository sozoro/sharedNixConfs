{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    configs = {
      # ls -1 ./configs | grep '\.nix$' | awk '{ sub(".nix", "") }{ print $1" = ./configs/"$1".nix;" }'
      adb = ./configs/adb.nix;
      autoUpgrade = ./configs/autoUpgrade.nix;
      commonPackages = ./configs/commonPackages.nix;
      console = ./configs/console.nix;
      cursor = ./configs/cursor.nix;
      enableUnfreeFirmwares = ./configs/enableUnfreeFirmwares.nix;
      fcitx-henkan-muhenkan = ./configs/fcitx-henkan-muhenkan.nix;
      fcitx-homeSettings = ./configs/fcitx-homeSettings.nix;
      fcitx-mozc = ./configs/fcitx-mozc.nix;
      fcitx = ./configs/fcitx.nix;
      flake = ./configs/flake.nix;
      fonts = ./configs/fonts.nix;
      git = ./configs/git.nix;
      gnome = ./configs/gnome.nix;
      gtk3QogirTheme = ./configs/gtk3QogirTheme.nix;
      hiDPI = ./configs/hiDPI.nix;
      ifuse = ./configs/ifuse.nix;
      #iosevka = ./configs/iosevka.nix;
      logind = ./configs/logind.nix;
      mplayer = ./configs/mplayer.nix;
      nixGCKeepOutputs = ./configs/nixGCKeepOutputs.nix;
      printer_ipp = ./configs/printer_ipp.nix;
      startxmonad = ./configs/startxmonad.nix;
      startxsession = ./configs/startxsession.nix;
      termite = ./configs/termite.nix;
      timezoneJP = ./configs/timezoneJP.nix;
      uefi = ./configs/uefi.nix;
      UPnP = ./configs/UPnP.nix;
      useTmpfs = ./configs/useTmpfs.nix;
      vim = ./configs/vim.nix;
      xkb = ./configs/xkb.nix;
      xmonad = ./configs/xmonad.nix;
      xserver = ./configs/xserver.nix;
      xsettingsd = ./configs/xsettingsd.nix;
      zoom-us = ./configs/zoom-us.nix;
    };

    packages = {
      # ls -1 ./packages | grep '\.nix$' | awk '{ sub(".nix", "") }{ print $1" = ./packages/"$1".nix;" }' 
      gene95 = ./packages/gene95.nix;
      non-variable-noto-fonts = ./packages/non-variable-noto-fonts.nix;
      pleroma-tools = ./packages/pleroma-tools.nix;
      rust-u2f = ./packages/rust-u2f.nix;
      termonad = ./packages/termonad.nix;
    };
  };
}
