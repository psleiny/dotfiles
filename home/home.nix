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
		./wofi.nix
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
	
	programs.ags = {
		enable = true;
		configDir = ./ags;
	};

  programs.alacritty.enable = true;

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";

  xdg.configFile."nvim".source = ./nvim;
  home.file."colors.json".text = builtins.toJSON (with config.lib.stylix.colors; {
		inherit base00 base01 base02 base03 base04 base05 base06 base07 base08 base09 base0A base0B base0C base0D base0E base0F;
	});

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
