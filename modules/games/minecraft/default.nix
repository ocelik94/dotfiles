{ pkgs, lib, config, user, theme, inputs, ... }:
let cfg = config.modules.games.minecraft;
in with lib; {
  options.modules.games.minecraft = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable minecraft tools";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        # MC related
        prismlauncher
        steam
        # inputs.nix-gaming.packages.${pkgs.system}.wine-ge
        (lutris.override {
          extraLibraries = pkgs: [
          pkgs.jansson
          ];
        })
      ];
    };
  };
}
