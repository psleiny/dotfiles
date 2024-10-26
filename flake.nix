{
  description = "My system configuration with Hyprland";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

		hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
   		url = "github:hyprwm/hyprland-plugins";
   		inputs.hyprland.follows = "hyprland";
  	};

    stylix.url = "github:danth/stylix";
    ags.url = "github:Aylur/ags";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs: let
    inherit (self) outputs;
  in {
    nixosConfigurations = {
      thinkpad-t14s = nixpkgs.lib.nixosSystem {
			  specialArgs = { inherit inputs outputs; };
			  modules = [ inputs.stylix.nixosModules.stylix ./system/configuration.nix ];
      };
    };
  };
}
