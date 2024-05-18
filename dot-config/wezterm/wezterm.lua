local wezterm = require("wezterm")
local act = wezterm.action

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

--settings

-- local font_family = "FiraMono Nerd Font"
local font_family = "MonoLisa"
local font_size = 15

-- to set color scheme based on system settings
config.color_scheme = "catppuccin-macchiato"
config.default_workspace = "MAIN"
config.enable_kitty_keyboard = false
config.enable_tab_bar = true
config.font = wezterm.font({
  family = font_family,
  harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})
config.font_size = font_size
config.hide_tab_bar_if_only_one_tab = false
config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.4,
}
config.native_macos_fullscreen_mode = true
config.send_composed_key_when_left_alt_is_pressed = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 64
-- config.use_fancy_tab_bar = false
config.window_close_confirmation = "AlwaysPrompt"
config.window_decorations = "RESIZE"
config.window_frame = {
  font = wezterm.font({
    family = font_family,
  }),
  font_size = font_size,
  active_titlebar_bg = "none",
  inactive_titlebar_bg = "none",
}
config.colors = {
  tab_bar = {
    background = "none",
    inactive_tab_edge = "none",
    active_tab = {
      bg_color = "#89b4fa",
      fg_color = "#212536",
    },
    inactive_tab = {
      bg_color = "#313244",
      fg_color = "#89b4fa",
    },
  },
}
config.window_padding = {
  left = "1cell",
  right = "1cell",
  top = "0.5cell",
  bottom = "0.5cell",
}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
  -- Repeat leader to send CTRL-A
  { key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
  { key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },

  -- Backwards and forwards word with alt-arrow
  { key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
  { key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },

  -- Panes
  { key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
  { key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
  { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
  { key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },

  -- Tabs
  { key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
  { key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
  { key = "n", mods = "LEADER", action = act.ShowTabNavigator },

  -- Reload config
  {
    key = "r",
    mods = "CMD|SHIFT",
    action = act.ReloadConfiguration,
  },
}

wezterm.on("update-status", function(window, _)
  local date = wezterm.strftime("%H:%M ")

  -- Workspace name
  local stat = window:active_workspace()
  local stat_color = "#89b4fa"
  local left_stat_color = stat_color
  -- It's a little silly to have workspace name all the time
  -- Utilize this to display LDR or current key table name
  if window:active_key_table() then
    stat = window:active_key_table()
    left_stat_color = "#7dcfff"
  end
  if window:leader_is_active() then
    stat = "LDR"
    left_stat_color = "#a6e3a1"
  end

  window:set_left_status(wezterm.format({
    { Foreground = { Color = left_stat_color } },
    { Text = " " .. wezterm.nerdfonts.cod_workspace_trusted .. " " .. stat .. " " },
    "ResetAttributes",
  }))

  window:set_right_status(wezterm.format({
    { Foreground = { Color = stat_color } },
    { Text = " " .. wezterm.nerdfonts.fa_clock_o .. " " .. date .. " " },
  }))
end)

return config
