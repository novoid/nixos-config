## Almost everything here is SPECIFICTOKARL
{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
    ];

#  # Setup keyfile
#  boot.initrd = {
#    secrets = {
#      "/crypto_keyfile.bin" = null;
#    };
#    # Enable grub cryptodisk
#    luks.devices."luks-f8186a1e-3f74-4df3-99f7-ed662b0341d7".keyFile = "/crypto_keyfile.bin";
#  };

  
  # Bootloader.                                                                                                                                                                                                                        
  boot.loader.grub.enable = true;                                                                                                                                                                                                      
  boot.loader.grub.device = "/dev/vda";                                                                                                                                                                                                
  boot.loader.grub.useOSProber = true;     

  networking.hostName = "nixosvms"; # Define your hostname.

  my.isnotebook = false;
  my.isvm = true;
  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  #networking.defaultGateway = "192.168.5.201";

  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  # when omitted:
  # error: The option `home-manager.users.vk.home.stateVersion' is used but not defined.
  # when active below:
  # error: The option `home' does not exist. Definition values: [...]

  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  
  services = {
    
    syncthing = {
      
      # https://nixos.wiki/wiki/Syncthing
      
      enable = true;
      user = "vk";
      dataDir = "/home/vk/share";
      configDir = "/home/vk/.config/syncthing";
      overrideDevices = false;     # overrides any devices added or deleted through the WebUI
      overrideFolders = false;     # overrides any folders added or deleted through the WebUI
      devices = {
        "sting" = { id = "GDIGF5G-ZPMAKBL-JQO6SXC-N322AAE-ENNGEDL-BPBZBTT-NFYXJ5M-SWHZYA7"; };
        "rise" = { id = "WJVLRCX-Q65XSAL-4DHPZLY-QHAXAEP-MU3FMDH-UHT5Q53-7T3UCQP-MWWJKAM"; };
        "karl-voit.at" = { id = "TPKSMZI-FUNRWLY-PND3NID-DPWM3RH-PP2W5ID-3MYSLQQ-MMLSIPP-ZIUHSAH"; };
        #"floyd" = { id = "HJUQBBS-PZ5PVX2-O737FMQ-6SOR2PM-5H2EHIM-FGLR4NT-EZNWRFX-S6NQXAB"; };
        #"" = { id = ""; };
        #"" = { id = ""; };
      };
      folders = {
        "nixos-configuration" = {        # Name of folder in Syncthing, also the folder ID
          id = "nixos-configuration";
          path = "/home/vk/nixos";    # Which folder to add to Syncthing
          devices = [ "karl-voit.at" "sting" "rise" ];      # Which devices to share the folder with
        };
       
      };
    };
    
  };
  ## # Syncthing ports
  ## networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  ## networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  
    ## 2023-06-05: option does not exist
#    # Enable blueman-applet when the machine has bluetooth enabled
#    services.blueman-applet.enable = config.hardware.bluetooth.enable == true;

}
