{ pkgs
, config
, lib
, theme
, user
, ...
}:
let
  cfg = config.modules.desktop.gnome;
  mkTuple = lib.hm.gvariant.mkTuple;
in
with lib; {
  options.modules.desktop.gnome = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "gnome + gtk config";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        adwaita-qt
        gtk3
        gtk4
        gnomeExtensions.dash-to-panel
        gnomeExtensions.appindicator
      ];
      sessionVariables = {
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell/extensions/user-theme" = {
          name = "Adwaita:dark";
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
        };
        "org/gnome/desktop/input-sources" = {
          show-all-sources = true;
          sources = [ (mkTuple [ "xkb" "eu" ]) ];
          xkb-options = [ "terminate:ctrl_alt_bksp" ];
        };
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "dash-to-panel@jderose9.github.com"
            "appindicatorsupport@rgcjonas.gmail.com"
          ];
        };
      };
    };

    gtk = with theme; {
      enable = true;
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      #theme.name = name.gtk;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
