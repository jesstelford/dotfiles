" vim-go binary dir
let g:go_bin_path = has('nvim') ? stdpath('data') . '/bin' : '~/.vim/bin'

" Setup plugins
runtime plugins.vim
" -------------
" end: vim-plug
" -------------

" ------------------
" colorscheme config
" ------------------
set background=dark

" Enable 24bit colors
set termguicolors

" Gruvbox
" -------
let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italic = '1'
let g:gruvbox_undercurl = '1'

" PICO-8
" ------
if !has_key(g:, 'pico8_config')
  let g:pico8_config = {}
endif
let g:pico8_config.imitate_console = '0'

" Nightfox
" --------
lua <<EOF
require('nightfox').setup({
  options = {
    styles = {
      comments = "italic",
      keywords = "bold",
      types = "italic,bold",
    }
  }
})
EOF

" Tokyonight
" ----------
lua <<EOF
require("tokyonight").setup({
  styles = {
    keywords = { italic = none },
  },
})
EOF

" Kanagawa
" --------
lua <<EOF
require('kanagawa').setup({
  keywordStyle = { italic = false},
  statementStyle = { bold = true },
})
EOF

" Github
" ------
lua <<EOF
-- NOTE: Sets the colorscheme, so we do this config first, then later we choose
-- which colorscheme we actually want.
require('github-theme').setup {
  theme_style = "dark",
  -- Disable italics on keywords
  keyword_style = "NONE",
}
EOF

" Actually set the colorscheme now that it's all configured
" colorscheme gruvbox
" colorscheme nightfox
" colorscheme tokyonight
colorscheme kanagawa
" colorscheme github_dark
" -----------------------
" end: colorscheme config
" -----------------------

" ------------------
" Tree sitter config
" ------------------
lua <<EOF
local diable_highlight = function()
  if vim.bo.filetype == "pico8" then
    return true
  end
end

-- NOTE: When tree sitter is enabled for a filetype, it will automatically run:
-- filetype indent off
-- syntax off
-- So, we don't have to run those, and can still support older syntax files where necessary
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    "css",
    "graphql",
    "html",
    "javascript",
    "json",
    "json5",
    "lua",
    "markdown",
    "scss",
    "tsx",
    "typescript",
    "vim",
  },

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing
  ignore_install = {
    -- Errors out during installation on MacOS: https://github.com/nvim-treesitter/nvim-treesitter/issues/1383
    -- Forcing the compiler to 'gcc' doesn't seem to help either
    "haskell",
    -- Has some kind of error during install. Don't need it.
    "fusion",
    -- Has some kind of error during install. Don't need it.
    "latex"
  },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    disable = diable_highlight,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  -- Enable experimental indentation
  indent = {
    enable = true
  },

  -- Use treesitter for matchup's matching
  matchup = {
    enable = true,
    -- list of language that will be disabled
    disable = {},
  },

  -- To support nvim-ts-context-commentstring
  context_commentstring = {
    enable = true
  }
}
EOF
" -----------------------
" End: Tree sitter config
" -----------------------

" --------------------
" nvim-ufo For folding
" --------------------
lua <<EOF
vim.o.foldcolumn = '0' -- Don't display nvim-ufo fold info in column
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

-- TODO: Figure out why the LSP version of nvim-ufo wasn't working for JS/TS
require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return {'treesitter', 'indent'}
  end
})
EOF

" ----------------
" lspconfig config
" ----------------
" Mostly copied from https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
lua <<EOF
local util = require'lspconfig.util'

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.cssls.setup {
  capabilities = capabilities,
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = util.root_pattern('.git', 'yarn.lock', 'package-lock.json'),
  on_attach = function(client)
    -- Let null-ls handle the formatting with the faster prettierd
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}

-- Uses the vscode eslint language server, so it's not slow
require'lspconfig'.eslint.setup{
  format = false,
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = util.root_pattern(
    '.eslintrc.js',
    '.eslintrc.cjs',
    '.eslintrc.yaml',
    '.eslintrc.yml',
    '.eslintrc.json',
    '.git',
    'yarn.lock',
    'package-lock.json'
  ),
}

require'lspconfig'.graphql.setup{
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = util.root_pattern(
    '.graphqlrc*',
    '.graphql.config.*',
    'graphql.config.*',
    '.git',
    'yarn.lock',
    'package-lock.json'
  ),
  on_attach = function(client)
    -- Let null-ls handle the formatting with the faster prettierd
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = util.root_pattern('.git', 'yarn.lock', 'package-lock.json'),
  on_attach = function(client)
    -- Let null-ls handle the formatting with the faster prettierd
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}

