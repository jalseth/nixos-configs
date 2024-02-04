{ pkgs, ... }: {
  # It yells without this.
  system.stateVersion = "23.11";

  # Specify the kernel version to latest LTS.
  boot.kernelPackages = pkgs.linuxPackages_6_6;

  # Common utilities I always want on the box.
  environment.systemPackages = with pkgs; [
    vim
    curl
    tmux
  ];

  # Use vim for invocations of $EDITOR.
  programs.vim.defaultEditor = true;

  # Servers should always use UTC.
  time.timeZone = "Etc/UTC";

  # Enable and configure sshd.
  services.openssh.enable = true;
  services.openssh.settings.PermitRootLogin = "no";
  services.openssh.settings.PasswordAuthentication = false;
  services.openssh.settings.KexAlgorithms = [
    "sntrup761x25519-sha512@openssh.com"
    "curve25519-sha256"
    "curve25519-sha256@libssh.org"
  ];
  services.openssh.settings.Macs = [
    "hmac-sha2-256-etm@openssh.com"
    "hmac-sha2-512-etm@openssh.com"
  ];
  services.openssh.settings.Ciphers = [
    "chacha20-poly1305@openssh.com"
    "aes256-gcm@openssh.com"
  ];

  # Set up user for SSH access.
  security.sudo.wheelNeedsPassword = false;
  users.users.james = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBIm4ZXpx8NbI+sS51XrtPRfkA43v5Hi3/B+ArE9Ti/WBF3u66E7jUKvlcWnuIQUZK5NFLKTW47b4MNZjXstwTms= yk5cnfc-fido"
    ];
  };

  # Allow wheel to manage NixOS.
  nix.settings.trusted-users = [
    "root"
    "@wheel"
  ];

  # Configure nftables firewall.
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 22 ]; # SSH only
    allowedUDPPorts = [];
  };
}
