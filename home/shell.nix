{ config, pkgs, ... }:
{
	programs.zsh = {
		enable = true;
		autosuggestion.enable = true;
		syntaxHighlighting.enable = true;
		shellAliases = {
			ls = "eza -a --icons=always --color=always";
			tree = "eza -a --icons=always --color=always --tree";
			ll = "eza -la --icons=always --color=always";
			".." = "cd ..";
			"..." = "cd ../..";
			"...." = "cd ../../..";
			vigodot = "nvim --listen 127.0.0.1:55432 .";
			v = "nvim";
			vi = "nvim";
			vim = "nvim";
			rbs = "cd ~/dotfiles; git add .; sudo nixos-rebuild switch --flake .";
		};

		initExtra = ''
			source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
		'';

		profileExtra = /* sh */ ''
			if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
				exec Hyprland
			fi
		'';

		history = {
			size = 10000;
			path = "${config.xdg.dataHome}/zsh/history";
		};
	};

	programs.starship = {
		enable = true;
		enableZshIntegration = true;
	};

	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
		options = [
			"--cmd cd"
		];
	};

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};
	
	programs.eza.enable = true;
}
