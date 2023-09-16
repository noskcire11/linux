let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'psf/black', { 'branch': 'stable' }
Plug 'rafi/awesome-vim-colorschemes'
Plug 'lurst/austere.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'arcticicestudio/nord-vim'
call plug#end()

let g:lightline = {
   \  'colorscheme': 'nord',
   \ }
syntax on
colorscheme nord
filetype indent plugin on


""""""""""""
" coc.nvim "
""""""""""""
let g:coc_global_extensions = [
   \  'coc-pairs',
   \  'coc-tsserver',
   \  'coc-pyright',
   \  'coc-json',
   \  'coc-prettier',
   \  'coc-css',
   \  'coc-html'
      \ ]

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" use Control Space for trigger completion (vim)
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-@> coc#refresh()

" use Tab to select item in completion list
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <expr> <c-j> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
inoremap <expr> <c-k> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming
nmap <F2> <plug>(coc-rename)

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Format selected
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


""""""""""""
" nerdtree "
""""""""""""
let NERDTreeIgnore=['\.swp$', '\.git$']

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if &buftype != 'quickfix' && getcmdwintype() == '' | silent NERDTreeMirror | endif


"""""""
" fzf "
"""""""
nn <silent> <leader>b :Buffer<cr>
nn <silent> <leader>w :Windows<cr>
nn <silent> <leader>f :Files<cr>
nn <silent> <leader>gf :GFiles<cr>
nn <silent> <leader>h :History<cr>
nn <silent> <leader>hc :History:<cr>
nn <silent> <leader>hs :History/<cr>



cno JJ <C-c>
cno jj <C-c>
ino <Esc>h <Left>
ino <Esc>l <Right>
ino <Esc>j <Down>
ino <Esc>k <Up>
ino <C-h> <Left>
ino <C-l> <Right>
"ino <C-j> <Down>
"ino <C-k> <Up>
ino JJ <Esc>
ino jj <Esc>
map Y y$
nno <C-L> :nohl<CR><C-L>
nno <Space> @
nno , @@
nno <C-j> :tabn<CR><C-L>
nno <C-k> :tabp<CR><C-L>

set encoding=UTF-8
set autoindent
set backspace=indent,eol,start
set clipboard=unnamedplus
set confirm
set hlsearch
set ignorecase
set laststatus=2
set mouse=a
set nocompatible
set noshowmode
set nostartofline
set number
set pastetoggle=<F3>
set shiftwidth=2
set showcmd
set smartcase
set t_vb=
set tabstop=2
set timeoutlen=350
set visualbell
set wildmenu

set hidden
set nobackup
set nowritebackup
"set cmdheight=2
set updatetime=300
set shortmess+=c

if has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif
