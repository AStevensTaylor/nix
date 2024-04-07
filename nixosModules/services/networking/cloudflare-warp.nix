{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cloudflare-warp.enable = lib.mkEnableOption "enables Cloudflare Warp";
  };

  config = lib.mkIf config.cloudflare-warp.enable {
    systemd.services.warp-svc = {
      wantedBy = ["multi-user.target"];
    };
    systemd.packages = [
      pkgs.cloudflare-warp
    ];
    environment.systemPackages = [
      pkgs.cloudflare-warp
    ];
  };
}
