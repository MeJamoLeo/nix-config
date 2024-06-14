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



    # Unbind the original keybindings
    config.unbind('<Shift-j>', mode='normal')
    config.unbind('<Shift-k>', mode='normal')

    # Bind Shift+j to move the tab focus to the left
    config.bind('<Shift-j>', 'tab-prev', mode='normal')

    # Bind Shift+k to move the tab focus to the right
    config.bind('<Shift-k>', 'tab-next', mode='normal')
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

 wayland.windowManager.hyprland = {
   settings = {
      "$mod" = "SUPER";
      monitor = [
        "eDP-1, highres, auto, 1" #laptop
        "DP-3, highres, auto-left, 1" #sumsung
      ];
      bind = [
          # switch focus
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"

          # show keybinds list
          "$mod, F1, exec, show-keybinds"

          # keybindings
          "$mod, M, exit,"
          "$mod, B, exec, qutebrowser"
          "$mod, Return, exec, kitty"
          "ALT, Return, exec, kitty --title float_kitty"
          "$mod SHIFT, Return, exec, kitty --start-as=fullscreen -o 'font_size=16'"
          "$mod, Q, killactive,"
          "$mod, F, fullscreen, 0"
          "$mod SHIFT, F, fullscreen, 1"
          "$mod, Space, togglefloating,"
          "$mod, D, exec, pkill wofi || wofi --show drun"
          "$mod SHIFT, D, exec, hyprctl dispatch exec '[workspace 4 silent] discord'"
          "$mod SHIFT, S, exec, hyprctl dispatch exec '[workspace 5 silent] SoundWireServer'"
          "$mod, Escape, exec, swaylock"
          "$mod SHIFT, Escape, exec, shutdown-script"
          "$mod, P, pseudo,"
          # "$mod, J, togglesplit,"
          "$mod, E, exec, nemo"
          "$mod SHIFT, B, exec, pkill -SIGUSR1 .waybar-wrapped"
          "$mod, C ,exec, hyprpicker -a"
          "$mod, G,exec, $HOME/.local/bin/toggle_layout"
          "$mod, W,exec, pkill wofi || wallpaper-picker"
          "$mod SHIFT, W, exec, vm-start"

          # screenshot
          "$mod, Print, exec, grimblast --notify --cursor save area ~/Pictures/$(date +'%Y-%m-%d-At-%Ih%Mm%Ss').png"
          ",Print, exec, grimblast --notify --cursor  copy area"

          # switch workspace
          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          # same as above, but switch to the workspace
          "$mod SHIFT, 1, movetoworkspacesilent, 1" # movetoworkspacesilent
          "$mod SHIFT, 2, movetoworkspacesilent, 2"
          "$mod SHIFT, 3, movetoworkspacesilent, 3"
          "$mod SHIFT, 4, movetoworkspacesilent, 4"
          "$mod SHIFT, 5, movetoworkspacesilent, 5"
          "$mod SHIFT, 6, movetoworkspacesilent, 6"
          "$mod SHIFT, 7, movetoworkspacesilent, 7"
          "$mod SHIFT, 8, movetoworkspacesilent, 8"
          "$mod SHIFT, 9, movetoworkspacesilent, 9"
          "$mod SHIFT, 0, movetoworkspacesilent, 10"
          "$mod CTRL, c, movetoworkspace, empty"

          # window control
          "$mod SHIFT, left, movewindow, l"
          "$mod SHIFT, right, movewindow, r"
          "$mod SHIFT, up, movewindow, u"
          "$mod SHIFT, down, movewindow, d"
          "$mod CTRL, left, resizeactive, -80 0"
          "$mod CTRL, right, resizeactive, 80 0"
          "$mod CTRL, up, resizeactive, 0 -80"
          "$mod CTRL, down, resizeactive, 0 80"
          "$mod ALT, left, moveactive,  -80 0"
          "$mod ALT, right, moveactive, 80 0"
          "$mod ALT, up, moveactive, 0 -80"
          "$mod ALT, down, moveactive, 0 80"

          # media and volume controls
          ",XF86AudioRaiseVolume,exec, pamixer -i 2"
          ",XF86AudioLowerVolume,exec, pamixer -d 2"
          ",XF86AudioMute,exec, pamixer -t"
          ",XF86AudioPlay,exec, playerctl play-pause"
          ",XF86AudioNext,exec, playerctl next"
          ",XF86AudioPrev,exec, playerctl previous"
          ",XF86AudioStop, exec, playerctl stop"
          "$mod, mouse_down, workspace, e-1"
          "$mod, mouse_up, workspace, e+1"

          # laptop brigthness
          ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          "$mod, XF86MonBrightnessUp, exec, brightnessctl set 100%+"
          "$mod, XF86MonBrightnessDown, exec, brightnessctl set 100%-"

          # clipboard manager
          "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        ];
      };
    };
  }
