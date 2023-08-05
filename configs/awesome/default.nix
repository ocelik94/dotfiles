{ lib, pkgs, inputs, theme, ... }:
pkgs.stdenv.mkDerivation rec {
  name = "awesomerc";

  src = inputs.awesomerc;

  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/awesome
    cp -r ${src}/* $out/awesome

    substituteInPlace $out/awesome/theme/pallete.lua \
      --replace "dark" "${theme.name.theme}"

    substituteInPlace $out/awesome/theme/init.lua \
      --replace "Roboto" "${theme.name.font}" \
      --replace "RobotoMono Nerd Font" "${theme.name.fontmonospace}"
  '';
}
