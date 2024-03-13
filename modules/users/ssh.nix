{...}: {
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    addKeysToAgent = "yes";
  };
  services.ssh-agent.enable = true;
}
