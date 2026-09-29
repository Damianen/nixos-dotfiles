-- ~/nixos-config/hypr/hyprland.lua
-- palette pulled from the wallpaper: crimson light on near-black, dark themed

local c = {
  crimson = "rgba(c3143cee)",
  wine    = "rgba(5c1022aa)",
  shadow  = "rgba(0a0507ee)",
}

local mainMod  = "SUPER"
local terminal = "uwsm app -- foot"
local browser  = "uwsm app -- firefox"

---- LOOK AND FEEL ----
hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 14,
    border_size = 2,
    layout = "dwindle",
    col = {
      active_border = c.crimson,
      inactive_border = c.wine,
    },
  },

  decoration = {
    rounding = 10,
    active_opacity = 1.0,
    inactive_opacity = 0.92,
    blur = {
      enabled = true,
      size = 6,
      passes = 3,
      vibrancy = 0.2,
    },
    shadow = {
      enabled = true,
      range = 18,
      render_power = 3,
      color = c.shadow,
    },
  },

  dwindle = {
    preserve_split = true,
  },

  input = {
    kb_layout = "us",
    follow_mouse = 1,
    touchpad = {
      natural_scroll = true,
    },
  },

  misc = {
    force_default_wallpaper = 0,  -- caelestia draws the wallpaper
    disable_hyprland_logo = true,
  },
})

---- ANIMATIONS ----
hl.curve("snap",   { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
hl.curve("linear", { type = "bezier", points = { {0, 0}, {1, 1} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 5, bezier = "snap",   style = "popin 85%" })
hl.animation({ leaf = "fade",       enabled = true, speed = 4, bezier = "snap" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "snap",   style = "slidefade 15%" })
hl.animation({ leaf = "border",     enabled = true, speed = 8, bezier = "linear" })

---- KEYBINDS ----
hl.bind(mainMod .. " + Return",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B",         hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("uwsm stop"))  -- log out (don't use exit under uwsm)

---- AUTOSTART ----
-- only uncomment if programs.caelestia.systemd.enable = false in home-manager
-- hl.on("hyprland.start", function()
--   hl.exec_cmd("caelestia shell -d")
-- end)
