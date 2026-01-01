{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.neversad = {
    initialHashedPassword = "$6$3ZAGUFpQ8vTUnVZj$FX9xXkq.VdDiURknPXP/NfulIMVe0sh/9COOrLY/RjpLtfjIzidGFbwZHZzWzv5kfeoLV89vjPkZjgU5LYUOr.";
    isNormalUser = true;
    description = "neversad";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEGT4wDVwwRefziU8NxEKI1c+7tqMZM7afXsyvN3kJPp o.novosad.reg@gmail.com"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.neversad = 
    import ../../../home/neversad/${config.networking.hostName}.nix;
}
