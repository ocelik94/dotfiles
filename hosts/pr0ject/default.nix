{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  system = "x86_64-linux";
  user = "ocelik";
  theme = import ../../theme/adwaita.nix;
  pkgs = import inputs.nixpkgs {
    inherit system lib;
    overlays = import ./overlays.nix { inherit inputs; };
    config = {
      allowBroken = false;
      allowUnfree = true;
      packageOverrides = super: { };
    };
  };
  fonts = import ./fonts.nix { inherit theme lib pkgs; };
in
lib.nixosSystem {
  inherit system pkgs;
  modules = [
    ./configuration.nix
    ./packages.nix
    fonts
    # inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager
    {
      users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "users" "docker" ];
        shell = pkgs.zsh;
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = import ./home/default.nix;
        extraSpecialArgs = { inherit inputs pkgs system user theme; };
      };
    }
  ];
}
