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
    };
  };

  environment.systemPackages =
    let
      myPythonPackages = pythonPackages: with pythonPackages; [
        ansible
        boto3
        botocore
      ];

      vscode-with-extensions = pkgs.vscode-with-extensions.override {
        vscodeExtensions = with pkgs.vscode-extensions; [
          bbenoist.Nix
          esbenp.prettier-vscode
          foxundermoon.shell-format
          github.github-vscode-theme
          golang.Go
          hashicorp.terraform
          jnoortheen.nix-ide
          ms-vsliveshare.vsliveshare
          redhat.vscode-yaml
          vscodevim.vim
          yzhang.markdown-all-in-one
        ];
      };
    in
    with pkgs; [
      (python3.withPackages myPythonPackages)
      alacritty
      awscli2
      aws-iam-authenticator
      bat
      binutils-unwrapped
      brave
      chromium
      cifs-utils
      dbeaver
      ddrescue
      direnv
      dive
      docker-compose
      eksctl
      element-desktop
      evolutionWithPlugins
      ffmpeg
      figlet
      file
      firefox
      fluxcd
      fontforge
      fontforge-gtk
      fontforge-fonttools
      fzf
      gawk
      gettext
      ghostscript
      git
      gitAndTools.diff-so-fancy
      gitAndTools.gh
      gitAndTools.hub
      git-crypt
      git-lfs
      glances
      gnome3.gnome-tweaks
      gnome3.pomodoro
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
      meld
      mpv
      mtr
      ncdu
      neofetch
      nerdfonts
      nixpkgs-fmt
      nixpkgs-review
      nix-prefetch-git
      nodejs-12_x
      nmap
      obs-studio
      openconnect
      openjdk11
      openldap
      openssl
      pinta
      postgresql
      powershell
      pulseeffects-legacy
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
      starship
      stow
      syncthing
      teams
      teamviewer
      terminal-parrot
      terraform_0_15
      thunderbird
      tilt
      tmux
      uget
      unzip
      vagrant
      vim
      virt-manager
      vscode-with-extensions
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
