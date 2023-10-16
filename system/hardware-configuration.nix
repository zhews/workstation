{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    extraModulePackages = [ ];
    initrd = {
      availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
      luks.devices."cryptlvm".device = "/dev/disk/by-label/cryptlvm";
      kernelModules = [ "dm-snapshot" ];
    };
    kernelModules = [ "kvm-intel" ];
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  networking = {
    useDHCP = lib.mkDefault true;
    firewall = {
      trustedInterfaces = [ "podman+" ];
      interfaces."podman+".allowedUDPPorts = [ 53 ];
      allowedTCPPorts = [
        6443
      ];
    };
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  swapDevices = [
    { device = "/dev/disk/by-label/swap"; }
  ];
}
