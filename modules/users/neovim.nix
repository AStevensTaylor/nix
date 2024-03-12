{
  inputs,
  pkgs,
  lib,
  ...
}: {
  nixpkgs.overlays = [
    inputs.nixneovim.overlays.default
  ];

  imports = [
    inputs.nixneovim.nixosModules.homeManager-23-11
  ];

  programs.nixneovim = {
    enable = true;

    plugins = {
      lspconfig = {
        enable = true;
        servers = {
          rust-analyzer.enable = true;
          bashls.enable = true;
          cssls.enable = true;
          eslint.enable = true;
          gopls.enable = true;
          html.enable = true;
          jsonls.enable = true;
          rnix.enable = true;
          pyright.enable = true;
          typescript-language-server.enable = true;
          vuels.enable = true;
        };
      };
      treesitter = {
        enable = true;
        indent = true;
      };
      mini = {
        enable = true;
        ai.enable = true;
        jump.enable = true;
      };
    };
  };
}
