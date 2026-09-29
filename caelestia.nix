{ pkgs, inputs, ... }:
{
  home-manager.users.damian = {
    imports = [
      inputs.caelestia-shell.homeManagerModules.default
    ];

    programs.caelestia = {
      enable = true;
      cli.enable = true;
    };
  };
}
