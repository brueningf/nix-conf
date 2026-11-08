# Git tooling. Name, email, and signing key live on the user profile.
{pkgs, ...}: {
  home.packages = [pkgs.gnupg];

  programs.git = {
    enable = true;
    ignores = ["**/.claude/settings.local.json"];

    settings = {
      color.ui = "auto";
      gpg.program = "${pkgs.gnupg}/bin/gpg";

      # Empty helper clears anything git already stored, then gh takes over.
      credential."https://github.com".helper = [
        ""
        "!${pkgs.gh}/bin/gh auth git-credential"
      ];
      credential."https://gist.github.com".helper = [
        ""
        "!${pkgs.gh}/bin/gh auth git-credential"
      ];
    };
  };
}
