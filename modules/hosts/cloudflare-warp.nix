{pkgs, ...}: {
  systemd.services.warp-svc = {
    wantedBy = ["multi-user.target"];
  };
  systemd.packages = [
    pkgs.cloudflare-warp
  ];
  environment.systemPackages = [
    pkgs.cloudflare-warp
  ];
}
