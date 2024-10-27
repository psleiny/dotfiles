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
	
	programs.ags.enable = true;

  programs.alacritty.enable = true;
  programs.wofi.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";

  xdg.configFile."nvim".source = ./nvim;
  home.file."colors.yaml".source = ../colors.yaml;

	gtk = {
		enable = true;
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme.override {
				color = "black";
			};
		};
	};
}
