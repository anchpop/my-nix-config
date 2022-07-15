{ pkgs, ... }: {
    home.packages = with pkgs;
    [   
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

        # Cli stuff
        # ========
        starship
        bat
        lsd
        ncdu
        ripgrep
        fd
        direnv
        nix-direnv
        tealdeer

        # Applications
        # ============
        obsidian
        element-desktop
        gocryptfs

        # Misc
        # ====
        nerdfonts
        ipfs
        pre-commit
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

        # git-branchless
        git = "git-branchless wrap --";

        # git aliases
        gsync = "git-branchless sync";
        gbinit = "git-branchless init";
        gs = "git-branchless wrap -- status";
        gp = "git-branchless wrap -- push";
        gpf = "git-branchless wrap -- push --force-with-lease";
        glog = "git sl";
        gamend = "git amend";
        greword = "git reword";
      };
    };
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    

    nixpkgs.config.allowUnfree = true;
  }
