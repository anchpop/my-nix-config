{ pkgs, ... }: {
    home.packages = with pkgs;
    [ cowsay
        fortune
        vscode
        lsd
        nerdfonts
    ];
    programs.zsh = {
      enable = true;
      shellAliases = {
        ls = "lsd";
        update = "darwin-rebuild switch";
      };
    };
    

    nixpkgs.config.allowUnfree = true;
  }
