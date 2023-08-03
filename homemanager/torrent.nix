{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    ## Torrent
    transmission
    transmission-remote-gtk 

  ];

}
