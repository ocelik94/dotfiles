{ pkgs, config, lib, inputs, ... }:
let
  cfg = config.modules.programs.neovim;
  neovim_cfg =
    import ../../../configs/neovim { inherit inputs lib pkgs; };
in
with lib; {
  options.modules.programs.neovim = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable neovim with nvchad";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs;
        [
          neovim
        ];
      file.".config/nvim/" = {
        source = neovim_cfg;
        recursive = true;
      };
    };
  };
}
