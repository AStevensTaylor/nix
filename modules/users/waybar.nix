{
    pkgs,
    config,
    ...
}: {
    programs.waybar = {
        enable = true;
        systemd.enable = true;
        
    }
}