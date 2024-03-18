{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/users/hyprland.nix
    ../../modules/users/nixpkgs.overlay.nix
    ../../modules/users/neovim.nix
  ];

  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    kubectl
    wl-clipboard
    wl-screenrec
    wlr-randr
    neovide
    (
      nerdfonts.override {fonts = ["FiraCode" "DroidSansMono" "NerdFontsSymbolsOnly"];}
    )
  ];

  programs.kitty = {
    enable = true;

  };

  programs.starship = {
    enable = true;
  };

  programs.lsd = {
    enable = true;
  };



  programs.yazi = {
    enable = true;
  };

  programs.jq = {
    enable = true;
  };



  programs.hyprlock = {
    enable = true;
    backgrounds = [
      {
        monitor = "DP-3";
        path = "${config.home.homeDirectory}/.local/share/wallpapers/9dad0f220de297eac617e9f5463eae31d5957853.png";
      }
      {
        monitor = "DP-1";
        path = "${config.home.homeDirectory}/.local/share/wallpapers/9dad0f220de297eac617e9f5463eae31d5957853.png";
      }
    ];
    input-fields = [
      {
        monitor = "DP-3";
        size = {
          width = 800;
          height = 30;
        };
        outline_thickness = 4;
        capslock_color = "rgba(249, 113, 65, 0.5)";
      }
    ];
  };

  services.hyprpaper = {
    enable = true;
    preloads = [
      "${config.home.homeDirectory}/.local/share/wallpapers/9dad0f220de297eac617e9f5463eae31d5957853.png"
    ];

    wallpapers = [
      "DP-1,${config.home.homeDirectory}/.local/share/wallpapers/9dad0f220de297eac617e9f5463eae31d5957853.png"
      "DP-3,${config.home.homeDirectory}/.local/share/wallpapers/9dad0f220de297eac617e9f5463eae31d5957853.png"
    ];
  };

  programs.git = {
    enable = true;
    userEmail = "ahrent@packt.com";
    userName = "Ahren Stevens-Taylor";
  };

  programs.firefox = {
    enable = true;
  };

  services.flameshot = {
    enable = true;
  };

  home = {
    username = "ahrent";
    homeDirectory = "/home/ahrent";

    sessionVariables = {
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
