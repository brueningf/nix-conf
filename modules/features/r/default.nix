{pkgs, ...}: {
  home.packages = [pkgs.R];
  home.file.".Rprofile".source = ./.Rprofile;
}
