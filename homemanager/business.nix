{ config, pkgs, lib, hostName, ... }:

{

    home.packages = with pkgs; [
      #zoom-us # 2024-02-27: disabled; use with nix-shell -p
      #webex # 2024-02-27: disabled; use with nix-shell -p
      #skypeforlinux # 2024-02-27: disabled; use with nix-shell -p
      obs-studio
      evolutionWithPlugins
      
      openvpn networkmanager-openvpn
      
      emacsPackages.helm-org-ql emacsPackages.helm-org emacsPackages.helm-org-rifle 

      nextcloud-client

      #citrix_workspace ## 2025-05-06: package needs linuxx64-24.5.0.76.tar.gz but website only provides linuxx64-25.03.0.66.tar.gz
      rustdesk ## Citrix alternative
    ];


  
  
}
