{ pkgs, lib, config, user, theme, ... }:
let cfg = config.modules.programs.vscode;
in with lib; {
  options.modules.programs.devops-tools = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable devops tools";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        # Kubernetes related
        terraform
        kubernetes-helm
        kubectl
        lens
        drawio
        jetbrains-toolbox
        awscli2
        azure-cli
      ];
    };
  };
}
