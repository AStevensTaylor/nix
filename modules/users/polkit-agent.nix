{pkgs, ...}: {
  systemd.user.services.polkit-kde-authentication-agent-1 = {
    Unit.Description = "polkit-kde-authentication-agent-1";
    Install = {
      WantedBy = ["graphical-session.target"];
      Wants = ["graphical-session.target"];
      After = ["graphical-session-pre.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
