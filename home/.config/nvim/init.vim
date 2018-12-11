if has('vim_starting')
  if &compatible
    set nocompatible
  endif
  if &shell =~# 'fish$'   "This is a compatibility fix for fish-shell and plugins
    set shell=sh
  endif
endif

let g:python_host_prog = '/Users/dos/.pyenv/versions/neovim2/bin/python2'
let g:python3_host_prog = '/Users/dos/.pyenv/versions/neovim3/bin/python3'

" ==== Most ALE settings want to be loaded before plugins
let g:ale_lint_on_enter = 1
let g:ale_open_list = 1

" ==== vim plug
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Core functionality
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim'}
Plug 'vim-airline/vim-airline'        " I like being on the airline
Plug 'vim-airline/vim-airline-themes' " my theme is here
Plug 'jremmen/vim-ripgrep'            " Ripgrep's time has come

" Play better w/ tmux
Plug 'christoomey/vim-tmux-navigator' " Seamless vim & tmux nav with C-hjkl
Plug 'wellle/tmux-complete.vim'

" The tpope section
Plug 'tpope/vim-fugitive'   " make git commands a thing
Plug 'tpope/vim-rhubarb'    " but use hub
Plug 'tpope/vim-surround'   " cs\" and cs' for surrounding
Plug 'tpope/vim-repeat'     " Make surround repeatable with .
Plug 'tpope/vim-commentary' " comment things with gc g<motion>c
Plug 'tpope/vim-endwise'    " Close my definitions like I close my braces

Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] } " Text Alignment plugin

Plug '/usr/local/opt/fzf'     " FZF navigation
Plug 'sheerun/vim-polyglot'   " Most language support
Plug 'rust-lang/rust.vim'     " Official Rust plugin
Plug 'dougireton/vim-chef'    " Sets filetypes with chef and sets path to make `gf` work with recipes
Plug 'blueyed/delimitMate'    " Autoadding closing braces
Plug 'airblade/vim-gitgutter' " Shows edits from git in gutter
Plug 'w0rp/ale'               " syntax checking and Language Server

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" My special plugins
Plug 'itspriddle/vim-marked'
Plug 'LokiChaos/vim-tintin'
call plug#end()

let g:deoplete#enable_at_startup = 1

" === Colorscheme
set background=dark
colorscheme Tomorrow-Night-Eighties

" ==== make nvim less annoyting
tnoremap jk <C-\><C-n>
tnoremap kj <C-\><C-n>
set clipboard+=unnamedplus

" ==== General sanity fixing
set encoding=utf-8
set fileencoding=utf-8
syntax enable
filetype plugin indent on
set backspace=indent,eol,start  "Allow backspace in insert mode
set list listchars=tab:→\ ,trail:∙,nbsp:+ " Display tabs and trailing spaces visually
set incsearch "Find the next match as we type the search
set nrformats= " blank nrf to make ^a always binary
set noswapfile
set nobackup
set nowritebackup
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set nowrap
set linebreak " Wrap lines at convenient points
set nofoldenable "no fold by default ever
set foldmethod=indent
set wildmode=list:longest,full
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches

" ==== Persistent Undo
" Keep undo history across sessions, by storing in file.
" Only works all the time.
let backupdir = expand('~/.local/share/nvim/backups')
if !isdirectory(backupdir)
  call mkdir(backupdir)
endif
set undodir=~/.local/share/nvim/backups
set undofile

" ==== Scrolling
set scrolloff     =8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff =15
set sidescroll    =1
" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="


" ================ My Cool shortcuts
let mapleader   = ","
let g:mapleader = ","

" <F1> = Disable help
nnoremap <F1> <nop>

" <F2> = Toggle line numbers
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR>

" <F3> = None
" nnoremap <F3> <nop>

" <F4> = change directory to current file's pwd
nnoremap <F4> :cd %:p:h<CR>:pwd<CR>

" <F5> = change directory to current file's pwd
nnoremap <F5> :call LanguageClient_contextMenu()<CR>

