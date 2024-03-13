{
  config,
  pkgs,
  ...
}: {
  services.dunst = {
    enable = true;

    settings = {
      global = {
        follow = "keyboard";
        markup = "full";
        dmenu = "${config.programs.rofi.finalPackage}/bin/rofi -dmenu -p dunst:";
      };

      urgency_low.timeout = 5;
      urgency_normal.timeout = 10;
      urgency_critical.timeout = 30;

      shortcuts = {
        context = "mod1+period";
        close = "mod1+space";
        close_all = "mod1+shift+space";
        history = "mod1+grave";
      };
    };
  };
}
