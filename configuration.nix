# This is a Nix configuration file that contains ALL SETTINGS shared by ALL HOSTS:

{ config, pkgs, ... }:

{
  imports =
    [
      ./customOptions.nix
      ./xfce.nix
    ];

  ## https://nixos.wiki/wiki/Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  ## 2023-07-22 https://graz.social/@pimeys@social.nauk.io/110757634337893588 -> https://github.com/pimeys/nixos/blob/main/core/default.nix#L73
  ## save space by enabling hard links in the nix store (not a default); And running the optimization once after enabling this setting by doing nix-store --optimise (can take a while). 50-100GB saved right there…
  ## docu: https://nixos.wiki/wiki/Storage_optimization
  nix.settings.auto-optimise-store = true;
  
  # Set your time zone.
  time.timeZone = "Europe/Vienna"; # SPECIFICTOKARL

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

  services.locate = {
    enable = true;
    locate = pkgs.plocate;
    localuser = null; # why? → warning: mlocate and plocate do not support the services.locate.localuser option. updatedb will run as root. Silence this warning by setting services.locate.localuser = null.
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  systemd.sleep.extraConfig = "HibernateDelaySec=30m"; # from: https://github.com/NixOS/nixos-hardware/issues/672
  
  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false; ## 2023-09-04: needs to be false when using pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.vk = { # SPECIFICTOKARL
    isNormalUser = true;
    description = "Karl Voit"; # SPECIFICTOKARL
    extraGroups = [
      "wheel" # Enable ‘sudo’ for the user.
      "networkmanager" # Access to networkmanager
      "docker" # Access to the "/run/docker.sock"
      "plocate"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
    ];
  };

  security.sudo.extraConfig = ''
                             Defaults        timestamp_timeout=60
  '';                        
  
  programs.zsh.enable = true; # FIXXME: is this redundant to the programs.zsh = {}?

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "vk"; # SPECIFICTOKARL

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  environment.variables = {
    EDITOR = "vim";
    PATH = "$PATH:/home/vk/bin"; # SPECIFICTOKARL
#    XDG_SCREENSHOTS_DIR = "/home/vk/screenshots/";
    DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";

  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    # interval = { Weekday = 0; Hour = 0; Minute = 0; };
    options = "--delete-older-than 30d";
  };

  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    gitFull
    tmux
    syncthing
    cron
    wpa_supplicant
    plocate # much faster locate; not in HM because system-service
    
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  
  # List services that you want to enable:

  
  services.xserver = {
    xkbOptions = "ctrl:nocaps"; # Configure keymap in X11
    
  };

  
#programs.git = {
#  enable = true;
#  userName  = "Karl Voit";
#  userEmail = "git@Karl-Voit.at";
#  ## 2023-06-05: "programs.git.aliases doesn not exist"
#  aliases = {
#    lol = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue)<%an>%Creset' --abbrev-commit";
#    ci = "commit";
#    co = "checkout";
#    s = "status";
#  };
#};

  ## 2023-06-05: option does not exist
#    services.gammastep = {
#      enable = true;
#      tray = true;
#      latitude = "47.07"; # Graz = 47.07 / 15.44 according to https://de.wikipedia.org/wiki/Graz
#      longitude = "15.44";
#      temperature = {
#        day = 5500;
#        night = 3300;
#      };
#
#    };



}
