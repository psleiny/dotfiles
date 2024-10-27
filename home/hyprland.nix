{ inputs, config, pkgs, ... }:
{
	wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
	wayland.windowManager.hyprland.plugins = with inputs.hyprland-plugins.packages.${pkgs.system}; [
		hyprbars
	];
	wayland.windowManager.hyprland.settings = {
		exec-once = [
		  "hyprpaper"
			"ags"
		];

		monitor = ",preferred,auto,1";

		env = [
			"XCURSOR_SIZE,24"
			"HYPRCURSOR_SIZE,24"
		];

		input = {
			kb_layout = "us";

			follow_mouse = 1;

			sensitivity = 0;
		};

		general = {
			border_size = 0;
			gaps_out = 10;
		};

		dwindle = {
			preserve_split = true;
		};

		decoration = {
			drop_shadow = true;
			shadow_range = 32;
			"col.shadow" = "rgba(11111132)";
			shadow_render_power = 2;
		};

		plugin = {
			hyprbars = {
				bar_height = 40;
				bar_color = "rgb(${config.lib.stylix.colors.base00})";
				"col.text" = "rgb(${config.lib.stylix.colors.base03})";
				bar_text_font = "JetBrainsMono Nerd Font";
			};
		};

		bind = [
			"SUPER, H, movefocus, l"
			"SUPER, J, movefocus, d"
			"SUPER, K, movefocus, u"
			"SUPER, L, movefocus, r"

			"SUPER SHIFT, H, swapwindow, l"
			"SUPER SHIFT, J, swapwindow, d"
			"SUPER SHIFT, K, swapwindow, u"
			"SUPER SHIFT, L, swapwindow, r"

			"SUPER CTRL, H, resizeactive, -10 0"
			"SUPER CTRL, J, resizeactive, 0 10"
			"SUPER CTRL, K, resizeactive, 0 -10"
			"SUPER CTRL, L, resizeactive, 10 0"

			"SUPER, return, fullscreen, 1"
			"SUPER SHIFT, return, fullscreen, 0"

			"SUPER, Q, exec, alacritty"
			"SUPER, C, killactive,"
			"SUPER, M, exit,"
			"SUPER, E, exec, thunar"
			"SUPER, V, togglefloating,"
			"SUPER, R, exec, wofi --show drun"
			"SUPER, P, pseudo,"
			"SUPER, S, togglesplit,"
			"SUPER, W, exec, firefox"

			"SUPER, 1, focusworkspaceoncurrentmonitor, 1"
			"SUPER, 2, focusworkspaceoncurrentmonitor, 2"
			"SUPER, 3, focusworkspaceoncurrentmonitor, 3"
			"SUPER, 4, focusworkspaceoncurrentmonitor, 4"
			"SUPER, 5, focusworkspaceoncurrentmonitor, 5"
			"SUPER, 6, focusworkspaceoncurrentmonitor, 6"
			"SUPER, 7, focusworkspaceoncurrentmonitor, 7"
			"SUPER, 8, focusworkspaceoncurrentmonitor, 8"
			"SUPER, 9, focusworkspaceoncurrentmonitor, 9"

			"SUPER SHIFT, 1, movetoworkspace, 1"
			"SUPER SHIFT, 2, movetoworkspace, 2"
			"SUPER SHIFT, 3, movetoworkspace, 3"
			"SUPER SHIFT, 4, movetoworkspace, 4"
			"SUPER SHIFT, 5, movetoworkspace, 5"
			"SUPER SHIFT, 6, movetoworkspace, 6"
			"SUPER SHIFT, 7, movetoworkspace, 7"
			"SUPER SHIFT, 8, movetoworkspace, 8"
			"SUPER SHIFT, 9, movetoworkspace, 9"
		];

		bindm = [
			"SUPER, mouse:272, movewindow" 
			"SUPER, mouse:273, resizewindow" 
		];

		bindel = [
			",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
			",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
			",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
			",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
			",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
		];

		windowrule = [
			"workspace 1, ^firefox$"
			"plugin:hyprbars:nobar, ^firefox$"
			"workspace 2, ^Alacritty$"
			"workspace 3, ^org.godotengine."
		];

		windowrulev2 = [
			"suppressevent maximize, class:.*"
			"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
		  "plugin:hyprbars:bar_color 0xff${config.lib.stylix.colors.base01}, focus:1"
		  "plugin:hyprbars:title_color 0xff${config.lib.stylix.colors.base05}, focus:1"
		];
	};

	services.hyprpaper.enable = true;

	stylix.targets.hyprland.enable = false;
}


