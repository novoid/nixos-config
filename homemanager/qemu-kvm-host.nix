{ config, pkgs, lib, hostName, ... }:

{

    home.packages = with pkgs; [
    qemu
    virt-manager
    # broken:      aqemu
    ];


  
  
}
