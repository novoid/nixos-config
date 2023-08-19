# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = false; ## disable os prober warnings; activate for dual-boot with Windows
  
  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable grub cryptodisk
  boot.loader.grub.enableCryptodisk=true;

  boot.initrd.luks.devices."luks-68a6a26b-400b-4b9a-aeb2-9da649ebaa6a".keyFile = "/crypto_keyfile.bin";
  # Enable swap on luks
  boot.initrd.luks.devices."luks-48f191cb-ee88-41aa-920d-34e9957cea27".device = "/dev/disk/by-uuid/48f191cb-ee88-41aa-920d-34e9957cea27";
  boot.initrd.luks.devices."luks-48f191cb-ee88-41aa-920d-34e9957cea27".keyFile = "/crypto_keyfile.bin";

  networking.hostName = "floyd"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Vienna";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_AT.UTF-8";
    LC_IDENTIFICATION = "de_AT.UTF-8";
    LC_MEASUREMENT = "de_AT.UTF-8";
    LC_MONETARY = "de_AT.UTF-8";
    LC_NAME = "de_AT.UTF-8";
    LC_NUMERIC = "de_AT.UTF-8";
    LC_PAPER = "de_AT.UTF-8";
    LC_TELEPHONE = "de_AT.UTF-8";
    LC_TIME = "de_AT.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "intl";
  };

nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
#  sound.enable = true;
#  hardware.pulseaudio.enable = false;
#  security.rtkit.enable = true;
#  services.pipewire = {
#    enable = true;
#    alsa.enable = true;
#    alsa.support32Bit = true;
#    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
#  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vk = {
    isNormalUser = true;
    description = "Karl Voit";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox git wget
    #  thunderbird
    ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vk";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

  my.isnotebook = true;
  my.isvm = false;

  services = {
    syncthing = {
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
      # folders = {
      #   "nixos-configuration" = {        # Name of folder in Syncthing, also the folder ID
      #     path = "/home/vk/nixos";    # Which folder to add to Syncthing
      #     devices = [ "karl-voit.at" "sting" "rise" ];      # Which devices to share the folder with
      #   };
      #  
      # }; # folders
    };
  };
  ## # Syncthing ports
  ## networking.firewall.allowedTCPPorts = [ 8384 22000 ];
  ## networking.firewall.allowedUDPPorts = [ 22000 21027 ];

}
