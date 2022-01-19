{ config, pkgs, options, ... }:

let
  unstablePinned = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/8e1eab9eae4278c9bb1dcae426848a581943db5a.tar.gz) {
    config.allowUnfree = true;
  };
in

{
  imports = [
    <nixos-hardware/dell/xps/13-9310>
    ./hardware-configuration.nix
    ./secret.nix
  ];

  boot = {
    # kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_testing;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
    kernel.sysctl = {
      # https://github.com/NixOS/nixpkgs/issues/36214
      "max_user_instances" = 8192;

      # https://stackoverflow.com/a/41453306/7733616
      "net.ipv4.ip_forward" = 1;
    };
  };

  environment.systemPackages =
    let
      myPythonPackages = pythonPackages: with pythonPackages; [
        ansible
        boto3
        botocore
      ];

      # vscode-with-extensions = pkgs.vscode-with-extensions.override {
      #   vscodeExtensions = with pkgs.vscode-extensions; [
      #     bbenoist.nix
      #     dbaeumer.vscode-eslint
      #     esbenp.prettier-vscode
      #     foxundermoon.shell-format
      #     github.github-vscode-theme
      #     github.vscode-pull-request-github
      #     golang.go
      #     hashicorp.terraform
      #     iciclesoft.workspacesort
      #     jnoortheen.nix-ide
      #     ms-python.python
      #     ms-vsliveshare.vsliveshare
      #     redhat.vscode-yaml
      #     stephlin.vscode-tmux-keybinding
      #     vscodevim.vim
      #     yzhang.markdown-all-in-one
      #   ];
      # };
    in
    with pkgs; [
      (python3.withPackages myPythonPackages)
      act
      alacritty
      awscli2
      awslogs
      aws-iam-authenticator
      #aws-sam-cli
      bat
      binutils-unwrapped
      brave
      chamber
      chromium
      cifs-utils
      conda
      cypress
      dbeaver
      ddrescue
      deja-dup
      direnv
      dive
      docker-compose
      dmidecode
      eksctl
      element-desktop
      etcher
      evolutionWithPlugins
      ffmpeg
      figlet
      file
      firefox-bin
      flameshot
      fluxcd
      fontforge
      fontforge-gtk
      fontforge-fonttools
      fzf
      gawk
      gettext
      gcc
      ghostscript
      git
      gitAndTools.diff-so-fancy
      gitAndTools.gh
      gitAndTools.hub
      git-crypt
      git-lfs
      glances
      glib # for glib-compile-schemas
      gnome3.gpaste
      gnome3.gnome-tweaks
      # gnome3.pomodoro
      gnome3.seahorse
      gnomeExtensions.appindicator
      gnomeExtensions.material-shell
      gnumake
      gnupg
      go
      google-chrome
      goreleaser
      gradle
      grafana-loki
      hey
      htop
      inetutils
      insomnia
      jq
      k9s
      keybase-gui
      kind
      krb5
      krew
      krita
      kubectl
      kubectx
      kubernetes-helm
      ldns
      lens
      libimobiledevice
      libreoffice
      lsof
      magic-wormhole
      maven
      meld
      microplane
      moreutils
      mpv
      mtr
      ncdu
      neofetch
      nerdfonts
      nixpkgs-fmt
      nixpkgs-review
      nix-prefetch-git
      nix-update
      unstablePinned.nodejs-16_x
      # nodejs-slim-12_x
      # unstablePinned.nodePackages.npm
      nmap
      obs-studio
      obsidian
      openconnect
      openjdk11
      openldap
      openssl
      pgbadger
      pinta
      postgresql
      postman
      # pulseeffects-legacy
      #pulumi-bin
      qutebrowser
      redis
      remmina
      rpi-imager
      shellcheck
      shfmt
      signal-desktop
      silver-searcher
      simplescreenrecorder
      slack
      spotify
      sshpass
      ssmsh
      starship
      stow
      superTux
      superTuxKart
      syncthing
      teams
      terminal-parrot
      terraform_1
      thunderbird
      tilt
      tmux
      uget
      unzip
      vagrant
      vim
      virt-manager
      # vscode-with-extensions
      vscode-fhs
      wireshark
      yarn
      youtube-dl
      yq-go
      zip
      zoom-us
    ];

  fonts.fonts = with pkgs; [
    fantasque-sans-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro
    terminus_font
  ];

  hardware = {
    pulseaudio.enable = true;
    sensor.iio.enable = true;
  };

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
    ];
  };

  networking = {
    extraHosts = ''
      127.0.0.1 placeholder.com
    '';
    firewall = {
      allowedTCPPorts = [ 80 ];
      allowPing = false;
      enable = true;
    };
    interfaces.eth0.useDHCP = true;
    interfaces.wlan0.useDHCP = true;
    hostName = "sandpiper";
    networkmanager.enable = true;
    useDHCP = false;
    usePredictableInterfaceNames = true;
  };

  nix = {
    autoOptimiseStore = true;

    extraOptions = ''
      experimental-features = nix-command
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    package = pkgs.nixUnstable; # needed until nix 2.4 is released
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  powerManagement.powertop.enable = true;

  programs = {
    dconf.enable = true;

    evolution = {
      enable = true;
      plugins = with pkgs; [
        evolution-ews
      ];
    };

    geary.enable = false;

    gnupg.agent = {
      enable = true;
      #enableSSHSupport = true;
      pinentryFlavor = "gnome3";
    };

    nm-applet.enable = true;

    seahorse.enable = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };

    fwupd.enable = true;

    gnome = {
      core-os-services.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
      evolution-data-server.enable = true;
      gnome-keyring.enable = true;
    };

    pcscd.enable = true; # for yubikey

    # Fixes the error:
    #   Failed assertions:
    #   - You have set services.power-profiles-daemon.enable = true;
    #   which conflicts with services.tlp.enable = true;
    power-profiles-daemon.enable = false;

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        hplip
      ];
    };

    syncthing = {
      enable = true;
      user = "david";
      configDir = "/home/david/.config/syncthing";
    };

    udev.packages = with pkgs; [
      yubikey-personalization
    ];

    usbmuxd.enable = true; # for connecting to iOS

    xserver = {
      enable = true;
      libinput.enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = false;
      };
      desktopManager.gnome.enable = true;
    };
  };

  security = {
    apparmor.enable = true;
    pam.services.gdm.enableGnomeKeyring = true;
  };

  sound.enable = true;

  system.stateVersion = "20.09";

  time.timeZone = "America/New_York";

  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" ];
  };

  virtualisation = {
    docker.enable = true;
    libvirtd = {
      allowedBridges = [
        "virbr0"
      ];
      enable = true;
    };
    podman.enable = true;
  };
}
