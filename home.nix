{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  home = rec { # recでAttribute Set内で他の値を参照できるようにする
  username="treo";
  homeDirectory = "/home/${username}"; # 文字列に値を埋め込む
  stateVersion = "22.11";

  sessionVariables = {
    EDITOR = "nvim";
  };
};

programs.home-manager.enable = true; # home-manager自身でhome-managerを有効化

# home.nix
home.packages = with pkgs; [
  #=============
  # GUI
  #=============
    bat
    btop
    eza
    ripgrep
    lazygit
    online-judge-tools

    nodejs_22
    python3
    sbcl #common lisp compiler

  #=============
  # GUI
  #=============
    brave
    discord
    obsidian
    virtualbox
    vivaldi
    vscode

  #=============
  # GNOME
  #=============
    gnome3.gnome-tweaks
  ];

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
      {
        plugin = iceberg-vim;
        config = ''
          colorscheme iceberg
        '';
      }
      {
        plugin = coc-nvim;
        config = ''
          let g:coc_global_extensions = [ 'coc-nix', 'coc-clangd' ]

          highlight CocErrorSign ctermfg=15 ctermbg=196
          highlight CocWarningSign ctermfg=0 ctermbg=172

          "select with Enter
          inoremap <expr> <cr> pumvisible() ? '<c-y>' : '<cr>'
        '';
      }
      {
        plugin = rainbow;
        config = ''
          let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
        '';
      }
      {
        plugin = lazygit-nvim;
        config = ''
        '';
      }
    ];
  };

  programs.kitty = {
    enable = true;
  # package
  # settings
};

programs.qutebrowser = {
  enable = true;
  extraConfig = ''
    config.set('content.javascript.clipboard', 'access', 'github.com')
    config.set('content.javascript.clipboard', 'access', 'atcoder.jp')
    config.set('content.javascript.clipboard', 'access', 'chat.openai.com')
  '';
  searchEngines = {
    "DEFAULT" = "https://duckduckgo.com/?ia=web&q={}";
    "!g" = "https://www.google.com/search?hl=en&q={}";
    "!gm" = "https://www.google.com/maps?q={}";
    "!d" = "https://duckduckgo.com/?ia=web&q={}";
    "!nw" = "https://nixos.wiki/index.php?search={}";
    "!np" = "https://github.com/NixOS/nixpkgs/search?q={}";
    "!no" = "https://mynixos.com/search?q={}";
    "!hp" = "https://github.com/nix-community/home-manager/search?q={}";
    "!a" = "https://www.amazon.com/s?k={}";
    "!gh" = "https://github.com/search?o=desc&q={}&s=stars";
    "!s" = "https://sourcegraph.com/search?patternType=standard&sm=1&q=context:global+{}";
    };
};

programs.starship = {
  enable = true;
};

}