" <F6> = change directory to current file's pwd
nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>

" <F7> = Toggle paste mode
set pastetoggle=<F7>

" <F8> = next buffer

" <F9> = None
" nmap <F9> <nop>

" // = clears search highlight
nnoremap <silent> // :noh<CR>

nnoremap XX :qall!<CR>

" K = Disable man key
nnoremap K <nop>

" jk smash = esc! Seriously, esc on the homerow
inoremap jk <Esc>
inoremap kj <Esc>

" Y = copy from current character to end of line
" (mimic y0's behavior but backwards)
noremap Y y$

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" <Leader>b = blagfix (strip curlies)
nnoremap <Leader>b :StraightenQuotes<CR>

" <Leader>c = comment out
vnoremap <Leader>c :Commentary<CR>
nnoremap <Leader>c :Commentary<CR>

" <Leader>d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nnoremap <silent> <leader>d "_d
xnoremap <silent> <leader>d "_d

" <Leader>e = open vimrc in a split for quick editing
nnoremap <leader>e :tabnew $MYVIMRC<cr>

" <Leader>f = toggle all folding
noremap <Leader>f zi

" <Leader>h = Highlight changed lines using Git Gutter
noremap <Leader>h :GitGutterLineHighlightsToggle<CR>

" <Leader>p = paste at end of line
inoremap <Leader>p :normal $p
nnoremap <Leader>p $p

" <Leader>P = paste in next line
inoremap <Leader>P :normal pu<CR>
nnoremap <Leader>P :pu<CR>

" <Leader>q = Auto rewrap
vnoremap <Leader>q gq
nnoremap <Leader>q gqap

" <Leader>r = Reload vim config
noremap <Leader>r :so $MYVIMRC<CR>

" <Leader>s = Search under word in my current search obsession
noremap <Leader>s :Rg<CR>

" <Leader>w = Strip all whitespace (from yadr-whitespace-killer.vim)
nnoremap <Leader>w :StripTrailingWhitespaces<CR>

" <Leader>z = quick write/save
nnoremap <Leader>z :write<CR>

" :w!! = write a file as sudo
cmap w!! w !sudo tee % >/dev/null

" :Q = quit all fast
command! -nargs=0 Quit :qall!

" ==== Rust.vim
let g:rustfmt_autosave = 1

" ==== ale
let g:airline#extensions#ale#enabled = 1

" ==== deoplete
let g:tmuxcomplete#trigger = ''
let g:deoplete#enable_at_startup = 1

" ==== Plug
let g:plug_window = 'tabnew'

" ==== airline
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#whitespace#enabled = 1

" ==== GitGutter
let g:gitgutter_realtime = 0
let g:gitgutter_eager    = 0

" ==== Powerline
set laststatus=2

" ==== vim-tmux-navigator
let g:tmux_navigator_disable_when_zoomed = 1

" ==== Ripgrep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" ==== Srtraighten Quotes
function! <SID>StraightenQuotes()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/[”“„]/"/g
    %s/[`’‘]/'/g
    %s/[…]/.../g
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

command! StraightenQuotes call <SID>StraightenQuotes()

" ==== Strip trailing whitespace
" http://rails-bestpractices.com/posts/60-remove-trailing-whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

command! StripTrailingWhitespaces call <SID>StripTrailingWhitespaces()

" ==== Super wrapping power
" http://vimcasts.org/episodes/soft-wrapping-text/
function! SetupWrapping()
  set wrap linebreak nolist
  set showbreak=…
endfunction

command! -nargs=* Wrap :call SetupWrapping()

" ==== Sourcing plugin specific setting
if filereadable(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" ==== local .vimrc with .envrc using add_extra_vimrc
if exists("$EXTRA_VIM")
  for path in split($EXTRA_VIM, ':')
    exec "source ".path
  endfor
endif

if has("gui_vimr")
  set termguicolors
  source ~/.gvimrc
endif
