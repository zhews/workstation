{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment.systemPackages = with pkgs; [
    home-manager
    k3s
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    zsh.enable = true;
  };

  security.pam.services.swaylock = { };

  services = {
    auto-cpufreq.enable = true;
    fwupd.enable = true;
    k3s = {
      enable = true;
      role = "server";
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    thermald.enable = true;
    xserver.layout = "eu";
  };

  system.stateVersion = "23.05";

  sound.enable = true;

  time.timeZone = "Europe/Zurich";

  users = {
    defaultUserShell = pkgs.zsh;
    extraGroups.vboxusers.members = [ "zhews" ];
    users."zhews" = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];
      initialPassword = "nixos";
    };
  };

  virtualisation = {
    podman = {
      defaultNetwork.settings.dns_enabled = true;
      enable = true;
    };
    virtualbox = {
      host.enable = true;
    };
  };
}
