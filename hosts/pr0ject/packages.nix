{ pkgs, ... }:
{
  programs = {
    gamemode.enable = true;
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

  environment = {
    sessionVariables = rec {
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
      clinfo
      gcc

      # compression
      p7zip
      unrar
      unzip
      exfat
      zip
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

  services = {
    xserver = {
      enable = true;
      layout = "eu";
      videoDrivers = [ "nvidia" ];
      desktopManager = { gnome.enable = true; };
      imwheel.enable = true;
      displayManager = {
        gdm.enable = true;
        gdm.wayland = true;
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

  security.pam.services.swaylock.text = ''
    # Account management.
    account required pam_unix.so

    # Authentication management.
    auth sufficient pam_unix.so   likeauth try_first_pass
    auth required pam_deny.so

    # Password management.
    password sufficient pam_unix.so nullok sha512

    # Session management.
    session required pam_env.so conffile=/etc/pam/environment readenv=0
    session required pam_unix.so
  '';

  # screenshare
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
}
