set nocompatible              " be iMproved, required
colorscheme lunaperche

" set the runtime path to include Vundle and initialize
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugin 'lyuts/vim-rtags'
Plugin 'Valloric/YouCompleteMe'
Plugin 'jiangmiao/auto-pairs'

Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'

Plugin 'L9'
Plugin 'FuzzyFinder'
" Plugin 'scrooloose/nerdtree'

Plugin 'JamshedVesuna/vim-markdown-preview'

Plugin 'mileszs/ack.vim'

Plugin 'rhysd/vim-clang-format'

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

" Plugin settings
" vim-markdown-preview
let vim_markdown_preview_github=1
" YCM
let g:ycm_always_populate_location_list = 1
let g:ycm_goto_buffer_command = 'split-or-existing-window'

" ack.vim
let g:ackprg = 'ag --vimgrep'

" term
let g:termdebug_popup = 0
let g:termdebug_wide = 163

" -==MAPPINGS==-
" YCM
nmap <leader>rj :YcmCompleter GoTo<CR>
nmap <leader>rv :vertical YcmCompleter GoTo<CR>
nmap <leader>rt :tab YcmCompleter GoTo<CR>
nmap <leader>rf :tab YcmCompleter GoToReferences<CR>
nmap <leader>rw :tab YcmCompleter RefactorRename
" FuzzyFinder
nmap ,f :call fuf#setOneTimeVariables(['g:fuf_coveragefile_globPatterns', ['**/*.h', '**/*.c', '**/*.cpp', '**/*.sh', '**/*.py', '**/*.ltc', '**/*.md']]) \| FufCoverageFile<CR>
nmap ,t :FufFile<CR>
nmap ,l :FufLine<CR>
nmap ,b :FufBuffer<CR>
" Line movement
nnoremap <c-j> :m .+1<CR>==
nnoremap <c-k> :m .-2<CR>==
inoremap <c-j> <Esc>:m .+1<CR>==gi
vnoremap <c-j> :m '>+1<CR>gv=gv
vnoremap <c-k> :m '<-2<CR>gv=gv
inoremap <c-k> <Esc>:m .-2<CR>==gi

set exrc
set secure
set number
" show existing tab with 2 spaces width 
set tabstop=3
" when indenting with '>', use 2 spaces width 
set shiftwidth=3
" On pressing tab, insert 2 spaces 
set expandtab

set ruler laststatus=2 showcmd showmode
set hlsearch incsearch ignorecase smartcase
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

" folding
set foldmethod=syntax
set foldlevel=1

set updatetime=500
syntax on
