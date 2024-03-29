{ pkgs, ... }: {
  services.network-manager-applet.enable = true;

  home = {
    username = "ocelik";
    homeDirectory = "/home/ocelik";
    stateVersion = "23.05";

    packages =
      let
      in with pkgs; [
        # Terminal
        ranger
        less
        lazygit
        ripgrep
        gh-dash
        direnv

        # General
        networkmanagerapplet

        # media/game
        feh
        pavucontrol
        easyeffects
        teamspeak_client
        discord

        # Downloader
        wget
        aria
        remmina
        filezilla

        # Dev
        sublime-merge
        gnupg
        git
        jq
        jetbrains.rust-rover
        jetbrains.webstorm
        jetbrains.datagrip
        kubeseal
        fluxcd
      ];
  };
}
