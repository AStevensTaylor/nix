{
  pkgs,
  inputs,
  lib,
  ...
}: {
  nix.settings = {
    trusted-substituters = ["https://cache.nixos.org/?priority=40" "https://hyprland.cachix.org?priority=50"];
    trusted-public-keys = lib.mkBefore ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
  environment.sessionVariables = rec {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
      };
    };
  };
}
