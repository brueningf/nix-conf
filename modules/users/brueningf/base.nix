# Shared tools. A NixOS host imports this and skips darwin.nix.
{pkgs, ...}: {
  imports = [
    ../../features/shell
    ../../features/git
    ../../features/gh
    ../../features/neovim
    ../../features/tmux
    ../../features/r
    ../../features/scripts
  ];

  programs.git.settings.user = {
    name = "Frederic B.";
    email = "fp@uniify.io";
    signingkey = "2D68E53ACFB100E2";
  };

  programs.git.settings.commit.gpgsign = true;
}
