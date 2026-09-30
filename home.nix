{ config, inputs, pkgs, ... }:
{
  home.username = "damian";
  home.homeDirectory = "/home/damian";
  home.stateVersion = "25.11";
 
  xdg.configFile."hypr".source = 
    config.lib.file.mkOutOfStoreSymlink "/home/damian/nixos-config/hypr";
  
  programs.foot = {
  enable = true;
  settings = {
    main = {
      font = "JetBrainsMono Nerd Font:size=11";
      pad = "12x12";
    };
    "colors-dark" = {
      alpha = 0.85;
      background = "0f0a0c";
      foreground = "d6d2d4";
      regular0 = "1a1215"; bright0 = "4a3a40";
      regular1 = "c3143c"; bright1 = "e0385e";
      regular2 = "8a9a6e"; bright2 = "a6b88a";
      regular3 = "c9a26b"; bright3 = "e0bd8a";
      regular4 = "7a7f9a"; bright4 = "989db8";
      regular5 = "a8385a"; bright5 = "c95a7c";
      regular6 = "8a9ea0"; bright6 = "a8bcbe";
      regular7 = "b8b4b6"; bright7 = "e6e2e4";
    };
  };
};

  services.kanshi = {
  enable = true;
  systemdTarget = "graphical-session.target";
  settings = [
    {
      profile.name = "undocked";
      profile.outputs = [
        { criteria = "eDP-1"; status = "enable"; scale = 1.5; }
      ];
    }
    {
      profile.name = "docked";
      profile.outputs = [
        { criteria = "eDP-1"; status = "disable"; }
        {
          criteria = "AOC Q27G2WG4 0x000122AE";
          mode = "2560x1440@143.91Hz";
          position = "0,0";
        }
        {
          criteria = "AOC Q27G42XE 2S6S2HA003532";
          mode = "2560x1440@144.00Hz";
          position = "2560,0";
        }
        {
          criteria = "AOC Q27G2WG4 0x000009DD";
          mode = "2560x1440@143.91Hz";
          position = "5120,0";
        }
      ];
    }
  ];
};
 
  home.packages = with pkgs; [
    go gopls
    gcc gnumake
    clang-tools
    helix
  ];

  programs.obs-studio = {
    enable = true;
  };
 
  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };
}
