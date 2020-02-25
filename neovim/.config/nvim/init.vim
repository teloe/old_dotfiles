" --------------------------------------------
"  _____                       _              
" |_   _|__ _ __  ___  _ ___ _(_)_ __  _ _ __ 
"   | |/ _ \ '  \(_-< | ' \ V / | '  \| '_/ _|
"   |_|\___/_|_|_/__/ |_||_\_/|_|_|_|_|_| \__|
"
"   repo: https://github.com/teloe/dotfiles/  
" --------------------------------------------

set encoding=utf8

" Settings --------------------------------------------- {{{

" Remap leader key to ,
let g:mapleader=','

" Remap ; to :
nnoremap ; :

" Quick save
noremap <Leader>s :update<CR>

" Use Vim defaults
set nocompatible

set path+=**
set fo+=t
set linebreak
set wrap
set laststatus=2

" Show line numbers
set number

" Show the cursor position
set ruler

" Display all matching files when tab complete
set wildmenu

" Disable swap files
set noswapfile

set autoindent

" Number of spaces of tab character
set tabstop=4

" Number of spaces to autoindent
set shiftwidth=4

" Convert tabs to spaces
set expandtab

" Split new window below the current one
set splitbelow

" Split new window to the right of current
set splitright

" Move freely around files
set whichwrap+=<,>,h,l,[,]

" Move cursor to end of line while in insert mode
inoremap <C-e> <Esc>A

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" Navigate beginning/ end of line move up/ down 5 lines
noremap H ^
noremap L g_
noremap J 5j
noremap K 5k

" Toggle windows
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Vertical resize current buffer by 10 
nnoremap <right> :vertical resize +10<CR>
nnoremap <left> :vertical resize -10<CR>

" Clear search
map <silent> <esc> :noh<cr>

" Simpler go to next
noremap <C-n> <C-f>n

" Show quotation marks in json files
autocmd Filetype json let g:indentLine_enabled=0

" Buffers
map gn :bn<cr>
map gp :bp<cr>
map gd :bd<cr>

" Space to toggle folds.
autocmd FileType css,scss,vim set foldmethod=marker foldlevel=0
autocmd FileType javascript,json set foldmethod=marker foldlevel=99 foldmarker={,}
nnoremap <Space> za
vnoremap <Space> za

" Copy to osx clipboard
vnoremap <C-c> "*y<CR>"

" Markdown filetype
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Show quotation marks in json files
autocmd Filetype json let g:indentLine_enabled=0

" }}}

" Dein Setup ------------------------------------------- {{{

if (!isdirectory(expand("$HOME/.config/nvim/repos/github.com/Shougo/dein.vim")))
    call system(expand("mkdir -p $HOME/.config/nvim/repos/github.com"))
    call system(expand("git clone https://github.com/Shougo/dein.vim $HOME/.config/nvim/repos/github.com/Shougo/dein.vim"))
endif

set runtimepath+=~/.config/nvim/repos/github.com/Shougo/dein.vim/
call dein#begin(expand('~/.config/nvim'))

call dein#add('Shougo/dein.vim')
call dein#add('haya14busa/dein-command.vim')
call dein#add('wsdjeg/dein-ui.vim')

if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
endif

" }}}

" Denite ----------------------------------------------- {{{

call dein#add('Shougo/denite.nvim')

" Mappings
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
endfunction

autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
    imap <silent><buffer> <C-o>
    \ <Plug>(denite_filter_quit)
    inoremap <silent><buffer><expr> <Esc>
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> <Esc>
    \ denite#do_map('quit')
    inoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    inoremap <silent><buffer><expr> <C-t>
    \ denite#do_map('do_action', 'tabopen')
    inoremap <silent><buffer><expr> <C-v>
    \ denite#do_map('do_action', 'vsplit')
    inoremap <silent><buffer><expr> <C-h>
    \ denite#do_map('do_action', 'split')
endfunction

nmap <leader>b :Denite buffer<CR>
nmap <leader>t :Denite file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Change file/rec command.
call denite#custom#var('file/rec', 'command',
\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" For ripgrep
" call denite#custom#var('file/rec', 'command',
" \ ['rg', '--files', '--glob', '!.git'])

