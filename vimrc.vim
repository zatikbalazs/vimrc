" ===========================
" Vimrc file of Balazs Zatik.
" ===========================
"
" How to use this file:
" ---------------------
" 1. Clone the repo anywhere on your hard disk.
" 2. In your default .vimrc file include the following line:
"    source /your/path/to/vimrc/vimrc.vim
" 3. Create folder at ~/vimtmp to store backups and temporary files.
" 4. You are done. Happy Vimming!
"
"
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc.
set nocompatible

" If there is a GUI (gVim).
if has("gui_running")
  set guifont=DejaVu_Sans_Mono:h11:cEASTEUROPE:qDRAFT   " set the GUI font
  set lines=999 columns=999                             " default window size
  set mousehide                                         " hide mouse when typing
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" Set encoding to UTF-8.
set encoding=utf-8
set fileencoding=utf-8

" Use centralized backup directories.
set backupdir=~/vimtmp,.
set undodir=~/vimtmp,.
set directory=~/vimtmp,.

" File browser.
let g:netrw_banner=0      " disable banner
let g:netrw_liststyle=3   " tree view

" Finding files.
" --------------
" Search down into subfolders.
" Provides tab-completion for all file-related tasks.
set path+=**

" Make Vim colorful.
syntax on               " turn on syntax highlighting
colorscheme darkblue    " set the color scheme

" Make the 81st column stand out.
highlight ColorColumn ctermbg=magenta
set colorcolumn=81

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

" Make shady characters visible.
set listchars=tab:~~,nbsp:~,trail:~
set list

" Search settings.
set hlsearch            " highlight search results
set incsearch           " turn on incremental searching
set ignorecase          " ignore case when searching
set smartcase           " match case when using capital letters

" Miscellaneous.
set number              " show line numbers on the left
set relativenumber      " line numbers as relative numbers
set history=200         " keep 200 lines of command line history
set cmdheight=2         " set the command window height to 2 lines
set ruler               " show the cursor position all the time
set laststatus=2        " always display the status line at the bottom
set showcmd             " show partial commands in the last line of the screen
set wildmenu            " better command-line completion
set scrolloff=3         " set scrolling offset
set nrformats-=octal    " do not recognize octal numbers for Ctrl-A and Ctrl-X

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

" Snippets.
nnoremap ,html :-1read vimrc/snippets/html.html<CR>3j11li

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


" Tips & Tricks
" =============
" Get help: :help, :he {subject}
" Move cursor one character at a time: h,j,k,l
" Move cursor to the highest position on the page: H
" Move cursor to the middle position on the page: M
" Move cursor to the lowest position on the page: L
" Move screen half a page down: CTRL + d
" Move screen half a page up: CTRL + u
" Move screen so that current line is at the center: zz
" Go to first line of the file: gg
" Go to last line of the file: G
" Go to line {i} of the file: {i}G
" Insert text before the cursor: i
" Insert text before the first non-blank character in the line: I
" Append text after the cursor: a
" Append text at the end of the line: A
" Begin a new line below the cursor and insert text: o
" Begin a new line above the cursor and insert text: O
" Change word: cw
" Change inside word: ciw
" Change inside tags: cit
" Change inside {symbol}: ci{symbol}
" Delete inside {symbol}: di{symbol}
" Yank inside {symbol}: yi{symbol}
" Change until end of line: c$
" Yank until end of line: Y
" Delete until end of line: D
" Delete characters under and after the cursor: x
" Delete characters before the cursor: X
" Delete the characters under the cursor until the end of the line: D
" Delete line: dd
" Delete selected text and/or lines: d
" Replace the character under the cursor: r
" Replace characters continuously: R
" Switch case of character or selected text: ~
" Set a mark to be referenced from within the current file: m + {a-z}
" Set a mark that can be referenced from other files as well: m + {A-Z}
" Jump to a mark: '{a-zA-Z}
" Jump to next line with a lowercase mark: ]'
" Jump to previous line with a lowercase mark: ['
" List marks: :marks
" Delete marks: :delmarks, :delm {a-zA-Z}
" Delete all lowercase marks for the current buffer (a-z): :delmarks!, :delm!
" Open file browser: :edit., :e.
" File browser help: :help netrw
" Make browsing directory the current directory: c
" Find a file in current directory: :find filename + TAB
" Open file in a tab from file browser: t
" Delete a file from the directory: D
" Create a new directory: d
" Create a new file: :tabe filename
" Rename file: R
" List all tabs: :tabs
" Go to next tab: gt
" Go to previous tab: gT
" Go to tab in position i: {i}gt
" Go to first tab: :tabfirst
" Go to last tab: :tablast
" Move current tab to first: :tabm 0
" Move current tab to last: :tabm
" Move current tab to position i+1: :tabm {i}
" Close all other tabs (show only the current tab): :tabonly
" Show each buffer in a tab: :tab ball
" List buffers: :ls
" Go to next buffer: :bn
" Go to previous buffer: :bp
" Go to buffer #{i}: :b{i}
" Delete buffer #{i}: :bd{i}
" Wipe out buffer #{i}: :bw{i}
" Search buffers by filename: :b filename + TAB
" Find all occurrences of text: *
" Jump to next search result: n
" Jump to previous search result: N
" Find in current file (forward): /searchterm
" Find in current file (backward): ?searchterm
" Find and replace (substitute) all occurrences in current file: :%s/old/new/gc
" Count all occurrences in current file: :%s/searchterm//gn
" Remove highlighting of search results: CTRL + l
" Jump to matching symbols: %
" Autocomplete text: CTRL + n, CTRL + p
" Autocomplete file name: CTRL + x CTRL + f
" Open file under cursor: gf
" Copy to system clipboard: "*y
" Paste from system clipboard: "*p
" Undo changes: u
" Undo all latest changes on one line: U
" Redo changes: CTRL + r
" Repeat last command: .
" Save current file: :w
" Quit file: :q
" Quit without saving: :q!
" Save current file and quit: :wq
" Save current file and quit: ZZ
" Save all files: :wa
" Quit all files: :qa
