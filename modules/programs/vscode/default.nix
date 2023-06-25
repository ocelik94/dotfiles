{
  pkgs,
  lib,
  config,
  user,
  theme,
  ...
}: let
  cfg = config.modules.programs.vscode;
in
  with lib; {
    options.modules.programs.vscode = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable official microsoft visual studio code";
      };
    };

    config = mkIf cfg.enable {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        extensions = with pkgs.vscode-extensions; [
          bbenoist.nix
        ];
        userSettings = {
           editor.fontFamily =  "RobotoMono Nerd Font Mono";
           terminal.integrated.fontFamily = "RobotoMono Nerd Font Mono, monospace";
        };
      };
    };
  }
