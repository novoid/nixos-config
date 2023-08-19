{
  description = "Karl Voit"; # SPECIFICTOKARL

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];

    ## substituters = [
    ##   # replace official cache with a mirror located in China
    ##   "https://mirrors.bfsu.edu.cn/nix-channels/store"
    ##   "https://cache.nixos.org/"
    ## ];

    ## # nix community's cache server
    ## extra-substituters = [
    ##   "https://nix-community.cachix.org"
    ## ];

    ## extra-trusted-public-keys = [
    ##   "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ## ];
  };

  inputs = {
    nixpkgs.url        = "github:NixOS/nixpkgs/nixos-23.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; ## from https://thiscute.world/en/posts/nixos-and-flake-basics/
  };

  outputs = inputs@{
    self,
      nixpkgs,
      nix,
      nixos-hardware,
      home-manager,
      ...
  }: {
    nixosConfigurations = {

      floyd = nixpkgs.lib.nixosSystem { # SPECIFICTOKARL
        system = "x86_64-linux";

        modules = [
	        {
        	  system.stateVersion = "22.11"; # Did you read the comment?
	        }
          nixos-hardware.nixosModules.lenovo-thinkpad-x260
          ./hosts/floyd
          ./configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          ({ config, lib, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
                 inherit inputs; # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                 inherit (config.networking) hostName;
            };
            home-manager.users.vk = {...}: { # SPECIFICTOKARL
                      imports = [
                          ./homemanager.nix
                          ./homemanager/xfce.nix
                          ./homemanager/browsers.nix
                          ./homemanager/cli-tools.nix
                          ./homemanager/desktop-GUI-tools.nix
                          ./homemanager/emacs.nix
                          ./homemanager/graphics.nix
                          ./homemanager/music-playback.nix
                          ./homemanager/python.nix
                          ./homemanager/videos.nix
                          #./homemanager/qemu-kvm-guest.nix
                          ./homemanager/latex.nix
                          #./homemanager/torrent.nix
                          
                          #./homemanager/notebooks.nix
                      ]
                      ++ (lib.optional config.my.isnotebook ./homemanager/notebooks.nix)
                      # ALTERNATIVE:
                      # ++ (if config.my.isnotebook then [./homemanager/notebooks.nix] else [])
                      # else-stmt is not optional in nix
                        ;
                 };
          }) # end home-manager
        ]; # end modules
      }; # end floyd

      nixosvms = nixpkgs.lib.nixosSystem {
        ## a qemu NixOS-VM
        system = "x86_64-linux";

        modules = [
	        {
        	  system.stateVersion = "23.05"; # Did you read the comment?

            # Clipboard sharing - requires spice-guest-tools
            services.spice-vdagentd.enable = true;
            services.qemuGuest.enable = true;
	        }
          ./hosts/nixosvms
          ./configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager
          ({ config, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
                 inherit inputs; # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                 inherit (config.networking) hostName;
            };
            home-manager.users.vk = {...}: { # SPECIFICTOKARL
                      imports = [
                          ./homemanager.nix
                          ./homemanager/xfce.nix
                          ./homemanager/browsers.nix
                          ./homemanager/cli-tools.nix
                          #./homemanager/desktop-GUI-tools.nix
                          #./homemanager/emacs.nix
                          #./homemanager/graphics.nix
                          #./homemanager/music-playback.nix
                          #./homemanager/python.nix
                          #./homemanager/videos.nix
                          #./homemanager/notebooks.nix
                          ./homemanager/qemu-kvm-guest.nix
                          #./homemanager/latex.nix
                          #./homemanager/torrent.nix

                      ];
                 };
          }) # end home-manager
        ]; # end modules
      }; # end nixos-VM


      nixosvmr = nixpkgs.lib.nixosSystem {
        ## a qemu NixOS-VM
        system = "x86_64-linux";

        modules = [
	        {
        	  system.stateVersion = "23.05"; # Did you read the comment?

            # Clipboard sharing - requires spice-guest-tools
            services.spice-vdagentd.enable = true;
            services.qemuGuest.enable = true;
	        }
          ./hosts/nixosvmr
          ./configuration.nix

          # make home-manager as a module of nixos
          # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
          home-manager.nixosModules.home-manager 
          ({ config, ... }: {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
                 inherit inputs; # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
                 inherit (config.networking) hostName;
            };
            home-manager.users.vk = {...}: { # SPECIFICTOKARL
                      imports = [
                          ./homemanager.nix
                          ./homemanager/xfce.nix
                          ./homemanager/browsers.nix
                          ./homemanager/cli-tools.nix
                          #./homemanager/desktop-GUI-tools.nix
                          #./homemanager/emacs.nix
                          #./homemanager/graphics.nix
                          #./homemanager/music-playback.nix
                          #./homemanager/python.nix
                          #./homemanager/videos.nix
                          #./homemanager/notebooks.nix
                          ./homemanager/qemu-kvm-guest.nix
                          #./homemanager/latex.nix
                          #./homemanager/torrent.nix

                      ];
                 };
          }) # end home-manager
        ]; # end modules
      }; # end nixosvmr


    };
  };
}
