{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    nur = { url = "github:nix-community/NUR"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nix-rice = { url = "github:bertof/nix-rice"; };

    awesomerc = {
      url = "git+https://gitlab.projectoc.de/dotfiles/awesome.git";
      flake = false;
    }; 
    
    astronvim = {
      url = "git+https://github.com/AstroNvim/AstroNvim.git";
      flake = false;
    };

    neovim-dotfiles = {
      url = "git+https://gitlab.projectoc.de/dotfiles/neovim.git";
      flake = false;
    };

  };

  outputs = inputs@{ self, ... }:
    let
      system = "x86_64-linux";

      overlays = with inputs; [
        nur.overlay
        neovim-nightly-overlay.overlay
        nixpkgs-f2k.overlays.compositors
        nix-rice.overlays.default
        (final: prev: rec {
          awesome = nixpkgs-f2k.packages.x86_64-linux.awesome-luajit-git;
        })
      ];
    in
    {
      nixosConfigurations = with inputs; {
        pr0ject = import ./host/pr0ject { inherit overlays inputs; };
        w0rk = import ./host/w0rk { inherit overlays inputs; };
      };
    };
}
