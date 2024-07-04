# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  boot.initrd.kernelModules = [ "amdgpu"];

  # TODO hacer que cambie según la gráfica  nvidia driver setup 
#  hardware.opengl.enable = true;
 # services.xserver.videoDrivers = [ "nvidia" ];
 # hardware.nvidia = {
 #   modesetting.enable = true;
 #   powerManagement.enable = false;
 #   powerManagement.finegrained = false;
 #   open = false;
 #   nvidiaSettings = true;
 #   package = config.boot.kernelPackages.nvidiaPackages.stable;
 # };
 # hardware.nvidia.prime = { 
 #   offload = {
 #     enable = true;
 #     enableOffloadCmd = true;
 #   };
 #   nvidiaBusId =  "PCI:0:1:0";
 #   intelBusId =  "PCI:0:0:2";
 # };
    

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Madrid";
  
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the gpu driver
  services.xserver.videoDrivers = ["amdgpu"];


  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the Bluetooth service
  hardware.bluetooth = {
    enable = true;
    settings = {
      "General" = {
        "AutoEnable" = "true";
      };
    };
  };

  # Ensure PulseAudio is configured to handle Bluetooth audio
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
    extraConfig = ''
      # Load Bluetooth modules
      load-module module-bluetooth-discover
      load-module module-bluetooth-policy
    '';
  };

  # Optional: Enable the Bluetooth applet for easier management
  services.blueman = {
    enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable zsh as default promt
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hernies = {
    isNormalUser = true;
    description = "hernies";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      google-chrome
      obsidian
      discord
      vscode
      spotify
      git
      popcorntime
      vlc
    ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    home-manager
    bluez
    blueman
    pulseaudio
    git
    lshw
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
