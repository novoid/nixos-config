{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    firefox
    ungoogled-chromium
    nyxt
    tor
    torsocks
    tor-browser-bundle-bin

  ];

}
