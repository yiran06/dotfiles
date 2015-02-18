syntax enable
filetype off

" load some bundles depending on where I'm logging from
let hostname = substitute(system('hostname'), '\n', '', '')

" I use vim-plug to manage libraries.  It handles the "Plug" entries below
" If there are bundle-specific configs that I like, I add them under the
" bundle entry, while also indenting them.
Plug 'junegunn/vim-plug'

Plug 'altercation/vim-colors-solarized'
    " solarized options
    let g:solarized_termtrans = 1
    set background=dark

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugs that support language-specific tooling and support
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'OCamlPro/ocp-indent'
Plug 'jcfaria/Vim-R-plugin'
Plug 'jdonaldson/vim-eco'
Plug 'jdonaldson/writeGooder'
Plug 'vim-ruby/vim-ruby'
Plug 'kchmck/vim-coffee-script'
Plug 'cakebaker/scss-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'jsx/jsx.vim'
Plug 'elzr/vim-json'
Plug 'PProvost/vim-markdown-jekyll'
Plug 'suan/vim-instant-markdown'
   let g:instant_markdown_slow = 1 
Plug 'plasticboy/vim-markdown'
Plug 'jdonaldson/vim-markdown-link-convert'
    map <Leader>il :call Inline2Ref()<CR>
Plug 'ap/vim-css-color'
Plug 'batsuev/csscomb-vim'
Plug 'xolox/vim-lua-ftplugin'
    Plug 'xolox/vim-misc'
Plug 'jdonaldson/vaxel'
    map <Leader>dh :! ./haxe build.hxml<CR>
    map <Leader>dl :luafile ~/.vim/bundle/vaxel/lua/vaxel.lua<CR>
    let g:vaxe_haxe_version = 3
    let g:vaxe_completion_write_compiler_output = 1
    map <Leader>oh :call vaxe#OpenHxml()<CR>
    map <Leader>ct :call vaxe#Ctags()<CR>
    map <Leader>ic :call vaxe#ImportClass()<CR>
    map <Leader>pj :call vaxe#ProjectHxml()<CR>
    map <Leader>jd :call vaxe#JumpToDefinition()<CR>
if hostname == "jdonaldson-wsm1.internal.salesforce.com"
    Plug 'vim-aura'
endif
Plug 'gerw/vim-latex-suite'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugs that provide general editor techniques and features
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Finding stuff
Plug 'Lokaltog/vim-easymotion'
Plug 'goldfeld/vim-seek'
Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_follow_symlinks = 2
    let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
    if len(argv())==0 || argv()[0] == '.'
        " If I open a directory, assume I want to hard set a working path
        let g:ctrlp_working_path_mode = ''
        let g:ctrlp_use_caching=1
        let g:ctrlp_clear_cache_on_exit=0
        let g:ctrlp_max_files = 0
    endif
Plug 'mileszs/ack.vim'
    " nnoremap <Leader>a :Ack<space>
    map <c-@> :Ack<space>
    " use silver searcher instead of ack:
    let g:ackprg = 'ag --follow --nogroup --nocolor --column'

Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'bling/vim-airline'
   let g:airline_theme = "solarized"
   let g:airline_powerline_fonts = 1
   let g:airline_left_sep = ''
   let g:airline_left_alt_sep = ''
   let g:airline_right_sep = ''
   let g:airline_right_alt_sep = ''
   if !exists("g:airline_symbols")
      let g:airline_symbols = {}
   endif
   let g:airline_symbols.branch = ''
   let g:airline_symbols.readonly = ''
   let g:airline_symbols.linenr = ''
Plug 'majutsushi/tagbar'
    nmap <silent><Leader>st :TagbarToggle<CR>
    " Extending tabar to support markdown (additionally to the ~/.ctags-file!)
        let g:tagbar_type_markdown = {
            \ 'ctagstype' : 'markdown',
            \ 'kinds' : [
                \ 'h:Heading_L1',
                \ 'i:Heading_L2',
                \ 'k:Heading_L3'
            \ ]
        \ }
Plug 'Lokaltog/powerline'
" Plug 'Align'
Plug 'junegunn/vim-easy-align'
    " Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
    vmap <Enter> <Plug>(EasyAlign)
    "
    " Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
    nmap <Leader>a <Plug>(EasyAlign)

    let g:easy_align_delimiters = {
                \ 't': { 'pattern': "\<tab>", 'left_margin': 0, 'right_margin': 0 } }

Plug 'jdonaldson/vim-cheat-x-in-y'
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
    let g:UltiSnipsSnippetDirectories=["UltiSnips", "bundle/UltiSnips/UltiSnips", "bundle/vim-aura/ultisnips"]
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-k>"
"include perforce if I have a p4 client
if executable("p4") && getcwd() =~ "blt\\|projectone\\|main\\|patch\\|freeze"
    Plug 'vim-scripts/perforce'
endif
Plug 'michalliu/sourcebeautify.vim'
Plug 'mkitt/browser-refresh.vim'
    " browser refresh settings
    let g:RefreshRunningBrowserDefault = 'chrome'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic'
    let g:syntastic_javascript_syntax_checker="gjslint"
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    " syntastic gutter
    augroup syn_gutter
        au BufWinEnter * sign define mysign
        au BufWinEnter * exe "sign place 1337 line=1 name=mysign buffer=" . bufnr('%')
    augroup END

" Most of Tim Pope's awesome bundles:
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
    " Plug 'jaxbot/github-issues.vim'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-projectile'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-dispatch'
    map <Leader>dm :Make<CR>
    " Use dispatch to execute the current line as a shell command, insert
    " results below the line
    nnoremap <Leader>r :exe ':Dispatch '.getline('.') <CR>
    
Plug 'tyru/open-browser.vim'


Plug 'Valloric/YouCompleteMe'
Plug 'sjl/gundo.vim'
    map <Leader>su :GundoToggle<CR>

Plug 'scrooloose/nerdtree'
    nmap <silent><Leader>sn :NERDTreeToggle<CR>
    command! En execute "NERDTree %"
    " Extended feature plugin
    Plug 'jdonaldson/nerdtree-execute'


Plug 'closetag.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kana/vim-fakeclip'
" Plug 'jdonaldson/wildfire.vim'
Plug 'dharanasoft/rtf-highlight'
Plug 'wellle/tmux-complete.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugs that provide vimscript libraries for other bundles
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'tomtom/tlib_vim'
Plug 'vim-scripts/genutils'
Plug 'michalliu/jsoncodecs.vim'
Plug 'michalliu/jsruntime.vim'
Plug 'Shougo/vimproc.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'L9'
Plug 'utl.vim'


filetype plugin indent on " required!
