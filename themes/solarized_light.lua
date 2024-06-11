local M = {}

M.base_30 = {
  white = "#586e75",
  darker_black = "#fdf6e3",
  black = "#fdf6e3", -- nvim bg
  black2 = "#eee8d5",
  one_bg = "#e0d9c6", -- real bg of onedark
  one_bg2 = "#d1c8b8",
  one_bg3 = "#c3baaa",
  grey = "#b4ac9a",
  grey_fg = "#a6a08f",
  grey_fg2 = "#989281",
  light_grey = "#8a8573",
  red = "#dc322f",
  baby_pink = "#cb4b16",
  pink = "#d33682",
  line = "#d1c8b8", -- for lines like vertsplit
  green = "#859900",
  vibrant_green = "#859900",
  nord_blue = "#268bd2",
  blue = "#268bd2",
  yellow = "#b58900",
  sun = "#b58900",
  purple = "#6c71c4",
  dark_purple = "#6c71c4",
  teal = "#2aa198",
  orange = "#cb4b16",
  cyan = "#2aa198",
  statusline_bg = "#e0d9c6",
  lightbg = "#d1c8b8",
  pmenu_bg = "#268bd2",
  folder_bg = "#268bd2",
}

M.base_16 = {
  base00 = "#fdf6e3",
  base01 = "#eee8d5",
  base02 = "#e0d9c6",
  base03 = "#d1c8b8",
  base04 = "#c3baaa",
  base05 = "#586e75",
  base06 = "#073642",
  base07 = "#002b36",
  base08 = "#dc322f",
  base09 = "#cb4b16",
  base0A = "#b58900",
  base0B = "#859900",
  base0C = "#2aa198",
  base0D = "#268bd2",
  base0E = "#6c71c4",
  base0F = "#d33682",
}

M.type = "light" -- light or dark

M = require("base46").override_theme(M, "solarized_light")

return M
