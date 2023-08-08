{ config, pkgs, lib, ... }:

{

    home.packages = with pkgs; [

      ## zsh
      zsh
      thefuck
      grml-zsh-config
      
      # system administration
      htop
      dnsutils
      mtr  # network diagnostic
      mc  #midnight commander
      ncdu
      nmap
      whois
      pmutils
      lsof
      usbutils
      hwinfo
      iotop
      fuse
      ddrescue
      gpart
      gparted
      hddtemp
      hdparm
      hwdata
      acpi
      rsync
      traceroute
      util-linux
      vpnc
      ssdeep # Computes context triggered piecewise hashes (fuzzy hashes)
      vnstat
      file

      ## 2023-07-24: this doesn't work: → "error: syntax error, unexpected IF"
#      if config.my.isnotebook; then
#        powertop
#      fi
      
      # NixOS
      comma

      
      # file management
      wget
      perl534Packages.vidir
      xdg-utils
      dos2unix
      mmv
      less
      mktemp
      plocate # much faster locate
      pwgen
      # 2022-11-06 broken: haskellPackages.haskell-pdf-presenter
      inotify-tools

      # backups
      rsnapshot

      # GnuPG
      gnupg

      
      # ssh
      sshuttle
      ssh-askpass-fullscreen
 
      # text UI
      dialog
      ncurses

      # tmux
      tmux
      tmuxp

      # git
      tig
      git
      
      # compression/decompression tools
      zip
      unzip
      unp
      bzip2
      gzip
      rar
      gnutar
      p7zip

      # diff tools
      wdiff
      diffpdf
      diffutils
      
      # search
      silver-searcher
      ack
      fzf
      fd  # fd is a simple, fast and user-friendly alternative to find(1).
      findutils
      zsh-z  # https://github.com/agkozak/zsh-z -> "Zsh-z is a native Zsh port of rupa/z, a tool written for bash and Zsh that uses embedded awk scripts to do the heavy lifting."
      rdfind

      # email
      mutt

      # QMK
      qmk
      qmk-udev-rules

      # spellchecker
      aspell aspellDicts.de aspellDicts.en aspellDicts.en-computers
      
    ];


  programs.tmux = {
    enable = true;
    shortcut = "a";
    # aggressiveResize = true; -- Disabled to be iTerm-friendly
    baseIndex = 1;
    newSession = true;
    # Stop tmux+escape craziness.
    escapeTime = 0;
    # Force tmux to use /tmp for sockets (WSL2 compat)
    secureSocket = false;

    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
    ];
    
        extraConfig = ''
      # https://old.reddit.com/r/tmux/comments/mesrci/tmux_2_doesnt_seem_to_use_256_colors/
      set -g default-terminal "xterm-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

## ======== personal configuration:

# Highlighting the active window in status bar
set-window-option -g window-status-style fg=white,bg=black
set -g status-fg green
set -g status-bg black
set -g status-left "#[default]@#h#[fg=red]:#S#[fg=white] |"
set -g status-right-length 34
set -g status-right '#[fg=yellow]#(cut -d " " -f 1-3 /proc/loadavg)#[default] #[fg=cyan,bold]%Y-%m-%d %H:%M#[default]'

## start with windows number 1 (not 0)
set -g base-index 1

## switch default prefix to C-a
unbind C-b
set -g prefix C-a
bind C-a send-prefix

## "C-a a" sends C-a
bind-key a  send-prefix

# Notifying if other windows has activities
setw -g monitor-activity on

## m -> notify me on 10s of silence
bind-key m set-window-option monitor-activity off \; set-window-option monitor-silence 10
## M -> notify me on activity again (as usual)
bind-key M set-window-option monitor-activity on \; set-window-option monitor-silence 0

bind-key P new-window -a -n "procmail" -t 1 "/usr/bin/vim /home/karl/.procmailrc"
bind-key C-a last-window
set -g mode-keys emacs
set -g status-keys emacs


      '';
  }; # tmux

  # FIXXME: currently trying to accomplish: replace "floyd" with the current hostname in the following line:
  # ORIG:    home.file.".tmuxp/floyd.yaml".source = ../assets/.tmuxp/floyd.yaml; # I usually start my main tmux session via: tmuxp load $HOST
  # networking.hostName
  # home.file."emacs.d".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/src/emac";
  #${config.networking.hostName}


  #  home.file.".tmuxp/"${nixos.config.networking.hostName}".yaml".source = ../assets/.tmuxp/nixosvm.yaml; # I usually start my main tmux session via: tmuxp load $HOST
  #${config.networking.hostName}
  #home.file.".tmuxp/${config.networking.hostName}.yaml".source = ../assets/.tmuxp/${config.networking.hostName}.yaml; # I usually start my main tmux session via: tmuxp load $HOST
  

    programs.zsh = {
      
      ## all options: https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enable

      enable = true;
      
      oh-my-zsh = {
        # 2023-07-28: oh-my-zsh doesn't have a plugin that shows me the exit code if it was not 0 (I'd probably have to define my own prompt)
        enable = true;
        theme = "kolo";
        plugins = [ # List of plugins: https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
          "git" # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
          "fzf" # fuzzy auto-completion and key bindings https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf
          "python" # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/python
          # conflicts with thefuck binding: "sudo" # Easily prefix your current or previous commands with sudo by pressing esc twice. https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
          "systemd" # useful aliases for systemd. https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/systemd
          "thefuck" # corrects your previous console command. https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/thefuck
          "tmux" # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux
          "z" # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/z
        ];
        # potential plugins:
        # autoenv Python virtualenv https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/autoenv "you will need to have the autoenv installed."
        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/emacs
      };

      # 2023-07-28: prezto doesn't have the z plugin which is a bummer.
      #prezto = {
      #  enable = true;
      #  prompt.theme = "skwp";
      #  prompt.pwdLength = "full"; # Set the working directory prompt display length. By default, it is set to short. Set it to long (without ~ expansion) for longer or full (with ~ expansion) for even longer prompt display.
      #  prompt.showReturnVal = true;
      #  # python.virtualenvAutoSwitch = true;
      #  terminal.autoTitle = false;
      #  pmodules = [ "git" "completion" "syntax-highlighting" "tmux" ];
      #};
      
      history = {
        share = true; # false -> every terminal has it's own history
        size = 9999999; # Number of history lines to keep.
        save = 9999999; # Number of history lines to save.
        ignoreDups = true; # Do not enter command lines into the history list if they are duplicates of the previous event.
        extended = true; # Save timestamp into the history file.
      };
      
      shellAliases = {
        "l" = "ls -la";
        "any" = "ps xauwww|grep -v grep|grep";
        "dl" = "ls -lhtr --color=always ~/Downloads | tail -n 10"; # Show the 10 newest Downloads
        "o" = "less";
        "gg" = "git grep";
        "m" = "mpv";
        "s" = "tmux a";
        "open" = "xdg-open";
        "e" = "emacsclient";
        "pdf" = "okular";
      };
    }; # zsh


    programs.git = {
      enable = true;
      userName  = "Karl Voit"; # SPECIFICTOKARL
      userEmail = "git@Karl-Voit.at"; # SPECIFICTOKARL
      aliases = {
        lol = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
        ci = "commit";
        co = "checkout";
        s = "status";
      };
    }; # git

  

    programs.mpv = {

      # all options: https://rycee.gitlab.io/home-manager/options.html#opt-programs.mpv.enable
      
      enable = true;
      config = {

        # Type: attribute set of (string or signed integer or boolean
        # or floating point number or list of (string or signed
        # integer or boolean or floating point number))
        
        osd-bar-align-y = 1;
        osd-duration = 2000;
        osd-on-seek = "msg-bar";
        keep-open = "yes";
        script-opts = "ytdl_hook-ytdl_path=/usr/local/bin/yt-dlp;";
      };

      
    }; # mpv
  
  
}
