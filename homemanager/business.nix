{ config, pkgs, lib, hostName, ... }:

{

    home.packages = with pkgs; [
      zoom-us
      webex
      skypeforlinux
      obs-studio
      evolutionWithPlugins
      
      openvpn networkmanager-openvpn gnome.networkmanager-openvpn
      
      emacsPackages.helm-org-ql emacsPackages.helm-org emacsPackages.helm-org-rifle 
    ];


  
  
}
