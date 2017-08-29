" =======================================
" Vim configuration file of Balazs Zatik.
" =======================================

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" If there is a GUI (gVIM).
if has("gui_running")
  set guifont=DejaVu_Sans_Mono:h11:cEASTEUROPE:qDRAFT
  set lines=999 columns=999
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Set encoding to UTF-8.
set encoding=utf-8
set fileencoding=utf-8

" Backup settings.
set backupdir=~/vimtmp,.
set undodir=~/vimtmp,.
set directory=~/vimtmp,.

" Set colors.
syntax on               " turn on syntax highlighting
colorscheme darkblue    " set the color scheme

" Search settings.
set hlsearch            " highlight search results
set incsearch           " turn on incremental searching
set ignorecase          " ignore case when searching

" Miscellaneous.
set history=200         " keep 200 lines of command line history
set ch=1		" command line height (how many lines)
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set wildmenu            " display completion matches in a status line

set ttimeout            " time out for key codes
set ttimeoutlen=100     " wait up to 100ms after Esc for special key

set number              " show line numbers
set scrolloff=3         " set scrolling offset
set display=truncate    " show @@@ in the last line if it is truncated
set nrformats-=octal    " do not recognize octal numbers for Ctrl-A and Ctrl-X
set mousehide		" hide the mouse when typing text

" Tab size.
set expandtab
set shiftwidth=2
set softtabstop=2

" Enable mouse if present.
if has('mouse')
  set mouse=a
endif

" Disable beeping and visual bell on errors.
set belloff=all

" Key mappings.
set backspace=indent,eol,start
map Q gq
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Make shift-insert work like in Xterm.
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

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
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent            " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif


" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit
