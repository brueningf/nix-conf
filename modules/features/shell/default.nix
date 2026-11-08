# Interactive zsh. oh-my-zsh owns the prompt; the rest is the part of .zshrc worth keeping.
# zsh-autosuggestions is not an oh-my-zsh plugin, so home-manager enables it on its own.
{config, pkgs, ...}: {
  home.packages = with pkgs; [eza bat fnm];

  # Absolute paths. sessionPath is shell-escaped, so $HOME would stay literal.
  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
    "${config.home.homeDirectory}/.bin"
    "${config.home.homeDirectory}/.cargo/bin"
    "${config.home.homeDirectory}/.config/composer/vendor/bin"
  ];

  home.sessionVariables = {
    TERM = "xterm-256color";
    VIM = "nvim";
    GIT_EDITOR = "nvim";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    HISTORY_IGNORE = "(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)";
  };

  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = ["git" "docker"];
    };

    autosuggestion.enable = true;

    shellAliases = {
      ls = "eza -al --color=always --group-directories-first";
      la = "eza -a --color=always --group-directories-first";
      ll = "eza -l --color=always --group-directories-first";
      lt = "eza -aT --color=always --group-directories-first";

      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";

      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      df = "df -h";

      vim = "nvim";
      python = "python3";
      sail = "[ -f sail ] && sh sail || sh vendor/bin/sail";

      addup = "git add -u";
      addall = "git add .";
      branch = "git branch";
      checkout = "git checkout";
      clone = "git clone";
      commit = "git commit -m";
      fetch = "git fetch";
      pull = "git pull origin";
      push = "git push origin";
      stat = "git status";
      tag = "git tag";
      newtag = "git tag -a";

      gpg-check = "gpg --keyserver-options auto-key-retrieve --verify";
      gpg-retrieve = "gpg --keyserver-options auto-key-retrieve --receive-keys";
    };

    # Runs after oh-my-zsh, so the sessionizer bind is not overwritten.
    initContent = ''
      up() {
        local d=""
        local limit="$1"

        if [ -z "$limit" ] || [ "$limit" -le 0 ]; then
          limit=1
        fi

        for ((i = 1; i <= limit; i++)); do
          d="../$d"
        done

        if ! cd "$d"; then
          echo "Couldn't go up $limit dirs."
        fi
      }

      extract() {
        if [ -z "$1" ]; then
          echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz>"
          return 1
        fi

        local n
        for n in "$@"; do
          if [ ! -f "$n" ]; then
            echo "'$n' - file does not exist"
            return 1
          fi

          case "$n" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) tar xvf "$n" ;;
            *.lzma) unlzma ./"$n" ;;
            *.bz2) bunzip2 ./"$n" ;;
            *.cbr|*.rar) unrar x -ad ./"$n" ;;
            *.gz) gunzip ./"$n" ;;
            *.cbz|*.epub|*.zip) unzip ./"$n" ;;
            *.z) uncompress ./"$n" ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar) 7z x ./"$n" ;;
            *.xz) unxz ./"$n" ;;
            *.exe) cabextract ./"$n" ;;
            *.cpio) cpio -id < ./"$n" ;;
            *.cba|*.ace) unace x ./"$n" ;;
            *)
              echo "extract: '$n' - unknown archive method"
              return 1
              ;;
          esac
        done
      }

      bindkey -s '^f' "sessionizer\n"
      eval "$(fnm env --use-on-cd)"
    '';
  };
}
