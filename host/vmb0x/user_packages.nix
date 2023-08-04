{ user, config, lib, ... }:
let
  # returns list of all folders in path
  getDirfolders = path:
    (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name))
      (lib.attrsets.filterAttrs (name: value: value == "directory")
        (builtins.readDir path)));
  shell = getDirfolders ../../modules/shell;
  desktop = getDirfolders ../../modules/desktop;
  games = getDirfolders ../../modules/games;
  programs = getDirfolders ../../modules/programs;
  services = getDirfolders ../../modules/services;
in
{
  imports = [ ./home.nix ] ++ desktop ++ programs ++ games ++ services ++ shell;

  config.modules = rec {
    desktop = {
      awesome.enable = true;
      gtk.enable = true;
    };
    programs = {
      neovim.enable = true;
      wezterm.enable = true;
      rofi.enable = true;
      vscode.enable = true;
      brave.enable = true;
      latex.enable = true;
      devops-tools.enable = true;
    };
    games = {
      minecraft.enable = true;
    };
    services = {
      picom.enable = false;
      polkit.enable = true;
    };
    shell = { zsh.enable = true; };
  };
}
