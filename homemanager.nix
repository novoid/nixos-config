{ config, pkgs, lib, inputs, ... }:

{

  # FIXXME: move stateVersion to either host-specific spot in flake.nix or hosts/$HOSTNAME/default.nix
  # causes:
  # trace: warning: system.stateVersion is not set, defaulting to 23.05. Read why this matters on https://nixos.org/manual/nixos/stable/options.html#opt-system.stateVersion.
  home.stateVersion = "22.11";

  nixpkgs.config.allowUnfree = true;   # e.g. for  vscode
#    nixpkgs.config.permittedInsecurePackages = [ "xpdf-4.04" ];

  home.packages = with pkgs; [
    hicolor-icon-theme
    inputs.nh.packages.${pkgs.system}.default
  ];

  home.sessionVariables.NH_FLAKE = "/home/vk/nixos"; ## for nh; 2024-12-23: changed "FLAKE" to "NH_FLAKE" because of https://github.com/viperML/nh/issues/199#issuecomment-2557575842
  
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  
  xdg = {
    enable = true;
  };


}