" Recommended defaults for ripgrep via Denite docs
" call denite#custom#var('grep', 'command', ['rg'])
" call denite#custom#var('grep', 'default_opts',
        " \ ['-i', '--vimgrep', '--no-heading'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
" call denite#custom#var('grep', 'separator', ['--'])
" call denite#custom#var('grep', 'final_opts', [])

" For ag
call denite#custom#var('file/rec', 'command',
\ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

" Recommended defaults for ag via Denite docs
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts',
        \ ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Custom options
let s:denite_options = {'default' : {
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': '> ',
\ 'statusline': 0,
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)

" }}}

" Coc.nvim --------------------------------------------- {{{

call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})

" Remap :CocFix lint command
nnoremap <leader>f :CocFix<CR>

" }}}

" NerdTree --------------------------------------------- {{{

call dein#add('scrooloose/nerdtree')

nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1

" Show hidden files/directories
let g:NERDTreeShowHidden = 1

" Disable cursorline
let NERDTreeHighlightCursorline=0

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" Custom icons for expandable/expanded directories
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" Remove the arrows next to directories
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

" }}}

" Airline ---------------------------------------------- {{{

call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
let g:airline_theme='hybrid'

let g:webdevicons_enable_airline_statusline = 1
if !exists('g:airline_symbols')
let g:airline_symbols = {
  \ 'branch': 'ᚠ',
  \ 'modified': ' •'
  \}
endif

" let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#left_sep = " "

" let g:airline#extensions#branch#format = 0
let g:airline_detect_spelllang=0
let g:airline_detect_spell=0
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
" let g:airline_section_c = '%f%m'
" let g:airline_section_x = ''
" let g:airline_section_y = ''
" let g:airline_section_z = '%l:%c'
let g:airline#parts#ffenc#skip_expected_string=''

" }}}

" UI --------------------------------------------------- {{{

call dein#add('flazz/vim-colorschemes')

" Color schemes
syntax on
set background=dark
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colo primetime
" colo ambient 

" Transparent backgrounds
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
hi! LineNr ctermfg=NONE guibg=NONE
hi! SignifySignAdd guibg=NONE
hi! SignifySignDelete guibg=NONE
hi! SignifySignChange guibg=NONE
" hi! Visual  guifg=NONE guibg=#4f5b66 gui=NONE

" }}}

" Misc ------------------------------------------------- {{{

" Auto-close plugin
call dein#add('rstacruz/vim-closer')

" Surround things in quotes, brackets, etc.
call dein#add('tpope/vim-surround')

" Multiple cursors
call dein#add('terryma/vim-multiple-cursors')
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0

" Highlight matching HTML tags
call dein#add('Valloric/MatchTagAlways')

" Improved motion in Vim
call dein#add('easymotion/vim-easymotion')

" Emmet
call dein#add('mattn/emmet-vim')
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_settings = {
\   'html' : {
\       'indentation' : '    ',
\       'inline_elements': 'h1,h2,h3,h4,h5,h6,p,a,span,blockquote,strong,em',
\       'indent_blockelement': 1,
\   },
\   'php' : {
\       'extends' : 'html',
\       'filters' : 'html',
\   },
\}

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Git
call dein#add('mhinz/vim-signify')
call dein#add('tpope/vim-fugitive')

" Tmux/Neovim movement integration
call dein#add('christoomey/vim-tmux-navigator')

" NERD Commenter
call dein#add('scrooloose/nerdcommenter')
let NERDSpaceDelims=1

call dein#add('jiangmiao/auto-pairs')
call dein#add('tpope/vim-unimpaired')

" Indentation guides
call dein#add('Yggdroot/indentLine')

" Icons
" call dein#add('ryanoasis/vim-devicons')
" let g:webdevicons_enable_nerdtree = 0
" call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

" }}}

if dein#check_install()
    call dein#install()
endif

" End dein
call dein#end()
call dein#save_state()

filetype plugin indent on