require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = util.root_pattern('.git', 'yarn.lock', 'package-lock.json'),
  on_attach = function(client)
    -- Let null-ls handle the formatting with the faster prettierd
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
  settings = {
    json = {
      -- Use https://www.schemastore.org/json/ for JSON schemas. Powered by b0o/SchemaStore.nvim
      schemas = require('schemastore').json.schemas(),
    },
  },
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = util.root_pattern('.git', 'yarn.lock', 'package-lock.json'),
}

require'lspconfig'.tailwindcss.setup{
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = function(fname)
    return util.root_pattern('tailwind.config.js', 'tailwind.config.ts')(fname)
      or util.root_pattern(
        'postcss.config.js',
        'postcss.config.ts',
        '.git',
        'yarn.lock',
        'package-lock.json'
      )(fname)
  end,
}

-- Get the global yarn bin directory
local yarnGlobalBinDir = string.gsub(
  -- Get the global yarn bin dir, but it includes a trailing `\n`
  vim.fn.system('yarn global bin'),
  -- So we match against the contents with leading/trailing spaces stripped
  '^%s*(.-)%s*$',
  '%1'
)

-- Requires a tsconfig.json or jsconfig.json in the root of your project.
require'lspconfig'.tsserver.setup{
  -- Forcibly use the globally installed `tsserver` version.
  -- Otherwise, this will use... some other version? Even if there's not a
  -- version installed in the local node_modules it somehow manages to find one
  -- somewhere that is out of date (doesn't understand optional chaining).
  cmd = {
    'typescript-language-server',
    '--stdio',
    '--tsserver-path='..yarnGlobalBinDir..'/tsserver'
  },
  init_options = require("nvim-lsp-ts-utils").init_options,
  on_attach = function(client)
    -- Let null-ls handle the formatting with the faster prettierd
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup{
      auto_inlay_hints = false
    }
    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)
  end,
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = function(fname)
    return util.root_pattern('tsconfig.json')(fname)
      or util.root_pattern('jsconfig.json')(fname)
      or util.root_pattern('.git', 'yarn.lock', 'package-lock.json')(fname)
  end,
}

require'lspconfig'.remark_ls.setup {
  capabilities = capabilities,
  single_file_support = false,
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = function(fname)
    local root_dir = util.root_pattern(
      '.remarkrc.json',
      '.remarkc',
      '.remarkc.json',
      '.remarkc.cjs',
      '.remarkc.mjs',
      '.remarkc.js',
      '.remarkc.yaml',
      '.remarkc.yml'
    )(fname)
    -- TODO: or: look for a 'remark' key in `package.json`?
    -- NOTE: If root_dir is empty, and single_file_support = false, this lsp is disabled
    -- Avoids an error demanding that `remark` be installed in `node_modules` even if you're not in a JS project
    return root_dir
  end,
  on_attach = function(client)
    -- Let null-ls handle the formatting with the faster prettierd
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Disable inline virtual text, use lspsaga to show diagnostics instead
  virtual_text = false,
  -- Show signs in the gutter
  signs = true,
  update_in_insert = false,
  -- High severity items always take precedence
  severity_sort = true
})

