# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, options, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    #<nixos-hardware/dell/xps/15-9560/intel>
    ./hardware-configuration.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;

    packageOverrides = pkgs: rec {
      dbeaver = pkgs.dbeaver.overrideAttrs
        (attrs: { patches = [ ./patches/dbeaver.patch ]; });
    };
  };

  # nixpkgs.overlays = import /etc/nixos/overlays-compat;

  # nix.nixPath =
  #   options.nix.nixPath.default ++ 
  #   [ "nixpkgs-overlays=/etc/nixos/overlays-compat/" ]
  # ;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackages_testing;

  networking.hostName = "sandpiper"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s13f0u1u2.useDHCP = true;
  #networking.interfaces.wlp59s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    alacritty
    firefox-bin
    vscode
    tmux
    slack
    teams
    #gnome3.gnome-shell
    gnome3.gnome-tweaks
    gnomeExtensions.material-shell
    gnomeExtensions.appindicator
    eksctl
    terraform_0_13
    git
    zoom-us
    google-chrome
    chromium
    ldns
    spotify
    nixfmt
    nixpkgs-fmt
    openconnect
    gnupg
    stow
    gitAndTools.diff-so-fancy
    gitAndTools.gh
    gitAndTools.hub
    gnumake
    aws-iam-authenticator
    awscli2
    syncthing
    youtube-dl
    thunderbird
    file
    kind
    #lens
    nodejs-12_x
    kubectl
    tilt
    kubernetes-helm
    kubectx
    fzf
    signal-desktop
    nixpkgs-review
    #python2
    krb5
    dbeaver
    postgresql
    htop
    glances
    docker-compose
    ddrescue
    nix-prefetch-git
    jq
    ansible
    pythonPackages.boto3
    pythonPackages.botocore
    #goPackages.go
    openssl
    go
    #android-studio
    grafana-loki
    krita
    pinta
    go-bindata
    binutils-unwrapped
    openjdk11
    neofetch
    powershell
    virt-manager
    kpt
    element-desktop
    dive
    python3
    figlet
    ssmsh
    mpv
    ncdu
    uget
    inetutils
    etcdctl
    libreoffice-fresh
    terragrunt
  ];

  nixpkgs.config.permittedInsecurePackages = [ "python2.7-cryptography-2.9.2" ];

  fonts.fonts = with pkgs; [
    fantasque-sans-mono
    terminus_font
    source-code-pro
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    #enableSSHSupport = true;
    pinentryFlavor = "gnome3";
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  virtualisation.docker.enable = true;

  virtualisation.libvirtd.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ gutenprint hplip ];

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;

  # Enable the GNOME 3 Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  services = {
    gnome3 = {
      core-os-services.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
    };
    syncthing = {
      enable = true;
      user = "david";
      #dataDir = "/home/david/syncthing";
      configDir = "/home/david/.config/syncthing";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" ];
  };

  powerManagement.powertop.enable = true;

  services.fwupd.enable = true;

  services.avahi.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
