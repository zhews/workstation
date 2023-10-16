{ pkgs, ... }:

{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  environment = {
    systemPackages = with pkgs; [
      home-manager
      k3s
    ];
    etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        		bluez_monitor.properties = {
        			["bluez5.enable-sbc-xq"] = true,
        			["bluez5.enable-msbc"] = true,
        			["bluez5.enable-hw-volume"] = true,
        			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        		}
        	'';
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      ethernet.macAddress = "random";
      insertNameservers = [
        "9.9.9.9"
        "149.112.112.112"
        "2620::fe::fe"
        "2620::fe::9"
      ];
      wifi.macAddress = "random";
    };
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
