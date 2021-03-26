{ config, pkgs, options, ... }:

{
  imports = [
    <nixos-hardware/dell/xps/13-9310>
    ./hardware-configuration.nix
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
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    ansible_2_8
    awscli2
    aws-iam-authenticator
    bat
    binutils-unwrapped
    brave
    chromium
    dbeaver
    ddrescue
    dive
    docker-compose
    eksctl
    element-desktop
    evolutionWithPlugins
    ffmpeg
    figlet
    file
    firefox-beta-bin
    fluxcd
    fzf
    gawk
    gettext
    ghostscript
    git
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gitAndTools.hub
    git-lfs
    glances
    gnome3.gnome-tweaks
    gnome3.seahorse
    gnomeExtensions.appindicator
    gnomeExtensions.material-shell
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
    meld
    mpv
    mtr
    ncdu
    neofetch
    nixpkgs-fmt
    nixpkgs-review
    nix-prefetch-git
    nodejs-12_x
    nmap
    openconnect
    openjdk11
    openldap
    openssl
    pinta
    postgresql
    powershell
    pulseeffects-legacy
    python2
    python3
    pythonPackages.boto3
    pythonPackages.botocore
    qutebrowser
    redis
    shellcheck
    shfmt
    signal-desktop
    simplescreenrecorder
    slack
    spotify
    sshpass
    ssmsh
    stow
    syncthing
    teams
    teamviewer
    terminal-parrot
    terraform_0_14
    thunderbird
    tilt
    tmux
    uget
    unzip
    vagrant
    vim
    virt-manager
    vscode
    wireshark
    yarn
    youtube-dl
    yq-go
    yubioath-desktop
    zoom-us
  ];

  fonts.fonts = with pkgs; [
    fantasque-sans-mono
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    # google-fonts
    recursive
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
    # interfaces.enp0s13f0u1u2.useDHCP = true;
    interfaces.eth0.useDHCP = true;
    # interfaces.wlp59s0.useDHCP = true;
    interfaces.wlan0.useDHCP = true;
    hostName = "sandpiper";
    networkmanager.enable = true;
    useDHCP = false;
    usePredictableInterfaceNames = true;
  };

  nixpkgs.config = {
    allowUnfree = true;

    # packageOverrides = pkgs: rec {
    #   dbeaver = pkgs.dbeaver.overrideAttrs
    #     (attrs: { patches = [ ./patches/dbeaver.patch ]; });
    # };
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

    seahorse.enable = true;

    gnupg.agent = {
      enable = true;
      #enableSSHSupport = true;
      pinentryFlavor = "gnome3";
    };

    nm-applet.enable = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns = true;
    };

    fwupd.enable = true;

    gnome3 = {
      core-os-services.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
      evolution-data-server.enable = true;
      gnome-keyring.enable = true;
    };

    pcscd.enable = true; # for yubikey

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

    teamviewer.enable = true;

    udev.packages = with pkgs; [
      yubikey-personalization
    ];

    usbmuxd.enable = true; # for connecting to iOS

    xserver = {
      enable = true;
      libinput.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome3.enable = true;
    };
  };

  security.pam.services.gdm.enableGnomeKeyring = true;

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
