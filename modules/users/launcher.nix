{pkgs, ...}: {
  programs.rofi = {
    package = pkgs.rofi-wayland;
    enable = true;
    theme = "android_notification";
  };
}
