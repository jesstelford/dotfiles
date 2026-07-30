-- arthur.lua -- Neovim colorscheme derived from Ghostty's built-in Arthur theme.
--
-- Not a port of thenewvu/vim-colors-arthur, which shares the name and the
-- #ddeedd foreground but is deliberately near-monochrome (every syntax group
-- resolves to the same off-white) and predates treesitter. This instead maps
-- Arthur's 16 ANSI colors -- the ones Ghostty actually renders -- onto modern
-- highlight groups, so the editor and the terminal around it agree.
--
-- Source of truth for the palette:
--   /Applications/Ghostty.app/Contents/Resources/ghostty/themes/Arthur
-- Keep `p` below in sync if that file ever changes upstream.

local p = {
  -- Arthur's 16, verbatim.
  black = "#3d352a",
  red = "#cd5c5c",
  green = "#86af80",
  yellow = "#e8ae5b",
  blue = "#6495ed",
  magenta = "#deb887", -- burlywood, not a true magenta
  cyan = "#b0c4de", -- lightsteelblue
  white = "#bbaa99",
  br_black = "#554444",
  br_red = "#cc5533",
  br_green = "#88aa22",
  br_yellow = "#ffa75d",
  br_blue = "#87ceeb",
  br_magenta = "#996600",
  br_cyan = "#b0c4de", -- Arthur defines 6 and 14 identically
  br_white = "#ddccbb",

  bg = "#1c1c1c",
  fg = "#ddeedd",
  cursor = "#e2bbef",
  cursor_text = "#000000",
  sel_bg = "#4d4d4d",
  sel_fg = "#ffffff",
}

