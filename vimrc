"  great overview of the rationale behind some of these options is given
" here: http://stevelosh.com/blog/2010/09/coming-home-to-vim/

" add ~/.vim to rtp
if has('nvim')
  let s:editor_root=expand("~/.nvim")
  let &rtp = &rtp . ',' . s:editor_root
  let viminfopath='~/.config/nvim/shada/main.shada'
  let &viminfo .= ',n' . escape(viminfopath, ',')
endif

" First, make the leader and command characters easier to type
let mapleader=","
nnoremap ; :
" Add some commands to quickly open or source this file
    nmap <Leader>1 :e $MYVIMRC<CR>
    nmap <Leader>so :so %<CR>


" Now we need to load vim-plug, it manages all of the extra plugins for vim
call plug#begin("~/.vim/bundle")
" bundle configs are stored in a separate file, source it.
source ~/.vim/settings/bundle.vim
call plug#end()

colorscheme solarized

" quickly exit insert mode with this combo
imap jk <Esc>

"
"BASIC OPTIONS

set autowrite
set cindent      " useful for python
set copyindent   " copy the previous indentation on autoindenting
set expandtab    " expand tabs to spaces
set hidden       " hide the old buffer when switching
set lazyredraw
set nocompatible
set noerrorbells " no, seriously, don't beep
set nowrap       " don't wrap lines
set number       " always show line numbers
set shiftround   " use multiple of shiftwidth when indenting with '<' and '>'
set smartindent
set title        " change the terminal's title
set visualbell   " don't beep
set ignorecase   " search : ignore case
set smartcase    " search : smart case
set gdefault     " search : default
set hlsearch     " search : highlight

                    " PARAMETER OPTIONS
set mouse=a         " use mouse in nvich modes
set clipboard+=unnamedplus
set encoding=utf-8
set tw=0
set shell=bash
set undolevels=1000 " use many muchos levels of undo
set ts=4            " a tab is four spaces
set tags=./tags;/
set sts=4
set sw=4

