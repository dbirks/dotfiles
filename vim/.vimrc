syntax enable

set backspace=indent,eol,start                          "Backspace like I'm used to.
let mapleader = ','                                     "Default leader is \, but let's try comma for now.
set number                                              "Activate line numbers.
set linespace=15                                        "gvim line height


"---------Visuals---------"
"colorscheme base16-hopscotch				"color
"set guifont=TamzenForPowerline\ 14			"Font

set guioptions-=l					"remove scrollbars
set guioptions-=L
set guioptions-=r
set guioptions-=R

"Make tabs and trailing spaces stand out
"Sets characters > and < when the line goes off screen
:set listchars=tab:»•,trail:█,extends:>,precedes:<
:set list
":set relativenumber


"---------Search---------"
set hlsearch                                            "search highlighting
set incsearch
set splitbelow						"some splitting defaults
set splitright

nmap <C-H> <C-W><C-H>  					"easier split switching
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>

"nmap <C-\> <C-W><\>


"---------Mappings---------"

"Open vimrc in a tab
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Simple highlighting removal
nmap <Leader><space> :nohlsearch<cr>

"Ctrl + backspace to delete prev word
imap <C-BS> <C-W>

"Open NERDTree with Ctrl+n
map <C-n> :NERDTreeToggle<CR>

"---------Auto-commands--------"

"Automatically source vimrc on write

augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"Open NERDTree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"---------Formatting----------"
"yaml
autocmd FileType yaml setlocal ai ts=2 sw=2 et

" Don't write new EOL when it's not there
set noendofline
set nofixendofline

"---------Indenting----------"

:set autoindent
:set smartindent

"---------Pasting----------"

:set pastetoggle=<f5>