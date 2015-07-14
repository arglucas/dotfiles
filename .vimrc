" vim Config
" Originally based on config from http://dougblack.io/words/a-good-vimrc.html

" Enable pathogen for path management (~/.vim/bundle/* will have runtimepath mapped).
call pathogen#infect()
"call pathogen#runtime_append_all_bundles()

" Colours {{{
" Syntax and colouring
syntax on
colorscheme badwolf
" }}}

" Spaces and Tabs {{{
set tabstop=4     " visual spaces per TAB
set softtabstop=4 " spaces inserted by tab and deleted when backspace is hit
set expandtab     " tabs are spaces
" }}}

" UI Config {{{
set number        " line numbers
set showcmd       " show command in bottom bar
set cursorline    " highlight current line

filetype indent on " load filetype-specific indent files

set wildmenu      " visual autocomplete for command menu

set lazyredraw    " redraw only when we need to.

set showmatch     " highlight matching [{()}]
" }}}

" Searching {{{
set incsearch     " search as characters are entered
set hlsearch      " highlight matches
"    turn off search highlight using ,<space> (needed when using search highlight)
nnoremap <leader><space> :nohlsearch<CR>
" }}}

" Folding {{{
set foldenable    " enable folding
set foldlevelstart=10 " open most folds by default
"    space open/closes folds, remapping from za
nnoremap <space> za
" }}}

" Movement (commented out)
"    move vertically by visual line
"nnoremap j gj
"nnoremap k gk
"    move to beginning/end of line
"nnoremap B ^
"nnoremap E $
"    $/^ doesn't do anything
"nnoremap $ <nop>
"nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" Leader Shortcuts
let mapleader="," " leader is a comma (swap from \)
"    jk is escape (<ESC> is far away keep on home row), if you need to type jk:  j <PAUSE> k
inoremap jk <esc>
"    toggle Gundo (Graphical Undo)
nnoremap <leader>u :GundoToggle<CR>
"    edit vimrc/zshrc and load vimrc bindings
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>ez :vsp ~/.zshrc<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
"    save session (save session/window layout) reopen vim -S
nnoremap <leader>s :mksession<CR>
"    open ag.vim (Silver Searcher)
"set runtimepath^=~/.vim/bundle/ag
nnoremap <leader>a :Ag 

" CtrlP settings {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" }}}

" Tmux {{{
" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}

" AutoGroups {{{
" language specific settings (only apply once - augroup)
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md
                \:call <SID>StripTrailingWhitespaces()
    autocmd FileType java setlocal noexpandtab
    autocmd FileType java setlocal list
    autocmd FileType java setlocal listchars=tab:+\ ,eol:-
    autocmd FileType java setlocal formatprg=par\ -w80,\ -T4
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd FileType ruby setlocal tabstop=2
    autocmd FileType ruby setlocal shiftwidth=2
    autocmd FileType ruby setlocal softtabstop=2
    autocmd FileType ruby setlocal commentstring=#\ %s
    autocmd FileType python setlocal commentstring=#\ %s
    autocmd BufEnter *.cls setlocal filetype=java
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
" }}}

" Backups {{{
" create a backup file (file~) and put in /tmp
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup
" }}}

" Custom Functions {{{
" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" strips trailing whitespace at the end of files. This
" is called on the buffer write in the autogroup above.
function! <SID>StripTrailingWhitespaces()
    " save last search & cursor position
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

set modelines=1

" vim:foldmethod=marker:foldlevel=0
