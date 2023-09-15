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
        gnomeExtensions.just-perfection
      ];
      sessionVariables = {
      };
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell/extensions/dash-to-panel" = {
          hide-overview-on-startup = true;
        };
        "org/gnome/desktop/wm/preferences" = {
          button-layout = "appmenu:minimize,maximize,close";
        };
        "org/gnome/desktop/session" = {
          idle-delay = "uint32 0";
        };
        "org/gnome/settings-daemon/plugins/power" = {
          sleep-inactive-ac-type = "nothing";
          power-button-action = "interactive";
        };
        "org/gnome/shell/extensions/user-theme" = {
          name = "Adwaita:dark";
        };
        
        "org/gnome/shell/extensions/just-perfection" = {
          animation = 2;
        };
        "org/gnome/mutter" = {
          dynamic-workspaces = true;
          edge-tiling = true;
          workspaces-only-on-primary = true;
        };
        "org/gnome/desktop/peripherals/mouse" = {
          speed = "-0.155";
          accel-profile = "flat";
        };
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita-dark";
          enable-animations = true;
        };
        "org/gnome/desktop/input-sources" = {
          show-all-sources = true;
          sources = [ (mkTuple [ "xkb" "eu" ]) ];
          xkb-options = [ "terminate:ctrl_alt_bksp" ];
        };
        "org/gnome/shell/app-switcher" = {
          current-workspace-only = true;
        };
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "dash-to-panel@jderose9.github.com"
            "appindicatorsupport@rgcjonas.gmail.com"
            "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
            "just-perfection-desktop@just-perfection"
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
