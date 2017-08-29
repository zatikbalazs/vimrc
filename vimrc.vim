" =======================================
" Vim configuration file of Balazs Zatik.
" =======================================

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc.
set nocompatible

" If there is a GUI (gVim).
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

" Make centralized backup directories.
set backupdir=~/vimtmp,.
set undodir=~/vimtmp,.
set directory=~/vimtmp,.

" Make Vim colorful.
syntax on               " turn on syntax highlighting
colorscheme darkblue    " set the color scheme

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Configure how tabbing works.
set expandtab
set shiftwidth=2
set softtabstop=2

" Search settings.
set hlsearch            " highlight search results
set incsearch           " turn on incremental searching
set ignorecase          " ignore case when searching
set smartcase           " match case when using capital letters

" Miscellaneous.
set number              " show line numbers on the left
set history=200         " keep 200 lines of command line history
set cmdheight=2		" set the command window height to 2 lines
set ruler               " show the cursor position all the time
set laststatus=2        " always display the status line at the bottom
set showcmd             " show partial commands in the last line of the screen
set wildmenu            " better command-line completion
set scrolloff=3         " set scrolling offset
set display=truncate    " show @@@ in the last line if it is truncated
set nrformats-=octal    " do not recognize octal numbers for Ctrl-A and Ctrl-X
set mousehide		" hide the mouse when typing text

" Enable mouse for all modes.
if has('mouse')
  set mouse=a
endif

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Instead of failing a command because of unsaved changes, raise a dialogue
" asking if you wish to save changed files.
set confirm

" Quickly time out on keycodes, but never time out on mappings.
set notimeout ttimeout ttimeoutlen=200

" Disable beeping and visual bell on errors.
set belloff=all

" Allow backspacing over autoindent, line breaks and start of insert action.
set backspace=indent,eol,start


" Key mappings.
" -------------
map Q gq
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default.
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search.
nnoremap <C-L> :nohl<CR><C-L>

" Use <F11> to toggle between 'paste' and 'nopaste'.
set pastetoggle=<F11>

" Make shift-insert work like in Xterm.
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>


" Only do this part when compiled with support for autocommands.
" --------------------------------------------------------------
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gVim).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

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
" ----------------------
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
packadd matchit
