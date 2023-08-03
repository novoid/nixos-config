{ config, pkgs, lib, ... }:

{

    home.packages = with pkgs; [

      signal-desktop
      
      libreoffice
      odt2txt
      hunspellDicts.de_AT
      hunspellDicts.en_US-large

#      subsurface
      freemind
      hyphen
      keepassxc
      lbdb
      lm_sensors
      meld
      ntp
      pdfgrep
      pdftk
      pgf
      pdfpc  # PDF presentation tool
#      gnuplot
      recode
      smartmontools
      w3m
      #xpdf ##2023-06-08: causes compilation error: id:2023-06-07-migrate-to-23-dot-05
      dia
#      slimserver  # Logitech Squeezebox
#      calibre  
      nedit
      nix-output-monitor

      okular

      element-desktop # Matrix-client
      xorg.xeyes
      
    ];

}
