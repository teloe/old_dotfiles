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

" Mouse
set mouse=a

" Remap ; to :
nnoremap ; :

" Quick save
noremap <Leader>s :update<CR>

" Use Vim defaults
set nocompatible

" Keep undo history when switching buffers
set hidden

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

" Vertical split
nnoremap vs :vsplit

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
" map gn :bn<cr>
" map gp :bp<cr>
" map gd :bd<cr>

" Space to toggle folds.
autocmd FileType css,scss,vim set foldmethod=marker foldlevel=0
autocmd FileType javascript,json set foldmethod=marker foldlevel=99 foldmarker={,}
nnoremap <Space> za
vnoremap <Space> za

" Copy to osx clipboard
vnoremap <C-c> "*y<CR>"

" Markdown filetype
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

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

" For ag (silver searcher)
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

" call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})

" Remap :CocFix lint command
" nnoremap <leader>f :CocFix<CR>

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

" call dein#add('vim-airline/vim-airline')
" call dein#add('vim-airline/vim-airline-themes')
" let g:airline_theme='hybrid'
" let g:airline_theme='monochrome'
" let g:airline_theme='minimalist'
" let g:airline_theme='nord_minimal'

let g:webdevicons_enable_airline_statusline = 1
if !exists('g:airline_symbols')
let g:airline_symbols = {
  \ 'branch': '',
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
call dein#add('arcticicestudio/nord-vim')
call dein#add('navarasu/onedark.nvim')
let g:onedark_transparent_background = 1
call dein#add('chriskempson/base16-vim')
call dein#add('sickill/vim-monokai')
call dein#add('tomasiser/vim-code-dark')
call dein#add('jnurmine/Zenburn')
call dein#add('morhetz/gruvbox')
call dein#add('ulwlu/elly.vim')
call dein#add('rktjmp/lush.nvim')
call dein#add('casonadams/walh')
call dein#add('wbthomason/vim-nazgul')

" Color schemes
syntax on
set background=dark
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" colo ryuuko
" colo predawn
" colo raider
" colo bronzage
colo distill
" colo ds
" colo whitedust
" colo wm

" Custom colors/backgrounds
hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE
" hi! LineNr guibg=NONE 
hi! Comment gui=NONE
" hi! Folded guibg=NONE gui=NONE guifg=NONE
hi! SignColumn guibg=NONE
" hi! PMenu guibg=#202020 guifg=#D7D7CE
" hi! PMenu guibg=#2C2C2D
" hi! PMenuSel guibg=#8fffff guifg=#000000
" hi! CursorLine guibg=NONE
" hi! DiffChange guibg=#2C2C2D ctermbg=Black
" hi! DiffAdd guifg=#373b41
" hi! DiffDelete guibg=#2C2C2D ctermbg=Black
" hi! DiffText guibg=#2C2C2D 
" hi! Visual guifg=NONE guibg=#373b41 gui=NONE

" }}}

" Misc ------------------------------------------------- {{{

" Live markdown preview
call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'sh -c "cd app && yarn install"' })

" Vim repeat
call dein#add('tpope/vim-repeat')

" JSX syntax highlighting
call dein#add('yuezk/vim-js')
call dein#add('maxmellon/vim-jsx-pretty')
call dein#add('chemzqm/vim-jsx-improve')

" JS Highlighting
call dein#add('pangloss/vim-javascript')

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
\       'inline_elements': 'h1,h2,h3,h4,h5,h6,p,a,span,blockquote,strong,em,li',
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
" call dein#add('mhinz/vim-signify')
" call dein#add('tpope/vim-fugitive')

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
call dein#add('ryanoasis/vim-devicons')
" let g:webdevicons_enable_nerdtree = 0
call dein#add('tiagofumo/vim-nerdtree-syntax-highlight')

" }}}

" nvim v0.5 {{{

" Native nvim LSP
call dein#add('neovim/nvim-lspconfig')

" tsserver {{{
lua << EOF
require'lspconfig'.tsserver.setup{}
local nvim_lsp = require('lspconfig')
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
EOF

" Compe Autocompletion
call dein#add('hrsh7th/nvim-compe')
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

" Gitsigns
call dein#add('nvim-lua/plenary.nvim')
call dein#add('lewis6991/gitsigns.nvim')
set statusline+=%{get(b:,'gitsigns_status','')}

lua << EOF
require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  numhl = false,
  linehl = false,
  keymaps = {
    -- Default keymap options
    noremap = true,

    ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
    ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

    ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
    ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
  },
  watch_index = {
    interval = 1000,
    follow_files = true
  },
  current_line_blame = false,
  current_line_blame_delay = 1000,
  current_line_blame_position = 'eol',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  word_diff = false,
  use_internal_diff = true,  -- If luajit is present
}
EOF

" }}}

" html {{{
lua << EOF
require'lspconfig'.html.setup{}
EOF
" }}}

" css {{{
lua << EOF
require'lspconfig'.cssls.setup{}
EOF
" }}}

" Treesitter
call dein#add('nvim-treesitter/nvim-treesitter', {'hook_post_update': 'TSUpdate'})

" Lualine
call dein#add('hoob3rt/lualine.nvim')

