{ lib, pkgs, inputs, ... }:
pkgs.stdenv.mkDerivation rec {
  name = "neovim";

  user-src = inputs.neovim-dotfiles;
  src = inputs.astronvim;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/lua/user
    cp -r ${src}/* $out/
    cp -r ${user-src}/* $out/lua/user
  '';
}
