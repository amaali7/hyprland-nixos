# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7a2cecc8-994b-4d1a-8ece-d551bd6e8934";
    fsType = "ext4";
  };

  boot.initrd = {
    luks.devices."root" = {
      device = "/dev/disk/by-uuid/9e56ed11-d281-4439-9b9d-a99eba30c275";
      preLVM = true;
      allowDiscards = true;
    };
    luks.devices."nix-stor" = {
      device = "/dev/disk/by-uuid/17b41ea9-1038-479b-bdbc-147ed1940efe";
      keyFile = "/keyfile0.bin";
      allowDiscards = true;
    };
    secrets = {
      "keyfile0.bin" = "/etc/secrets/initrd/keyfile0.bin";
    };
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/d3ecbcd2-a11f-4330-b812-b95edcffc03c";
    fsType = "btrfs";
    options = ["subvol=nix-stor"];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-uuid/BD0C-B202";
    fsType = "vfat";
  };
  # my filesystems
  fileSystems."/windows" = {
    device = "/dev/disk/by-uuid/5CA8E333A8E309FA";
    fsType = "ntfs";
  };
  fileSystems."/home/ai3wm" = {
    device = "/dev/disk/by-uuid/d3ecbcd2-a11f-4330-b812-b95edcffc03c";
    fsType = "btrfs";
    options = ["subvol=home"];
  };
  swapDevices = [];

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  hardware.acpilight.enable = true;
  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
