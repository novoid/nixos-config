{ config, pkgs, lib, ... }:
{

  # NOTE: Home-manager related settings are in homemanager/xfce.nix
  
  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager = {
    lightdm.enable = true;
    
    # auto-start a few apps on xfce startup:
    sessionCommands = ''
        autokey-gtk &
    '';         
  };

  services.xserver.desktopManager = {
    xfce.enable = true;
  };


  environment.systemPackages = with pkgs; [

    # ##################################################################
    # xfce: this can't be in homemanager/xfce.nix because of: 
    redshift
    xclip
    xfce.xfce4-dict
    autokey
    gnome-icon-theme
    dejavu_fonts
    gentium
    yanone-kaffeesatz
    wmctrl
    gnome.gnome-keyring
    xfce.xfwm4-themes
    xfce.thunar
    xfce.thunar-volman
    xfce.xfce4-appfinder
    xfce.xfce4-clipman-plugin
    xfce.xfce4-cpugraph-plugin
    xfce.xfce4-eyes-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-weather-plugin
    xfce.xfce4-mailwatch-plugin
    xfce.xfce4-netload-plugin
    xfce.xfce4-notes-plugin
    xfce.xfce4-notifyd
    xfce.xfce4-power-manager
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-screensaver
    xfce.xfce4-screenshooter
    xfce.xfce4-session
    xfce.xfce4-settings
    xfce.xfce4-systemload-plugin
    xfce.xfce4-taskmanager
    xfce.xfce4-terminal
    xfce.xfce4-verve-plugin
    emojione
    rofi
    brightnessctl
    # libsForQt514.oxygen-icons5 ## 2022-11-06 broken
    # ##################################################################

  ];
  
  programs.xfconf.enable = true;

}
