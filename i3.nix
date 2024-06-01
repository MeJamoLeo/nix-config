{ config, lib, pkgs, ... }:

let 
  mod = "Mod4";
  term = "alacritty";
  browser = "qutebrowser";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      # fonts = ["pango:Fira Sans 8"];

      keybindings = lib.mkOptionDefault {
        "${mod}+t" = "exec ${term}";
        "${mod}+b" = "exec ${browser}";
        "${mod}+q" = "kill";
        "${mod}+Shift+q" = "killall";
        "${mod}+Escape" = "exec --no-startup-id ~/.config/i3/scripts/blur-lock";
        "${mod}+d" = "exec ${pkgs.rofi}/bin/rofi -show combi -combi-modi drun";
        "${mod}+Shift+d" = "exec ${pkgs.rofi}/bin/rofi";
        "Mod1+Tab" = "exec ${pkgs.rofi}/bin/rofi -show window";
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";
        "${mod}+Control+j" = "move window to workspace prev";
        "${mod}+Control+k" = "move window to workspace next";
        "${mod}+Control+Shift+Up" = "exec --no-startup-id i3-msg [workspace=__focused__] move window to output up, focus output up";
        "${mod}+Control+Shift+Down" = "exec --no-startup-id i3-msg [workspace=__focused__] move window to output down, focus output down";
        "${mod}+Control+Shift+Left" = "exec --no-startup-id i3-msg [workspace=__focused__] move window to output left, focus output left";
        "${mod}+Control+Shift+Right" = "exec --no-startup-id i3-msg [workspace=__focused__] move window to output right, focus output right";
        "${mod}+backslash" = "split h";
        "${mod}+minus" = "split v";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";
        "${mod}+z" = "focus child";
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"";
      };

      workspaceOutputAssign = [
        { workspace = "1"; output = "eDP-1"; }
        { workspace = "2"; output = "eDP-1"; }
        { workspace = "3"; output = "eDP-1"; }
        { workspace = "4"; output = "eDP-1"; }
        { workspace = "5"; output = "eDP-1"; }
        { workspace = "6"; output = "eDP-1"; }
        { workspace = "7"; output = "eDP-1"; }
        { workspace = "8"; output = "eDP-1"; }
        { workspace = "9"; output = "eDP-1"; }
        { workspace = "10"; output = "eDP-1"; }
        { workspace = "11"; output = "DP-3"; }
        { workspace = "12"; output = "DP-3"; }
        { workspace = "13"; output = "DP-3"; }
        { workspace = "14"; output = "DP-3"; }
        { workspace = "15"; output = "DP-3"; }
        { workspace = "16"; output = "DP-3"; }
        { workspace = "17"; output = "DP-3"; }
        { workspace = "18"; output = "DP-3"; }
        { workspace = "19"; output = "DP-3"; }
        { workspace = "20"; output = "DP-3"; }
      ];

      bars = [
  {
    position = "top";
    statusCommand = "${pkgs.i3status}/bin/i3status";
    colors = {
      activeWorkspace = { background = "#4C4845"; border = "#48B9C7"; text = "#F6F6F6"; };
      background = "#3F3B39";
      focusedWorkspace = { background = "#2C8691"; border = "#2C8691"; text = "#F6F6F6"; };
      inactiveWorkspace = { background = "#4C4845"; border = "#2C8691"; text = "#cccccc"; };
      separator = "#BE7704";
      statusline = "#cccccc";
      urgentWorkspace = { background = "#900000"; border = "#A00000"; text = "#cccccc"; };
    };
  }
];
# 
#       startup = [
#         "xrandr --output eDP-1 --mode 2160x1350"
#       ];

#      floatingWindows = [
#      { class = "Gnome-tweaks"; }
#      { class = "Gnome-control-center"; }
#      { class = "Io.elementary.appcenter"; }
#      { class = "Gnome-calculator"; }
#      { class = "qt5ct"; }
#      { class = "Synergy"; }
#      { class = "Gimp"; }
#      { class = "Skype"; }
#      { class = "zoom"; }
#      { class = "Nxplayer.bin"; }
#      { class = "Virt-manager"; }
#      { class = "Virt-viewer"; }
#      { class = "vlc"; }
#      { class = "Wine"; }
#      { class = "Pavucontrol"; }
#      { class = "Moonlight"; }
#      { class = "minecraft-launcher"; }
#      { class = "^Minecraft*"; }
#      { class = "Steam"; }
#      { class = "^steam_app*"; }
#      ];
#
assigns = {
  "9" = [
    { class = "^Spotify"; }
  ];
  "0" = [
    { class = "^Discord"; }
  ];
};
    };
  };
}
