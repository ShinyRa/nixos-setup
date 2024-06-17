{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "tijs";
    homeDirectory = "/home/tijs";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      vscodium
      btop
      fastfetch
      bibata-cursors
      wgnord
      
      # Visual desktop packages
      (waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        })
      )

      dunst
      
      fzf
      zoxide

      # Background image daemon
      swww

      # Terminal wrapper
      foot

      # Search bar
      rofi-wayland
      
      # screenshot service
      grim
      slurp
      
      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    file = {
      # Hyprland config
      ".config/hypr/hyprland.conf".source = ../config/hypr/hyprland.conf;
      ".config/hypr/hypridle.conf".source = ../config/hypr/hypridle.conf;
      ".config/hypr/hyprlock.conf".source = ../config/hypr/hyprlock.conf;
      
      # Waybar config
      ".config/waybar/config.jsonc".source = ../config/waybar/config.jsonc;
      ".config/waybar/style.css".source = ../config/waybar/style.css;

      # Btop config
      ".config/btop/btop.conf".source = ../config/btop/btop.conf;
      
      # Foot config
      ".config/foot/foot.ini".source = ../config/foot/foot.ini;
      
      # Zsh config
      ".zshrc".source = ../config/zsh/.zshrc;
      # Git config
      ".config/git/config".source = ../config/git/config;

      # Powerlevel10k config
      ".p10k.zsh".source = ../config/p10k/.p10k.zsh;

      # Dunst notification config
      ".config/dunst/dunstrc".source = ../config/dunst/dunstrc;

      # Rofi config
      ".config/rofi/config.rasi".source = ../config/rofi/config.rasi;

      # Set custom wallpaper
      ".config/swww/wallpaper.jpg".source = ../config/swww/wallpaper.jpg;
    };

      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
    #
    # or
    #
    #  /etc/profiles/per-user/tijs/etc/profile.d/hm-session-vars.sh
    #
    sessionVariables = {
      # EDITOR = "emacs";
    };
  };
  
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
    };
    home-manager = {
      enable = true;
    };
  };
}
