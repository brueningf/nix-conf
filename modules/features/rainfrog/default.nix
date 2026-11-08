{pkgs, ...}: {
  home.packages = [pkgs.rainfrog];

  xdg.configFile."rainfrog/rainfrog_config.toml".source = ./rainfrog_config.toml;
}
