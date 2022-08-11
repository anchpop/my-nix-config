{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Dev tools
    # =========
    vscode

    # Build systems
    # =============
    # Js
    nodejs
    yarn
    # haskell
    stack
    # other
    zld

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

    # Applications
    # ============
    obsidian
    element-desktop
    gocryptfs
    postman
    youtube-dl

    # Misc
    # ====
    nerdfonts
    ipfs
    pre-commit
    nixfmt
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
      gs = "git-branchless wrap -- status";
      gp = "git-branchless wrap -- push";
      gpf = "git-branchless wrap -- push --force-with-lease";
      # Git-branchless
      gsync = "git-branchless sync";
      gbinit = "git-branchless init";
      gsl = "git sl";
      gamend = "git-branchless amend";
      greword = "git-branchless reword";

      # Rust
      clippy =
        "cargo clippy --locked --all-features --tests --benches -- -D warnings -D clippy::all -D clippy::mem_forget -A clippy::redundant_closure -A clippy::too_many_arguments -C debug-assertions=off";
    };
    enableCompletion = true;
    enableAutosuggestions = true;
    # initExtra = 
    #"source \"$HOME/.cargo/env\"";
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
