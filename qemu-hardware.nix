{ config, lib, pkgs, ... }: {
  boot.loader.grub.device = "/dev/sda";

  fileSystems = {
    "/" = {
        device = "/dev/disk/by-label/nixos";
        fsType = "ext4";
    };
  };
}
