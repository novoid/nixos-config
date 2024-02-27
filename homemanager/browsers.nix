{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    firefox
    ungoogled-chromium
    # nyxt # 2024-02-27: disabled; use with nix-shell -p
    tor
    torsocks
    tor-browser-bundle-bin

  ];

}
