{
  inputs,
  pkgs,
  lib,
  ...
}: {
  programs.nixvim = {
    enable = true;
    plugins.lightline.enable = true;
    colorschemes.gruvbox.enable = true;

    options = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };

    plugins.lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true;
      };
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources = [
        {name = "nvim_lsp";}
        {name = "path";}
        {name = "buffer";}
      ];
    };
  };
}
