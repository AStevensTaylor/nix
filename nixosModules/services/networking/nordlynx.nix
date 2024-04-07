{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.services.wgnordlynx;
in {
  options.services.wgnordlynx = {
    enable = mkEnableOption (lib.mkDoc "NordVPN using Nordlynx (Wireguard) protocol as a network namespace");

    apiToken = mkOption {
      type = types.str;
      description = lib.mdDoc ''
        NordVPN API Token found in the account page under manual setup
      '';
    };
  };

  config = {
    # TODO: Add config to automatically gather 
  };
}
