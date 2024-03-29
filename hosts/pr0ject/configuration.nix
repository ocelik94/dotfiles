{ config, pkgs, ... }:
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
    hostName = "pr0ject";
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  virtualisation = { 
    docker = {
      enable = true;
    };
  };

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";


  programs.xwayland.enable = true;
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        libva
        nvidia-vaapi-driver
      ];
    };

    nvidia = {
      nvidiaSettings = true;
      modesetting.enable = true;
      open = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
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
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "fortuneteller2k.cachix.org-1:kXXNkMV5yheEQwT0I4XYh1MaCSz+qg72k8XAi2PthJI="
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
