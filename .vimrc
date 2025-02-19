" .vimrc Configuration File

" This file is run on vim startup, and contains your settings
" Place this file as ~/.vimrc to have it automatically run on startup

" Open this file with vim to get it syntax highlighted

" If this file messes up your vim configuration, you can start vim
" with no initialisations with `vim -u NONE`

" This flag is needed to make sure when loading this file with 
" `vim -U filename`, it behaves as if it were the global ~/.vimrc
set nocompatible

" Set syntax highlighting on
syntax on

" Display relative numbers for lines above and below, but the actual 
" line number for the cursor line
set number
set relativenumber

" Display column and line number in the bottom right
set ruler

" Display the current command being typed in the bottom right
" Most of the time, the current command will just flash briefly,
" but it is helpful for commands like f{char}
set showcmd

" Always display the status line
set laststatus=2

" Allow you to backspace before insertion point i
set backspace=indent,eol,start

" Allow mouse use for highlighting, scrolling, etc
" not recommended that you do this, but it is nice to have the option
set mouse=a

" Allow you to hide buffers which are unsaved
set hidden

" Set no error bell sound
set noerrorbells visualbell t_vb=

" Use case insensitive searching when the search string is lowercase,
" But case sensitive when at least one character is uppercase
set ignorecase
set smartcase

" Use incremental search, enable searching as you type
set incsearch

" Highlight search terms when enter is pressed
" use `:nohls` to turn off then 
" `:set hlsearch` to turn back on
set hlsearch

" Allow lines to wrap
set wrap

" Allow command autocomplete with <tab>
set wildmenu

" Add persistent undo trees, allowing you to undo even after exiting
" Also guards against distributions lacking persistent undo
if has('persistent_undo')
	" Define a path to store persistent undo files
	if has('nvim')
		let target_path = expand($HOME. '/.vim/undo')
	else
		let target_path = expand($HOME. '/.local/share/nvim/undo')
	endif

	" Make the directory if it does not exist
	if !isdirectory(target_path)
		call mkdir(target_path, "p")
	endif

	" Point Vim to defined undo directory
	let &undodir = target_path

	" Finally, enable undo persistence
	set undofile
endif

"--------------------------------------------------------------------
" My personal preferences

" Bash-style autocompletion for filenames
set wildmode=longest,list,full
set wildmenu

" Display different types of white spaces
set list
set listchars=tab:>·,trail:•,nbsp:·

" Dark theme with gruvbox
colorscheme gruvbox
set background=dark

" 4 tab spacing instead of the default 8 spaces
" Set max width of a tab to be 4 spaces
set tabstop=4

" Make tab key only insert tabs 
" Use any other number to insert a combination of tabs and spaces
set softtabstop=0

" set noexpandtab

" Set the size of an indent
set shiftwidth=4

" Automatically apply the indentation of the current line
" to the next line in insert mode or with o/O
set autoindent

" Custom status line generated with:
" https://www.tdaly.co.uk/projects/vim-statusline-generator/
set statusline=
set statusline+=%{b:gitbranch}
set statusline+=%{expand('%:p:h:t')}/%t
set statusline+=\  
set statusline+=%r
set statusline+=%m
set statusline+=\  
set statusline+=%=
set statusline+=%l
set statusline+=:
set statusline+=%c
set statusline+=\  
set statusline+=%{strlen(&fenc)?&fenc:'none'}
set statusline+=\ 
set statusline+=%P

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

" set cursorline
