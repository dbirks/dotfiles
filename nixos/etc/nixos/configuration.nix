{ config, pkgs, options, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    # kernelPackages = pkgs.linuxPackages_testing;
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    ansible_2_8
    awscli2
    aws-iam-authenticator
    binutils-unwrapped
    brave
    chromium
    croc
    dbeaver
    ddrescue
    dep2nix
    dive
    docker-compose
    eksctl
    element-desktop
    etcdctl
    ffmpeg
    figlet
    file
    firefox-bin
    fzf
    ghostscript
    git
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gitAndTools.hub
    git-lfs
    glances
    gnome3.gnome-tweaks
    gnomeExtensions.appindicator
    gnomeExtensions.material-shell
    gnumake
    gnupg
    go
    go-bindata
    google-chrome
    grafana-loki
    htop
    inetutils
    jq
    kind
    krb5
    krita
    kubectl
    kubectx
    kubernetes-helm
    ldns
    lens
    libreoffice-fresh
    mpv
    mtr
    ncdu
    neofetch
    nixpkgs-fmt
    nixpkgs-review
    nix-prefetch-git
    nodejs-12_x
    openconnect
    openjdk11
    openssl
    pinta
    postgresql
    powershell
    pulumi-bin
    python2
    python3
    pythonPackages.boto3
    pythonPackages.botocore
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
    tektoncd-cli
    terminal-parrot
    terraform_0_13
    thunderbird
    tilt
    trivy
    tmux
    uget
    vim
    virt-manager
    vscode
    youtube-dl
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

  hardware.pulseaudio.enable = true;

  networking = {
    interfaces.enp0s13f0u1u2.useDHCP = true;
    # interfaces.wlp59s0.useDHCP = true;
    hostName = "sandpiper";
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    useDHCP = false;
  };

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: rec {
      dbeaver = pkgs.dbeaver.overrideAttrs
        (attrs: { patches = [ ./patches/dbeaver.patch ]; });
    };
  };

  powerManagement.powertop.enable = true;

  programs.gnupg.agent = {
    enable = true;
    #enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  services = {
    avahi.enable = true;
    fwupd.enable = true;
    gnome3 = {
      core-os-services.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
    };
    pcscd.enable = true; # for yubikey
    printing = {
      enable = true;
      drivers = with pkgs; [ gutenprint hplip ];
    };
    syncthing = {
      enable = true;
      user = "david";
      #dataDir = "/home/david/syncthing";
      configDir = "/home/david/.config/syncthing";
    };
    udev.packages = with pkgs; [ yubikey-personalization ];
    xserver = {
      enable = true;
      libinput.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome3.enable = true;
    };
  };

  sound.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

  time.timeZone = "America/New_York";

  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" ];
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
}
