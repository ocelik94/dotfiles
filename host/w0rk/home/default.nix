{ lib, ... }:
let
  # returns list of all folders in path
  get_dir = path:
    (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name))
      (lib.attrsets.filterAttrs (name: value: value == "directory")
        (builtins.readDir path)));
  shell = get_dir ../../../modules/shell;
  desktop = get_dir ../../../modules/desktop;
  games = get_dir ../../../modules/games;
  programs = get_dir ../../../modules/programs;
  services = get_dir ../../../modules/services;
in
{
  imports = [ ./home.nix ] ++ desktop ++ programs ++ games ++ services ++ shell;

  config.modules = {
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
