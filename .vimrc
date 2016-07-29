set nocompatible  " We don't want vi compatibility.

" vundle stuff
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe' " General purpose auto-completer box
Plugin 'tpope/vim-fugitive' " Git wrapper tool
Plugin 'tpope/vim-rails.git' " Rails helper for vim
Plugin 'rstacruz/sparkup' " helps write HTML concisely
Plugin 'kien/ctrlp.vim' " fuzzy matcher for file opening
Plugin 'scrooloose/syntastic' " Syntax checking
Plugin 'bling/vim-airline' " status bar
Plugin 'SirVer/ultisnips' " Snippet plugin (engine)
Plugin 'honza/vim-snippets' " Snippet repo
Plugin 'elzr/vim-json' " Better JSON handling (hilighting) for vim
Plugin 'justinmk/vim-sneak' " Fast(er) vim editor motion plugin
Plugin 'majutsushi/tagbar' " View file structure/tags for Vim
Plugin 'mhinz/vim-signify' " Show changes relative to VCS
Plugin 'plasticboy/vim-markdown' " Markdown editing in Vim
Plugin 'scrooloose/nerdcommenter' " Comment/uncomment tool
Plugin 'sjl/gundo.vim' " Visualize git history/undo tree
Plugin 'tpope/vim-sleuth' " Automatically detect (and set) spacing options
Plugin 'tpope/vim-surround' " Handle editing with quotes/parens
Plugin 'tyru/open-browser.vim' " Open link in browser
Plugin 'vim-scripts/a.vim' " Switch between source and header files quickly
Plugin 'tomasr/molokai' " Color scheme
Plugin 'flazz/vim-colorschemes' " more color stuff
Plugin 'mileszs/ack.vim' " ack plugin for vim
"Plugin 'vim-scripts/c.vim' " C/C++ IDE for vim
Plugin 'fholgado/minibufexpl.vim' " Buffer explorer for vim
Plugin 'scrooloose/nerdtree' " Tree explorer
Plugin 'vim-scripts/SingleCompile' " Compiling utility
Plugin 'vim-scripts/TaskList.vim' " Search for TODO tags
Plugin 'rizzatti/dash.vim' " Dash integration
Plugin 'slim-template/vim-slim.git' " syntax hi-lighting for slim template
Plugin 'kchmck/vim-coffee-script'
Plugin 'ntpeters/vim-better-whitespace' " whitespace errors hilighting & fixing
Plugin 'vim-scripts/ruby-matchit' " allow navigation using % for ruby blocks
Plugin 'tpope/vim-endwise' " Automatically add 'end' in Ruby code

let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

call vundle#end()

filetype plugin indent on

let mapleader=","

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

syntax enable

" Prefer local project eslint
let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
  let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
  let g:syntastic_javascript_eslint_exec = local_eslint
endif
let g:syntastic_javascript_checkers = ['eslint']

" options set from biodegradablegeek.com/2007/12/using-vim-as-a-complete-ruby-on-rails-ide/
set clipboard+=unnamed " Yanks go on clipboard instead
set history=256 " Number of things remembered in history
set autowrite " write out file when switching to a new one
set autoindent " automatically indent based on context
set ruler " show current cursor position
set cf " actions that would fail b/c of unsaved changes will pop up dialog
set relativenumber
set nu " line numbers on

" formatting stuff
" don't want to mess with tabs too much... set ts=2 " tabs are 2 spaces (perhaps change to 4?)
set bs=2 " Backspace over everything in insert mode
set shiftwidth=2 " Tabs under smart indent
set tabstop=2
set nocp incsearch " has to do with searching pattern matching
set cindent " C-style indenting
set expandtab " use the appropriate number of spaces to insert a tab

set showmatch " when a bracket is inserted, briefly jump to matching one
set mat=3 " tenths of a second to show matching bracket

" Backups & files
set backup " enable creation of backup file
set backupdir=~/.vim/backups "backup dir
set directory=~/.vim/tmp " temp directoryy

" minibufexpl stuff
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" map shortcuts to tasklist and tag view
map T <Plug>TaskList<CR>
map P :TlistToggle<CR>

" OmniCppCompliete options
" auto close options when exiting insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
set completeopt=menu,menuone
" configs
let OmniCpp_MayCompleteDot = 1 "autocomplete with .
let OmniCpp_MayCompleteArrow = 1 "autocomplete with ->
let OmniCpp_MayCompleteSCope = 1 "autocomplete with ::
let OmniCpp_SelectFirstItem = 2 "select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 "search namespace in this and included files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype (i.e. parameters) in popup window

" remap movement keys
nmap j gj
nmap k gk

" better search stuff
set incsearch
set ignorecase
set smartcase
set hlsearch
nmap <leader>q :nohlsearch<CR>

" buffers
nmap <C-e> :e#<CR>
nmap <C-n> :bnext<CR>
nmap <C-p> :bprev<CR>

" fuzzy search
nmap <leader>t :CtrlP<CR>
nmap ; :CtrlPBuffer<CR>

" NERDTree
nmap <leader>e :NERDTreeToggle<CR>

" -- ctags stuff
"  map ctrl - F12 to generate tag file for the current folder:
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra+q.<CR><CR>
" add current directory's generated tags file to available tags
set tags+=./tags
set laststatus=1 " show status bar in multiple windows

" simple compile stuff
nmap <F9> :SCCompile<cr>
nmap <F10> :SCCCompileRun<cr>

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

colorscheme koehler
set guifont=Menlo\ Regular:h10

" JavaDoc stuff
autocmd FileType java let b:jcommenter_class_author='Ben Peters (ben@aiqinvestments.com)'
autocmd FileType java let b:jcommenter_file_author='Ben Peters (ben@aiqinvestments.com)'
autocmd FileType java source ~/.vim/plugin/jcommenter.vim
autocmd FileType java nmap <leader>jc :call JCommentWriter()<CR>
autocmd FileType groovy let b:jcommenter_class_author='Ben Peters (ben@aiqinvestments.com)'
autocmd FileType groovy let b:jcommenter_file_author='Ben Peters (ben@aiqinvestments.com)'
autocmd FileType groovy source ~/.vim/plugin/jcommenter.vim
autocmd FileType groovy nmap <leader>jc :call JCommentWriter()<CR>

autocmd FileType ruby setlocal shiftwidth=2 tabstop=2
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2

" Python stuff
" Indent Python in the Google way.
setlocal indentexpr=GetGooglePythonIndent(v:lnum)

let s:maxoff = 50 " maximum number of lines to look backwards.

function GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)

endfunction

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"

" nesting matching for ruby
runtime macros/matchit.vim
