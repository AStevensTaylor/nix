# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.forceImportRoot = false;

  networking.hostName = "beefaced"; # Define your hostname.
  networking.hostId = "a72a8bef";
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.astevenstaylor = {
    isNormalUser = true;
    description = "Ahren Stevens-Taylor";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMAwj6/meHvnaYvWacMzkldJaNoQ2oKTsr5GAvjqLn5K"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMm6Uqyeiv8nAI37iKMGN4C1xaWei35dm15zbGClxH2+"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFk9I5kUybKhVPGdqpLTI5BD5Owe8EoxbBPP6/Xmrwly"
      "ecdsa-sha2-nistp521 AAAAE2VjZHNhLXNoYTItbmlzdHA1MjEAAAAIbmlzdHA1MjEAAACFBAA2f5lIwjHB9hFyCj7+lkvbUS99W5yyeNDwgLOmDZZcIy7/d6IxPpI34Xq42p6xuMmlBv2SZU7shIfr5V3l+L+tOQDprI03woDG3NAALg4F9na8j3pFcINlABgUaWirkqwBO8OE+wbs18Ip2Iee+/DM6orfEfI7nElVJ4k+znsazssNZA=="
    ];
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Allow unfree packages
  nixpkgs.config = pkgs: {
    allowUnfree = true;
    packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    btrfs-progs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        KbdInteractiveAuthentication = true;
      };
    };
    plex = {
      enable = true;
      openFirewall = true;
    };
    btrfs = {
      autoScrub = {
        enable = true;
      };
    };
    netdata = {
      enable = true;
    };
    openvscode-server = {
      enable = true;
      host = "0.0.0.0";
    };
  };

  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
    ];
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