-- Setup the symbols for nvim to use when displaying diagnostics (used by lspsaga)
local signs = {
  Error = ' ',
  Warn = ' ',
  Info = ' ',
  Hint = 'ﴞ ',
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- lspsaga for nicer diagnostics and other commands
require'lspsaga'.init_lsp_saga{
  code_action_keys = {
    quit = "<esc>",
  },
  border_style = "single",
}

EOF
" ----------------
" end: lspconfig config
" ----------------

" -------
" null-ls
" -------
" For things that lspconfig can't handle well
lua <<EOF
local command_resolver = require("null-ls.helpers.command_resolver")
local util = require'lspconfig.util'

require("null-ls").setup({
  sources = {
    require("null-ls").builtins.completion.spell,
    require("null-ls").builtins.formatting.prettierd.with({
      -- Attempt to use a local version of prettier first
      -- falling back to the globally installed version when not found
      -- See: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md#using-local-executables
      dynamic_command = function(params)
        return command_resolver.from_node_modules(params)
          or command_resolver.from_yarn_pnp(params)
          or vim.fn.executable(params.command) == 1 and params.command
      end,
      -- Only format on save
      --method = require("null-ls").methods.DIAGNOSTICS_ON_SAVE,
    }),
  },
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  --root_dir = util.root_pattern('.git', 'yarn.lock', 'package-lock.json'),
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd([[
        augroup LspFormatting
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
        augroup END
      ]])
    end
  end,
})
EOF
" ------------
" end: null-ls
" ------------

lua <<EOF
require("indent_blankline").setup {}
require("lsp-colors").setup {}
require('gitsigns').setup {}
--require('nvim-ts-autotag').setup {}
require('nvim-tree').setup {
  -- Create new files within a closed folder when that folder is under cursor
  create_in_closed_folder = true,
  -- Keep nvim-tree up to date with cwd always to avoid accidentally running
  -- commands in the wrong directory, etc.
  sync_root_with_cwd = true,
  -- When using gf to jump to a file, prefer to keep the tree open at the cwd
  -- we started at.
  respect_buf_cwd = true,
  actions = {
    change_dir = {
      -- Do not ever change cwd when browsing / opening files and folders
      enable = false,
    },
  },
  update_focused_file = {
    -- Jump nvim-tree to the currently open file
    enable = true,
    -- When opening a file from within a directory listing, we need nvim-tree
    -- to update its root back to the correct location
    update_root = true,
  },
  prefer_startup_root = true,
  diagnostics = {
    enable = true,
  },
  git = {
    enable = true,
  },
  renderer = {
    highlight_git = true,
    indent_markers = {
      enable = true,
    },
    icons = {
      show = {
        git = false,
        file = true,
        folder = true,
        folder_arrow = true,
      },
      glyphs = {
        default = '',
      },
    },
  },
}
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        -- Use Trouble instead of Quick Fix for the files which is much nicer to browser, but doesn't have commands
        ["<C-q>"] = require("trouble.providers.telescope").smart_open_with_trouble
      },
      n = {
        ["<C-q>"] = require("trouble.providers.telescope").smart_open_with_trouble
      }
    }
  }
}
require('neoscroll').setup({
  easing_function = "sine"
})
local t = {}
-- Syntax: t[keys] = {function, {function arguments}}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '150'}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '150'}}
t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '200'}}
t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '200'}}
t['<C-y>'] = {'scroll', {'-0.10', 'false', '100'}}
t['<C-e>'] = {'scroll', { '0.10', 'false', '100'}}
t['zt']    = {'zt', {'150'}}
t['zz']    = {'zz', {'150'}}
t['zb']    = {'zb', {'150'}}
-- From https://github.com/karb94/neoscroll.nvim/issues/23#issuecomment-839630060
t['gg']    = {'scroll', {'-2*vim.api.nvim_buf_line_count(0)', 'true', '1', '5', e}}
t['G']     = {'scroll', {'2*vim.api.nvim_buf_line_count(0)', 'true', '1', '5', e}}

require('neoscroll.config').set_mappings(t)

-- require "nvim-treesitter.configs".setup {
--   playground = {
--     enable = true,
--   }
-- }
EOF

set grepprg=rg

" Force override the default colour for the < / > tag delimeters
" See: https://github.com/ellisonleao/gruvbox.nvim/blob/b0a1c4bd71aa58e02809632fbc00fa6dce6d1213/lua/gruvbox/plugins/highlights.lua#L70
hi! link TSTagDelimiter GruvboxOrange

" Tell the Directory highlight to calm down and stop yelling at me
hi! link Directory Text

" Less in-your-face folder icons/lines in nvim-tree
hi! link NvimTreeFolderIcon NonText
hi! link NvimTreeIndentMarker NonText

hi! link CursorLineNr LineNr " Force cursorline number to be same as line number
hi! link SignColumn CursorLineNr " Force sign column number to be same as line number

set textwidth=80
set autowriteall
if has('nvim')
	set viminfo=!,'25,\"100,:20
else
	set viminfo=!,'25,\"100,:20,n~/.viminfo
endif
set showcmd
set showmatch
set noshowmode
set list          " Display unprintable characters f12 - switches
set listchars=trail:•,extends:»,precedes:« " Unprintable chars mapping
set statusline=
set hlsearch
set ignorecase
set smartcase
set undodir=~/.vim/undodir
if filewritable(&undodir) == 0
  call mkdir(&undodir, "p")
