{ pkgs
, config
, lib
, theme
, user
, ...
}:
let
  cfg = config.modules.desktop.gnome;
in
with lib; {
  options.modules.desktop.gnome = {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "gnome + gtk config";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        adwaita-qt
        gtk3
        gtk4
      ];
      sessionVariables = {
        GTK_THEME = "${theme.name.gtk}";
      };
    };

    gtk = with theme; {
      enable = true;
      gtk3.extraConfig = {
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
        gtk-application-prefer-dark-theme = 1;
      };
      font = {
        name = "Roboto";
        size = 10;
      };
      theme.name = name.gtk;
      iconTheme = {
        name = name.icon;
      };
    };
  };
}
