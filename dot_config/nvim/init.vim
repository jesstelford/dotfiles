" vim-go binary dir
let g:go_bin_path = has('nvim') ? stdpath('data') . '/bin' : '~/.vim/bin'

" --------
" vim-plug
" --------
" Auto-install vim-plug if not already installed
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/68488fd/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Load the plugins
let plugin_dir = has('nvim') ? stdpath('data') . '/bundle' : '~/.vim/bundle'
call plug#begin(plugin_dir)

Plug 'andymass/vim-matchup', { 'commit': 'ef044ee' }
Plug 'ap/vim-css-color', { 'commit': '26ff274' }
" Easily change word casing with motions, text objects or visual mode. This
" plugin is largely inspired by Tim Pope's vim-abolish
Plug 'arthurxavierx/vim-caser', { 'commit': '6bc9f41' }
Plug 'christoomey/vim-tmux-navigator', { 'commit': 'd030f75' }
Plug 'crusoexia/vim-monokai', { 'commit': '66f7dc9' }
Plug 'digitaltoad/vim-pug', { 'commit': 'ea39cd9' }
Plug 'EdenEast/nightfox.nvim', { 'commit': 'aaea945' }
Plug 'ellisonleao/gruvbox.nvim', { 'commit': 'b0a1c4b' }
Plug 'folke/lsp-colors.nvim', { 'commit': '517fe3a' }
Plug 'folke/tokyonight.nvim', { 'commit': 'd561999' }
" Mega list window thing for errors, hints, lsp diagnostics, etc
Plug 'folke/trouble.nvim', { 'commit': 'aae12e7' }
Plug 'honza/vim-snippets', { 'commit': 'e2156cd' }
Plug 'jose-elias-alvarez/null-ls.nvim', { 'commit': '80e1c29' }
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils', { 'commit': '083c918' }
Plug 'jparise/vim-graphql', { 'commit': '9a9fe18' }
" `ga` then some character to align text vertically by that character
Plug 'junegunn/vim-easy-align', { 'commit': '12dd631' }
" Vim help for vim-plug itself (e.g. :help plug-options)
Plug 'junegunn/vim-plug', { 'commit': '68488fd' }
Plug 'kyazdani42/nvim-tree.lua', { 'commit': '0aec64d' }
Plug 'kyazdani42/nvim-web-devicons', { 'commit': '218658d' }
Plug 'lewis6991/gitsigns.nvim', { 'commit': 'a451f97' }
" <leader><leader><motion> then select from the a-z as shown on the screen
" hightlighted in red
Plug 'lukas-reineke/indent-blankline.nvim', { 'commit': '0f8df7e' }
Plug 'moll/vim-node', { 'commit': 'ede0477' }
" TODO: Find a modern version of this
"Plug 'myusuf3/numbers.vim', { 'commit': '1867e76' }
Plug 'NLKNguyen/papercolor-theme', { 'commit': 'd0d32dc' }
Plug 'neovim/nvim-lspconfig', { 'commit': 'c018b1e' }
Plug 'nvim-lua/plenary.nvim', { 'commit': 'a672e11' }
Plug 'nvim-lualine/lualine.nvim', { 'commit': '3a17c8f' }
Plug 'nvim-telescope/telescope.nvim', { 'commit': '9aaaa0c' }
" Add fzf as the sorter for telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'commit': 'b8662b0', 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', { 'commit': 'c9db432', 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground', { 'commit': '787a7a8' }
Plug 'Pamplemousse/badWords', { 'commit': '467f330' }
Plug 'projekt0n/github-nvim-theme', { 'commit': '335dc0e' }
" required by ellisonleao/gruvbox.nvim
Plug 'rktjmp/lush.nvim', { 'commit': '57e9f31' }
" TODO: Is there a modern alternative (that uses devicons, etc), but still uses
" the same commands I'm used to?
" <F8> (or :e /path/to/dir) to open file browser
" (F6 hotkey already setup) - Visual VIM Undo tree
Plug 'sjl/gundo.vim', { 'commit': 'c5efef1' }
Plug 'tikhomirov/vim-glsl', { 'commit': '25f9a7d' }
" Plurals search / replace (:S), and: crs (coerce to snake_case), MixedCase
" (crm), camelCase (crc), and UPPER_CASE (cru)
Plug 'tpope/vim-abolish', { 'commit': '3f0c8fa' }
" Commenting: [n]gcc to comment out lines, gc[motion] to comment out motion
Plug 'tpope/vim-commentary', { 'commit': '627308e' }
" Add %{fugitive#statusline()} to 'statusline' to get an indicator with the
" current branch in (surprise!) your statusline.
Plug 'tpope/vim-fugitive', { 'commit': '3652313' }
Plug 'tpope/vim-jdaddy', { 'commit': '5cffddb' }
Plug 'tpope/vim-obsession', { 'commit': '82c9ac5' }
Plug 'tpope/vim-repeat', { 'commit': '24afe92' }
" Date manipulation: Ctrl-A & Ctrl-X to Increment / Decrement a datetime
Plug 'tpope/vim-speeddating', { 'commit': '95da3d7' }
" Quoting / Parenthasising: cs"' to swap double quotes with single quotes
Plug 'tpope/vim-surround', { 'commit': 'aeb9332' }
" common commands: :h unimpaired
Plug 'tpope/vim-unimpaired', { 'commit': 'e4006d6' }
" I wish this workd better, but it's unreliable
"Plug 'windwp/nvim-ts-autotag', { 'commit': '0ceb4ef' }
" IDE-like commands for interacting with LSPs like code actions, diagnostics in
" floats, etc
Plug 'tami5/lspsaga.nvim', { 'commit': '3cd3c4b' }
" golang syntaix higlighting support (also chezmoi .tmpl file highlighting)
Plug 'fatih/vim-go', { 'commit': 'dcefd64', 'do': ':GoUpdateBinaries', 'frozen': 1 }

