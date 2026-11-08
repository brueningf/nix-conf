# Work monitor layout. docker comes from OrbStack; jq is the parser the audit panes need.
{pkgs, ...}: {
  home.packages = [pkgs.tmuxinator pkgs.jq];

  xdg.configFile."tmuxinator/monitor.yml".source = ./monitor.yml;
  xdg.configFile."tmuxinator/bin/docker-follow" = {
    source = ./bin/docker-follow;
    executable = true;
  };
  xdg.configFile."tmuxinator/bin/audit-detail" = {
    source = ./bin/audit-detail;
    executable = true;
  };
  xdg.configFile."tmuxinator/bin/audit-overview" = {
    source = ./bin/audit-overview;
    executable = true;
  };
  xdg.configFile."tmuxinator/bin/lib/docker-log.sh" = {
    source = ./bin/lib/docker-log.sh;
    executable = true;
  };
}
