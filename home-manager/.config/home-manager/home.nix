{ config, pkgs, ... }:

# let
#   unstablePinned = import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/8e1eab9eae4278c9bb1dcae426848a581943db5a.tar.gz) {
#     config.allowUnfree = true;
#   };
#   nixpkgsUnstable = import <nixpkgs-unstable> { };
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
    dbeaver
    chart-testing
    #haskellPackages.nixpkgs-update
    #? pythonPackages.huggingface-cli

    ipcalc
    sipcalc
    imagemagick
    tflint
    vlc
    trivy
    transmission-gtk
    drone-cli
    jc
    #youtube-dl
    yt-dlp
    cargo
    chart-testing
    tree
    hadolint
    direnv
    magic-wormhole
    promtail
    tcptraceroute
    obsidian
    bind
    heroku
    awslogs
    k3s
    pluto
    tcpdump
    stern
    k6
    hadolint
    #dotnet-sdk_7
    dotnet-sdk_6
    libsForQt5.dolphin
    xfce.thunar
    azure-cli
    eksctl
    samba
    gron
    firefox
    grpcurl
    #nixpkgsUnstable.awscli2
    awscli2
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
    ansible-lint
    azuredatastudio
    lens
    pluto
    kubent
    teams
    aws-iam-authenticator
    act
    #unstablePinned.nodejs-16_x
    nodejs-18_x
    #nodejs-slim-12_x
    #unstablePinned.nodePackages.npm
    go_1_20
    google-chrome
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
    python310Packages.virtualenvwrapper
    ttyd
    rufo
    poetry
    signal-desktop
    kubeshark
    linkerd

  ];

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;
    vscode.enable = true;
    #zsh.enable = true;
  };

  # environment.sessionVariables = {
  #   DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
  # };

  services = {
    spotifyd = {
      enable = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
