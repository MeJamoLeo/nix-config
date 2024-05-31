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
  bat
  eza
  ripgrep
  lazygit
  online-judge-tools

  nodejs_22
  python3
  sbcl #common lisp compiler
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
      '';
    }
  ];
};

programs.git.enable = true;
}
