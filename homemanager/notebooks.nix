#NOTE: The purpose of this file is to collect setup which is specific to notebooks only (in contrast to desktop or server computers)
{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    powertop

  ];

}
