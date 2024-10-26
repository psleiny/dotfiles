{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
    ./hyprland.nix
    ./firefox.nix
	./shell.nix
  ];

  nixpkgs = {
    overlays = [];

    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "remy";
    homeDirectory = "/home/remy";

    packages = with pkgs; [
      hyprpaper
    ];
  };

  programs.home-manager.enable = true;

  programs.alacritty.enable = true;
  programs.wofi.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";

  xdg.configFile."nvim".source = ./nvim;
}
