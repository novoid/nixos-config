{ config, pkgs, lib, ... }:
{

    services.gnome-keyring.enable = true;

    services.clipman.enable = true;
  
    services.gammastep.enable = true;
    services.gammastep.tray = true;
    services.gammastep.latitude  = "47.0"; # SPECIFICTOKARL
    services.gammastep.longitude = "15.4"; # SPECIFICTOKARL
    services.gammastep.temperature.day = 5700;
    services.gammastep.temperature.night = 3500;
  
    xfconf.enable = true;
    
    home.packages = with pkgs; [


    ];

#        xfconf.settings = {
    # FIXXME: test from https://www.reddit.com/r/NixOS/comments/15coxtr/homemanager_using_hostname_for_hostspecific/
    xfconf.settings = let
      myServers = [
        "nixosvms"
        "nixosvmr"
      ];
      isVm = hostname: (builtins.match "^nixos" hostname) != null;
      isInList = hostname: builtins.elem hostname myServers;
      enableSaver = hostname: ! (isVm hostname || isInList hostname);
    in {

      # FIXXME: as of 2023-07-28 I had some issues with xfconf not
      # being able to set some options. While playing around and to my
      # astonishment, I found out that some xfce modules require a
      # leading slash for the options ("/saver/enabled" = true;) and
      # other modules don't require those leading slashes
      # ("general/workspace_count" = 4;). Therefore, I added "MUST
      # NOT" and "MUST" comments when a certain configuration did seem
      # to run through without causing this error message. This might
      # be considered as a bug and may change in future, I don't know
      # for now.
      
      xfce4-session = {
      }; # xfce4-session

      xfwm4 = { # 2023-07-29: MUST NOT have leading slashes
        "general/workspace_count" = 4;
        "general/workspace_names" = [ "1" "2" "3" "4" ];
        "general/borderless_maximize" = true;
        "general/click_to_focus" = false;
        "general/cycle_apps_only" = false;
        "general/cycle_draw_frame" = true;
        "general/cycle_hidden" = true;
        "general/cycle_minimized" = false;
        "general/cycle_minimum" = true;
        "general/cycle_preview" = true;
        "general/cycle_raise" = false;
        "general/cycle_tabwin_mode" = 0;
        "general/cycle_workspaces" = false;
        "general/double_click_action" = "maximize";  # Window Manager -> Advanced -> Double click action
        "general/double_click_distance" = 5;
        "general/double_click_time" = 250;
        "general/easy_click" = "Alt";
        "general/focus_delay" = 141;
        "general/focus_hint" = true;
        "general/focus_new" = true;
        "general/prevent_focus_stealing" = false;
        "general/raise_delay" = 250;
        "general/raise_on_click" = true;
        "general/raise_on_focus" = false;
        "general/raise_with_any_button" = true;
        "general/scroll_workspaces" = false;
        "general/snap_resist" = false;
        "general/snap_to_border" = true;
        "general/snap_to_windows" = true;
        "general/snap_width" = 10;
        "general/theme" = "Adwaita-dark-Xfce";
        "general/tile_on_move" = true;
        "general/title_alignment" = "center";
        "general/title_font" = 9;
        "general/title_horizontal_offset" = 0;
        "general/title_shadow_active" = false;
        "general/title_shadow_inactive" = false;
        "general/toggle_workspaces" = false;
        "general/wrap_cycle" = false;
        "general/wrap_layout" = false;
        "general/wrap_resistance" = 10;
        "general/wrap_windows" = false;
        "general/wrap_workspaces" = false;
        "general/zoom_desktop" = true;
        "general/zoom_pointer" = true;
      }; # xfwm4

      xfce4-desktop = { # 2023-07-29: MUST NOT have leading slashes
        # FIXXME: this section is untested
        "desktop-icons/file-icons/show-filesystem" = false;
        "desktop-icons/file-icons/show-home" = false;
        "desktop-icons/file-icons/show-removable" = false;
        "desktop-icons/file-icons/show-trash" = true;
        "desktop-icons/icon-size" = 32;
        "desktop-menu/show" = false;
        "backdrop/single-workspace-mode" = true;
        "backdrop/single-workspace-number" = 3;
      }; # xfce4-desktop

      xfce4-panel = { # 2023-07-29: MUST have leading slashes
        # FIXXME: this section is not working completely; in particular: "whiskermenu"; "cpugraph"; "netload"; "eyes";

        # example configurations:
        # https://github.com/vhminh/dotfiles/blob/7b7dd80408658f0d76f8d0b518a314f5952146ec/nix/modules/desktop.nix#L62
        # https://github.com/lobre/nix-home/blob/8117fbdb4bca887b875f622132b3b9e9c737a5bf/roles/hm/xfce/xfconf.nix#L144 -> leading slashes! :-O
        
        "panels" = [ 1 ];
        "panels/dark-mode" = true;
        "panels/panel-1/nrows" = 1; # number of rows
        "panels/panel-1/mode" = 0; # Horizontal
        "panels/panel-1/output-name" = "Automatic";
        "panels/panel-1/span-monitors" = false;
        "panels/panel-1/background-style" = 0; # None (use system style)
        "panels/panel-1/icon-size" = 0; # Adjust size automatically
        "panels/panel-1/size" = 24; # Row size (pixels)
        "panels/panel-1/length" = 100.0;
        "panels/panel-1/length-adjust" = true;
        "panels/panel-1/position" = "p=6;x=0;y=0";
        "panels/panel-1/enable-struts" = true;
        "panels/panel-1/position-locked" = true;
        "panels/panel-1/plugin-ids" = [ 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 ];
        # Application menu = whiskermenu
        "plugins/plugin-1" = "whiskermenu";
        # Tasklist
        "plugins/plugin-2" = "tasklist";
        "plugins/plugin-2/grouping" = false;
        "plugins/plugin-2/show-handle" = true;
        "plugins/plugin-2/show-labels" = true;
        "plugins/plugin-2/flat-buttons" = false;
        "plugins/plugin-2/include-all-monitors" = true;
        "plugins/plugin-2/window-scrolling" = false;
        "plugins/plugin-2/sort-order" = 1; # Group title and timestamp
        "plugins/plugin-2/middle-click" = 0; # Nothing
        "plugins/plugin-2/show-wireframes" = false;
        "plugins/plugin-2/include-all-workspaces" = false;
        # Separator
        "plugins/plugin-3" = "separator";
        "plugins/plugin-3/style" = 0; # transparent
        "plugins/plugin-3/expand" = true;
        # Workspaces
        "plugins/plugin-4" = "pager";
        "plugins/plugin-4/rows" = 1;
        "plugins/plugin-4/miniature-view" = false; # show name instead of preview
        "plugins/plugin-4/numbering" = false;
        "plugins/plugin-4/workspace-scrolling" = false;
        # screenshooter (if order of this item is changed → also change order of symlink below: "files in ~/.config/")
        "plugins/plugin-5" = "screenshooter";
        # Separator
        "plugins/plugin-6" = "separator";
        "plugins/plugin-6/style" = 0; # transparent
        # Sys tray
        "plugins/plugin-7" = "systray";
        # CPU graph (if order of this item is changed → also change order of symlink below: "files in ~/.config/")
        "plugins/plugin-8" = "cpugraph";
        # Pulse audio
        "plugins/plugin-9" = "pulseaudio";
        "plugins/plugin-9/enable-keyboard-shortcuts" = true;
        # Network monitor (if order of this item is changed → also change order of symlink below: "files in ~/.config/")
        "plugins/plugin-10" = "netload";
        # clipboard
        "plugins/plugin-11" = "xfce4-clipman-plugin";
        "plugins/clipman/settings/save-on-quit" = true;
        "plugins/clipman/settings/max-texts-in-history" = 1000;
        "plugins/clipman/settings/add-primary-clipboard" = false;
        # Notification
        "plugins/plugin-12" = "notification-plugin";
        # Separator
        "plugins/plugin-13" = "separator";
        "plugins/plugin-13/style" = 0; # transparent
        # Power manager
        "plugins/plugin-14" = "power-manager-plugin";
        # Clock
        "plugins/plugin-15" = "clock";
        "plugins/plugin-15/digital-layout" = 3; # Time Only
        "plugins/plugin-15/digital-time-font" = "Sans 11";
        "plugins/plugin-15/digital-time-format" = "%a %d %R";
        "plugins/plugin-15/tooltip-format" = "%A %d %B %Y"; # Saturday 29 July 2023
        "plugins/plugin-15/mode" = 2; # digital
        "plugins/plugin-15/show-frame" = false;
        # Eyes: where's my mouse cursor?
        "plugins/plugin-16" = "eyes";
      }; # xfce4-panel        
      
      
      xfce4-screensaver = { # 2023-07-29: MUST have leading slashes
        # FIXXME: this section is untested
        "/lock/saver-activation/delay" = 2;
        "/lock/saver-activation/enabled" = false;
        "/lock/user-switching/enabled" = false;
        #"/lock/enabled" = true; # Enable Lock Screen
        # FIXXME: trying to find the correct syntax for setting the lock screen boolean according to "my.isvm":
        #"/lock/enabled" =  "${nixos.config.networking.hostName}" == "nixosvms"; # error: undefined variable 'nixos'
        #"/lock/enabled" =  "${config.networking.hostName}" == "nixosvms"; # error: attribute 'networking' missing
        
        #"/lock/enabled" =  ! config.options.my.isvm; # error: attribute 'options' missing
        #"/lock/enabled" =  ! ${config.options.my.isvm}; # error: syntax error, unexpected DOLLAR_CURLY
        #"/lock/enabled" =  ! ${nixos.config.options.my.isvm}; # error: syntax error, unexpected DOLLAR_CURLY
        #"/lock/enabled" =  ! ${options.my.isvm}; # error: syntax error, unexpected DOLLAR_CURLY
        #"/lock/enabled" =  ! "${options.my.isvm}"; # error: undefined variable 'options'
        #"/lock/enabled" =  ! options.my.isvm; # error: undefined variable 'options'
        
        #"/lock/enabled" =  ! config.my.isvm; #attribute 'my' missing
        #"/lock/enabled" =  ! my.isvm; # error: undefined variable 'my'
        #"/lock/enabled" =  ! ${config.my.isvm}; # error: syntax error, unexpected DOLLAR_CURLY
        #"/lock/enabled" =  ! ${nixos.config.my.isvm}; # error: syntax error, unexpected DOLLAR_CURLY
        #"/lock/enabled" =  ! ${my.isvm}; # error: syntax error, unexpected DOLLAR_CURLY
        #"/lock/enabled" =  ! "${my.isvm}"; # error: undefined variable 'my'

#        "/lock/enabled" = enableSaver config.networking.hostName;
        
        "/saver/enabled" = true;
        "/saver/idle-activation/delay" = 9;
        "/saver/idle-activation/enabled" = true;
        "/saver/mode" = 0;
        "/screensavers/xfce-personal-slideshow/arguments" = "month";
        "/screensavers/xfce-personal-slideshow/location" = "month";
      }; # xfce4-screensaver

      
      xfce4-appfinder = {
      }; # xfce4-appfinder

      
      keyboard-layout = { # 2023-07-29: MUST have leading slashes
        "/Default/XkbDisable" = false;
        "/Default/XkbLayout" = "us";
        "/Default/XkbModel" = "pc105";
        "/Default/XkbOptions/Compose" = "compose:rctrl";
        "/Default/XkbVariant" = "intl";
      }; # keyboard-layout

      
      xfce4-keyboard-shortcuts = { # 2023-07-29: MUST have leading slashes
        # FIXXME: this section is untested
        
        "/commands/custom/<Alt>F1" = "xfce4-popup-applicationsmenu";
        "/commands/custom/<Alt>F2" = "xfce4-popup-whiskermenu";
        "/commands/custom/<Alt>F3" = "xfce4-appfinder";
        # "/commands/custom/<Alt>space" = recoll;
        "/commands/custom/override" = true;  # no idea what this is
        #"/commands/custom/<Primary><Alt>Delete" = "xflock4";
        #"/commands/custom/<Primary>Escape" = "--menu";
        "/commands/custom/<Primary>F1" = "exec /home/vk/src/misc/vksave-window-positions.sh"; # DEPENDENCY
        "/commands/custom/<Primary>F2" = "exec /home/vk/src/misc/vkrestore-window-positions.sh"; # DEPENDENCY
        "/commands/custom/<Primary>F7" = "emacs-everywhere"; # unconfirmed
        #"/commands/custom/<Primary>F8" = "{window}";
        "/commands/custom/<Shift><Super>Left" = "active";  # no idea what this is
        "/commands/custom/<Shift><Super>Right" = "active";  # no idea what this is
        "/commands/custom/<Super>l" = "xflock4";
        "/commands/custom/<Super>p" = "xfce4-display-settings"; # FIXXME: doesn't work
        "/commands/custom/XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -10%";
        "/commands/custom/XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +10%";
        "/commands/custom/XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        #"/commands/custom/XF86AudioNext" = "--next";
        #"/commands/custom/XF86AudioPlay" = "--toggle-playing";
        #"/commands/custom/XF86AudioPrev" = "--previous";
        #"/commands/custom/XF86AudioStop" = "--stop";
        #"/commands/custom/XF86Display" = "--minimal";
        # "/commands/custom/XF86Mail" = MailReader;
        # "/commands/custom/XF86WWW" = WebBrowser;
        "/commands/default/<Alt>F1" = "xfce4-popup-applicationsmenu";
#         "/commands/default/<Alt>F2" = --collapsed
#     true;
        "/commands/default/<Alt>F2/startup-notify" = true;  # no idea what this is
#         "/commands/default/<Alt>F3" = xfce4-appfinder
#     true;
        "/commands/default/<Alt>F3/startup-notify" = true;  # no idea what this is
        #"/commands/default/<Alt>Print" = "-w";
        #"/commands/default/<Alt><Super>s" = "orca";
        #"/commands/default/HomePage" = "WebBrowser";
        # Primary = Control:
        #"/commands/default/<Primary><Alt>Delete" = "xfce4-session-logout";
        #"/commands/default/<Primary><Alt>Escape" = "xkill";
        "/commands/default/<Primary><Alt>f" = "thunar";
        #"/commands/default/<Primary><Alt>l" = "xflock4";
        #"/commands/default/<Primary><Alt>t" = "TerminalEmulator";
        #"/commands/default/<Primary>Escape" = "--menu";
        "/commands/default/<Primary><Shift>Escape" = "xfce4-taskmanager";
        #"/commands/default/Print" = "xfce4-screenshooter";
        #"/commands/default/<Shift>Print" = "-r";
        #"/commands/default/<Super>e" = "thunar";
        #"/commands/default/<Super>p" = "--minimal";
#         "/commands/default/<Super>r" = -c
#     true;
        "/commands/default/<Super>r/startup-notify" = true;  # no idea what this is
#         "/commands/default/XF86Display" = --minimal;
#         "/commands/default/XF86Mail" = MailReader;
#         "/commands/default/XF86WWW" = WebBrowser;
#         "providers" = <<UNSUPPORTED>>;
        "/xfwm4/custom/<Alt>F11" = "fullscreen_key";
        "/xfwm4/default/<Alt>F11" = "fullscreen_key";
        "/xfwm4/custom/<Alt>F4" = "close_window_key";
        "/xfwm4/custom/<Alt><Shift>Tab" = "cycle_reverse_windows_key";
        "/xfwm4/custom/<Alt>Tab" = "cycle_windows_key";
        #"/xfwm4/custom/<Control><Shift><Alt>Left" = "move_window_left_key";
        #"/xfwm4/custom/<Control><Shift><Alt>Right" = "move_window_right_key";
        #"/xfwm4/custom/<Control><Shift><Alt>Up" = "move_window_up_key";
        "/xfwm4/custom/Down" = "down_key";
        "/xfwm4/custom/Up" = "up_key";
        "/xfwm4/custom/Left" = "left_key";
        "/xfwm4/custom/Escape" = "cancel_key";
        "/xfwm4/custom/Right" = "right_key";
        "/xfwm4/default/Down" = "down_key";
        "/xfwm4/default/Escape" = "cancel_key";
        "/xfwm4/default/Left" = "left_key";
        "/xfwm4/default/Up" = "up_key";
        "/xfwm4/default/Right" = "right_key";
        "/xfwm4/custom/override" = true;  # no idea what this is
        "/xfwm4/custom/<Primary>F9" = "workspace_1_key"; # FIXXME: doesn't work
        "/xfwm4/custom/<Primary>F10" = "workspace_2_key"; # FIXXME: doesn't work
        "/xfwm4/custom/<Primary>F11" = "workspace_3_key"; # FIXXME: doesn't work
        "/xfwm4/custom/<Primary>F12" = "workspace_4_key"; # FIXXME: doesn't work
        "/xfwm4/custom/<Primary><Shift>F9"  = "move_window_workspace_1_key"; # FIXXME: doesn't work
        "/xfwm4/custom/<Primary><Shift>F10" = "move_window_workspace_2_key"; # FIXXME: doesn't work
        "/xfwm4/custom/<Primary><Shift>F11" = "move_window_workspace_3_key"; # FIXXME: doesn't work
        "/xfwm4/custom/<Primary><Shift>F12" = "move_window_workspace_4_key"; # FIXXME: doesn't work
        #"/xfwm4/custom/<Primary><Super>Down" = "tile_down_key";
        #"/xfwm4/custom/<Primary><Super>Up" = "tile_up_key";
        #"/xfwm4/custom/<Shift><Alt>Left" = "left_workspace_key";
        #"/xfwm4/custom/<Shift><Alt>Right" = "right_workspace_key";
        "/xfwm4/custom/<Super>Down" = "hide_window_key";
        "/xfwm4/custom/<Super>Left" = "tile_left_key";
        "/xfwm4/custom/<Super>Right" = "tile_right_key";
        "/xfwm4/custom/<Super>Up" = "maximize_window_key";
        #"/xfwm4/default/<Alt>Delete" = "del_workspace_key";
        #"/xfwm4/default/<Alt>F10" = "maximize_window_key";
        #"/xfwm4/default/<Alt>F12" = "above_key";
        "/xfwm4/default/<Alt>F4" = "close_window_key";
        #"/xfwm4/default/<Alt>F6" = "stick_window_key";
        #"/xfwm4/default/<Alt>F7" = "move_window_key";
        #"/xfwm4/default/<Alt>F8" = "resize_window_key";
        #"/xfwm4/default/<Alt>F9" = "hide_window_key";
        #"/xfwm4/default/<Alt>Insert" = "add_workspace_key";
        "/xfwm4/default/<Alt><Shift>Tab" = "cycle_reverse_windows_key";
        "/xfwm4/default/<Alt>space" = "popup_menu_key";
        "/xfwm4/default/<Alt>Tab" = "cycle_windows_key";
        #"/xfwm4/default/<Primary><Alt>d" = "show_desktop_key";
        #"/xfwm4/default/<Primary><Alt>Down" = "down_workspace_key";
        #"/xfwm4/default/<Primary><Alt>End" = "move_window_next_workspace_key";
        #"/xfwm4/default/<Primary><Alt>Home" = "move_window_prev_workspace_key";
        "/xfwm4/default/<Primary><Alt>Left" = "left_workspace_key";
        "/xfwm4/default/<Primary><Alt>Right" = "right_workspace_key";
        #"/xfwm4/default/<Primary><Alt>Up" = "up_workspace_key";
        "/xfwm4/default/<Primary>F1" = "workspace_1_key"; # FIXXME: doesn't work
        "/xfwm4/default/<Primary>F2" = "workspace_2_key"; # FIXXME: doesn't work
        "/xfwm4/default/<Primary>F3" = "workspace_3_key"; # FIXXME: doesn't work
        "/xfwm4/default/<Primary>F4" = "workspace_4_key"; # FIXXME: doesn't work
        #"/xfwm4/default/<Primary>F5" = "workspace_5_key";
        #"/xfwm4/default/<Primary>F6" = "workspace_6_key";
        #"/xfwm4/default/<Primary>F7" = "workspace_7_key";
        #"/xfwm4/default/<Primary>F8" = "workspace_8_key";
        #"/xfwm4/default/<Primary>F9" = "workspace_9_key";
        #"/xfwm4/default/<Primary><Shift><Alt>Left" = "move_window_left_key";
        #"/xfwm4/default/<Primary><Shift><Alt>Right" = "move_window_right_key";
        #"/xfwm4/default/<Primary><Shift><Alt>Up" = "move_window_up_key";
        #"/xfwm4/default/<Shift><Alt>Page_Down" = "lower_window_key";
        #"/xfwm4/default/<Shift><Alt>Page_Up" = "raise_window_key";
        #"/xfwm4/default/<Super>KP_Down" = "tile_down_key";
        #"/xfwm4/default/<Super>KP_End" = "tile_down_left_key";
        #"/xfwm4/default/<Super>KP_Home" = "tile_up_left_key";
        #"/xfwm4/default/<Super>KP_Left" = "tile_left_key";
        #"/xfwm4/default/<Super>KP_Next" = "tile_down_right_key";
        #"/xfwm4/default/<Super>KP_Page_Up" = "tile_up_right_key";
        #"/xfwm4/default/<Super>KP_Right" = "tile_right_key";
        #"/xfwm4/default/<Super>KP_Up" = "tile_up_key";
        "/xfwm4/default/<Super>Tab" = "switch_window_key";
      }; # xfce4-keyboard-shortcuts
      
      xsettings = {
        # "/Gdk/WindowScalingFactor" = 1;
        # "/Gtk/ButtonImages" = true;
        # "/Gtk/CanChangeAccels" = false;
        # "/Gtk/ColorPalette" = "green:gray10:gray30:gray75:gray90";
        # "/Gtk/CursorThemeName" = "default";
        # "/Gtk/CursorThemeSize" = 16;
        # "/Gtk/DecorationLayout" = "menu:minimize,maximize,close";
        # "/Gtk/DialogsUseHeader" = false;
        # "/Gtk/FontName" = 10;
        # "/Gtk/IconSizes" = ;
        # "/Gtk/KeyThemeName" = ;
        # "/Gtk/MenuBarAccel" = F10;
        # "/Gtk/MenuImages" = true;
        # "/Gtk/MonospaceFontName" = 10;
        # "/Gtk/TitlebarMiddleClick" = lower;
        # "/Gtk/ToolbarIconSize" = 3;
        # "/Gtk/ToolbarStyle" = icons;
        # "/Net/CursorBlink" = true;
        # "/Net/CursorBlinkTime" = 1200;
        # "/Net/DndDragThreshold" = 8;
        # "/Net/DoubleClickDistance" = 5;
        # "/Net/DoubleClickTime" = 400;
        # "/Net/EnableEventSounds" = false;
        # "/Net/EnableInputFeedbackSounds" = false;
        # "/Net/IconThemeName" = Moka;
        # "/Net/SoundThemeName" = default;
        # "/Net/ThemeName" = "Adwaita-dark-Xfce";
        # "/Xft/Antialias" = -1;
        # "/Xft/Hinting" = -1;
        # "/Xft/HintStyle" = hintnone;
        # "/Xft/RGBA" = none;
      }; # xsettings

      
      xfce4-power-manager = { # 2023-07-29: MUST have leading slashes
        # FIXXME: this section is untested
        "/xfce4-power-manager/blank-on-ac" = 0;
        "/xfce4-power-manager/brightness-switch" = 1;
        "/xfce4-power-manager/brightness-switch-restore-on-exit" = -1;
        "/xfce4-power-manager/dpms-enabled" = true;
        "/xfce4-power-manager/dpms-on-ac-off" = 0;
        "/xfce4-power-manager/dpms-on-ac-sleep" = 0;
        "/xfce4-power-manager/lock-screen-suspend-hibernate" = true;
        "/xfce4-power-manager/show-tray-icon" = 1;

        "/xfce4-power-manager/handle-brightness-keys" = true; # FIXXME: doesn't work on floyd yet
        "/xfce4-power-manager/power-button-action" = 3; # Ask
        "/xfce4-power-manager/lid-action-on-battery" = 0; # just blank screen
        "/xfce4-power-manager/lid-action-on-ac" = 0; # just blank screen
        "/xfce4-power-manager/logind-handle-lid-switch" = false;
        "/xfce4-power-manager/critical-power-action" = 3; # Ask

      }; # xfce4-power-manager

      
      xfce4-mime-settings = {
      }; # xfce4-mime-settings


      displays = {
      }; # displays

      
      xfce4-mixer = { # 2023-07-29: MUST have leading slashes
        # FIXXME: this section is untested
        # "/sound-card" = "HDAIntelHDMIAlsamixer";
        #"/volume-step-size" = 5;
      }; # xfce4-mixer

      
      xfce4-notifyd = {
        # "/applications/known_applications" = <<UNSUPPORTED>>;
        # "/log-level" = 0;
        # "/log-level-apps" = 0;
        # "/notify-location" = 2;
        # "/primary-monitor" = 0;
      }; # xfce4-notifyd

      
      ristretto = {
        # "window/navigationbar/position" = left;
      }; # ristretto

      
      thunar-volman = { # 2023-07-29: MUST have leading slashes
        # FIXXME: this section is untested
        "/autobrowse/enabled" = true;
        # "/autoburn/audio-cd-command" = -a;
        # "/autoburn/data-cd-command" = -d;
        # "/autoburn/enabled" = false;
        # "/autoipod/enabled" = false;
        # "/autokeyboard/enabled" = false;
        "/automount-drives/enabled" = true;
        "/automount-media/enabled" = true;
        "/automouse/enabled" = false;
        "/autoopen/enabled" = false;
        "/autophoto/enabled" = false;
        # "/autoplay-audio-cds/command" = --device=%d;
        # "/autoplay-audio-cds/enabled" = true;
        # "/autoplay-video-cds/command" = --device=%d;
        # "/autoplay-video-cds/enabled" = true;
        # "/autoprinter/enabled" = false;
        "/autorun/enabled" = false;
        # "/autotablet/enabled" = false;
      }; # thunar-volman

      thunar = { # 2023-07-29: MUST have leading slashes
        # FIXXME: this section is untested
        # "/hidden-bookmarks" = <<UNSUPPORTED>>;
        # "/hidden-devices" = <<UNSUPPORTED>>;
        # "/last-details-view-column-order" = "THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_TYPE,THUNAR_COLUMN_DATE_ACCESSED,THUNAR_COLUMN_OWNER,THUNAR_COLUMN_PERMISSIONS,THUNAR_COLUMN_MIME_TYPE,THUNAR_COLUMN_GROUP";
        # "/last-details-view-column-widths" = "50,151,209,50,1083,50,50,81,1045,1074,50,50,50,1244";
        # "/last-details-view-fixed-columns" = true;
        # "/last-details-view-visible-columns" = "THUNAR_COLUMN_DATE_MODIFIED,THUNAR_COLUMN_NAME,THUNAR_COLUMN_SIZE,THUNAR_COLUMN_TYPE";
        # "/last-details-view-zoom-level" = "THUNAR_ZOOM_LEVEL_SMALLEST";
        # "/last-icon-view-zoom-level" = "THUNAR_ZOOM_LEVEL_NORMAL";
        # "/last-location-bar" = "ThunarLocationEntry";
        # "/last-separator-position" = 170;
        "/last-show-hidden" = true;
        # "/last-side-pane" = "ThunarShortcutsPane";
        # "/last-sort-column" = "THUNAR_COLUMN_DATE_MODIFIED";
        # "/last-sort-order" = "GTK_SORT_DESCENDING";
        # "/last-splitview-separator-position" = 1194;
        # "/last-view" = "ThunarDetailsView";
        # "/last-window-height" = 1384;
        # "/last-window-maximized" = true;
        # "/last-window-width" = 2560;
        "/misc-date-style" = "THUNAR_DATE_STYLE_ISO";
        "/misc-middle-click-in-tab" = false;
        "/misc-single-click" = false;
        "/misc-thumbnail-mode" = "THUNAR_THUMBNAIL_MODE_NEVER";
        "/misc-volume-management" = false;
      }; # thunar

      
      xfce4-settings-manager = {
        #"/last/window-height" = 1029;
        #"/last/window-width" = 734;
      }; # xfce4-settings-manager
    
    keyboards = { # 2023-07-29: MUST have leading slashes
        "/Default/Numlock" = false;
    }; # keyboards

    }; # xfconf.settings

    
    # files in ~/
    home.file.".themes/Adwaita-dark-Xfce".source = ../assets/.themes/Adwaita-dark-Xfce;

    # files in ~/.config/
    # 2023-08-06: following xfce panel plugins can't be configured via xfconf. Therefore, I just overwrite my personal settings via file:
    xdg.configFile."xfce4/panel/screenshooter-5.rc".source = ../assets/.config/xfce4/panel/screenshooter-x.rc;
    xdg.configFile."xfce4/panel/cpugraph-8.rc".source = ../assets/.config/xfce4/panel/cpugraph-x.rc;
    xdg.configFile."xfce4/panel/netload-10.rc".source = ../assets/.config/xfce4/panel/netload-x.rc;
    
}
