# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:
  
{
  imports =
    [
      ./hardware-configuration.nix
      # ./system/intel.nix
      ./system/nvidia.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos"; # Define your hostname
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Enable networking
    networkmanager.enable = true;
  };
  
  
  # Enable nixos flakes experimental feature
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };
  

  services = {
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${pkgs.hyprland}/bin/Hyprland";
          user = "greeter";
        };
      };
    };
    xserver = {
      # Enable the X11 windowing system
      enable = true;
      # Disable xterm bs
      excludePackages = [ pkgs.xterm ];
      desktopManager.xterm.enable = false; 
      
      displayManager.gdm = {
        # enable = true;
        # Enable the wayland Desktop Environment.
        wayland= true;
      };
      
      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "symbolic";
      };
    };

    pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      
      alsa = {
        enable = true;
        support32Bit = true;
      };

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
    };

    # Enable CUPS to print documents.
    # printing.enable = true;
    blueman.enable = true;
  };


  xdg.portal = { enable = true; extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];  };

  security = {
    # Enable sound with pipewire.
    rtkit.enable = true;
    polkit.enable = true;
  };

  programs = {
    firefox.enable = true;
    nix-ld.enable = true;
    zsh.enable = true;
    fish.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tijs = {
    isNormalUser = true;
    description = "Tijs";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # Apps
      brave
      google-chrome
      vesktop
    ];
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware = {
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  # Workaround until this hits unstable:
  # https://github.com/NixOS/nixpkgs/issues/113628
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd -f /etc/bluetooth/main.conf"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  fonts.packages = [
    pkgs.nerdfonts
    pkgs.jetbrains-mono
    pkgs.font-awesome
    pkgs.siji
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
	    git
  
      # shells
      zsh
      fish

      # Clipboard tools
      wl-clipboard
      cliphist

      xdragon
      
      # Code editors
      vim neovim
      # Home manager
      home-manager
      
      wget
      lf
      jq

      # Gaming
      steam

      # Image editor
      satty

      hypridle
      hyprlock
      libnotify
      go
      bat

      wireguard-tools
    ];

    shells = with pkgs; [ zsh fish ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
