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
    ];


  
  
}
