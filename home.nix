{ pkgs, ... }: {
    home.packages = with pkgs;
    [   cowsay
        fortune
        vscode
        lsd
        nerdfonts
        starship
        cargo
        bat
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
        update = "darwin-rebuild switch";
      };
    };
    

    nixpkgs.config.allowUnfree = true;
  }
