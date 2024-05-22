{ config, pkgs, lib, ... }:

{

  home.packages = with pkgs; [

    #Bluetooth for controllers:
    bluez  # BT protocol
    blueman # BT manager
    hidapi # Library for communicating with USB and Bluetooth HID devices
    bluez-tools
    
    retroarchFull

  ];

}
