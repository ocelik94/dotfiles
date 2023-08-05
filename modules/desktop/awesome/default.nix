{ pkgs, config, lib, theme, inputs, ... }:
let
  cfg = config.modules.desktop.awesome;
  i3lock-script = import ./i3lock.nix {inherit pkgs theme;};
  awesome_cfg =
    import ../../../configs/awesome { inherit inputs lib theme pkgs; };
in
with lib; {
  options.modules.desktop.awesome = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "awesome basic";
    };
  };

  config = mkIf cfg.enable {
    services.xidlehook = {
      enable = true;
      not-when-audio = true;
      not-when-fullscreen = true;
      timers = [
        {
          delay = 600;
          command = ''xrandr --output "$PRIMARY_DISPLAY" --brightness .1'';
          canceller = ''xrandr --output "$PRIMARY_DISPLAY" --brightness 1'';
        }
        {
          delay = 630;
          command = "${i3lock-script}/bin/i3lock-script";
        }
      ];
    };
    home = {
      packages = with pkgs; [
        scrot
        xclip
        i3lock-color
        i3lock-script
        redshift
        dconf
      ];
      file.".config" = {
        source = awesome_cfg;
        recursive = true;
      };
    };
    xresources = {
      extraConfig = import ./xresources.nix { inherit theme; };
    };
  };
}
