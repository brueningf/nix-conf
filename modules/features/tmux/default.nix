# pbcopy replaces xclip. The cht lists stay in $HOME because tmux-cht.sh reads them there.
{...}: {
  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g base-index 1
      set -g extended-keys on
      set -g extended-keys-format csi-u

      bind r source-file ~/.tmux.conf

      set-window-option -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'pbcopy'

      bind-key -r i run-shell "tmux neww tmux-cht.sh"
    '';
  };

  home.file.".tmux-cht-command".source = ./cht-command;
  home.file.".tmux-cht-languages".source = ./cht-languages;
}
