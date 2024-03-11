{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    devShells = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = with pkgs;
        mkShell {
          nativeBuildInputs = with pkgs; [
            bashInteractive
            git
            age
            age-plugin-yubikey
          ];
          shellHook = with pkgs; ''
            export EDITOR="code -w"
          '';
        };
    });

    # Set a formatter
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      deadbeef = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          inputs.disko.nixosModules.default
          (import hosts/deadbeef/disko.nix {device = "/dev/disk/by-path/pci-0000:01:00.0-nvme-1";})

          hosts/deadbeef/configuration.nix

          inputs.home-manager.nixosModules.default
          inputs.impermanence.nixosModules.impermanence

          inputs.hyprland.nixosModules.default
          {programs.hyprland.enable = true;}
        ];
      };
    };

    homeConfigurations = forAllSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      "astevenstaylor@deadbeef" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;

        modules = [
          inputs.hyprland.homeManagerModules.default
          {
            wayland.windowManager.hyprland.enable = true;
          }
          users/astevenstaylor/default.nix
        ];
      };
    });
  };
}
