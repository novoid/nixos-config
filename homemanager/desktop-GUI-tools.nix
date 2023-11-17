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
      dosbox
      gnome.gnome-terminal
      libnotify

      (callPackage ../pkgs/xdu.nix {})

      qpwgraph ## pipewire tool

      openai-whisper ## https://github.com/openai/whisper
      scrcpy ## Android screen content → desktop https://scrcpy.org/
      android-tools ## mkbootimg avbtool lpunpack mkdtboimg simg2img img2simg lpadd lpdump unpack_bootimg lpmake append2simg mke2fs.android lpflash repack_bootimg ext2simg e2fsdroid adb fastboot
      android-udev-rules
      
    ];

}

