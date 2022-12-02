" ==== PLUGIN INSTALLS=========================================================
call  plug#begin('~/.local/share/nvim/plugged')
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mattn/emmet-vim'
Plug 'mikelue/vim-maven-plugin'
Plug 'easymotion/vim-easymotion'
Plug 'ludovicchabant/vim-gutentags'
Plug 'roxma/nvim-yarp'            "for deoplete
Plug 'roxma/vim-hug-neovim-rpc'   "for deoplete
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-zsh'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/unite.vim'           " for vimFiler
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'Shougo/vimfiler.vim', { 'on': 'VimFiler' }
Plug 'Shougo/neco-vim'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'tmhedberg/SimpylFold'
Plug 'konfekt/fastfold'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'dracula/vim'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc'
call plug#end()

" ==== VARIABLE STUFF  =========================================================
" TAGS I need to finally learn to use
set tags=./tags;,tags
" nocompatible only matters for vim. neovim forever
set nocompatible
filetype plugin on
" Set swap directory so I can actually getfrid of stuff
set dir=/Users/afrankel02/logs/swap//
set backupdir=/Users/afrankel02/logs/swap//
set undodir=/Useres/afrankel02/logs/swap//
" some path / search stuff:
set path=.,**   " add filetype specific adds for STL stuff
set suffixesadd=.py,.txt,.csv,.java,.js,.c,.cpp
" allows switch between unsaved buffers:
set hidden 
" redraw screen less often
set lazyredraw
" syntax highlighting!
syntax on
" status bar lives forever. cool with powerline or wtvr 
set laststatus=2  
" Ignore case except at beginning of words
set ignorecase
set smartcase
" Experiment failed. I like no word wrap
set nowrap
" Adjust system undo levels
set undolevels=100
set undofile                " Save undos after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
set nopaste
" I need to figure out where I like these settings
set foldmethod=indent
set foldlevel=99
set foldnestmax=2
" Show matching parenthesis
set showmatch
" Set tab width and convert tabs to spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set noerrorbells
" dunno what full is but wildmenu is the lil autocomplete menu in :
set wildmenu
set wildmode=full
set wildignore=*.swp,*.bak
set wildignore+=*.pyc,*.cache,*.min.*,*.v
set wildignore+=*/.git/**/*,*/node_modules/**/*
" Number gutter
set number
" Use search highlighting and live regex highlighting (maybe that one plugin
" for better highlights
set hlsearch
set incsearch
" Space above/beside cursor from screen edges
set scrolloff=1
set sidescrolloff=2
" split focus stuff
set splitbelow
set splitright
" relative numbers
set relativenumber
" THINGS I NEED TO FIGURE OUT:
set ruler
set confirm
set autoread   " I think eliminates dem swaps
set backup
set mouse=r    
set conceallevel=1

