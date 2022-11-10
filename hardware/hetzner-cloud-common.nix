{ modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  boot.loader.grub.device = "/dev/sda";
  boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "xen_blkfront" "vmw_pvscsi" ];
  boot.initrd.kernelModules = [ "nvme" ];
  fileSystems."/" = { device = "/dev/sda1"; fsType = "ext4"; };

  boot.cleanTmpDir = true;
  zramSwap.enable = true;

  networking = {
    hostName = "hetzner-cloud-common";

    interfaces.ens3.ipv6.addresses = [{
      address = "2a01:4ff:f0:bb04::/64";
      prefixLength = 64;
    }];
    defaultGateway6 = {
      address = "fe80::1";
      interface = "ens3";
    };
  };
}
