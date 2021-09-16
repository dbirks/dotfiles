{ config, pkgs, options, ... }:

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
      bat
      binutils-unwrapped
      brave
      chromium
      cifs-utils
      cypress
      dbeaver
      ddrescue
      direnv
      dive
      docker-compose
      dmidecode
      eksctl
      element-desktop
      evolutionWithPlugins
      ffmpeg
      figlet
      file
      firefox
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
      gnome3.gnome-tweaks
      # gnome3.pomodoro
      gnome3.seahorse
      gnomeExtensions.appindicator
      # gnome40Extensions."material-shell@papyelgringo"
      gnumake
      gnupg
      go
      google-chrome
      goreleaser
      grafana-loki
      hey
      htop
      inetutils
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
      libreoffice-fresh
      lsof
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
      # nodejs-12_x
      nodejs-16_x
      nodePackages.node2nix
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
      pulseeffects-legacy
      pulumi-bin
      qutebrowser
      redis
      remmina
      shellcheck
      shfmt
      signal-desktop
      simplescreenrecorder
      slack
      spotify
      sshpass
      ssmsh
      starship
      stow
      syncthing
      teams
      terminal-parrot
      terraform_1_0
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
      yubioath-desktop
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
      displayManager.gdm.enable = true;
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
