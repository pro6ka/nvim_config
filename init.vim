set encoding=UTF-8

if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
	Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'
    Plug 'kristijanhusak/vim-hybrid-material'
	Plug 'vim-airline/vim-airline'
	Plug 'vim-airline/vim-airline-themes'
    Plug 'scrooloose/nerdtree'
    Plug 'mattn/emmet-vim'
    Plug 'jiangmiao/auto-pairs'
    Plug 'irrationalistic/vim-tasks'
    Plug 'vimwiki/vimwiki'
    Plug 'ryanoasis/vim-devicons'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    "Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'scrooloose/syntastic'
    Plug 'gcorne/vim-sass-lint'
    Plug 'ArtBIT/vim-modularvimrc'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'ap/vim-css-color'
    Plug 'tpope/vim-dotenv'
    Plug 'lifepillar/vim-solarized8'
    " CTags
    Plug 'ludovicchabant/vim-gutentags'
    " autocomplete
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    if has('win32') || has('win64')
        Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
    else
        Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
    endif
    " git
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim' " :GV command to show commits
    Plug 'mhinz/vim-signify' " sign column to indicate added, modified, removed lines
    Plug 'idanarye/vim-merginal' " git branching
call plug#end()

""" Material Theme
let g:enable_bold_font = 1
let g:enable_italic_font = 1
let g:hybrid_transparent_background = 1
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

""" GutenTags
set statusline+=%{gutentags#statusline()}

""" Deoplete
let g:deoplete#enable_at_startup = 1

""" AirLine
let g:airline_extensions = ['branch', 'hunks', 'coc']
" Do not draw separators for empty sections (only for the active window) >
let g:airline_skip_empty_sections = 1

" Smartly uniquify buffers names with similar filename, suppressing common parts of paths.
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Custom setup that removes filetype/whitespace from default vim airline bar
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]

let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'

let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

" Configure error/warning section to use coc.nvim
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable caching of syntax highlighting groups
let g:airline_highlighting_cache = 1

" Define custom airline symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Don't show git changes to current file in airline
let g:airline#extensions#hunks#enabled=0


""" Emmet
"let g:user_emmet_leader_key=','

""" NERDTree
" Hide the Nerdtree status line to avoid clutter
let g:NERDTreeStatusline = ''

" open a NERDTree automatically when vim starts up
autocmd vimenter * NERDTree

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" map a specific key or shortcut to open NERDTree
map <C-t><C-t> :NERDTreeToggle<CR>


""" UltiSnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" UltiSnips PHP7
let g:ultisnips_php_scalar_types = 1


""" System

" folding
set foldmethod=manual
set foldnestmax=10
set nofoldenable
set foldlevel=2

" highlight current line
set cursorline

" Tags file
"" search first in current directory then file directory for tag file
set tags=tags,./tags

" Map the leader key to SPACE
let mapleader="\<SPACE>"
" Autocompletition
filetype plugin on
set omnifunc=syntaxcomplete#Complete
set complete=.,w,b,u

set showmatch           " Show matching brackets.
set number              " Show the line numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.
set smarttab
set expandtab
set smartindent
set nocompatible
set autoindent
set tags+=./.vim/tags
" Don't dispay mode in command line (airilne already shows it)
set noshowmode
"Search
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set incsearch
set hlsearch
" Add simple highlight removal
nmap ,<space> :nohlsearch<CR>

" For file watchers
set backupcopy=yes
set nobackup
set nowritebackup
set exrc
set secure

set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set nostartofline       " Do not jump to first character with page commands.

" Split Management
set splitbelow
set splitright
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

" Search and Replace
nmap <Leader>s :%s//g<Left><Left>

" Syntax
syntax enable
filetype plugin indent on


" Git
set autoread
autocmd FocusGained,CursorHold ?* if getcmdwintype() == '' | checktime | endif
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
set updatetime=100

""" Git Marginal
map <C-m><C-m> :MerginalToggle<CR>
""" Sass Lint
let g:syntastic_sass_checkers=["sasslint"]
let g:syntastic_scss_checkers=["sasslint"]

""" Syntatic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


""" CtrlP
let g:ctrlp_map='<c-p>'
let g:ctrlp_cmd='CtrlPBuffer'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] "Hide files in .gitignore
let g:ctrlp_show_hidden = 1                                                         "Show dotfiles
let g:ctrlp_working_path_mode='awr'
let g:ctrlp_switch_buffer='et'

hi Normal guibg=NONE ctermbg=NONE
