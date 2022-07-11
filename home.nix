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
      };
    };
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    

    nixpkgs.config.allowUnfree = true;
  }
