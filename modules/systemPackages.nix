{ config, pkgs, lib, ... }: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Dedit
    vim
    neovim
    emacs
    zeal

    # System
    wget
    ibus
    fcitx
    docker
    lsd
    glances
    duf
    p7zip
    unrar
    inetutils
    dpkg
    silver-searcher
    tig
    tmux
    starship
    fish
    z-lua
    bat
    tree
    ncdu
    ripgrep
    synergy
    remmina
    borgbackup
    jq

    # Work
    vscode-latest
    google-chrome
    git
    freeoffice
    awscli2
    gftp
    dbeaver
    clickhouse-cli
    graphviz
    mailspring
    nixfmt
    sqlitebrowser
    nixopsUnstable
    flameshot
    # nixops

    # VPN
    nettools

    # Python
    python3
    (python39.withPackages (ps:
      with ps; [
        jupyter
        jupyter_core
        notebook
        ipython
        ipykernel
        pandas
        numpy
        systemd
        click
        jinja2
        clickhouse-driver
        flask
        autopep8
        pip
        pyyaml
        boto
        boto3
        pytz
        websockets
        black
        beancount
        redis
      ]))

    # C++
    gcc
    gdb
    clang_11
    nodejs
    lua
    cmake
    doxygen
    doxygen_gui

  ];
}
