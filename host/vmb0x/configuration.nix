{ pkgs, lib, inputs, theme, user, ... }:
let sddm-theme = pkgs.callPackage ../../pkgs/sddmtheme.nix { };
in {
  imports =
    [ ./fontconfig.nix ./extra-settings.nix ./hardware-configuration.nix ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_5_4;
    kernelParams = [ "quiet" ];
    loader = {
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        default = "saved";
      };
    };
  };

  time.hardwareClockInLocalTime = true;

  networking = {
    hostName = "vmb0x";
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  virtualisation = { 
    docker.enable = true;
    vmware.guest.enable = true;
  };

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    packages = with pkgs; [ terminus_font ];
    font = "ter-u28b";
    useXkbConfig = true;
    earlySetup = true;
    colors =
      let substr = str: lib.strings.removePrefix "#" str;
      in with theme.colors; [
        (substr black)
        (substr red)
        (substr green)
        (substr yellow)
        (substr blue)
        (substr purple)
        (substr aqua)
        (substr gray)
        (substr brightblack)
        (substr brightred)
        (substr brightgreen)
        (substr brightyellow)
        (substr brightblue)
        (substr brightpurple)
        (substr brightaqua)
        (substr brightgray)
      ];
  };

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "users" "docker" ];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    _1password = { enable = true; };
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "ocelik" ];
    };
    git = {
      enable = true;
      package = pkgs.gitFull;
      config = {
        user = {
          email = "okan@celik.tech";
          name = "Okan Celik";
          signingkey = "7D279ED727E5D470";
        };
        init.defaultBranch = "main";
        commit.gpgsign = "true";
        credential.helper = "libsecret";
      };
    };
    ssh.askPassword = "";
  };

  nixpkgs.config = { allowUnfree = true; };

  environment = {
    sessionVariables = rec {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      EDITOR = "nvim";
    };

    systemPackages = with pkgs; [
      # program
      _1password
      _1password-gui

      # system
      pulseaudio
      ntfs3g
      alsa-utils
      usbutils
      ffmpeg
      htop

      # compression
      p7zip
      unrar
      unzip
      exfat
      zip

      sddm-theme
    ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    gnome.gnome-keyring.enable = true;
    blueman.enable = false;
    fstrim.enable = true;
    dbus.enable = true;
    gvfs.enable = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        mesa.drivers
        libglvnd
        libGL
      ];
    };

    pulseaudio.enable = false;
    bluetooth = {
      enable = false;
      settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "eu";
      videoDrivers = [ "vmware" ];
      desktopManager = { xfce.enable = false; };
      windowManager = { awesome = { enable = true; }; };
      desktopManager = { xterm.enable = false; };
      imwheel.enable = true;
      displayManager = {
        startx.enable = true;
        sddm = {
          enable = true;
          theme = "Psion";
        };
      };
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.accelSpeed = "0";
        touchpad.naturalScrolling = true;
      };
    };
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  environment.pathsToLink = [ "/share/zsh" ];

  system.stateVersion = "23.05";
}