" NOTE: internally calls: filetype indent on, syntax on
call plug#end()
" Disable these so we can use tree-sitter instead
filetype indent off
syntax off
" -------------
" end: vim-plug
" -------------

set background=dark
set termguicolors

let g:gruvbox_sign_column = 'bg0'
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italic = '1'
let g:gruvbox_undercurl = '1'

" let g:gh_color = "soft"
colorscheme gruvbox
" colorscheme nightfox
" colorscheme tokyonight

" ------------------
" Tree sitter config
" ------------------
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "all",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

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
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" -----------------------
" End: Tree sitter config
" -----------------------

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
}

require'lspconfig'.html.setup {
  capabilities = capabilities,
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = util.root_pattern('.git', 'yarn.lock', 'package-lock.json'),
}

require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
  -- Support monorepos by not checking for `package.json`s, instead check for `.git` or `yarn.lock`
  root_dir = util.root_pattern('.git', 'yarn.lock', 'package-lock.json'),
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
    ts_utils.setup{}
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

-- Use a circle instead of a square for diagnostics
-- Taken from https://github.com/projekt0n/circles.nvim
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  -- Disable inline virtual text, use lspsaga to show diagnostics instead
  virtual_text = false,
  -- Show signs in the gutter
  signs = true,
  update_in_insert = false,
  -- High severity items always take precedence
  severity_sort = true
})

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
require("null-ls").setup({
  sources = {
    require("null-ls").builtins.completion.spell,
    require("null-ls").builtins.formatting.prettierd.with({
      -- TODO: Does this still work with yarn v3 installations?
      -- only_local = "node_modules/.bin",
      -- method = require("null-ls").methods.DIAGNOSTICS_ON_SAVE,
    }),
  },
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
  end,
})
EOF
" ------------
" end: null-ls
" ------------

let g:nvim_tree_show_icons = {
  \ 'git': 0,
  \ 'files': 1,
  \ 'folders': 1,
  \ 'folder_arrows': 1,
  \ }

let g:nvim_tree_git_hl = 1

let g:nvim_tree_icons = {
  \ 'default': '',
  \ }

" Create new files within a closed folder when that folder is under cursor
let g:nvim_tree_create_in_closed_folder = 1

lua <<EOF
require("indent_blankline").setup {}
require("lsp-colors").setup {}
require('gitsigns').setup {}
--require('nvim-ts-autotag').setup {}
require('nvim-tree').setup {
  diagnostics = {
    enable = true,
  },
  git = {
    enable = true,
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
-- Sets the colorscheme
--require('github-theme').setup {
--  theme_style = "dimmed",
--  -- Disable italics on keywords
--  keyword_style = "NONE",
--  colors = {
--    syntax = {
--      --func = '#ff0000'
--    }
--  }
--}
--require "nvim-treesitter.configs".setup {
--  playground = {
--    enable = true,
--  }
--}
EOF

set grepprg=rg

" Force override the default colour for the < / > tag delimeters
" See: https://github.com/ellisonleao/gruvbox.nvim/blob/b0a1c4bd71aa58e02809632fbc00fa6dce6d1213/lua/gruvbox/plugins/highlights.lua#L70
hi! link TSTagDelimiter GruvboxOrange

" Tell the Directory highlight to calm down and stop yelling at me
hi! link Directory Text

" Less in-your-face folder icons in nvim-tree
hi! link NvimTreeFolderIcon NonText

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
  au BufNewFile,BufRead *.p8 set filetype=lua

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
