# Alacritty stays a Homebrew cask. This only owns the config, so /Applications/Alacritty.app still matches.
{...}: {
  xdg.configFile."alacritty/alacritty.toml".source = ./alacritty.toml;
}
