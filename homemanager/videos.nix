{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    ## Video apps
    ffmpeg
    mpv
    vlc
    #libsForQt514.kdenlive  ## 2023-06-05: kdenlive-22.08.3 is broken
    mediathekview

  ];


    
}
