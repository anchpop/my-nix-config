{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    # Dev tools
    # =========
    vscode

    # Build systems
    # =============
    # Rust
    rustup
    # Js
    nodejs
    yarn
    # other
    zld
    llvm
    bazel-buildtools
    bazelisk

    # Cli stuff
    # ========
    zsh-completions
    zsh-autocomplete
    starship
    bat
    lsd
    ncdu
    ripgrep
    fd
    direnv
    nix-direnv
    tealdeer
    asciinema
    broot

    # Applications
    # ============
    obsidian
    element-desktop
    gocryptfs
    postman
    youtube-dl
    ffmpeg

    # Misc
    # ====
    ipfs
    pre-commit
    nixfmt
    openssl
    pkg-config
  ];
  programs.starship = {
    enable = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };
  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "lsd";
      cat = "bat";
      refresh = "darwin-rebuild switch";

      # Git aliases
      # Standard git
      gstat = "git-branchless wrap -- status";
      gp = "git-branchless wrap -- push";
      gpf = "git-branchless wrap -- push --force-with-lease";
      # Git-branchless
      gsync = "git-branchless sync";
      gbinit = "git-branchless init";
      gsl = "git sl";
      gamend = "git-branchless amend -m";
      greword = "git-branchless reword";
      gs = "git-branchless wrap -- switch";
      gdp = "git difftool HEAD~1";

      # Rust
      clippy =
        "cargo clippy --locked --all-features --tests --benches -- -D warnings -D clippy::all -D clippy::mem_forget -A clippy::redundant_closure -A clippy::too_many_arguments -C debug-assertions=off";
    };
    enableCompletion = true;
    enableAutosuggestions = true;
    initExtra = ''
      source /Users/andrepopovitch/.ghcup/env
      export PATH=$HOME/.cargo/bin:/opt/homebrew/bin:$PATH
      export OPENSSL_DIR=${pkgs.openssl.dev}
    '';
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
