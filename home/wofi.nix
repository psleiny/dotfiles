{ config, ... }:
{
  programs.wofi = {
		enable = true;

		settings = {
			prompt = "Search Apps";
			width = "25%";
		};

		style = /* css */ ''
			* {
				font-family: JetBrainsMono Nerd Font;
			}

			#outer-box {
				padding: 16px;
			}

			#entry {
				padding: 12px 16px;
				outline: none;
				border-radius: 0px;
			}

			#entry:selected {
				background: #${config.lib.stylix.colors.base02};
			}

			#window {
				background: #${config.lib.stylix.colors.base01};
			}

			#expander-box {
				background: none;
			}

			#input {
				background: none;
				margin-bottom: 16px;
				border-radius: 0px;
			}
		'';
	};

	stylix.targets.wofi.enable = false;
}
