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


"---------Search---------"
set hlsearch
set incsearch


"---------Search---------"
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


"---------Auto-commands--------"

"Automatically source vimrc on write

augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END
