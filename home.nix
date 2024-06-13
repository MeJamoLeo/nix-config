{ config, lib, pkgs, ... }:

{
  imports = [
    ./i3.nix
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
    ];
  };

  programs.kitty = {
    enable = true;
  # package
  # settings
};

wayland.windowManager.hyprland.extraConfig = ''









##############################
### WINDOWS AND WORKSPACES ###
##############################

# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
# See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

# Example windowrule v1
# windowrule = float, ^(kitty)$

# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
  '';

programs.qutebrowser = {
  enable = true;
  extraConfig = ''
  config.set('content.javascript.clipboard', 'access', 'github.com')
  config.set('content.javascript.clipboard', 'access', 'atcoder.jp')
  config.set('content.javascript.clipboard', 'access', 'chat.openai.com')
  '';
};

programs.starship = {
  enable = true;
};

}
