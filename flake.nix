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
    nixpkgs.url        = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; ## from https://thiscute.world/en/posts/nixos-and-flake-basics/
    gpt4all.url = "github:polygon/gpt4all-nix"; ## 2023-09-06 https://github.com/polygon/gpt4all-nix ; example use-case in config: https://github.com/search?q=repo%3AWhiteBlackGoose%2Fdotfiles%20gpt4all&type=code
    nh = {  ## https://github.com/viperML/nh
      url = "github:viperML/nh";
      # inputs.nixpkgs.follows = "nixpkgs"; # override this repo's nixpkgs snapshot ## disabled because: https://github.com/viperML/nh/issues/33#issuecomment-1719833405
    };
  };

  outputs = inputs@{
    self,
      nixpkgs,
      nix,
      nixos-hardware,
      home-manager,
      gpt4all,
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
                          #./homemanager/qemu-kvm-host.nix
                          #./homemanager/qemu-kvm-guest.nix
                          ./homemanager/latex.nix
                          #./homemanager/torrent.nix
                          
                          #./homemanager/notebooks.nix
                          #./homemanager/gaming.nix  ## 2024-11-17 disabled doe to issues with compiling of retroarch
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


      jackson = nixpkgs.lib.nixosSystem { # SPECIFICTOKARL
        system = "x86_64-linux";

        modules = [
	        {
        	  system.stateVersion = "23.05"; # Did you read the comment?
	        }
          nixos-hardware.nixosModules.lenovo-thinkpad-t490
          ./hosts/jackson
          ./configuration.nix
          # FIXXME: gpt4all.nixosModules.gpt4all-chat  ## 2023-09-06 fails with: "error: attribute 'nixosModules' missing"
          
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
                          ./homemanager/qemu-kvm-host.nix
                          #./homemanager/qemu-kvm-guest.nix
                          ./homemanager/latex.nix
                          #./homemanager/torrent.nix
                          
                          ./homemanager/business.nix
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
      }; # end jackson


      
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
                          #./homemanager/qemu-kvm-host.nix
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
                          #./homemanager/qemu-kvm-host.nix
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
