{ config, pkgs, lib, ... }:

{

  # NOTE: My GNU Emacs configuration is available on https://github.com/novoid/dot-emacs/blob/master/config.org

  # https://nixos.wiki/wiki/Emacs
  # FIXXME: try out the alternative method for "With Home-Manager":
#{
#  programs.emacs = {
#    enable = true;
#    package = pkgs.emacs;  # replace with pkgs.emacs-gtk, or a version provided by the community overlay if desired.
#    extraConfig = ''
#      (setq standard-indent 2)
#    '';
#  };
#}  
  
  home.packages = with pkgs; [

    emacs
    emacs28Packages.use-package
    pandoc
    imagemagick
    plantuml
    fantasque-sans-mono

    # emacs-everywhere:
    xclip
    xdotool
    xorg.xprop
    xorg.xwininfo
    
  ];

}