" ==== KEY REMAPPING ===========================================================
let mapleader="\<SPACE>"
" shortcut for system copy paste
nnoremap <leader>y "=Y
 " lets me escape from search:
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>  
" This makes H/J/K/L work even on wrapped lines
nnoremap j gj
nnoremap k gk
" some shortcuts: EditVimRC and SourceVimRC
nnoremap <silent> <leader>ev  :vsplit /Users/afrankel02/dotfiles/vimrc<cr>
nnoremap <silent> <leader>sv :source ~/dotfiles/vimrc<cr>
"" Ale is cool
nnoremap <silent> <C-j> :ALEPrev<cr>
nnoremap <silent> <C-k> :ALENext<cr>
" Switch bufferss
" Need to replace with a vimscript that:
"   reacts to <leader>##
"   inputs :b (<tab> * number typed)
"   silent <cr>
nnoremap <silent> <leader>1 :b1 <cr>
nnoremap <silent> <leader>2 :b2 <cr>
nnoremap <silent> <leader>3 :b3 <cr>
nnoremap <silent> <leader>4 :b4 <cr>
nnoremap <silent> <leader>5 :b5 <cr>
nnoremap <silent> <leader>6 :b6 <cr>
nnoremap <silent> <leader>7 :b7 <cr>
nnoremap <silent> <leader>8 :b8 <cr>
nnoremap <silent> <leader>9 :b9 <cr>
nnoremap <silent> <leader>! :b10 <cr>
nnoremap <silent> <leader>@ :b11 <cr>
nnoremap <silent> <leader># :b12 <cr>
nnoremap <silent> <leader>$ :b13 <cr>
nnoremap <silent> <leader>% :b14 <cr>
nnoremap <silent> <leader>^ :b15 <cr>
nnoremap <silent> <leader>& :b16 <cr>
nnoremap <silent> <leader>* :b17 <cr>
nnoremap <silent> <leader>( :b18 <cr>
nnoremap <silent> <leader>) :b19 <cr>
nnoremap <silent> <leader>= :bnext <cr>
nnoremap <silent> <leader>- :bprev <cr>
nnoremap <silent> <leader><leader> :blast <cr>
nnoremap <silent> <leader>wq :w <cr> :bwipeout! <cr>
nnoremap <silent> <leader>q :bwipeout! <cr>
nnoremap <silent> <leader>ls :ls <cr>
" I think I still like vimfiler
nnoremap ` :VimFiler -explorer<CR>
nnoremap ~ :VimFilerCurrentDir -explorer -find<CR>
 " Switches buffers too
nnoremap <Leader><Leader> <c-^>  
nnoremap <Left> :vertical resize -1<CR>
nnoremap <Right> :vertical resize +1<CR>
nnoremap <Up> :resize -1<CR>
nnoremap <Down> :resize +1<CR>
" terminal shortcut
nnoremap <silent> <C-p> :vsplit <cr> :terminal <cr> :vertical resize 70 <cr> i ipython <cr>
nnoremap <silent> <C-t> :vsplit <cr> :terminal <cr> :vertical resize 70 <cr> i <cr>
" Disable arrow keys completely in Insert Mode
imap <up> fuck
imap <down> BOOP
imap <left> <nop>
imap <right> <nop>
" Terminal escape!
tnoremap <Esc> <C-\><C-n>

" ==== INDENT GUIDES ========================================================
let g:indent_guides_auto_colors = 1
let g:indent_guides_enable_on_vim_startup = 1
" === OTHER ====================================================================
" Seriously, you don't know half of this stuff. What does this do:
let g:python3_host_prog ="/usr/bin/python3"
let g:loaded_python_provider = 1    "    find out if that means i can play with it
colorscheme dracula
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter = 'unique_tail'  "I think this is tab titling
let g:airline_powerline_fonts=2
let g:spacegray_underline_search = 2
let g:spacegray_italicize_comments = 2
highlight Folded ctermfg=lightgray ctermbg=bg

" === DEFAULT VIM FILER ===============================================================
let g:netrw_banner = 1       " disable banner
let g:netrw_preview = 1      " open previews vertically
let g:netrw_list_hide = '.*\.swp,.git/,*.~'
let g:indentLine_char = '│'
let g:netrw_banner = 0
let g:netrw_browse_split = 1
let g:netrw_winsize = 25
" 
" === FOLDS ===============================================================
" I don't use folds enough
nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
let g:SimpylFold_docstring_preview = 1


"
" === DEOPLETE ===============================================================
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()
" refresh always can cause screen flicker
let g:deoplete#enable_at_startup = 1
" I prefer the path be where we started
let g:deoplete#auto_completion_start_length =0
" something to do with omni pattrerns
"if !exists('g:deoplete#omni#input_patterns')
  "let g:deoplete#omni#input_patterns = {}
"endif
" for now leave auto complete on:
" let g:deoplete#disable_auto_complete = 1
" this auto closes scratch window:
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" omnifuncs
augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end
" Tern
if exists('g:plugs["tern_for_vim"]')
  let g:tern_show_argument_hints = 'on_hold'
  let g:tern_show_signature_in_pum = 1
  autocmd FileType javascript setlocal omnifunc=tern#Complete
endif

" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" " This should turn off swap files for wiki
" Cause it crashes everything, Currently doesn't work
autocmd BufRead,BufNewFile,BufRead */wimwikimd/*.md set noswapfile
au BufNewFile,BufFilePre,BufRead *.md setfiletype=markdown
let g:vimwiki_list = [{'path': '~/vimwikimd/',
                       \ 'syntax': 'markdown', 'ext': '.md'}]
let g:pandoc#modules#disabled = [ "spell" ]

" The following sets default markdown interpreter rather than vimWiki
" autocmd FileType vimwiki set ft=markdown
" indent_levels = 30;

