-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
-- Modified from: https://github.com/nvim-lualine/lualine.nvim/blob/f4ab5b56dae695657cb15ae69e938038c0acfa62/examples/evil_lualine.lua
-- TODO: Handle if vim.o.background == "dark", like https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua
local lualine = require 'lualine'
local hsluv = require('lush').hsluv

-- Color table for highlights
-- stylua: ignore
local colors = {
  bg        = '#202328',
  fg        = '#bbc2cf',
  yellow    = '#ECBE7B',
  cyan      = '#008080',
  green     = '#98be65',
  orange    = '#FF8800',
  violet    = '#a9a1e1',
  magenta   = '#c678dd',
  blue      = '#51afef',
  red       = '#ec5f67',
  text      = '#ffffff',
}

-- from https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/util.lua#L55
local function invertColor(color)
  if color ~= "NONE" then
    local hsl = hsluv(color)
    hsl.l = 100 - hsl.l
    if hsl.l < 40 then
      hsl.l = hsl.l + (100 - hsl.l) * 0.3
    end
    return hsl.hex
  end
  return color
end

local function color(hexColor, dimmed)
  if vim.o.background == "dark" then
    if dimmed == true then
      return hsluv(hexColor).darken(65).hex
    else
      return hexColor
    end
  else
    local invHexColor = invertColor(hexColor)
    if dimmed == true then
      return hsluv(invHexColor).lighten(65).hex
    else
      return invHexColor
    end
  end
end

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand '%:t') ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand '%:p:h'
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = color(colors.fg), bg = color(colors.bg) } },
      inactive = { c = { fg = color(colors.fg), bg = color(colors.bg) } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  extensions = {
    'nvim-tree',
    'quickfix',
    --{ filetypes = { 'Trouble' } },
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component, inactive_component)
  table.insert(config.sections.lualine_c, component)
  table.insert(
    config.inactive_sections.lualine_c,
    vim.tbl_deep_extend("force", {}, component, inactive_component or {})
  )
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component, inactive_component)
  table.insert(config.sections.lualine_x, component)
  table.insert(
    config.inactive_sections.lualine_x,
    vim.tbl_deep_extend("force", {}, component, inactive_component or {})
  )
end

ins_left(
  {
    function()
      return '▊'
    end,
    color = { fg = color(colors.blue) }, -- Sets highlighting of component
    padding = { left = 0, right = 1 }, -- We don't need space before this
  },
  {
    color = { fg = color(colors.blue, true) },
  }
)

ins_left {
  -- mode component
  function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    vim.api.nvim_command('hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. ' guibg=' .. colors.bg)
    return ''
  end,
  color = 'LualineMode',
  padding = { right = 1 },
}

ins_left(
  {
    -- Lsp server name .
    function()
      local msg = 'No Lsp'
      local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
      local clients = vim.lsp.get_active_clients()
      if next(clients) == nil then
        return msg
      end
      for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
          return client.name
        end
      end
      return msg
    end,
    icon = ' ',
    color = { fg = color(colors.text) },
  },
  {
    color = { fg = color(colors.text, true) },
  }
)

ins_left(
  {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
      color_error = { fg = color(colors.green) },
      color_warn = { fg = color(colors.yellow) },
      color_info = { fg = color(colors.green) },
    },
  },
  {
    diagnostics_color = {
      color_error = { fg = color(colors.red, true) },
      color_warn = { fg = color(colors.yellow, true) },
      color_info = { fg = color(colors.cyan, true) },
    },
  }
)

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left(
  {
    'filetype',
    colored = true,
    icon_only = true,
    cond = conditions.buffer_not_empty,
    color = { fg = color(colors.magenta), gui = 'bold' },
  },
  {
    color = { fg = color(colors.magenta, true), gui = 'bold' },
  }
)


ins_left(
  {
    'filename',
    path = 1,
    cond = conditions.buffer_not_empty,
    color = { fg = color(colors.magenta), gui = 'bold' },
  },
  {
    color = { fg = color(colors.magenta, true), gui = 'bold' },
  }
)

-- Add components to right sections
ins_right(
  {
    'fileformat',
    fmt = string.upper,
    color = { fg = color(colors.green), gui = 'bold' },
  },
  {
    color = { fg = color(colors.green, true), gui = 'bold' },
  }
)

ins_right(
  {
    'location',
    color = { fg = color(colors.text) },
  },
  {
    color = { fg = color(colors.text, true) },
  }
)

ins_right(
  {
    'branch',
    icon = '',
    color = { fg = color(colors.violet), gui = 'bold' },
  },
  {
    color = { fg = color(colors.violet, true), gui = 'bold' },
  }
)

ins_right(
  {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = { added = ' ', modified = '柳 ', removed = ' ' },
    diff_color = {
      added = { fg = color(colors.green) },
      modified = { fg = color(colors.orange) },
      removed = { fg = color(colors.red) },
    },
    cond = conditions.hide_in_width,
  },
  {
    diff_color = {
      added = { fg = color(colors.green, true) },
      modified = { fg = color(colors.orange, true) },
      removed = { fg = color(colors.red, true) },
    },
  }
)

ins_right(
  {
    function()
      return '▊'
    end,
    color = { fg = color(colors.blue) },
    padding = { left = 1 },
  },
  {
    color = { fg = color(colors.blue, true) },
  }
)

-- Now don't forget to initialize lualine
lualine.setup(config)
