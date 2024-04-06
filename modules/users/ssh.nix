{...}: {
  programs.ssh = {
    enable = true;
    hashKnownHosts = true;
    addKeysToAgent = "no";
    matchBlocks = {
      "*" = {
        port = 22;
        identitiesOnly = true;
        identityFile = "~/.ssh/id_ed25519_sk_rk";
      };
    };
  };
  #services.ssh-agent.enable = true;
}
