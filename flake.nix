{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nur = { url = "github:nix-community/NUR"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    # };

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

  outputs = inputs @ { self, ... }: {
    nixosConfigurations = {
      pr0ject = import ./hosts/pr0ject { inherit inputs; };
      pr0ject-gnome = import ./hosts/pr0ject-gnome { inherit inputs; };
      w0rk = import ./hosts/w0rk { inherit inputs; };
      vmb0x = import ./hosts/vmb0x { inherit inputs; };
    };
  };
}
