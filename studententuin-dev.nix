# System-level module for Studententuin development.
# Import it in your flake's nixosConfigurations, e.g. modules = [ ./modules/studententuin-dev.nix ];
# Everything project-specific (Go, linters, scanners) lives in the repo's flake devShell instead.
{ config, pkgs, lib, ... }:

let
  user = "damian"; # change to your username
in
{
  # Docker with gVisor registered as an extra runtime:
  #   docker run --rm --runtime=runsc hello-world
  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      features.buildkit = true;
      runtimes.runsc.path = "${pkgs.gvisor}/bin/runsc";
    };
  };

  # Standalone containerd for the node agent you write against the containerd Go client.
  # The gvisor package ships containerd-shim-runsc-v1; putting it on containerd's PATH
  # lets your node agent use the runtime name "io.containerd.runsc.v1".
  virtualisation.containerd.enable = true;
  systemd.services.containerd.path = [ pkgs.gvisor ];

  # KVM and libvirt: for testing cloud-init VPS templates locally and trying Kata or Firecracker later.
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Reach the alpha VMs and servers without opening ports.
  services.tailscale.enable = true;

  # Loads the repo's devShell automatically when you cd into the repo.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  users.users.${user} = {
    # Note: the docker group is effectively root on this machine.
    extraGroups = [ "docker" "kvm" "libvirtd" ];
    # Sub-UIDs/GIDs for rootless BuildKit and rootless containers.
    autoSubUidGidRange = true;
  };

  environment.systemPackages = with pkgs; [
    git
    gh
    obsidian # unfree: needs allowUnfree (or an allowUnfreePredicate) in your nixpkgs config
  ];

  # Let containers reach services on the host during development.
  networking.firewall.trustedInterfaces = [ "docker0" ];
}