" lua << EOF
" require('lualine').setup{
    " options = {theme = 'onedark'}
" }
" EOF

" Eviline {{{
lua << EOF
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require 'lualine'

-- Color table for highlights
local colors = {
  bg = '#202328',
  fg = '#bbc2cf',
  yellow = '#ECBE7B',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#98be65',
  orange = '#FF8800',
  violet = '#a9a1e1',
  magenta = '#c678dd',
  blue = '#51afef',
  red = '#ec5f67'
}

local conditions = {
  buffer_not_empty = function() return vim.fn.empty(vim.fn.expand('%:t')) ~= 1 end,
  hide_in_width = function() return vim.fn.winwidth(0) > 80 end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = "",
    section_separators = "",
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = {c = {fg = colors.fg, bg = colors.bg}},
      inactive = {c = {fg = colors.fg, bg = colors.bg}}
    }
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {}
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {}
  }
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function() return '▊' end,
  color = {fg = colors.blue}, -- Sets highlighting of component
  left_padding = 0 -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red
    }
    vim.api.nvim_command(
        'hi! LualineMode guifg=' .. mode_color[vim.fn.mode()] .. " guibg=" ..
            colors.bg)
    return ''
  end,
  color = "LualineMode",
  left_padding = 0
}

ins_left {
  -- filesize component
  function()
    local function format_file_size(file)
      local size = vim.fn.getfsize(file)
      if size <= 0 then return '' end
      local sufixes = {'b', 'k', 'm', 'g'}
      local i = 1
      while size > 1024 do
        size = size / 1024
        i = i + 1
      end
      return string.format('%.1f%s', size, sufixes[i])
    end
    local file = vim.fn.expand('%:p')
    if string.len(file) == 0 then return '' end
    return format_file_size(file)
  end,
  condition = conditions.buffer_not_empty
}

ins_left {
  'filename',
  condition = conditions.buffer_not_empty,
  color = {fg = colors.magenta, gui = 'bold'}
}

ins_left {'location'}

ins_left {'progress', color = {fg = colors.fg, gui = 'bold'}}

ins_left {
  'diagnostics',
  sources = {'nvim_lsp'},
  symbols = {error = ' ', warn = ' ', info = ' '},
  color_error = colors.red,
  color_warn = colors.yellow,
  color_info = colors.cyan
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {function() return '%=' end}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then return msg end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = {fg = '#ffffff', gui = 'bold'}
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  upper = true, -- I'm not sure why it's upper case either ;)
  condition = conditions.hide_in_width,
  color = {fg = colors.green, gui = 'bold'}
}

ins_right {
  'fileformat',
  upper = true,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = {fg = colors.green, gui = 'bold'}
}

ins_right {
  'branch',
  icon = '',
  condition = conditions.check_git_workspace,
  color = {fg = colors.violet, gui = 'bold'}
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = {added = ' ', modified = '柳 ', removed = ' '},
  color_added = colors.green,
  color_modified = colors.orange,
  color_removed = colors.red,
  condition = conditions.hide_in_width
}

ins_right {
  function() return '▊' end,
  color = {fg = colors.blue},
  right_padding = 0
}

-- Now don't forget to initialize lualine
lualine.setup(config)
EOF

" }}}


" Minimap
" call dein#add('wfxr/minimap.vim')
" let g:minimap_width = 10
" let g:minimap_auto_start = 1
" let g:minimap_auto_start_win_enter = 1

" Barbar buffer management
call dein#add('kyazdani42/nvim-web-devicons')
call dein#add('romgrk/barbar.nvim')
" Move to previous/next
nnoremap <silent>    bp :BufferPrevious<CR>
nnoremap <silent>    bn :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    b< :BufferMovePrevious<CR>
nnoremap <silent>    b> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    b1 :BufferGoto 1<CR>
nnoremap <silent>    b2 :BufferGoto 2<CR>
nnoremap <silent>    b3 :BufferGoto 3<CR>
nnoremap <silent>    b4 :BufferGoto 4<CR>
nnoremap <silent>    b5 :BufferGoto 5<CR>
nnoremap <silent>    b6 :BufferGoto 6<CR>
nnoremap <silent>    b7 :BufferGoto 7<CR>
nnoremap <silent>    b8 :BufferGoto 8<CR>
nnoremap <silent>    b9 :BufferLast<CR>
" Close buffer
nnoremap <silent>    bc :BufferClose<CR>
" Wipeout buffer
"                       :BufferWipeout<CR>
" Close commands
"                       :BufferCloseAllButCurrent<CR>
"                       :BufferCloseBuffersLeft<CR>
"                       :BufferCloseBuffersRight<CR>
" Magic buffer-picking mode
nnoremap <silent>    bp :BufferPick<CR>
" Sort automatically by...
nnoremap <silent>    bd :BufferOrderByDirectory<CR>
nnoremap <silent>    bl :BufferOrderByLanguage<CR>

" Other:
" :BarbarEnable - enables barbar (enabled by default)
" :BarbarDisable - very bad command, should never be used

" }}}

if dein#check_install()
    call dein#install()
endif

" End dein
call dein#end()
call dein#save_state()

filetype plugin indent on

