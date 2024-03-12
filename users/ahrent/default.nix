{
  inputs,
  lib,
  config,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ../../modules/users/hyprland.nix
    ../../modules/users/nixpkgs.overlay.nix
    ../../modules/users/neovim.nix
  ];

  programs.home-manager.enable = true;
  programs.vscode.enable = true;
  home.packages = with pkgs; [
    jq
    kubectl
    kitty
    wl-clipboard
    wl-screenrec
    wlr-randr
    fuzzel
    neovide
    #gnome.nautilus
    (
      nerdfonts.override {fonts = ["FiraCode" "DroidSansMono" "NerdFontsSymbolsOnly"];}
    )
  ];

  programs.git = {
    enable = true;
    userEmail = "git@stevenstaylor.dev";
    userName = "Ahren Stevens-Taylor";
  };

  programs.brave = {
    enable = true;
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };

  services.ssh-agent.enable = true;
  programs.ssh.enable = true;

  home = {
    username = "ahrent";
    homeDirectory = "/home/ahrent";

    sessionVariables = rec {
      WLR_NO_HARDWARE_CURSORS = "1";
      XCURSOR_SIZE = "24";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";

      GBM_BACKEND = "nvidia-drm";
      MOZ_ENABLE_WAYLAND = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.flat-remix-gtk;
      name = "Flat-Remix-GTK-Grey-Darkest";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _:true;

  nix.package = pkgs.nix;
  nix.settings.experimental-features = "nix-command flakes";

  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
