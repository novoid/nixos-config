{ config, pkgs, lib, ... }:

{

  users.users.vk = {
    packages = with pkgs; [


    ];
  };

}
