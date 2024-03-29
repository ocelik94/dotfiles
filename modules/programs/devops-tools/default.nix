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
        kubernetes-helm
        kubectl
        lens
        drawio
        awscli2
        # azure-cli
        grype
        syft
        kind
        cosign
        google-cloud-sdk
        gnome-connections
        tigervnc
        kubie
        inkscape
        bun
      ];
    };
  };
}