-- Two tones Arthur does not define, needed because its own darks are unusable
-- as text. br_black (#554444) sits at 1.8:1 against the background -- fine for
-- rules and indent guides, illegible for prose -- so comments get a lifted warm
-- grey at ~4.1:1 and line numbers a midpoint at ~2.7:1. Both are hue-matched to
-- br_black so they read as part of the palette rather than bolted on.
p.comment = "#8a7a6a"
p.gutter = "#6b5d51"

-- Surfaces lifted off p.bg. Arthur ships no elevation ramp; these are the
-- background nudged just far enough for floats and the cursorline to separate.
p.bg_float = "#232323"
p.bg_line = "#262626"

local hl = function(group, spec)
  vim.api.nvim_set_hl(0, group, spec)
end

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.g.colors_name = "arthur"

-- :terminal buffers inherit the same 16 colors, so a shell inside Neovim looks
-- identical to the same shell in Ghostty directly.
local ansi = {
  p.black,
  p.red,
  p.green,
  p.yellow,
  p.blue,
  p.magenta,
  p.cyan,
  p.white,
  p.br_black,
  p.br_red,
  p.br_green,
  p.br_yellow,
  p.br_blue,
  p.br_magenta,
  p.br_cyan,
  p.br_white,
}
for i, color in ipairs(ansi) do
  vim.g["terminal_color_" .. (i - 1)] = color
end

local groups = {
  -- Editor chrome
  Normal = { fg = p.fg, bg = p.bg },
  NormalNC = { fg = p.fg, bg = p.bg },
  NormalFloat = { fg = p.fg, bg = p.bg_float },
  FloatBorder = { fg = p.black, bg = p.bg_float },
  FloatTitle = { fg = p.br_white, bg = p.bg_float, bold = true },
  Cursor = { fg = p.cursor_text, bg = p.cursor },
  lCursor = { link = "Cursor" },
  TermCursor = { link = "Cursor" },
  CursorLine = { bg = p.bg_line },
  CursorColumn = { bg = p.bg_line },
  ColorColumn = { bg = p.bg_line },
  CursorLineNr = { fg = p.br_yellow, bold = true },
  LineNr = { fg = p.gutter },
  SignColumn = { bg = p.bg },
  FoldColumn = { fg = p.gutter },
  Folded = { fg = p.comment, bg = p.bg_float },
  WinSeparator = { fg = p.black },
  VertSplit = { fg = p.black },
  EndOfBuffer = { fg = p.br_black },
  NonText = { fg = p.br_black },
  Whitespace = { fg = p.br_black },
  SpecialKey = { fg = p.br_black },
  Conceal = { fg = p.comment },
  Directory = { fg = p.blue },
  Title = { fg = p.br_white, bold = true },
  MatchParen = { fg = p.br_yellow, bold = true },
  QuickFixLine = { bg = p.bg_line, bold = true },
  Visual = { bg = p.sel_bg },
  VisualNOS = { bg = p.sel_bg },
  Search = { fg = p.bg, bg = p.yellow },
  IncSearch = { fg = p.bg, bg = p.br_yellow },
  CurSearch = { fg = p.bg, bg = p.br_yellow },
  Substitute = { fg = p.bg, bg = p.red },

  -- Messages
  ErrorMsg = { fg = p.red, bold = true },
  WarningMsg = { fg = p.yellow },
  MoreMsg = { fg = p.green },
  ModeMsg = { fg = p.fg, bold = true },
  Question = { fg = p.green },
  MsgArea = { fg = p.fg },

  -- Menus and bars
  Pmenu = { fg = p.fg, bg = p.bg_float },
  PmenuSel = { fg = p.bg, bg = p.blue, bold = true },
  PmenuSbar = { bg = p.bg_float },
  PmenuThumb = { bg = p.br_black },
  PmenuKind = { fg = p.cyan, bg = p.bg_float },
  PmenuExtra = { fg = p.comment, bg = p.bg_float },
  WildMenu = { link = "PmenuSel" },
  StatusLine = { fg = p.fg, bg = p.bg_float },
  StatusLineNC = { fg = p.comment, bg = p.bg_float },
  TabLine = { fg = p.comment, bg = p.bg_float },
  TabLineSel = { fg = p.br_yellow, bg = p.bg, bold = true },
  TabLineFill = { bg = p.bg_float },
  WinBar = { fg = p.comment, bg = p.bg },
  WinBarNC = { fg = p.br_black, bg = p.bg },

  -- Diffs
  DiffAdd = { fg = p.green, bg = "#20261f" },
  DiffChange = { fg = p.yellow, bg = "#26231c" },
  DiffDelete = { fg = p.red, bg = "#261d1d" },
  DiffText = { fg = p.br_yellow, bg = "#332d20", bold = true },

  -- Legacy syntax. The treesitter groups below cover most real buffers, but
  -- these still drive vim-syntax filetypes and anything without a parser.
  Comment = { fg = p.comment, italic = true },
  Constant = { fg = p.magenta },
  String = { fg = p.green },
  Character = { fg = p.green },
  Number = { fg = p.br_yellow },
  Float = { fg = p.br_yellow },
  Boolean = { fg = p.br_yellow },
  Identifier = { fg = p.fg },
  Function = { fg = p.blue },
  Statement = { fg = p.yellow },
  Conditional = { fg = p.yellow },
  Repeat = { fg = p.yellow },
  Label = { fg = p.yellow },
  Operator = { fg = p.white },
  Keyword = { fg = p.yellow },
  Exception = { fg = p.br_red },
  PreProc = { fg = p.br_red },
  Include = { fg = p.br_red },
  Define = { fg = p.br_red },
  Macro = { fg = p.br_red },
  PreCondit = { fg = p.br_red },
  Type = { fg = p.cyan },
  StorageClass = { fg = p.cyan },
  Structure = { fg = p.cyan },
  Typedef = { fg = p.cyan },
  Special = { fg = p.br_blue },
  SpecialChar = { fg = p.br_green },
  Tag = { fg = p.br_blue },
  Delimiter = { fg = p.white },
  SpecialComment = { fg = p.comment, bold = true },
  Debug = { fg = p.br_red },
  Underlined = { underline = true },
  Ignore = { fg = p.br_black },
  Error = { fg = p.red },
  Todo = { fg = p.bg, bg = p.yellow, bold = true },
  Added = { fg = p.green },
  Changed = { fg = p.yellow },
  Removed = { fg = p.red },

  -- Treesitter
  ["@variable"] = { fg = p.fg },
  ["@variable.builtin"] = { fg = p.br_red, italic = true },
  ["@variable.parameter"] = { fg = p.br_white },
  ["@variable.member"] = { fg = p.cyan },
  ["@constant"] = { fg = p.magenta },
  ["@constant.builtin"] = { fg = p.br_yellow },
  ["@constant.macro"] = { fg = p.br_red },
  ["@module"] = { fg = p.cyan },
  ["@module.builtin"] = { fg = p.cyan, italic = true },
  ["@label"] = { fg = p.yellow },
  ["@string"] = { fg = p.green },
  ["@string.documentation"] = { fg = p.comment },
  ["@string.regexp"] = { fg = p.br_green },
  ["@string.escape"] = { fg = p.br_green, bold = true },
  ["@string.special"] = { fg = p.br_green },
  ["@string.special.url"] = { fg = p.br_blue, underline = true },
  ["@character"] = { fg = p.green },
  ["@character.special"] = { fg = p.br_green },
  ["@boolean"] = { fg = p.br_yellow },
  ["@number"] = { fg = p.br_yellow },
  ["@number.float"] = { fg = p.br_yellow },
  ["@type"] = { fg = p.cyan },
  ["@type.builtin"] = { fg = p.cyan, italic = true },
  ["@type.definition"] = { fg = p.cyan },
  ["@attribute"] = { fg = p.br_magenta },
  ["@property"] = { fg = p.cyan },
  ["@function"] = { fg = p.blue },
  ["@function.builtin"] = { fg = p.br_blue },
  ["@function.call"] = { fg = p.blue },
  ["@function.macro"] = { fg = p.br_red },
  ["@function.method"] = { fg = p.blue },
  ["@function.method.call"] = { fg = p.blue },
  ["@constructor"] = { fg = p.cyan },
  ["@operator"] = { fg = p.white },
  ["@keyword"] = { fg = p.yellow },
  ["@keyword.function"] = { fg = p.yellow },
  ["@keyword.operator"] = { fg = p.yellow },
  ["@keyword.import"] = { fg = p.br_red },
  ["@keyword.type"] = { fg = p.yellow },
  ["@keyword.modifier"] = { fg = p.yellow },
  ["@keyword.repeat"] = { fg = p.yellow },
  ["@keyword.return"] = { fg = p.br_red },
  ["@keyword.debug"] = { fg = p.br_red },
  ["@keyword.exception"] = { fg = p.br_red },
  ["@keyword.conditional"] = { fg = p.yellow },
  ["@keyword.directive"] = { fg = p.br_red },
  ["@punctuation.delimiter"] = { fg = p.white },
  ["@punctuation.bracket"] = { fg = p.white },
  ["@punctuation.special"] = { fg = p.br_blue },
  ["@comment"] = { fg = p.comment, italic = true },
  ["@comment.error"] = { fg = p.bg, bg = p.red, bold = true },
  ["@comment.warning"] = { fg = p.bg, bg = p.yellow, bold = true },
  ["@comment.todo"] = { fg = p.bg, bg = p.br_blue, bold = true },
  ["@comment.note"] = { fg = p.bg, bg = p.green, bold = true },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.underline"] = { underline = true },
  ["@markup.heading"] = { fg = p.br_yellow, bold = true },
  ["@markup.quote"] = { fg = p.comment, italic = true },
  ["@markup.math"] = { fg = p.magenta },
  ["@markup.link"] = { fg = p.br_blue },
  ["@markup.link.label"] = { fg = p.blue },
  ["@markup.link.url"] = { fg = p.br_blue, underline = true },
  ["@markup.raw"] = { fg = p.br_green },
  ["@markup.raw.block"] = { fg = p.br_green },
  ["@markup.list"] = { fg = p.yellow },
  ["@markup.list.checked"] = { fg = p.green },
  ["@markup.list.unchecked"] = { fg = p.comment },
  ["@tag"] = { fg = p.br_blue },
  ["@tag.builtin"] = { fg = p.br_blue },
  ["@tag.attribute"] = { fg = p.magenta },
  ["@tag.delimiter"] = { fg = p.white },
  ["@diff.plus"] = { fg = p.green },
  ["@diff.minus"] = { fg = p.red },
  ["@diff.delta"] = { fg = p.yellow },

  -- LSP semantic tokens. Left mostly linking to treesitter so servers cannot
  -- disagree with the parser about the same identifier.
  ["@lsp.type.class"] = { link = "@type" },
  ["@lsp.type.decorator"] = { link = "@attribute" },
  ["@lsp.type.enum"] = { link = "@type" },
  ["@lsp.type.enumMember"] = { link = "@constant" },
  ["@lsp.type.function"] = { link = "@function" },
  ["@lsp.type.interface"] = { link = "@type" },
  ["@lsp.type.macro"] = { link = "@function.macro" },
  ["@lsp.type.method"] = { link = "@function.method" },
  ["@lsp.type.namespace"] = { link = "@module" },
  ["@lsp.type.parameter"] = { link = "@variable.parameter" },
  ["@lsp.type.property"] = { link = "@property" },
  ["@lsp.type.struct"] = { link = "@type" },
  ["@lsp.type.type"] = { link = "@type" },
  ["@lsp.type.typeParameter"] = { link = "@type.definition" },
  ["@lsp.type.variable"] = { link = "@variable" },
  ["@lsp.mod.deprecated"] = { strikethrough = true },

  LspReferenceText = { bg = p.bg_line },
  LspReferenceRead = { bg = p.bg_line },
  LspReferenceWrite = { bg = p.bg_line, underline = true },
  LspInlayHint = { fg = p.gutter, bg = p.bg_float, italic = true },
  LspSignatureActiveParameter = { fg = p.br_yellow, bold = true },
  LspCodeLens = { fg = p.comment, italic = true },
  LspInfoBorder = { link = "FloatBorder" },

  -- Diagnostics
  DiagnosticError = { fg = p.red },
  DiagnosticWarn = { fg = p.yellow },
  DiagnosticInfo = { fg = p.br_blue },
  DiagnosticHint = { fg = p.cyan },
  DiagnosticOk = { fg = p.green },
  DiagnosticVirtualTextError = { fg = p.red, bg = "#261d1d" },
  DiagnosticVirtualTextWarn = { fg = p.yellow, bg = "#26231c" },
  DiagnosticVirtualTextInfo = { fg = p.br_blue, bg = "#1d2226" },
  DiagnosticVirtualTextHint = { fg = p.cyan, bg = "#1d2226" },
  DiagnosticVirtualTextOk = { fg = p.green, bg = "#20261f" },
  DiagnosticUnderlineError = { undercurl = true, sp = p.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = p.yellow },
  DiagnosticUnderlineInfo = { undercurl = true, sp = p.br_blue },
  DiagnosticUnderlineHint = { undercurl = true, sp = p.cyan },
  DiagnosticUnderlineOk = { undercurl = true, sp = p.green },
  DiagnosticUnnecessary = { fg = p.comment },
  DiagnosticDeprecated = { strikethrough = true, sp = p.comment },

  -- gitsigns
  GitSignsAdd = { fg = p.green },
  GitSignsChange = { fg = p.yellow },
  GitSignsDelete = { fg = p.red },
  GitSignsAddInline = { fg = p.bg, bg = p.green },
  GitSignsChangeInline = { fg = p.bg, bg = p.yellow },
  GitSignsDeleteInline = { fg = p.bg, bg = p.red },

  -- snacks.nvim (LazyVim's dashboard, picker, notifier, indent guides)
  SnacksNormal = { link = "NormalFloat" },
  SnacksBackdrop = { bg = "#000000" },
  SnacksWinBar = { link = "FloatTitle" },
  SnacksDashboardHeader = { fg = p.br_yellow },
  SnacksDashboardTitle = { fg = p.blue },
  SnacksDashboardDesc = { fg = p.fg },
  SnacksDashboardIcon = { fg = p.cyan },
  SnacksDashboardKey = { fg = p.br_red },
  SnacksDashboardFooter = { fg = p.comment, italic = true },
  SnacksDashboardDir = { fg = p.comment },
  SnacksNotifierInfo = { fg = p.br_blue },
  SnacksNotifierWarn = { fg = p.yellow },
  SnacksNotifierError = { fg = p.red },
  SnacksNotifierDebug = { fg = p.comment },
  SnacksNotifierTrace = { fg = p.magenta },
  SnacksPickerMatch = { fg = p.br_yellow, bold = true },
  SnacksPickerDir = { fg = p.comment },
  SnacksPickerPrompt = { fg = p.blue },
  SnacksIndent = { fg = p.br_black },
  SnacksIndentScope = { fg = p.gutter },

  -- blink.cmp (LazyVim's completion) plus nvim-cmp fallbacks
  BlinkCmpMenu = { link = "Pmenu" },
  BlinkCmpMenuBorder = { link = "FloatBorder" },
  BlinkCmpMenuSelection = { link = "PmenuSel" },
  BlinkCmpLabelMatch = { fg = p.br_yellow, bold = true },
  BlinkCmpKind = { fg = p.cyan },
  BlinkCmpDoc = { link = "NormalFloat" },
  BlinkCmpDocBorder = { link = "FloatBorder" },
  BlinkCmpGhostText = { fg = p.br_black },
  CmpItemAbbrMatch = { fg = p.br_yellow, bold = true },
  CmpItemAbbrDeprecated = { fg = p.comment, strikethrough = true },
  CmpItemKind = { fg = p.cyan },
  CmpGhostText = { fg = p.br_black },

  -- which-key
  WhichKey = { fg = p.br_red },
  WhichKeyGroup = { fg = p.blue },
  WhichKeyDesc = { fg = p.fg },
  WhichKeySeparator = { fg = p.comment },
  WhichKeyFloat = { bg = p.bg_float },
  WhichKeyBorder = { link = "FloatBorder" },
  WhichKeyTitle = { link = "FloatTitle" },

  -- neo-tree
  NeoTreeNormal = { fg = p.fg, bg = p.bg_float },
  NeoTreeNormalNC = { fg = p.fg, bg = p.bg_float },
  NeoTreeDirectoryName = { fg = p.blue },
  NeoTreeDirectoryIcon = { fg = p.blue },
  NeoTreeRootName = { fg = p.br_yellow, bold = true },
  NeoTreeFileName = { fg = p.fg },
  NeoTreeGitAdded = { fg = p.green },
  NeoTreeGitModified = { fg = p.yellow },
  NeoTreeGitDeleted = { fg = p.red },
  NeoTreeGitIgnored = { fg = p.br_black },
  NeoTreeGitUntracked = { fg = p.comment },
  NeoTreeIndentMarker = { fg = p.br_black },
  NeoTreeWinSeparator = { fg = p.black, bg = p.bg },

  -- telescope (still pulled in by some extras)
  TelescopeNormal = { link = "NormalFloat" },
  TelescopeBorder = { link = "FloatBorder" },
  TelescopeTitle = { link = "FloatTitle" },
  TelescopeSelection = { bg = p.bg_line, bold = true },
  TelescopeMatching = { fg = p.br_yellow, bold = true },
  TelescopePromptPrefix = { fg = p.br_red },

  -- octo
  OctoGreen = { fg = p.green },
  OctoRed = { fg = p.red },
  OctoYellow = { fg = p.yellow },
  OctoBlue = { fg = p.blue },
  OctoPurple = { fg = p.magenta },
  OctoGrey = { fg = p.comment },
}

for group, spec in pairs(groups) do
  hl(group, spec)
end
