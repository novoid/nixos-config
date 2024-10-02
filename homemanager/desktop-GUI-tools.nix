{ config, pkgs, lib, ... }:

{

    home.packages = with pkgs; [

      corefonts  # Microsoft TTF core fonts
      
      signal-desktop
      
      libreoffice
      odt2txt
      hunspellDicts.de_AT
      hunspellDicts.en_US-large

#      subsurface
      #freemind # 2024-02-27: disabled; use with nix-shell -p
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
      pdfarranger # Small python-gtk application, which helps the user to merge or split PDF documents and rotate, crop and rearrange their pages using an interactive and intuitive graphical interface.  https://github.com/pdfarranger/pdfarranger
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

      blanket ## Noisli for the desktop: https://apps.gnome.org/Blanket/ → listen to different background sounds like birds, ocean, rain, ...
      libretranslate  # standalone dictionary service: need to invoke "libretranslate" in a shell in order to download language models.
      languagetool # text correction framework for multiple languages incl. tray app

      librewolf # privacy-friendly firefox
    ];

}

