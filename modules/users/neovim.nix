{
  pkgs,
  ...
}: {

  home.packages = [
    pkgs.ripdrag
  ];
  programs.nixvim = {
    enable = true;
    plugins.lightline.enable = true;
    colorschemes.onedark.enable = true;

    viAlias = true;
    vimAlias = true;

    clipboard.providers.wl-copy.enable = true;

    options = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };

    plugins.lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true;
        phpactor.enable = true;
        pyright.enable = true;
        yamlls.enable = true;
        eslint.enable = true;
        cssls.enable = true;
        vuels.enable = true;
        tsserver.enable = true;
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
      settings.mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
    };

    plugins = {
      image.enable = true;
      nix.enable = true;
      copilot-vim.enable = true;
      auto-save.enable = true;
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      nvim-tree = {
        enable = true;
        openOnSetup = true;
        reloadOnBufenter = true;
      };
      fugitive.enable = true;
      cmp-git.enable = true;
      cmp-nvim-lsp.enable = true;
      gitgutter.enable = true;
      airline.enable = true;
      nvim-autopairs.enable = true;
      intellitab.enable = true;
    };
  };
}
