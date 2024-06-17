{ config, lib, pkgs, ... }:

{
  imports = [
  ];

  home = rec { # recでAttribute Set内で他の値を参照できるようにする
  username="treo";
  homeDirectory = "/home/${username}"; # 文字列に値を埋め込む
  stateVersion = "22.11";

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

    cliphist #hyprland clipboard
    xclip
    git

  #=============
  # GUI
  #=============
    brave
    discord
    obsidian
    virtualbox
    vivaldi
    vscode
    spotify

  #=============
  # GNOME
  #=============
    gnome3.gnome-tweaks


  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    coc = {
      enable = true;
      pluginConfig = ''
          let g:coc_global_extensions = [ 'coc-nix', 'coc-clangd', 'coc-prettier', 'coc-pairs', 'coc-highlight' ]

          highlight CocErrorSign ctermfg=15 ctermbg=196
          highlight CocWarningSign ctermfg=0 ctermbg=172
      '';
      settings = {
        "suggest.noselect" = true;
        languageserver = {
          nix = {
            enableLanguageServer = true;
            serverPath = "nil";
          };
        };
      };
    };
    plugins = with pkgs.vimPlugins; [
      vim-nix
      {
        plugin = iceberg-vim;
        config = ''
          colorscheme iceberg
          set cursorline
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
          let g:lazygit_floating_window_winblend = 0
          let g:lazygit_floating_window_scaling_factor = 0.9
          let g:lazygit_floating_window_border_chars = ['╭','─', '╮', '│', '╯','─', '╰', '│']
          let g:lazygit_floating_window_use_plenary = 0
          let g:lazygit_use_neovim_remote = 1
          let g:lazygit_use_custom_config_file_path = 0
          nnoremap <silent> <space>lg :LazyGit<CR>
        '';
      }
      {
        plugin = vim-gitgutter;
        config = ''
          let g:gitgutter_enabled = 1
          let g:gitgutter_sign_allow_clobber = 1
          highlight GitGutterAdd ctermbg=Green
          "highlight GitGutterChange guibg=Yellow
          "highlight GitGutterDelete guibg=Red
          let g:gitgutter_highlight_lines = 0
          let g:gitgutter_nr_highlight_lines = 1
        '';
      }
    ];
    extraLuaConfig = ''
      -- base config
      vim.opt.number = true
      vim.opt.clipboard:append('unnamedplus')
      vim.opt.autoindent = true
      vim.opt.smartindent = true
      vim.opt.ignorecase = true
      vim.opt.shiftwidth = 4
      vim.opt.tabstop = 4
      vim.opt.softtabstop = 4
      vim.opt.expandtab = false
      vim.opt.laststatus = 0
      vim.opt.list = true
      vim.opt.listchars = { tab = '»-', trail = '-', eol = '↲', extends = '»', precedes = '«', nbsp = '%' }
      vim.opt.termguicolors = true
      vim.api.nvim_create_autocmd("TermOpen", { pattern = "*", command = "startinsert" })
      vim.opt.signcolumn = "yes"

      -- func
      if vim.fn.has('nvim') == 1 then
        -- `:Term` コマンドを定義します。水平分割、20行の高さにリサイズし、ターミナルを開きます。
          vim.api.nvim_create_user_command('Term', function(opts)
          vim.cmd('split')
          vim.cmd('wincmd j')
          vim.cmd('resize 20')
          vim.cmd('terminal ' .. table.concat(opts.fargs, ' '))
        end, { nargs = '*' })

      -- `:Termv` コマンドを定義します。垂直分割し、ターミナルを開きます。
          vim.api.nvim_create_user_command('Termv', function(opts)
          vim.cmd('vsplit')
          vim.cmd('wincmd l')
          vim.cmd('terminal ' .. table.concat(opts.fargs, ' '))
        end, { nargs = '*' })
      end


      -- maps
      vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<ESC><ESC>', ':nohlsearch<CR><ESC>', { noremap = true, silent = true })

      vim.g.mapleader = ' '
      vim.api.nvim_set_keymap('n', '<Leader>nc', ':vs ~/.nix-config/configuration.nix<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>nh', ':vs ~/.nix-config/home.nix<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>nf', ':vs ~/.nix-config/flake.nix<CR>', { noremap = true, silent = true })

      vim.api.nvim_set_keymap('n', '<Leader>t', ':tabnew<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader><CR>', ':Term<CR>', { noremap = true, silent = true })

      -- TODO: oj Atcoder
      -- vim.api.nvim_set_keymap('n', '<Leader>aT', ':vsplit | terminal<CR>g++ main.cpp && oj t -d tests/<CR>', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<Leader>aS', ':vsplit | terminal oj s main.cpp<CR>', { noremap = true, silent = true })

      -- netrw
      vim.api.nvim_create_autocmd("FileType", {
      pattern = "netrw",
      callback = function()
      vim.api.nvim_buf_set_keymap(0, 'n', 'v', ":execute 'vsplit' fnameescape(expand('<cfile>'))<CR><C-w>L<C-w>p", { noremap = true, silent = true })
      vim.api.nvim_buf_set_keymap(0, 'n', 'o', ":execute 'split' fnameescape(expand('<cfile>'))<CR><C-w>p", { noremap = true, silent = true })
      end
      })


      -- clipboard config
      local desktop_env = os.getenv("XDG_CURRENT_DESKTOP")

      if desktop_env == "GNOME" then
      vim.g.clipboard = {
      name = "xclip",
      copy = {
      ['+'] = 'xclip -selection clipboard',
      ['*'] = 'xclip -selection primary',
      },
      paste = {
      ['+'] = 'xclip -selection clipboard -o',
      ['*'] = 'xclip -selection primary -o',
      },
      cache_enabled = 0,
      }
      elseif desktop_env == "Hyprland" then
      vim.g.clipboard = {
      name = "cliphist",
      copy = {
      ['+'] = 'cliphist copy',
      ['*'] = 'cliphist copy',
      },
      paste = {
      ['+'] = 'cliphist paste',
      ['*'] = 'cliphist paste',
      },
      cache_enabled = 0,
      }
      end;
    '';
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


    # TODO: I cannot use 'j' for input
    # config.bind('jj', 'mode-leave', mode='insert')

    # Unbind the original keybindings
    config.unbind('<Shift-j>', mode='normal')
    config.unbind('<Shift-k>', mode='normal')

    config.bind('<Shift-j>', 'tab-prev', mode='normal') # Bind Shift+j to move the tab focus to the left
    config.bind('<Shift-k>', 'tab-next', mode='normal') # Bind Shift+k to move the tab focus to the right
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

wayland.windowManager.hyprland = {
  settings = {
    env = [
      "TERM, kitty"
      "BROWSER, qutebrowser"
    ];
    "$mod" = "SUPER";
    monitor = [
      "eDP-1, highres, auto, 1" #laptop
      "DP-3, highres, auto-left, 1" #sumsung
    ];
    bind = [
          # Keyboard Shortcuts for Pop_OS! like??
          ## Move, resize, and swap windows
          ### switch focus
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
          ### resize window
          "$mod SHIFT, H, resizeactive, -90 0"
          "$mod SHIFT, L, resizeactive, 90 0"
          "$mod SHIFT, K, resizeactive, 0 -90"
          "$mod SHIFT, J, resizeactive, 0 90"
          ### move window
          "$mod CTRL, H, movewindow, l"
          "$mod CTRL, L, movewindow, r"
          "$mod CTRL, K, movewindow, u"
          "$mod CTRL, J, movewindow, d"

          # "$mod ALT, left, moveactive,  -80 0"
          # "$mod ALT, right, moveactive, 80 0"
          # "$mod ALT, up, moveactive, 0 -80"
          # "$mod ALT, down, moveactive, 0 80"

          ## Manipulate windows
          "$mod, S, togglesplit,"
          # "$mod, O, TODO: Change window orientation,"
          "$mod, G, togglefloating,"
          "$mod, M, fullscreen, 0"
          "$mod, Q, killactive,"

          ## Manage workspace and displays
          "$mod, Escape, exec, hyprlock"

          ## Use the launcher
          ## Switch between apps and windows
          ## Miscellaneous OS shortcuts
          "$mod, B, exec, qutebrowser"
          "$mod, T, exec, kitty"
          ## Accessibility shortcuts
          "$mod SHIFT, Escape, exit,"
          "$mod CTRL SHIFT, Escape, exec, shutdown-script"

          # show keybinds list
          "$mod, F1, exec, show-keybinds"

          # keybindings
          "$mod, Space, exec, pkill wofi || wofi --show drun"
          "$mod SHIFT, Space, exec, pkill wofi || wofi --show"
          "$mod SHIFT, D, exec, hyprctl dispatch exec '[workspace 4 silent] discord'"
          "$mod SHIFT, S, exec, hyprctl dispatch exec '[workspace 5 silent] SoundWireServer'"
          "$mod, P, pseudo,"
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
        exec-once = [
          "wl-paste --type text --watch cliphist store #Stores only text data"
          "wl-paste --type image --watch cliphist store #Stores only image data"
          "fcitx5"
        ];
        input.kb_options = "ctrl:swapcaps";
        # windowrulev2 = [
        #   "new, tile horizontal"
        # ];
      };
    };
    programs.hyprlock = {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 300;
          hide_cursor = true;
          no_fade_in = false;
        };

        background = [
          {
            path = "screenshot";
            blur_passes = 3;
            blur_size = 8;
          }
        ];

        input-field = [
          {
            size = "200, 50";
            position = "0, -80";
            monitor = "";
            dots_center = true;
            fade_on_empty = false;
            font_color = "rgb(202, 211, 245)";
            inner_color = "rgb(91, 96, 120)";
            outer_color = "rgb(24, 25, 38)";
            outline_thickness = 5;
            placeholder_text = "'\'<span foreground=\"##cad3f5\">Password...</span>'\'";
            shadow_passes = 2;
          }
        ];
      };
    };
    programs.wofi = {
      enable = true;
      settings = {
        location = "bottom-right";
        allow_markup = true;
        width = 250;
      };
    };
    programs.zathura = {
      enable = true;
      mappings = {
        D = "toggle_page_mode";
      };
    };
    programs.fzf = {
      enable = true;
    };
  }
