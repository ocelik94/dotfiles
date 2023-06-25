{pkgs, ...}: {
  services.network-manager-applet.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home = {
    username = "ocelik";
    homeDirectory = "/home/ocelik";
    stateVersion = "23.05";

    packages = let
    in
      with pkgs; [
        # Terminal
        ranger
        less
        lazygit
        ripgrep
        gh-dash
        lxqt.pcmanfm-qt
        libsForQt5.ark

        # General
        networkmanagerapplet

        # media/game
        feh
        pavucontrol
        easyeffects

        # Downloader
        wget
        aria

        # Language Servers
        sumneko-lua-language-server
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted

        # Dev
        rustup
        git
        jq
        gcc
        pkg-config
        luajitPackages.jsregexp
        cmake
      ];
  };
}
