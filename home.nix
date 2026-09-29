{ inputs, pkgs, ... }:
{
  home.username = "damian";
  home.homeDirectory = "/home/damian";
  home.stateVersion = "25.11";
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    settings = {
      "$mod" = "SUPER";
      bind = [
       "$mod, Return, exec, kitty"
       "$mod, Q, killactive"
      ];
    };
  };
  
  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };
}
