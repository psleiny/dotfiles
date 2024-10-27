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

  stylix.base16Scheme = {
		base00 = "161616";
		base01 = "1E1E1E";
		base02 = "393939";
		base03 = "626262";
		base04 = "8D8D8D";
		base05 = "A8A8A8";
		base06 = "E0E0E0";
		base07 = "E6E6E6";
		base08 = "AC6F6B";
		base09 = "B78365";
		base0A = "C0A479";
		base0B = "8E9E6D";
		base0C = "779E89";
		base0D = "718FA0";
		base0E = "928198";
		base0F = "987A8C";
	};

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
