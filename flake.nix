{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-gaming.url = "github:fufexan/nix-gaming";

    # nur = { url = "github:nix-community/NUR"; };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-rice = { url = "github:bertof/nix-rice"; };

    awesomerc = {
      url = "git+https://gitlab.pr0ject.dev/dotfiles/awesomewm.git";
      flake = false;
    };

    astronvim = {
      url = "git+https://github.com/AstroNvim/AstroNvim.git";
      flake = false;
    };

    nvchad = {
      url = "git+https://github.com/NvChad/NvChad.git";
      flake = false;
    };

    neovim-dotfiles = {
      url = "git+https://gitlab.pr0ject.dev/dotfiles/neovim.git";
      flake = false;
    };

    neovim-dotfiles-nvchad = {
      url = "git+https://gitlab.pr0ject.dev/dotfiles/neovim-nvchad-config.git";
      flake = false;
    };
  };

  outputs = inputs @ { self, ... }: {
    nixosConfigurations = {
      pr0ject = import ./hosts/pr0ject { inherit inputs; };
      w0rk = import ./hosts/w0rk { inherit inputs; };
      vmb0x = import ./hosts/vmb0x { inherit inputs; };
    };
  };
}
