# Existing lua config, deployed as files. Mason still fetches lua_ls and rust_analyzer.
{pkgs, ...}: {
  home.packages = with pkgs; [neovim ripgrep fd];

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