endif
set undofile
set virtualedit=block              "can move cursor past end of line in visualblock mode
set splitbelow
set splitright

" Use global status line if available. See: https://github.com/neovim/neovim/pull/17266
" NOTE: May not work with lualine: https://github.com/vim-airline/vim-airline/issues/2517
"set laststatus=3
" Use buffer status line
set laststatus=2

set formatoptions=cqlron

" Spacing
set tabstop=2
set shiftwidth=2		" indents
set softtabstop=2

set synmaxcol=400
set nocursorline
set nocursorcolumn
set ttyfast
if !has('nvim')
    set ttyscroll=3
endif
set lazyredraw

" So that we can edit the quickfix list with `:set modifiable`, then reload it
" with `:cgetbuf`
setlocal errorformat=%f\|%l\ col\ %c\|%m

function! GetFilenameFromQFLine(val)
  let l:buf = bufname(a:val['bufnr'])
  echo l:buf
  return l:buf
  "let l:matched = matchstr(l:buf, '\c^\zs.\{-}\ze|.*$')
  "echo l:matched
  "return l:matched
endfunction

function! UniqueQuickFix()
  let l:list = getqflist()
  call sort(l:list)
  call uniq(l:list, {val1, val2 -> GetFilenameFromQFLine(val1) !=# GetFilenameFromQFLine(val2)})
  "call filter(g:list, {idx, val -> index(g:list, matchstr(val, '\c^\zs.\{-}\ze\|.*$'), idx + 1) == -1})
  call setqflist(l:list)
endfunction

augroup qf
  autocmd!
  nnoremap <leader>u :set modifiable<CR>:call UniqueQuickFix()<CR>
augroup END

" Show any text longer than 'textwidth' in red
highlight OverOneTwenty ctermbg=DarkRed ctermfg=white guibg=#592929
match OverOneTwenty /\%>120v.\+/

" Background colors for active vs inactive windows
" From: https://medium.com/@caleb89taylor/customizing-individual-neovim-windows-4a08f2d02b4e
"hi! InactiveWindow ctermbg=236
"
"" Call method on window enter
"augroup WindowManagement
"  autocmd!
"  autocmd WinEnter * call Handle_Win_Enter()
"augroup END
"
"" Change highlight group of active/inactive windows
"function! Handle_Win_Enter()
"  setlocal winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
"endfunction

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" Mappings
nmap ,b :ls<CR>:b<Space>
nmap <leader>b <cmd>Telescope buffers<cr>
nmap <leader>d <cmd>Telescope lsp_definitions<cr>
nmap <leader>f <cmd>Telescope find_files<cr>
nmap <leader>s <cmd>Telescope live_grep<cr>
" Show all diagnostics on current line in floating window
nnoremap <silent>? <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
" Show documentation on the current method / variable / etc
nnoremap <silent>K <cmd>Lspsaga hover_doc<cr>
" Trigger code actions for the current line / range
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
" Rename symbol with lsp. Also mapped to <F2>
nnoremap <silent>gr <cmd>Lspsaga rename<cr>
" Open definition in a float window
nnoremap <silent>gd <cmd>Lspsaga peek_definition<cr>

" <Fn> keys
"
" <F1>
" Rename symbol with lsp. Also mapped to gr
nnoremap <silent><F2> <cmd>Lspsaga rename<cr>
" <F3>
" <F4>
" <F5>
nnoremap <F6> :GundoToggle<CR>
nnoremap <F7> <cmd>NvimTreeFindFile<cr>
nnoremap <F8> <cmd>NvimTreeToggle<cr>
nnoremap <F9> :call EggheadMode()<CR>
nnoremap <F10> :TroubleToggle<CR>
" <F11>
" <F12>

" TODO: show or hide bottom status bar. useful for egghead recordings
" see http://unix.stackexchange.com/questions/140898/vim-hide-status-line-in-the-bottom

function! UseSpaces()
  set expandtab            " use spaces, not tabs

  " Show leading tabs in gray
  hi clear ExtraWhiteSpace
  highlight ExtraWhiteSpace ctermbg=DarkGrey ctermfg=white guibg=#592929
  match ExtraWhitespace /^\s*\(\t\+\s*\)\+/

  set listchars+=tab:•\ " Print a tab as a dot followed by a number of spaces
endfunction

function! UseTabs()
  set noexpandtab        " use tabs, not spaces

  " Show leading spaces in gray
  hi clear ExtraWhiteSpace
  highlight ExtraWhiteSpace ctermbg=DarkGrey ctermfg=white guibg=#592929
  match ExtraWhitespace /^\t*\zs \+/

  set listchars+=tab:\ \
endfunction

" Use spaces by default, but can call UseTabs() to toggle, for example, in a
" `.nvimrc` in a project directory, add the line `call UseTabs()`
call UseSpaces()

" Center the match in the window
noremap n nzz
noremap N Nzz

" Move columnwise instead of rowwise when wrapping long lines
noremap <expr> j v:count ? 'j' : 'gj'
noremap <expr> k v:count ? 'k' : 'gk'

nnoremap :qs<CR> :mks!<CR>:q<CR>
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    " Mac OSX
    nnoremap ,p :read !pbpaste<CR>
  else
    nnoremap ,p :read !xsel --clipboard --output<CR>
  endif
endif

" Refresh the screen / clear any search highlights
noremap <silent> <c-m> :nohls<cr><c-m>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

set guicursor= " Disable neovim custom cursor styling
set ofu=syntaxcomplete#Complete
set completeopt=menuone,menu,longest
set autoindent smartindent	" turn on auto/smart indenting
set smarttab			" make <tab> and <backspace> smarter
set backspace=eol,start,indent	" allow backspacing over indent, eol, & start
set relativenumber              " supersceded by numbers plugin
set number                      " Show current line's actual line number
set incsearch                   " Show search matches as typing
set ttimeoutlen=50              " Register key presses immediately
set colorcolumn=121             " Mark column 121
if executable("par")
	nmap ,f vip:!par -w<c-r>=&tw<cr><cr>
endif
:command! -range=% -nargs=1 Space2Tab execute "<line1>,<line2>s/^\\( \\{<args>\\}\\)\\+/\\=substitute(submatch(0), ' \\{<args>\\}', '\\t', 'g')"
:command! -range=% -nargs=1 Tab2Space execute "<line1>,<line2>s/^\\t\\+/\\=substitute(submatch(0), '\\t', repeat(' ', <args>), 'g')"
let localvimrc_ask=0	" don't ask to load .lvimrc files

let g:SeeTabCtermFG="grey"

" vim-matchup
let g:matchup_matchparen_status_offscreen = 0
let g:matchup_transmute_enabled = 1

" function! FindNodeBinDir()
"     let l:package_json = findfile('package.json', '.;')
"     " Found the package.json file
"     if strlen(l:package_json)
"         if match(l:package_json, "/") == -1
"             " It's in the current directory
"             let l:path = getcwd()
"         else
"             " It's in a parent directory
"             let l:path = fnamemodify(l:package_json, ':p:h')
"         endif
"         " Absolute path to the dir
"         let l:path = l:path . '/node_modules/.bin/'
"         " If it exists
"         if !empty(glob(l:path))
"             " Return it
"             return l:path
"         endif
"     endif
" endfunction

function! LinterErrors() abort
    " TODO: how do I do this with new lsp?
    "let l:counts = ale#statusline#Count(bufnr(''))
    let l:counts = {'error': 0, 'style_error': 0, 'total': 0}

    let l:all_errors = l:counts.error + l:counts.style_error

    return l:counts.total == 0 ? '' : printf(
    \   '✘%d',
    \   all_errors
    \)
endfunction

function! LinterWarnings() abort
    " TODO: how do I do this with new lsp?
    "let l:counts = ale#statusline#Count(bufnr(''))
    let l:counts = {'error': 0, 'style_error': 0, 'total': 0}

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? '' : printf(
    \   '⚠%d',
    \   all_non_errors
    \)
endfunction

set foldlevelstart=99
noremap zO m'[zzczO`'

if has('autocmd')
  " Unfold everything by default, still allowing `zm` to work
  "autocmd BufWinEnter * let &foldlevel = max(map(range(1, line('$')), 'foldlevel(v:val)'))

  " Disable annoying bells
  set noerrorbells visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=

  au BufNewFile,BufRead *.less set filetype=css
  au BufNewFile,BufRead *.cson set filetype=coffee
  au BufNewFile,BufRead Jenkinsfile set filetype=groovy
  "au BufNewFile,BufRead *.p8 set filetype=lua

  " In neovim 0.5.0+, briefly highlight the yanked area
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank("IncSearch", 500)
  augroup END
endif

" Enable project-local .nvimrc files
set exrc
" Stop those project local files being malicous
set secure
