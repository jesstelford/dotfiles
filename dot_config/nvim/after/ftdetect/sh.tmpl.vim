" chezmoi uses golang templates within bash files, but the default of vim-go is
" to highlight it as templates within html files. Here, we overwrite that
" setting.
au BufRead,BufNewFile *.sh.tmpl set filetype=sh.gotexttmpl
