{...}: {
  imports = [
    ./base.nix
    ./darwin.nix
  ];

  home.username = "brueningf";
  home.homeDirectory = "/Users/brueningf";
  home.stateVersion = "26.05";

  xdg.enable = true;
}
