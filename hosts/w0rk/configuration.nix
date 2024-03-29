{ pkgs, ... }:
{
  imports =
    [ ./hardware-configuration.nix ];
  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "quiet" "acpi_osi=!" ];
    loader = {
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        gfxmodeEfi = "2560x1440";
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        default = "saved";
      };
    };
  };

  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "w0rk";
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  virtualisation = { docker.enable = true; };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";


  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    pulseaudio.enable = false;
    bluetooth = {
      enable = false;
      settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://fortuneteller2k.cachix.org"
        "https://nix-gaming.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  environment.pathsToLink = [ "/share/zsh" ];

  system.stateVersion = "23.05";
}
