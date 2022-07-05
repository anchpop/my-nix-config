{ pkgs, ... }: {
    home.packages = with pkgs;
    [   
        # Dev tools
        # =========
        vscode

        # Build systems
        # =============
        # Rust
        cargo
        # Js
        nodejs
        yarn

        # Cli stuff
        # ========
        starship
        bat
        lsd
        ncdu
        pandoc

        # Applications
        # ============
        obsidian
        element-desktop

        # Misc
        # ====
        nerdfonts
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
    

    nixpkgs.config.allowUnfree = true;
  }
