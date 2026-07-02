{self, inputs, ...}: {
  flake.nixosModules.heliosHardware = { config, lib, pkgs, modulesPath, ... }:
  {
    imports =
      [ (modulesPath + "/installer/scan/not-detected.nix")
      ];
  
    boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];
  
    fileSystems."/" =
      { device = "/dev/disk/by-uuid/e93a2865-5f58-4457-8c12-7338f99452f1";
        fsType = "btrfs";
      };
  
    fileSystems."/home" =
      { device = "/dev/disk/by-uuid/e93a2865-5f58-4457-8c12-7338f99452f1";
        fsType = "btrfs";
        options = [ "subvol=home" ];
      };
  
    fileSystems."/nix" =
      { device = "/dev/disk/by-uuid/e93a2865-5f58-4457-8c12-7338f99452f1";
        fsType = "btrfs";
        options = [ "subvol=nix" ];
      };
  
    fileSystems."/boot" =
      { device = "/dev/disk/by-uuid/84EF-EFA9";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
  
    swapDevices = [ ];
  
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
