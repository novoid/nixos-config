{ config, pkgs, lib, hostName, ... }:

{

    home.packages = with pkgs; [
      zoom-us
      webex
      skypeforlinux
      obs-studio
      evolutionWithPlugins
      
    ];


  
  
}
