{ config, ... }:
let
	time_settings = {
		color = "rgb(${config.lib.stylix.colors.base05})";
		font_size = 180;
		font_family = "JetBrainsMono Nerd Font Bold";
		halign = "center";
		valign = "center";
	};
in
{
	services.hypridle = {
		enable = true;
		settings = {
			general = {
				lock_cmd = "pidof hyprlock || hyprlock";
				before_sleep_cmd = "loginctl lock-session";
				after_sleep_cmd = "hyprctl dispatch dpms on";
			};
		};
	};

	programs.hyprlock = {
		enable = true;
		settings = {
			background = {
				color = "rgb(${config.lib.stylix.colors.base00})";
			};
			label = [
				({ text = "cmd[update:1000] date +%I"; position = "0, 300"; } // time_settings)
				({ text = "cmd[update:1000] date +%M"; position = "0, 100"; } // time_settings)
				{
					text = "cmd[update:1000] date +'%a %b %-d'";
					halign = "center";
					valign = "center";
					font_family = "JetBrainsMono Nerd Font";
					color = "rgb(${config.lib.stylix.colors.base04})";
					position = "0, -40";
					font_size = 35;
				}
			];
			input-field = {
				halign = "center";
				valign = "center";
				position = "0, -180";
				outline_thickness = 0;
				dots_rounding = -2;
				inner_color = "rgb(${config.lib.stylix.colors.base01})";
				font_color = "rgb(${config.lib.stylix.colors.base05})";
				fade_on_empty = false;
				placeholder_text = ''<span font_family="JetBrainsMono Nerd Font" color="##${config.lib.stylix.colors.base03}">Enter Password</span>'';
				check_color = "rgb(${config.lib.stylix.colors.base0A})";
				fail_color = "rgb(${config.lib.stylix.colors.base08})";
				fail_text = ''<span font_family="JetBrainsMono Nerd Font" color="##${config.lib.stylix.colors.base00}">Incorrect Password</span>'';
				rounding = 0;
			};
		};
	};
}
