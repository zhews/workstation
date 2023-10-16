{ pkgs, ... }:

{
  home = {
    homeDirectory = "/home/zhews";
    packages = with pkgs; [
      # Fonts
      font-awesome
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "Noto" ]; })
      # Packages
      air
      aircrack-ng
      alacritty
      android-studio
      ansible
      black
      brightnessctl
      cargo
      cargo-watch
      calibre
      cliphist
      fd
      firefox
      fzf
      gcc
      gnumake
      go
      golangci-lint
      gopass
      gopls
      gradle
      grim
      hyprpaper
      imv
      jdk
      john
      jq
      killall
      kotlin
      kotlin-language-server
      libreoffice
      librewolf
      ltex-ls
      lua
      lua-language-server
      metasploit
      mpv
      nb
      nil
      nixpkgs-fmt
      nmap
      nodejs_20
      obs-studio
      opentofu
      pandoc
      podman-compose
      prettierd
      pulsemixer
      python311
      python311Packages.python-lsp-server
      radare2
      ripgrep
      rustc
      rustfmt
      rust-analyzer
      slurp
      signal-desktop
      swayidle
      swaylock
      taskwarrior
      terraform-ls
      timewarrior
      tmux
      typst
      volatility3
      waybar
      wireshark
      wlogout
      wl-clipboard
      wofi
      xplr
      yara
      zap
      zathura
      zip
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      EDITOR = "nvim";
    };
    stateVersion = "23.11";
    username = "zhews";
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    git = {
      enable = true;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
      };
      userEmail = "118117386+zhews@users.noreply.github.com";
      userName = "zhews";
    };
    home-manager.enable = true;
    neovim.enable = true;
    zsh = {
      enable = true;
      shellAliases = {
        "la" = "ls -alh";
        "v" = "nvim";
        "g" = "git";
        "k" = "kubectl";
      };
    };
  };

  services = {
    mako = {
      backgroundColor = "#613681";
      borderColor = "#ec4678";
      defaultTimeout = 3000;
      enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mainMod" = "SUPER";
      animations = {
        animation = [
          "windows, 1, 7, default"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
        enabled = "yes";
      };
      bind = [
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, C, killactive,"
        "$mainMod, E, exec, ${pkgs.alacritty}/bin/alacritty --command ${pkgs.xplr}/bin/xplr"
        "$mainMod, H, movefocus, l"
        "$mainMod, J, movefocus, d"
        "$mainMod, K, movefocus, u"
        "$mainMod, L, movefocus, r"
        "$mainMod, M, exec, ${pkgs.wlogout}/bin/wlogout"
        "$mainMod, P, pseudo,"
        "$mainMod, Q, exec, ${pkgs.alacritty}/bin/alacritty"
        "$mainMod, R, exec, ${pkgs.wofi}/bin/wofi --show drun"
        "$mainMod, S, togglesplit,"
        "$mainMod ALT, J, changegroupactive, f"
        "$mainMod ALT, K, changegroupactive, b"
        "$mainMod, V, togglefloating,"
        "$mainMod, Y, togglegroup,"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod, F, exec, ${pkgs.cliphist}/bin/cliphist list | ${pkgs.wofi}/bin/wofi --show dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy"
        "$mainMod SHIFT, L, exec, ${pkgs.swaylock}/bin/swaylock -f"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        ", Print, exec, ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g - - | ${pkgs.wl-clipboard}/bin/wl-copy"
        ", XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      binde = [
        ", XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume	@DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
        ", XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      decoration = {
        blur = {
          enabled = "true";
          passes = "1";
          size = "3";
        };
        drop_shadow = "yes";
        "col.shadow" = "rgba(1a1a1aee)";
        rounding = "10";
        shadow_range = "4";
        shadow_render_power = "3";
      };
      dwindle = {
        preserve_split = "yes";
        pseudotile = "yes";
      };
      env = "XCURSOR_SIZE,24";
      exec-once = [
        "${pkgs.wl-clipboard}/bin/wl-paste --watch ${pkgs.cliphist}/bin/cliphist store"
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "${pkgs.waybar}/bin/waybar"
        "${pkgs.swayidle}/bin/swayidle -w timeout 180 'swaylock -f' timeout 300 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on' timeout 900 'systemctl suspend' before-sleep 'swaylock -f' timeout 1200 'systemctl hibernate'"
      ];
      general = {
        border_size = "2";
        "col.active_border" = "rgba(613681ee) rgba(ec4678ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        gaps_in = "5";
        gaps_out = "20";
      };
      gestures = {
        workspace_swipe = "on";
      };
      input = {
        follow_mouse = "1";
        kb_layout = "eu";
        sensitivity = "0";
        touchpad.natural_scroll = "no";
      };
      master = {
        new_is_master = "true";
      };
      misc = {
        disable_hyprland_logo = "true";
      };
      monitor = "eDP-1,preferred,auto,auto";
    };
    xwayland.enable = true;
  };

  xdg.configFile = {
    "alacritty" = {
      enable = true;
      recursive = true;
      source = ../config/alacritty;
    };
    "hypr" = {
      enable = true;
      recursive = true;
      source = ../config/hypr;
    };
    "nvim" = {
      enable = true;
      recursive = true;
      source = ../config/nvim;
    };
    "swaylock" = {
      enable = true;
      recursive = true;
      source = ../config/swaylock;
    };
    "tmux" = {
      enable = true;
      recursive = true;
      source = ../config/tmux;
    };
    "waybar" = {
      enable = true;
      recursive = true;
      source = ../config/waybar;
    };
  };
}
