# AeroSpace and borders stay Homebrew casks. The session script is ours.
# tomllib is in the Python 3.11+ stdlib, so no extra library.
# writeScriptBin, not writePython3Bin: that helper lints the script and rejects it.
{pkgs, lib, ...}:
let
  script = builtins.readFile ./aerospace-session;
  body = lib.removePrefix "#!/usr/bin/env python3\n" script;
in
{
  xdg.configFile."aerospace/aerospace.toml".source = ./aerospace.toml;
  xdg.configFile."aerospace/session.toml".source = ./session.toml;

  home.packages = [
    (pkgs.writeScriptBin "aerospace-session" ''
      #!${pkgs.python3}/bin/python3
      ${body}
    '')
  ];
}
