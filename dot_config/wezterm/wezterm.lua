-- Generated by Home Manager.
-- See https://wezfurlong.org/wezterm/

-- Add config folder to watchlist for config reloads.
local wezterm = require 'wezterm';
wezterm.add_to_config_reload_watch_list(wezterm.config_dir)

local act = wezterm.action
local wezterm = require 'wezterm'

wezterm.on('update-right-status', function(window, pane)
        local time = wezterm.strftime '%H:%M '
        local date = wezterm.strftime '%a %b %-d'
        window:set_right_status(wezterm.format {
            { Foreground = { Color = '#7E97AB' } },
            { Text = '  ' .. date },
            { Text = '  ' .. time },
            })
        end)

local keybinds = {
  { key="UpArrow", mods="SHIFT|CTRL", action= act.ScrollByPage(0.5) },
  { key="DownArrow", mods="SHIFT|CTRL", action= act.ScrollByPage(-0.5) },
  { key="c", mods="SHIFT|CTRL", action= act.CopyTo 'ClipboardAndPrimarySelection'},
  { key="v", mods="SHIFT|CTRL", action= act.PasteFrom 'Clipboard' },
  { key="_", mods="SHIFT|CTRL", action= act.DecreaseFontSize },
  { key="+", mods="SHIFT|CTRL", action= act.IncreaseFontSize },
  { key="Backspace", mods="SHIFT|CTRL", action= act.ResetFontSize },
  { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
  { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
  { key="LeftArrow", mods="SHIFT|CTRL", action= act.ActivateTabRelative(-1) },
  { key="RightArrow", mods="SHIFT|CTRL", action= act.ActivateTabRelative(1) },
  { key="d", mods="SHIFT|CTRL", action= act.CloseCurrentTab { confirm = true }, },
  { key="t", mods="SHIFT|CTRL", action= act.SpawnTab 'CurrentPaneDomain' },
  { key="w", mods="SHIFT|CTRL", action= act.SpawnWindow },
  { key = 'L', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },
}

for i = 1, 9 do
  table.insert(keybinds, {
    key = tostring(i),
    mods = 'SHIFT|CTRL',
    action = act.ActivateTab(i - 1),
  })
end

return {
  font = wezterm.font_with_fallback({
      {
          family = "JetBrainsMono NF",
          -- harfbuzz_features = { "cv06" , "cv07" }
      },
  }),
  font_rules = {
    {
      intensity = 'Bold',
      italic = false,
      font = wezterm.font("JetBrainsMono NF", {weight="Bold", stretch="Normal", style="Normal"})
    },
    {
      intensity = 'Bold',
      italic = true,
      font = wezterm.font("JetBrainsMono NF", {weight="Bold", stretch="Normal", style="Italic"})
    },
    {
      intensity = 'Normal',
      italic = false,
      font = wezterm.font("JetBrainsMono NF", {weight="Regular", stretch="Normal", style="Normal"}),
    },
    {
      intensity = 'Normal',
      italic = true,
      font = wezterm.font("JetBrainsMono NF", {weight="Regular", stretch="Normal", style="Italic"}),
    },
  },
  foreground_text_hsb = {
    hue = 1.0,
    saturation = 1.0,
    brightness = 1.0,
  },
  font_size = 10,
  underline_position = '125%',
  use_fancy_tab_bar = false,
  freetype_load_target = "Normal",
  freetype_load_flags = "DEFAULT",
  adjust_window_size_when_changing_font_size = false,
  color_scheme = "custom",
  colors = {
      compose_cursor = '#FFA557',
  },
  check_for_updates = false,
  hide_tab_bar_if_only_one_tab = true,
  disable_default_key_bindings = true,
  enable_scroll_bar = true,
  keys = keybinds,
  warn_about_missing_glyphs = false,
}


