{ config, pkgs, ... }:

# let
#   unstablePinned = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/8e1eab9eae4278c9bb1dcae426848a581943db5a.tar.gz) {
#     config.allowUnfree = true;
#   };
#   nixpkgsUnstable = import <nixpkgs-unstable> { };
# in

let
  unstablePinnedForNeovim9 = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/9957cd48326fe8dbd52fdc50dd2502307f188b0d.tar.gz) {
    config.allowUnfree = true;
  };
  unstablePinnedForNewerUvVersion5 = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/f212b495d309f522024f065d79189be3e131c403.tar.gz) {};
in

# let
#   packageOverrides = pkgs: rec {
#     weechat = pkgs.weechat.override { extraBuildInputs = [ pkgs.weechatScripts.wee-slack pkgs.python311Packages.websocket-client ]; };
#   };
# in

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "david";
  home.homeDirectory = "/home/david";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    # gnome3 apps
    # gnome3.eog    # image viewer
    # gnome3.evince # pdf reader

    # desktop look & feel
    #gnome3.gnome-tweaks

    # extensions
    #gnomeExtensions.material-shell

    nodePackages.json-diff
    google-cloud-sdk
    dbeaver-bin
    chart-testing
    #haskellPackages.nixpkgs-update
    #? pythonPackages.huggingface-cli

    ipcalc
    #sipcalc
    imagemagick
    tflint
    vlc
    trivy
    transmission_4-gtk
    drone-cli
    jc
    #youtube-dl
    yt-dlp
    cargo
    chart-testing
    tree
    #hadolint
    direnv
    #magic-wormhole
    promtail
    tcptraceroute
    #obsidian
    bind
    heroku
    awslogs
    #k3s
    pluto
    tcpdump
    stern
    k6
    #dotnet-sdk_7
    #dotnet-sdk_6
    #libsForQt5.dolphin
    #xfce.thunar
    azure-cli
    eksctl
    samba
    gron
    firefox
    grpcurl
    #nixpkgsUnstable.awscli2
    #awscli2
    unstablePinnedForNewerUvVersion5.awscli2
    dive
    fluxcd
    htop
    kubectl
    kubectx
    kubernetes-helm
    buildah
    okteto
    tmate
    dash
    #jdk19_headless
    jdk17_headless
    #jdk8_headless
    ssm-session-manager-plugin
    #ansible-lint
    #lens
    #openlens
    pluto
    kubent
    #teams
    aws-iam-authenticator
    act
    #unstablePinned.nodejs-16_x
    nodejs_20
    #nodejs-slim-12_x
    #unstablePinned.nodePackages.npm
    go
    google-chrome
    chromium
    google-cloud-sdk
    goreleaser
    slack
    zoom-us
    yq-go
    pwgen
    powershell
    kitty
    mitmproxy
    patchelf
    nodePackages.zx
    wishlist
    virtualenv
    #python310Packages.virtualenvwrapper
    #python311Packages.virtualenvwrapper
    ttyd
    rufo
    poetry
    signal-desktop
    kubeshark
    linkerd
    #jetbrains.idea-community
    mullvad
    poetry
    #libstdcxx5
    #python39Packages.numpy
    skopeo
    nodePackages.pnpm
    kubie
    unstablePinnedForNeovim9.neovim
    dos2unix
    ollama
    mkcert
    insomnia
    weechat
    weechatScripts.wee-slack
    terminus_font
    #terminus-nerdfont
    #nerdfonts
    tmux
    thunderbird
    shfmt
    shellcheck
    postman
    metasploit
    kind
    krew
    k9s
    jq
    hey
    git
    git-lfs
    fzf
    flameshot
    chamber
    checkbashisms
    nix-update
    #globalprotect-openconnect
    gpclient
    openconnect
    obs-studio
    nmap
    zsh
    nix-prefetch-git
    nixpkgs-review
    nixpkgs-fmt
    newman
    wget
    fio
    #dbt
    playwright-driver.browsers
    #chatgpt-cli
    #chatblade
    diffuse
    #anytype
    kdiff3
    meld
    #tor-browser
    gthumb
    libsForQt5.kdenlive
    #archivebox
    gp-saml-gui
    debootstrap
    #jetbrains.pycharm-professional
    cw
    terraform
    helvum
    carla
    lynx
    ipmitool
    pspg
    at
    aichat
    cilium-cli
    difftastic
    swaks
    talosctl
    liquibase
    postgresql_16
    #cudatoolkit
    pciutils # lspci
    #nvidia-container-toolkit
    lshw
    go-task
    jira-cli-go
    #_1password-gui
    #_1password-cli
    #super-slicer
    #orca-slicer
    #icesl
    prusa-slicer
    ranger
    pywal
    eza
    conda
    azuredatastudio
    s5cmd
    lsix
    hadolint
    ventoy-full
    apache-directory-studio
    #microsoft-edge
    grafana-agent
    rye
    age
    gh
    #minicom
    #cura
    #super-slicer-latest
    zoxide
    speechd
    zellij
    android-tools
    lnav
    vsce
    #dog
    doggo
    unstablePinnedForNewerUvVersion5.uv
    #cidr
    websocat
    intel-gpu-tools
    #llama-cpp
    maple-mono
    #wofi
    #playerctl
    #rofi-wayland
    #waybar
    ##hyprpanel
    #hyprlock
    #hypridle
    #aws-sam-cli
    nh
    code-cursor
    zed-editor
    ptyxis
    devbox
    deno
    #bruno
    lazydocker
    dry
    docui
    nerdctl
    #diffoci
    oxker
    distrobox
    wpsoffice
    onlyoffice-desktopeditors
    ffmpeg
    jellyfin-media-player
    jellycli
    jftui
    ghostty


  ];

  fonts.fontconfig.enable = true;

  programs = {
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
    vscode.enable = true;
    #zsh.enable = true;
  };

  # environment.sessionVariables = {
  #   DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
  # };

  services = {
    # spotifyd = {
    #   enable = true;
    # };
    # mullvad-vpn = {
    #   enable = true;
    # };
  };

  nixpkgs.config.allowUnfree = true;
}
