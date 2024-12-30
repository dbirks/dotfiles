{ config, pkgs, options, ... }:

#let
#  unstablePinned = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/8e1eab9eae4278c9bb1dcae426848a581943db5a.tar.gz) {
#    config.allowUnfree = true;
#  };
#in

{
  imports = [
    #<nixos-hardware/dell/xps/13-9310>
    #<nixos-hardware/dell/xps/15-9570/nvidia>
    #<nixos-hardware/framework/13-inch/13th-gen-intel>
    #<nixos-hardware-dbirks/framework/13-inch/intel-core-ultra-series1>
    #"${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; rev = "b2db7996458d18f9357a6fef832698383c7cb3ff"; }}/framework/13-inch/intel-core-ultra-series1"
    #"${builtins.fetchGit { url = "https://github.com/dbirks/nixos-hardware.git"; rev = "b2db7996458d18f9357a6fef832698383c7cb3ff"; }}/framework/13-inch/intel-core-ultra-series1"
    #"${builtins.fetchGit { url = "https://github.com/dbirks/nixos-hardware.git"; rev = "d946a2566916e25ff03cc9d94e315850879ad9b9"; }}/framework/13-inch/intel-core-ultra-series1"
    <nixos-hardware/framework/13-inch/intel-core-ultra-series1>
    # <home-manager/nixos>
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
    tmp = {
      useTmpfs = true;
      tmpfsSize = "80%";
      cleanOnBoot = true;
    };
  };

  environment.systemPackages =
    let
      # myPythonPackages = pythonPackages: with pythonPackages; [
      #   # ansible
      #   # ansible-core
      #   # boto3
      #   # botocore
      #   # conda
      #   # huggingface-hub
      #   pip
      # ];

      # vscode-fhsWithPackages = pkgs.vscode-fhs (pkgs: with pkgs; [ zlib vim ])

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
      # ansible
      # python310Packages.boto3
      # python310Packages.botocore

      #(python3.withPackages myPythonPackages)
      python3
      #nix-update
      # #unstablePinned.nodejs-16_x
      # nodejs-18_x
      # #nodejs-slim-12_x
      # unstablePinned.nodePackages.npm
      #act
      alacritty
      argocd
      audacity
      #awscli2
      # awslogs
      #aws-iam-authenticator
      #aws-sam-cli
      bat
      # binutils-unwrapped
      buildpack
      #chamber
      #checkbashisms
      #chromium
      cifs-utils
      conda
      csvkit
      cypress
      #dbeaver
      ddrescue
      #deja-dup
      delta
      #dive
      docker-buildx
      docker-compose
      dmidecode
      #element-desktop
      #etcher
      #evolutionWithPlugins
      ffmpeg
      figlet
      file
      #firefox-esr
      #flameshot
      #fluxcd
      fontforge
      fontforge-gtk
      fontforge-fonttools
      #fzf
      gawk
      gettext
      gcc
      ghostscript
      #git
      gitAndTools.diff-so-fancy
      #gitAndTools.gh
      gitAndTools.hub
      git-crypt
      #git-lfs
      glances
      glib # for glib-compile-schemas
      #gnome3.gpaste
      gnome-tweaks
      seahorse
      networkmanager-l2tp
      gnomeExtensions.appindicator
      #gnomeExtensions.appindicator
      #gnomeExtensions.material-shell
      gnome-network-displays
      gnumake
      gnupg
      gradle
      #grafana-loki
      #hey
      #htop
      inetutils
      #insomnia
      inotify-tools
      #jq
      #k9s
      kazam
      #keybase-gui
      #kind
      krb5
      #krew
      krita
      #kubectl
      #kubectx
      #kubernetes-helm
      ldns
      #lens
      libimobiledevice
      #libreoffice
      losslesscut-bin
      lsof
      # magic-wormhole
      maven
      meld
      #metasploit
      #microplane
      miraclecast
      moreutils
      mpv
      mtr
      ncdu
      neofetch
      #neovim
      #newman
      nfs-utils
      #nerdfonts
      net-snmp
      #nixpkgs-fmt
      #nixpkgs-review
      #nix-prefetch-git
      #zsh
      bash
      nmap
      obs-studio
      #octant
      #octant-desktop
      #obsidian
      openconnect
      #globalprotect-openconnect
      #openjdk8
      #openjdk17
      openldap
      openssl
      # perl534Packages.Appperlbrew
      # perl534Packages.Carton
      # perl534Packages.libxml_perl
      # perl534Packages.AlienLibxml2
      # perl534Packages.libxml_perl
      # libxml2
      #pgadmin4
      pgbadger
      pinta
      postgresql
      #postman
      #python310Packages.howdoi
      # pulseeffects-legacy
      #pulumi-bin
      #qutebrowser
      redis
      #redis-desktop-manager
      remmina
      rpi-imager
      #shellcheck
      #shfmt
      #signal-desktop
      silver-searcher
      simplescreenrecorder
      #spotify
      sshpass
      ssmsh
      starship
      stow
      superTux
      superTuxKart
      #syncthing
      #teams
      terminal-parrot
      #terraform_1
      #thunderbird
      tilt
      #tmux
      uget
      unzip
      #vagrant
      vim
      virt-manager
      # vscode-with-extensions
      # vscode-fhs
      # vscode-fhsWithPackages (pkgs: with pkgs; [ zlib vim ])
      # vscode-fhsWithPackages
      wireshark
      xclip
      yarn
      #youtube-dl
      zip
      #terraformer
      #_1password
      #ngrok
      #pspg
      #lastpass-cli
      #okular
      #notion-app-enhanced
      #trivy
      #uucp
      #cutecom
      #minicom
      #kubeshark
      fio

      # vscode

      libsForQt5.bismuth

      # (pkgs.lens.overrideAttrs (oldAttrs: {
      #   src = pkgs.fetchurl {
      #     url = "https://github.com/MuhammedKalkan/OpenLens/releases/download/v6.1.1/OpenLens-6.1.1.AppImage";
      #     sha256 = "sha256-hIYmoO44pdpqqUkkmvB/ar92AnWsnVdpzQaSfO7j3Hk=";
      #   };
      # }))
    ];

  # https://discourse.nixos.org/t/a-fast-way-for-modifying-etc-hosts-using-networking-extrahosts/4190/3
  environment.etc.hosts.mode = "0644";

  fonts = {
    packages = with pkgs; [
      courier-prime
      fantasque-sans-mono
      material-design-icons
      meslo-lg
      #nerdfonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      source-code-pro
      terminus_font
      nerd-fonts.comic-shanns-mono
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.terminess-ttf
      nerd-fonts.hack
      nerd-fonts.go-mono
      nerd-fonts.overpass
      nerd-fonts.gohufont
      nerd-fonts._0xproto
      nerd-fonts.anonymice
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu-sans
      nerd-fonts.commit-mono
    ];
    enableDefaultPackages = true;
    fontconfig.useEmbeddedBitmaps = true;
  };

  hardware = {
    pulseaudio = {
      enable = false;
      # extraConfig = ''
      #   load-module module-echo-cancel
      # '';
    };
    sane.enable = true;
    sensor.iio.enable = true;
  };

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
    ];
  };

  networking = {
    # extraHosts = ''
    #   127.0.0.1 placeholder.com
    # '';
    firewall = {
      #allowedTCPPorts = [ 80 5173 5432 8082 8080 ];
      allowedTCPPorts = [ 5434 8096 3000 8080 8443 3478 10001 5173 8000 ];
      allowPing = false;
      enable = true;
    };
    #interfaces.eth0.useDHCP = true;
    interfaces.wlan0.useDHCP = true;
    hostName = "sandpiper";
    networkmanager.enable = true;
    # wireless = {
    #   enable = true;
    # };
    useDHCP = false;
    usePredictableInterfaceNames = true;
    wireguard.enable = true;
  };

  nix = {
    extraOptions = ''
      experimental-features = nix-command
    '';

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    #package = pkgs.nixUnstable; # needed until nix 2.4 is released

    settings = {
      auto-optimise-store = true;
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://ploop.cachix.org"
        "https://numtide.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "ploop.cachix.org-1:i6+Fqarsbf5swqH09RXOEDvxy7Wm7vbiIXu4A9HCg1g="
        "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      ];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    # overlays = [
    #   (self: super:
    #     {
    #       lens = super.lens.overrideAttrs (old: {
    #         src = pkgs.fetchurl {
    #           url = "https://github.com/MuhammedKalkan/OpenLens/releases/download/v6.1.1/OpenLens-6.1.1.AppImage";
    #           sha256 = "sha256-u3pOiacEOPe0O0ucO+l6EEYy+T/9uyDdsQMR/OvsRQ8=";
    #         };
    #       });
    #     }
    #   )
    # ];
  };

  #powerManagement.powertop.enable = true;

  programs = {
    dconf.enable = true;

    evolution = {
      enable = true;
      plugins = with pkgs; [
        evolution-ews
      ];
    };

    # geary.enable = false;

    gnupg.agent = {
      enable = true;
      #enableSSHSupport = true;
      #pinentryFlavor = "gnome3";
    };

    hyprland.enable = true;

    java.enable = true;

    nm-applet.enable = true;

    # noisetorch.enable = true;

    #openvpn3.enable = true;

    seahorse.enable = true;

    #steam.enable = true;
    steam.enable = false;

    # vscode.package = pkgs.vscode-fhsWithPackages (ps: with ps; [ vim ]);

    zsh.enable = true;
  };

  services = {
    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    flatpak.enable = true;

    fwupd = {
      enable = true;
      extraRemotes = [ "lvfs-testing" ];
    };

    # globalprotect = {
    #   enable = true;
    #   # csdWrapper = "${pkgs.openconnect}/libexec/openconnect/hipreport.sh";
    # };

    gnome = {
      core-os-services.enable = true;
      core-shell.enable = true;
      core-utilities.enable = true;
      evolution-data-server.enable = true;
      gnome-keyring.enable = true;
      games.enable = false;
      sushi.enable = true;
    };

    libinput.enable = true;

    llama-cpp = {
      enable = false;
      model = "/home/david/Downloads/llama3.1";
    };

    jellyfin.enable = true;

    #mullvad-vpn.enable = true;

    ollama = {
      enable = true;
      environmentVariables = {
        OLLAMA_INTEL_GPU = "1";
      };
    };

    netdata.enable = true;

    pcscd.enable = true; # for yubikey

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
    };

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

    # https://github.com/NixOS/nixpkgs/issues/64965#issuecomment-741920446
    strongswan = {
      enable = true;
      secrets = [
        "ipsec.d/ipsec.nm-l2tp.secrets"
      ];
    };

    syncthing = {
      enable = true;
      user = "david";
      configDir = "/home/david/.config/syncthing";
      dataDir = "/home/david/.config/syncthing/db";
    };

    tailscale.enable = true;

    teamviewer = {
      enable = false;
      # enable = true;
    };

    dbus.packages = [ pkgs.dconf ];

    udev.packages = with pkgs; [
      #gnome-settings-daemon
      yubikey-personalization
    ];

    unifi = {
      enable = true;
      openFirewall = true;
      unifiPackage = pkgs.unifi8;
      mongodbPackage = pkgs.mongodb-7_0;
    };

    usbmuxd.enable = true; # for connecting to iOS

    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      desktopManager = {
        gnome.enable = true;
        # plasma5.enable = true;
      };
      #videoDrivers = [ "displaylink" "modesetting" ];
      videoDrivers = [ "modesetting" ];
    };
  };

  security = {
    apparmor.enable = true;
    pam.services.gdm.enableGnomeKeyring = true;
    pki.certificateFiles = [ /home/david/mitmproxy-ca-cert.pem ];
  };

  # services.pipewire.wireplumber.enable = true;
  # sound.enable = true;

  system.stateVersion = "24.11";

  time.timeZone = "America/New_York";

  users.users.david = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "audio" "dialout" "scanner" "lp" ];
    shell = pkgs.zsh;
  };
  # home-manager = {
  #   useGlobalPkgs = true;
  #   # useUserPackages = true;
  #   users.david = { pkgs, ... }: {
  #     nixpkgs.config.allowUnfree = true;
  #     home = {
  #       username = "david";
  #       homeDirectory = "/home/david";
  #       packages = with pkgs; [
  #       ];
  #     };
  #     programs = {
  #       # bash.enable = true;
  #       # zsh.enable = true;
  #       # gtk.enable = true;
  #       vscode.enable = true;
  #     };
  #   };
  # };

  virtualisation = {
    docker = {
      enable = true;
      daemon.settings = {
        default-address-pools = [
          {
            base = "172.100.0.0/16";
            size = 24;
          }
        ];
      };
    };
    libvirtd = {
      allowedBridges = [
        "virbr0"
      ];
      enable = true;
    };
    podman = {
      enable = true;
    };
  };

  # wayland.windowManager.hyprland.enable = true;
}
