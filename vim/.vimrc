syntax enable

colorscheme base16-hopscotch

set backspace=indent,eol,start                           "Backspace like I'm used to.
let mapleader = ','                                      "Default leader is \, but let's try comma for now.
set number                                               "Activate line numbers.
set linespace=15                                         "gvim line height

"---------Search---------"
set hlsearch
set incsearch


"---------Mappings---------"

"Open vimrc in a tab
nmap <Leader>ev :tabedit $MYVIMRC<cr>

"Simple highlighting removal
nmap <Leader><space> :nohlsearch<cr>




"---------Auto-commands--------"

"Automatically source vimrc on write

augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END
