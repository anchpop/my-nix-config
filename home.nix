{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
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
    protobuf
    shellcheck
    podman

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
    jq

    # Applications
    # ============
    obsidian
    element-desktop
    gocryptfs
    postman
    ffmpeg

    # Misc
    # ====
    ipfs
    pre-commit
    nixfmt
    openssl
    pkg-config
    gnupg
    coreutils-full
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

      bazel = "bazelisk";
    };
    enableCompletion = true;
    enableAutosuggestions = true;
    initExtra = ''
      source $HOME/.ghcup/env
      export PATH=$HOME/.cargo/bin:/opt/homebrew/bin:$PATH

      protogen() {
        (
          set -x
          # Gets the absolute path of the current directory
          CURRENT_DIR=$(pwd)

          # Checks if the current directory starts with the base path
          if [[ $CURRENT_DIR == $HOME/*/ic/rs* ]]; then
              # If so, extracts the relative path after the base path
              RELATIVE_DIR=''${CURRENT_DIR#$HOME/*/ic/rs/}

              # Runs the Bazel command with the relative path
              bazelisk run //rs/$RELATIVE_DIR/protobuf_generator:protobuf_generator --config=local
          else
              echo "Error: must be in a directory under $HOME/*/ic/rs"
          fi
        )
      }

      gpfall() {
        (
          set -x
          local current_branch=$(git rev-parse --abbrev-ref HEAD)
          local branches=$(git for-each-ref --format='%(refname:short)' refs/heads/@anchpop 2>/dev/null)
          
          if [[ -z "$branches" ]]; then
            echo "No branches found starting with '@anchpop'"
            return 1
          fi
          
          echo "$branches" | while read -r branch; do
            echo "Force pushing branch: $branch"
            git push origin "$branch" --force-with-lease
          done
          
          git checkout "$current_branch"
          echo "Returned to branch: $current_branch"
        )
      }

      source "$HOME/Library/Application Support/org.dfinity.dfx/env"

      eval "$(zoxide init --cmd cd zsh)"
    '';
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
}
