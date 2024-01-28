{ ... }: {
  imports = [
    ./min_image.nix
  ];

  networking.hostName = "k3s-leader";
}
