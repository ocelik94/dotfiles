{ inputs, ... }:
with inputs; [
  # nur.overlay
  # neovim-nightly-overlay.overlay
  nix-rice.overlays.default
  (final: prev: {
    awesome = nixpkgs-f2k.packages.x86_64-linux.awesome-luajit-git;
  })
]
