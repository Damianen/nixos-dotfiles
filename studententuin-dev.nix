{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "damian";
in
{
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      features.buildkit = true;
      runtimes.runsc.path = "${pkgs.gvisor}/bin/runsc";
    };
  };

  virtualisation.containerd.enable = true;
  systemd.services.containerd.path = [ pkgs.gvisor ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  services.tailscale.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  users.users.${user} = {
    extraGroups = [
      "docker"
      "kvm"
      "libvirtd"
    ];
    autoSubUidGidRange = true;
  };

  environment.systemPackages = with pkgs; [
    obsidian # unfree: needs allowUnfree (or an allowUnfreePredicate) in your nixpkgs config
  ];

  networking.firewall.trustedInterfaces = [ "docker0" ];
}
