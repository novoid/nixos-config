{ config, pkgs, lib, hostName, eza, ... }:

{

    home.packages = with pkgs; [

      ## zsh
      zsh
      thefuck
      grml-zsh-config
      lsd  # https://github.com/Peltoche/lsd + German: https://www.heise.de/news/LSD-in-der-Kommandozeile-GNU-List-Befehl-in-Rust-und-Farbe-9287119.html?wt_mc=rss.red.ho.ho.atom.beitrag.beitrag
      #eza ## FIXXME 2023-09-07: eza.url defined in flake.nix but I don't know how to install it here yet.
      psmisc ## e.g., killall, fuser, pstree
      
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
      pciutils
      ncftp
      socat
      cryptsetup

      ## 2023-07-24: this doesn't work: → "error: syntax error, unexpected IF"
#      if config.my.isnotebook; then
#        powertop
#      fi
      
      # NixOS
      nix-index  # "locate/grep" for files in all nix packages
      comma      # temporarily installing packages in current shell

      
      # file management
      wget
      moreutils ## vidir from perl534Packages.vidir doesn't sort output: id:2023-11-10-fix-wrong-order-in-vidir
      xdg-utils
      dos2unix
      mmv
      less
      mktemp
      pwgen
      # 2022-11-06 broken: haskellPackages.haskell-pdf-presenter
      inotify-tools

      # backups
      rsnapshot

      # ssh
      sshuttle
      ssh-askpass-fullscreen
      autossh
 
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
      delta # "A syntax-highlighting pager for git" https://github.com/dandavison/delta
      
      # search
      silver-searcher
      ack
      fzf
      fd  # fd is a simple, fast and user-friendly alternative to find(1).
      findutils
      zsh-z  # https://github.com/agkozak/zsh-z -> "Zsh-z is a native Zsh port of rupa/z, a tool written for bash and Zsh that uses embedded awk scripts to do the heavy lifting."
      rdfind
      ripgrep

      # email
      mutt

      # QMK
      qmk
      qmk-udev-rules

      # spellchecker
      aspell aspellDicts.de aspellDicts.en aspellDicts.en-computers
     
      ocrmypdf
      poppler_utils
      
      yt-dlp
      youtube-dl
      jq ## used for yth.sh
      magic-wormhole
      pdfminer  # e.g. for pdf2txt dumppdf
      qpdf  # e.g. splitting pdf files
      
      #jre_minimal ## minimal Java environment (including keytool); 2023-11-03 this JRE caused: "Error: Unable to initialize main class net.sourceforge.plantuml.Run" → "Caused by: java.lang.NoClassDefFoundError: java/awt/Graphics"
      openjdk17-bootstrap ## because "jre_minimal" caused: "Error: Unable to initialize main class net.sourceforge.plantuml.Run" → "Caused by: java.lang.NoClassDefFoundError: java/awt/Graphics"

      yubikey-manager # "ykman" for managing Yubikeys and their PINs and so forth

      libfaketime # faketime for debugging gpg issues

      gnumake
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
  }; # end of tmux

  # FIXXME: currently trying to accomplish: replace "floyd" with the current hostname in the following line:

  # WORKS:
  # home.file.".tmuxp/nixosvmr".source = ../assets/.tmuxp/nixosvmr.yaml; # with hard-coded hostname
  home.file.".tmuxp/${hostName}.yaml".source = ../assets/.tmuxp/${hostName}.yaml;


    programs.zsh = {
      
      ## all options: https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.enable

      enable = true;
      
      oh-my-zsh = {
        # 2023-07-28: oh-my-zsh doesn't have a plugin that shows me the exit code if it was not 0 (I'd probably have to define my own prompt)
        enable = true;
        theme = "kolo";
        plugins = [ # List of plugins: https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
          # "git" # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git -> overwrites with my own "ga" alias
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

      ## dirHashes → https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.dirHashes
      dirHashes = {
      };

      ## shellAliases → https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.shellAliases
      shellAliases = {
        #"ls" = "lsd";
        "l" = "lsd -la";
        "any" = "ps xauwww|grep -v grep|grep";
        "dl" = "ls -lhtr --color=always ~/Downloads | tail -n 10"; # Show the 10 newest Downloads
        "o" = "less";
        "gg" = "git grep";
        "m" = "mpv";
        "s" = "tmux a"; # reminiscence to good old GNU screen ;-)
        "open" = "xdg-open";
        "e" = "emacsclient";
        "pdf" = "okular";
        "plvolleyball" = "grep ':ID: 2015-09-28-PL-Volleyball' -A 17  ~/org/notes.org | tail -n 16";
      };

      # extra entries for .zshrc → https://rycee.gitlab.io/home-manager/options.html#opt-programs.zsh.initExtra
      initExtra = ''

          risetransfer () {
              ## works only from within the VPN!
              if [ $# -eq 0 ]; then
                  echo "No arguments specified.\nUsage:\n  transfer <file|directory>\n  ... | transfer <file_name>">&2;
                  return 1;
              fi;
              if tty -s; then
                  file="$1";
                  file_name=$(basename "$file");
                  if [ ! -e "$file" ];
                  then echo "$file: No such file or directory">&2;
                       return 1;
                  fi;
                  if [ -d "$file" ];
                  then file_name="$file_name.zip" ,;
                       (cd "$file"&&zip -r -q - .) | curl --progress-bar --upload-file "-" "https://transfer.risedev.at/$file_name" | tee /dev/null,;
                  else cat "$file" | curl --progress-bar --upload-file "-" "https://transfer.risedev.at/$file_name" | tee /dev/null;
                  fi;
              else file_name=$1;
                   curl --progress-bar --upload-file "-" "https://transfer.risedev.at/$file_name" | tee /dev/null;
              fi;
                 }

      REPORTTIME=5
      '';
      
    }; # end of zsh


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
    }; # end of git

  

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

    ## see also issue from id:2023-09-03-fix-no-pinentry-for-Emacs-decrypt-gpg
    ## from: https://github.com/hlissner/dotfiles/blob/089f1a9da9018df9e5fc200c2d7bef70f4546026/modules/shell/gnupg.nix#L22
    # HACK Without this config file you get "No pinentry program" on 20.03.
    #      programs.gnupg.agent.pinentryFlavor doesn't appear to work, and this
    #      is cleaner than overriding the systemd unit.
    home.file.".gnupg/gpg-agent.conf" = {
      text = ''
        default-cache-ttl 600
        max-cache-ttl 6000
        pinentry-program ${pkgs.pinentry.gtk2}/bin/pinentry
      '';
    };
    
  
}
