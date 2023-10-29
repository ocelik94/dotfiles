{ pkgs
, config
, lib
, theme
, user
, ...
}:
let
  cfg = config.modules.desktop.plasma;
  mkTuple = lib.hm.gvariant.mkTuple;
in
with lib; {
  options.modules.desktop.plasma = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "plasma config";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        
      ];
      sessionVariables = {
      };
    };
  };
}
