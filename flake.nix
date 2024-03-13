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

    hyprlock = {
      url = "github:hyprwm/hyprlock";
    };

    hypridle = {
      url = "github:hyprwm/hypridle";
    };

    hyprpaper = {
      url = "github:hyprwm/hyprpaper";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-23.05";

      inputs.nixpkgs.follows = "nixpkgs";
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

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # Set a formatter
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      deadbeef = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          inputs.disko.nixosModules.default
          (import hosts/deadbeef/disks.nix {device = "/dev/nvme0n1";})

          hosts/deadbeef/configuration.nix

          inputs.home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # home-manager.users.astevenstaylor = import ./users/astevenstaylor;
            # home-manager.users.ahrent = import ./users/ahrent;
          }
          {
            security.pam.services.hyprlock = {};
          }

          inputs.impermanence.nixosModules.impermanence
          {
            nix.settings = {
              trusted-substituters = ["https://hyprland.cachix.org?priority=50"];
              trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
            };
          }

          inputs.hyprland.nixosModules.default
        ];
      };
    };

    homeConfigurations = {
      "astevenstaylor" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {inherit inputs outputs;};

        modules = [
          inputs.nixvim.homeManagerModules.nixvim
          inputs.hyprland.homeManagerModules.default
          inputs.hyprlock.homeManagerModules.default
          inputs.hyprpaper.homeManagerModules.default
          {
            wayland.windowManager.hyprland.enable = true;
          }
          ./users/astevenstaylor
        ];
      };
      "ahrent" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        extraSpecialArgs = {inherit inputs outputs;};

        modules = [
          inputs.nixvim.homeManagerModules.nixvim
          inputs.hyprland.homeManagerModules.default
          inputs.hyprlock.homeManagerModules.default
          inputs.hyprpaper.homeManagerModules.default
          {
            wayland.windowManager.hyprland.enable = true;
          }
          ./users/ahrent
        ];
      };
    };
  };
}
