{ pkgs, lib, config, user, theme, ... }:
let
  biber217 = pkgs.callPackage ../../../pkgs/biber217.nix { };
  cfg = config.modules.programs.latex;
in
with lib; {
  options.modules.programs.latex = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable tectonic with biber 2.7";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [ tectonic biber217 perl536Packages.LatexIndent jabref ];
    };
  };
}
