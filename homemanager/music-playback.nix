{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    pavucontrol
    playerctl
    flac
    id3v2
    puddletag
    lame
    rhythmbox

  ];

}
