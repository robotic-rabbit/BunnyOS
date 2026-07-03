{ self, inputs, ... }: {

  flake.nixosModules.helios = {configs, pkgs, ...}:{
    imports = [
      self.nixosModules.heliosHardware
      self.nixosModules.commonPackages
      # self.nixosModules.niri
      inputs.home-manager.nixosModules.home-manager
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.configurationLimit = 4; 
    boot.loader.efi.canTouchEfiVariables = true;
  
    networking.hostName = "burrow"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  
    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  
    # Enable networking
    networking.networkmanager.enable = true;

    # Tailscale (Remote Access)
    services.tailscale.enable = true;
  
    # Enable SSH 
    services.openssh.enable = true;

  
    # Set your time zone.
    time.timeZone = "Australia/Sydney";
  
    # Select internationalisation properties.
    i18n.defaultLocale = "en_AU.UTF-8";
  
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_AU.UTF-8";
      LC_IDENTIFICATION = "en_AU.UTF-8";
      LC_MEASUREMENT = "en_AU.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_AU.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  
    # Enable the X11 windowing system. apparently need this even with wayland
    services.xserver.enable = true;
  
    # Enable the GNOME Desktop Environment.
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;

    # Enable Niri tiling window manager
    programs.niri.enable = true;

    # adding home manager
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.bunny = self.homeManagerModules.bunny;
    };
  
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  
    # Enable CUPS to print documents.
    services.printing.enable = true;
  
    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;
  
      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;
  
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."bunny" = {
      isNormalUser = true;
      description = "bunny";
      extraGroups = [ "networkmanager" "wheel" ];
      packages = with pkgs; [
      ];
    };
  
    # Install firefox.
    programs.firefox.enable = true;
  
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
  
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
    ];

    # services.tlp = {
      # enable = true;
      # settings = {
        # CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        # CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        # CPU_BOOST_ON_AC = 0;
        # CPU_BOOST_ON_BAT = 0;
      # };
    # };

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
    system.stateVersion = "26.05"; # Did you read the comment?
  };
}
