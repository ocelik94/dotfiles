{
  user,
  config,
  lib,
  ...
}: let
  # returns list of all folders in path
  getDirfolders = path: (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name)) (lib.attrsets.filterAttrs (name: value: value == "directory") (builtins.readDir path)));
  shell = getDirfolders ../../modules/shell;
  desktop = getDirfolders ../../modules/desktop;
  programs = getDirfolders ../../modules/programs;
  services = getDirfolders ../../modules/services;
in {
  imports =
    [
      ./home.nix
    ]
    ++ desktop
    ++ programs
    ++ services
    ++ shell;

  config.modules = rec {
    desktop = {
      awesome.enable = true;
      gtk.enable = true;
    };
    programs = {
      neovim.enable = true;
      firefox.enable = true;
      kitty.enable = true;
      rofi.enable = true;
    };
    services = {
      picom.enable = true;
      mpd.enable = true;
      gammastep.enable = false;
      mako.enable = true;
      polkit.enable = true;
      gnupg.enable = true;
    };
    shell = {
      zsh.enable = true;
      tmux.enable = true;
    };
  };
}
