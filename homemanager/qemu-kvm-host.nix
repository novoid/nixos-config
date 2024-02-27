{ config, pkgs, lib, hostName, ... }:

{

    home.packages = with pkgs; [
    qemu
    virt-manager-qt   ## seems to only connect to existing VMs and not create new ones
    # broken:      aqemu
    # qtemu  ## looks nice but is not able to find the installed qemu-img to create a new virtual disk ("Ensure that you have installed qemu-img in your system and it's available").
    quickemu # recommendation from Mastodon to create VMs
    # quickgui # a GUI for guickemu - looked nice but doesn't support Windows hosts
    ];


  
  
}
