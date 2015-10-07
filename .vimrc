set nocompatible

set number relativenumber
set cursorline
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab nosmarttab
set autoindent smartindent
set virtualedit=block


set encoding=utf-8
set scrolloff=3
set showmode showcmd
set hidden
set wildmenu
set wildmode=longest:full,full
set visualbell
set ttyfast
set ruler
set laststatus=2
set undofile
set history=50		" keep 50 lines of command line history

" allow backspacing over everything in insert mode
set backspace=indent,eol,start


set ignorecase
set smartcase
set gdefault
set incsearch
set hlsearch

if has("gui_running")
  set gfn=Ubuntu\ Mono\ derivative\ Powerline\ 13
  set lines=999 columns=999
endif



" don't know if I want this:
"set wrap
"set textwidth=79
"set formatoptions=qrn1
"set colorcolumn=85


" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'kien/ctrlp.vim'
Plugin 'xolox/vim-session'
Plugin 'xolox/vim-misc'
Plugin 'scrooloose/syntastic'
Plugin 'Valloric/YouCompleteMe'
Plugin 'Raimondi/delimitMate'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'powerman/vim-plugin-viewdoc'
Plugin 'marijnh/tern_for_vim'
Plugin 'joonty/vdebug'

"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"Vim Session
let g:session_autosave_periodic = 2
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_default_to_last = 1

" Airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" Color settings
set t_Co=256

" For the Solarized colorscheme. Won't look as designed, though (needs setting up custom colors)
let g:solarized_termcolors=256


" Ctrl P

let g:ctrlp_root_markers = ['.project']
let g:ctrlp_extensions = ['tag', 'buffertag']
let g:ctrlp_by_filename = 1
let g:ctrlp_buffer_func = { 'enter': 'BrightHighlightOn', 'exit':  'BrightHighlightOff',}

" A little hack to have the selected line in Ctrl-P look brighter
function BrightHighlightOn()
  let g:_myclbg = synIDattr(hlID('CursorLine'), 'bg#')
  "let g:_myclfg = synIDattr(hlID('CursorLine'), 'fg#')
  hi CursorLine ctermbg=23
 endfunction

function BrightHighlightOff()
  if g:_myclbg != -1
    exe "hi CursorLine ctermfg=NONE ctermbg=" . g:_myclbg
  endif

endfunction

" Syntastic stuff...
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" This enables the mouse. But I'd rather practice keyboard only
"if has('mouse')
"  set mouse=a
"endif


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")


" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif


"Exit with double shift-Q
nnoremap QQ :qa<CR>

" Alt + arrows to cycle buffers
nnoremap <A-Right> :bnext!<CR>
nnoremap <A-Left> :bprevious!<CR>

" Ctrl-F for files, Ctrl+J to jump to (initially local) tags
nnoremap <C-f> :CtrlP<CR>
nnoremap <C-j> :CtrlPBufTag<CR>

"Bubble single lines (kicks butt)
""http://vimcasts.org/episodes/bubbling-text/
nmap <C-Up> ddkP
nmap <C-Down> ddp

"Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]

"Inline left/right bubble by word (with room for improvement!)
vmap <C-S-Right> dwhp`[v`]
vmap <C-S-Left> dbhp`[v`]

"Normal/sane ('very magic') regex syntax
noremap / /\v
vnoremap / /\v

"Clear search highlighting
nnoremap <leader><space> :noh<cr>

"For easier parens matching/jumping. Might screw something else, maybe?
"nnoremap <tab> %
"vnoremap <tab> %

"Show highlight groups under cursor (handy when tweaking colorschemes, etc)
map <leader>h :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
      \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
      \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

"Prevents some flickering (useful for line bubbling)
set lazyredraw


"Color settings
syntax on
set background=dark
colorscheme molokai

"Custom patches (I find some colors too dark, parens matching confusing, etc.)
hi CursorLine ctermbg=235
hi Comment ctermfg=245
hi Delimiter ctermfg=148
hi Visual ctermbg=23
hi MatchParen cterm=bold ctermfg=226 ctermbg=bg



