# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      <home-manager/nixos>
    ];


  # Home-Manager
  home-manager.users.anirudh = import ./home.nix;

  # Use the GRUB EFI boot loader.
   boot.loader.systemd-boot.enable = false;
   boot.loader.efi.canTouchEfiVariables = true;
   boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
    gfxmodeEfi = "1600x900";
  };
 
  networking.hostName = "nixos-btw"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
    time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
    services.xserver.enable = false;

  # Hyprland Wayland Compositor
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

  # Display Manager
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        (import ./derivations/sddm-astronaut-unstable.nix { inherit pkgs lib stdenvNoCC; embeddedTheme = "black_hole"; })	
	kdePackages.qt5compat
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
        ];
      theme = "sddm-astronaut-theme";
    };

   # Remove old rebuilds
    nix.gc = {
     automatic = true;            # enable the GarbageCollection service
     dates     = "daily";         # run every day (see systemd.time formats)
     options   = "--delete-older-than 7d";  # remove store paths older than 7 days
    };

  # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

  # Fish shell
    programs.fish.enable = true;
    users.defaultUserShell = pkgs.fish; # set the fish shell as default

  # Bluetooth Configuration
    hardware.bluetooth.enable = true;
    services.blueman.enable = true; # For GUI management
    systemd.services.bluetooth.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
     hardware.pulseaudio.enable = false;
     services.pipewire = {
       enable = true;
       alsa.enable = true;
       alsa.support32Bit = true;
       pulse.enable = true;
       jack.enable = true;
    }; 

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.anirudh = {
      isNormalUser = true;
      extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [
        tree
      ];
    };
   
  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
      neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      ghostty
      waybar
      nautilus
      hyprpaper
      xarchiver
      gcc
      wl-clipboard
      wofi
      wget
      flatpak
      git
      cava
      pipes
      fastfetch
      btop
      fish
      vesktop
      spotify
      spicetify-cli
      starship
      obsidian
      hypridle
      hyprlock
      cmatrix
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      pavucontrol
      playerctl
      swappy
      hyprshot
      hyprpolkitagent
      swaynotificationcenter
      libnotify
      glib
      dconf
      yazi
      wlogout
      google-chrome
      (import ./derivations/sddm-astronaut-unstable.nix { inherit pkgs lib stdenvNoCC; embeddedTheme = "black_hole"; })
    ];

  # Font Configuration
    fonts.packages = with pkgs; [ nerdfonts ]; 

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
    services.flatpak.enable = true;


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

