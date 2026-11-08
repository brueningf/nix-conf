# sessionizer and the cht picker. fzf has to be on PATH for both.
{pkgs, ...}: {
  home.packages = [
    pkgs.fzf
    (pkgs.writeShellScriptBin "sessionizer" (builtins.readFile ./sessionizer))
    (pkgs.writeShellScriptBin "tmux-cht.sh" (builtins.readFile ./tmux-cht.sh))
  ];
}
