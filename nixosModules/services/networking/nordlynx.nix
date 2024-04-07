{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.nordlynx;
in {
  options.services.nordlynx = {
    enable = mkEnableOption (lib.mkDoc "NordVPN using Nordlynx (Wireguard) protocol");

    apiToken = mkOption {
      type = types.str;
      description = lib.mdDoc ''
        NordVPN API Token found in the account page
      '';
    };
  };
}
