{
  pkgs,
  user,
  theme,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.shell.zsh;
in
  with lib; {
    options.modules.shell.zsh = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "enables zsh and zsh plugins";
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        exa
        fzf
        vscode-extensions.vadimcn.vscode-lldb
      ];

      programs = {
        zsh = {
          enable = true;
          enableAutosuggestions = true;
          autocd = true;
          dotDir = ".config/zsh";
          history = {
            expireDuplicatesFirst = true;
            path = "$HOME/.config/zsh/.zsh_history";
          };
          initExtraFirst = ''
            if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
              source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi

            export EDITOR="nvim"
          '';
          initExtra = let
            p10k = ''
              ZSH_THEME="powerlevel10k/powerlevel10k"
              [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
            '';
          in
            with theme.colors;
              ''
                export FZF_DEFAULT_OPTS="--layout=reverse"\
                " --color=bg+:${background2},bg:${background},spinner:${brightred},hl:${brightblack}"\
                " --color=fg:${foreground},header:${brightblack},info:${brightaqua},pointer:${brightred}"\
                " --color=marker:${brightred},fg+:${foreground},prompt:${brightred},hl+:${brightred}"
              ''
              + (
                p10k
              );
          shellAliases = {
            nixr = "sudo nixos-rebuild switch --flake https://gitlab.projectoc.de/dotfiles/flake#pr0ject";
            nixc = "sudo nix-collect-garbage --delete-older-than 2d";
            e = "${pkgs.neovim}/bin/nvim ./";
            f = "${pkgs.ranger}/bin/ranger";
            vim = "nvim";
          };
         zplug = {
              enable = true;
              plugins = [
               { name = "zsh-users/zsh-autosuggestions"; }
               { name = "zsh-users/zsh-completions"; }
               { name = "zsh-users/zsh-syntax-highlighting"; }
               { name = "plugins/command-not-found"; tags = [ from:oh-my-zsh ];}
               { name = "plugins/sudo"; tags = [ from:oh-my-zsh ];}
              ];
          };
          plugins =
          [
            {
              name = "zsh-nix-shell";
              file = "nix-shell.plugin.zsh";
              src = pkgs.fetchFromGitHub {
                owner = "chisui";
                repo = "zsh-nix-shell";
                rev = "v0.7.0";
                sha256 = "sha256-oQpYKBt0gmOSBgay2HgbXiDoZo5FoUKwyHSlUrOAP5E=";
              };
            }
          ] ++
          [
            {
              name = "powerlevel10k";
              file = "powerlevel10k.zsh-theme";
              src = pkgs.fetchFromGitHub {
                owner = "romkatv";
                repo = "powerlevel10k";
                rev = "v1.19.0";
                sha256 = "sha256-fgrwbWj6CcPoZ6GbCZ47HRUg8ZSJWOsa7aipEqYuE0Q=";
              };
            }
          ];
        };
      };

      home.file.".config/zsh/.p10k.zsh".source = ./.p10k.zsh;
    };
  }
