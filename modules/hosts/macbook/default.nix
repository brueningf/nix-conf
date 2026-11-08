# This Mac. A later NixOS host is another directory under modules/hosts.
{pkgs, ...}: {
  networking.hostName = "MacBook-Pro-4";

  users.users.brueningf = {
    home = "/Users/brueningf";
    shell = pkgs.zsh;
  };

  # Login shells must include the nix zsh, or macOS refuses to switch to it.
  environment.shells = [pkgs.zsh];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # SIP rejects the symlink nix-darwin would put at /etc/pam.d/sudo_local.
  security.pam.services.sudo_local.enable = false;

  system.primaryUser = "brueningf";
  system.stateVersion = 6;

  home-manager.users.brueningf.imports = [
    ../../users/brueningf
  ];
}
