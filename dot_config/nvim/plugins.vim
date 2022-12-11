" --------
" vim-plug
" --------
" Load the plugins
let plugin_dir = has('nvim') ? stdpath('data') . '/bundle' : '~/.vim/bundle'
call plug#begin(plugin_dir)

Plug 'andymass/vim-matchup', { 'commit': '7fd8806' }
Plug 'ap/vim-css-color', { 'commit': '0eb967a' }
" Easily change word casing with motions, text objects or visual mode. This
" plugin is largely inspired by Tim Pope's vim-abolish
Plug 'arthurxavierx/vim-caser', { 'commit': '6bc9f41' }
Plug 'christoomey/vim-tmux-navigator', { 'commit': '9ca5bfe' }
Plug 'crusoexia/vim-monokai', { 'commit': '66f7dc9' }
Plug 'digitaltoad/vim-pug', { 'commit': 'ea39cd9' }
Plug 'EdenEast/nightfox.nvim', { 'commit': '15f3b58' }
Plug 'ellisonleao/gruvbox.nvim', { 'commit': 'dc6bae9' }
Plug 'folke/lsp-colors.nvim', { 'commit': '4e6da19' }
Plug 'folke/tokyonight.nvim', { 'commit': '9fba0cd' }
" Mega list window thing for errors, hints, lsp diagnostics, etc
Plug 'folke/trouble.nvim', { 'commit': '691d490' }
"Plug 'honza/vim-snippets', { 'commit': '3c40345' }
Plug 'jose-elias-alvarez/null-ls.nvim', { 'commit': '4eb2fa8' }
Plug 'jose-elias-alvarez/nvim-lsp-ts-utils', { 'commit': '1d2c585' }
Plug 'jparise/vim-graphql', { 'commit': '15c5937' }
" `ga` then some character to align text vertically by that character
Plug 'junegunn/vim-easy-align', { 'commit': '12dd631' }
" Vim help for vim-plug itself (e.g. :help plug-options)
Plug 'junegunn/vim-plug', { 'commit': 'e300178' }
Plug 'kyazdani42/nvim-tree.lua', { 'commit': '4a725c0' }
Plug 'kyazdani42/nvim-web-devicons', { 'commit': '4415d1a' }
Plug 'lewis6991/gitsigns.nvim', { 'commit': '3791dfa' }
" <leader><leader><motion> then select from the a-z as shown on the screen
" hightlighted in red
Plug 'lukas-reineke/indent-blankline.nvim', { 'commit': '9915d46' }
Plug 'moll/vim-node', { 'commit': 'ede0477' }
" TODO: Find a modern version of this
"Plug 'myusuf3/numbers.vim', { 'commit': '1867e76' }
Plug 'NLKNguyen/papercolor-theme', { 'commit': '5465702' }
Plug 'neovim/nvim-lspconfig', { 'commit': '48e59a4' }
Plug 'nvim-lua/plenary.nvim', { 'commit': '0d66015' }
Plug 'nvim-lualine/lualine.nvim', { 'commit': '181b143' }
Plug 'nvim-telescope/telescope.nvim', { 'commit': '1a72a92' }
" Add fzf as the sorter for telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'commit': '8ec164b', 'do': 'make' }
Plug 'nvim-treesitter/nvim-treesitter', { 'commit': '9e8749f', 'do': ':TSUpdate' }
Plug 'nvim-treesitter/playground', { 'commit': '9df82a2' }
Plug 'Pamplemousse/badWords', { 'commit': '467f330' }
Plug 'projekt0n/github-nvim-theme', { 'commit': 'a0632f9' }
" required by ellisonleao/gruvbox.nvim
Plug 'rktjmp/lush.nvim', { 'commit': '87e9039' }
" TODO: Is there a modern alternative (that uses devicons, etc), but still uses
" the same commands I'm used to?
" <F8> (or :e /path/to/dir) to open file browser
" (F6 hotkey already setup) - Visual VIM Undo tree
Plug 'sjl/gundo.vim', { 'commit': 'c5efef1' }
Plug 'tikhomirov/vim-glsl', { 'commit': '28a6dfb' }
" Plurals search / replace (:S), and: crs (coerce to snake_case), MixedCase
" (crm), camelCase (crc), and UPPER_CASE (cru)
Plug 'tpope/vim-abolish', { 'commit': '3f0c8fa' }
" Commenting: [n]gcc to comment out lines, gc[motion] to comment out motion
Plug 'tpope/vim-commentary', { 'commit': '627308e' }
" Add %{fugitive#statusline()} to 'statusline' to get an indicator with the
" current branch in (surprise!) your statusline.
Plug 'tpope/vim-fugitive', { 'commit': '46652a3' }
Plug 'tpope/vim-jdaddy', { 'commit': '5cffddb' }
Plug 'tpope/vim-obsession', { 'commit': '82c9ac5' }
Plug 'tpope/vim-repeat', { 'commit': '24afe92' }
" Date manipulation: Ctrl-A & Ctrl-X to Increment / Decrement a datetime
Plug 'tpope/vim-speeddating', { 'commit': '95da3d7' }
" Quoting / Parenthasising: cs"' to swap double quotes with single quotes
Plug 'tpope/vim-surround', { 'commit': 'baf89ad' }
" common commands: :h unimpaired
Plug 'tpope/vim-unimpaired', { 'commit': 'f992923' }
" I wish this workd better, but it's unreliable
"Plug 'windwp/nvim-ts-autotag', { 'commit': '0ceb4ef' }
" IDE-like commands for interacting with LSPs like code actions, diagnostics in
" floats, etc
Plug 'glepnir/lspsaga.nvim', { 'commit': 'f33bc99' }
" golang syntaix higlighting support (also chezmoi .tmpl file highlighting)
Plug 'fatih/vim-go', { 'commit': 'dcefd64', 'do': ':GoUpdateBinaries', 'frozen': 1 }
Plug 'rebelot/kanagawa.nvim', { 'commit': 'dda1b8c' }
Plug 'b0o/SchemaStore.nvim', { 'commit': '0a3f765' }
Plug 'JoosepAlviste/nvim-ts-context-commentstring', { 'commit': '8834375' }
Plug 'karb94/neoscroll.nvim', { 'commit': '07242b9' }
" PICO8 syntax, indent, sprite colour, and folding support
" Add `-- vim: set ft=pico8:` to .lua files to have them highlighted (mostly)
" correctly
Plug 'Bakudankun/PICO-8.vim', { 'commit': '34f8442' }

" NOTE: internally calls: filetype indent on, syntax on
call plug#end()
