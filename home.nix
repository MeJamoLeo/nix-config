{ config, lib, pkgs, ... }:

{
  imports = [
    ./i3.nix
  ];

  home = rec { # recでAttribute Set内で他の値を参照できるようにする
  username="bbb";
  homeDirectory = "/home/${username}"; # 文字列に値を埋め込む
  stateVersion = "22.11";
};
programs.home-manager.enable = true; # home-manager自身でhome-managerを有効化

home.packages = with pkgs; [
  #=============
  # GUI
  #=============
  bat
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
  discord
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

programs.git.enable = true;

services.picom = {
  activeOpacity = 0.95;
  backend = "glx";
  enable = true;
# extraArgs
fade = true;
# fadeDelta
# fadeExclude
fadeSteps = [0.1 0.03];
inactiveOpacity = 0.9;
menuOpacity = 0.8;
opacityRules = [
  "100:class_g = 'zoom'"
  "100:class_g = 'Brave-browser'"
  "100:class_g = 'Firefox'"
  "100:class_g = 'konqueror'"
  "100:window_type = 'dock' && class_g = 'i3bar'"
  "80:window_type = 'dock'"
];
# package
# settings #Picom settings. Use this option to configure Picom settings not exposed in a NixOS option or to bypass one. For the available options see the CONFIGURATION FILES section at picom(1).
# shadow
shadowExclude = 
[
  "name = 'Notification'"
  "class_g = 'Conky'"
  "class_g ?= 'Notify-osd'"
  "class_g = 'Cairo-clock'"
  "_GTK_FRAME_EXTENTS@:c"
];
# shadowOffsets
# shadowOpacity
vSync = true;
# wintypes = 
# {
#   tooltip = { fade = true; shadow = false; opacity = 0.9; focus = true; full-shadow = false; }
#   dock = { shadow = false; }
#   dnd = { shadow = false; }
#   popup_menu = { opacity = 0.9; }
#   dropdown_menu = { opacity = 0.9; }
# };
};


programs.alacritty = {
  enable = true;
  # package
  # settings
};

programs.qutebrowser = {
  enable = true;
};
}
