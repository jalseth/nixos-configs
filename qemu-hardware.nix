{
  boot.growPartition = true;
  boot.loader.grub.device = "/dev/vda";
  boot.initrd.kernelModules = [
    "ext4"
    "virtio"
    "virtio_blk"
    "virtio_pci"
  ];

  fileSystems."/" = {
    device = "/dev/vda1";
    autoResize = true;
    fsType = "ext4";
  };
}
