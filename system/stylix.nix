{ inputs, pkgs, config, ... }:
let
  stylix = inputs.stylix;
in
{
  stylix.enable = true;

	stylix.cursor = {
		name = "graphite-dark";
		package = pkgs.graphite-cursors;
		size = 24;
	};

  stylix.image = ../wallpaper.png;

  stylix.base16Scheme = ../colors.yaml;

  stylix.fonts = {
    serif = {
      package = pkgs.liberation_ttf;
      name = "Liberation Serif";
    };

    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
    };

    monospace = {
      package = (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];});
      name = "JetBrainsMono Nerd Font";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };

    sizes = {
      applications = 11;
      terminal = 11;
    };
  };
}
