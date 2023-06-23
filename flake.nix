{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    nur = {
      url = "github:nix-community/NUR"; # NUR Packages
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   url = "github:vaxerski/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixpkgs-wayland = {
    #   url = "github:nix-community/nixpkgs-wayland";
    # };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nix-rice = {url = "github:bertof/nix-rice";};

    rtl8812au = {
      url = "github:aircrack-ng/rtl8812au";
      flake = false;
    };

    awesomerc = {
      url = "https://gitlab.projectoc.de/dotfiles/awesome.git";
      flake = false;
    };

    tmux-tpm = {
      url = "github:tmux-plugins/tpm";
      flake = false;
    };
  };

  outputs = inputs @ {self, ...}: let
    system = "x86_64-linux";

    overlays = with inputs; [
      nur.overlay
      neovim-nightly-overlay.overlay
      nixpkgs-f2k.overlays.compositors
      # wallpapers.overlay
      nix-rice.overlays.default
      (final: prev: rec {
        awesome = nixpkgs-f2k.packages.x86_64-linux.awesome-luajit-git;
      })
    ];
  in {
    nixosConfigurations = with inputs; {
      pr0ject = import ./host/pr0ject {
        inherit overlays inputs;
      };
    };
  };
}
