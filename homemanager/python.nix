{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    python3Full
    python3Packages.pip
    python3Packages.pyscss
    python3Packages.flake8
    python3Packages.pyflakes
    python3Packages.pylint
    python3Packages.matplotlib

    sass
  ];

}