" Ignore all files like this
set wildignore=*.swp,*.bak,*.pyc,*.class,*.sass-cache,*/_site/*


" Experimental
set nrformats=octal,hex,alpha " increment letters in addition to numbers

" color too-wide columns
syntax on         " syntax highlighting, natch

" better completion popup options
" highlight Pmenu ctermbg=238 gui=bold

"splits!
set splitright

autocmd BufEnter Makefile set noexpandtab | set tabstop=4

" too lazy to hit the forward slash
nnoremap <space> /
vnoremap <space> /

" Some  general reformatting command(s)
" strip whitespace at end of line
nnoremap <Leader>f$ :%s/\s\+$//<CR>:let @/=''<CR>

"fix line (or visual block lines)
nnoremap <Leader>fl :normal gqq==<CR>
vnoremap <Leader>fl :normal gvgqgv=<CR>

" fix operator/type declaration spacing (single space each side) on line
nnoremap <Leader>fd :call ExpandDelimited()<CR>
vnoremap <Leader>fd :call ExpandDelimited()<CR>

"autocmd BufNewFile,BufRead *.hx set formatprg=astyle\ --style=java\ -A2p
autocmd BufNewFile,BufRead *.hx setlocal formatprg=uncrustify\ -l\ cs\ --no-backup\ 2>/dev/null
autocmd BufNewFile,BufRead *.cpp setlocal formatprg=uncrustify\ --no-backup\ 2>/dev/null

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType python set expandtab
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType haxe set noautoindent

autocmd BufNewFile,BufRead *.md set tw=80
autocmd BufNewFile,BufRead *.py set tabstop=2 | set shiftwidth=2

autocmd BufNewFile,BufRead *.Rpres setf markdown



" window navigation tweaks
set wiw=10
set wmw=10
nmap <c-h> <c-w>h<c-w><Bar>
nmap <c-l> <c-w>l<c-w><Bar>


function! ExpandDelimited()
    " new line after opening paren/bracket
    :s/{/{\r/e
    :s/\[/\[\r/e
    :s/,/,\r/e
    exe "normal :vi[="
    exe "normal :vi{="
endfunction

"GLOBAL AUTOMATIC ACTIONS
" autosave on lost focus
au FocusLost * :wa

" tab through buffers in normal mode
" map <silent> <S-TAB> <C-W>W

" nmap <expr><silent> q winnr() != 1 ? ":q\<CR>" : "q"

if exists('+colorcolumn')
  set colorcolumn=80
else
    au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

function! ToggleSet(toggle)
    execute "let x = &".a:toggle

    if x
        execute "set no".a:toggle
    else
        execute "set ".a:toggle
    endif
endfunction

function! ToggleSetValue(toggle, value)
    let toggle_saved_varname = "g:_toggle_saved_" . a:toggle
    if exists(toggle_saved_varname)
        execute "set "   . a:toggle . " = " . toggle_saved_varname
        execute "unlet " . toggle_saved_varname
    else
        execute "let " . toggle_saved_varname . " = " . a:toggle
        execute "set " . a:toggle . "="  a:value
    endif
endfunction

function! DoWindowSwap()
    "If window is already leftmost, ignore it
    if winnr() == 1
        return
    endif

    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    let targetWin =  1
    exe targetWin."wincmd w"
    let foo = 0
    while winwidth('%') < 5 || winheight('%') < 5 || targetWin > bufnr("$") || &buftype != ''
        let targetWin = targetWin + 1
        exe targetWin."wincmd w"
    endwhile

    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
    exe targetWin."wincmd w"
endfunction


" swaps the current window with the left-most window
" nmap <silent> <expr><CR> &buftype == '' ?  ":call DoWindowSwap()\<CR>" : "\<CR>"
" nmap <silent> <tab> :wincmd w<CR>

" MISC KEY MAPPING

" force write a file
cmap w!! w !sudo tee % >/dev/null

" insert a newline  below in normal mode
" nnoremap <C-J> hmao<esc>`a

" stamp paste with capital S
nmap <silent><Leader>lp :execute ""_diwP"<CR>




map <Leader>pc :call ToggleEnablePreview()<CR>

" All of my 'panels'
"map <Leader>y :YRShow<CR>

"folding
nmap <silent><Leader>fl0 :set foldlevel=0<CR>
nmap <silent><Leader>fl1 :set foldlevel=1<CR>
nmap <silent><Leader>fl2 :set foldlevel=2<CR>
nmap <silent><Leader>fl3 :set foldlevel=3<CR>
nmap <silent><Leader>fl4 :set foldlevel=4<CR>


" Show/hide stuff: <Leader>s + letter
" refresh screen
nmap <silent><Leader>ss :redraw!<CR>
" Show/hide whitespace characters
nmap <silent><Leader>sw :call ToggleSet("list")<CR>
" hide highlights from last search
nmap <silent><Leader>sh :nohlsearch<CR>
" show/hide the quickfix window
nmap <silent><Leader>sq :call ToggleList("Quickfix List", 'c')<CR>
" show/hide the foldcolumn
nmap <silent><Leader>sl :call ToggleSetValue("foldcolumn", 0)<CR>
" Show the bundle list
nmap <silent><Leader>bb :e ~/.vim/settings/bundle.vim<CR>
" Show my personal ultisnips directory
nmap <silent><Leader>sp :e ~/.vim/UltiSnips<CR>

"Toggle stuff: <Leader>t + letter
" toggle paste mode
nmap <silent><Leader>tp :call ToggleSet("paste")<CR>


" Shortcuts for working with tabs
" Load the current buffer in a new tab
nnoremap <leader>tn :tabedit %<cr>
" close the current tab
nnoremap <leader>tc :tabclose<cr>

" Reload current buffer
nnoremap <leader>ee :edit!<cr>


" echo current syntax scope
map <Leader>syn :echo "hi<" . synIDattr(synID(line("."), col("."), 1), "name")
            \. "> trans<"
            \. synIDattr(synID(line("."),col("."),0),"name")
            \. "> lo<"
            \. synIDattr(synIDtrans(synID(line("."),col("."),1)), "name")
            \. ">"<CR>

"showmarks
highlight ShowMarksHLl   cterm=bold ctermfg=1 ctermbg=12 gui=bold guifg=black guibg=lightblue
highlight ShowMarksHLu   cterm=bold ctermfg=1 ctermbg=12 gui=bold guifg=darkblue guibg=lightblue
highlight ShowMarksHLo   cterm=bold ctermfg=8 ctermbg=12 gui=bold guifg=darkgray guibg=lightblue
highlight ShowMarksHLm   cterm=bold ctermfg=1 ctermbg=4 gui=bold guifg=white guibg=lightblue

" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+\%#\@<!$/
" au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" au InsertLeave * match ExtraWhitespace /\s\+$/

" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif




command! Thtml :%!tidy -q -i --show-errors 0

let g:netrw_liststyle=1

hi QuickFixLine term=reverse ctermbg=52

