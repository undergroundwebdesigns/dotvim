" Create them if they don't exist ---- {{{
  silent execute '!mkdir -p $HOME/.vimbackup'
  silent execute '!mkdir -p $HOME/.vimswap'
  silent execute '!mkdir -p $HOME/.vimviews'
" }}}

" Directories for backups ---- {{{
  setglobal backup
  setglobal backupdir=$HOME/.vimbackup//
  setglobal directory=$HOME/.vimswap//
  setglobal viewdir=$HOME/.vimviews//
  if exists("&undodir")
    setglobal undodir=$HOME/.vimundo//
  endif
" }}}

" }}}

" Ctrl-p settings ----------------- {{{
  let g:ctrlp_switch_buffer = 'et'
  let g:ctrlp_clear_cache_on_exit = 0 " retain cache on exit (might mean I have to manually refresh every now and again)
  let g:ctrlp_open_new_file = 't' " <c-y> opens file in new tab
  let g:ctrlp_arg_map = 1 " for <c-z> and <c-o>
  let g:ctrlp_root_markers = ['Gemfile', 'README']
  let g:ctrlp_custom_ignore = 'node_modules\|reports'
" }}}

" Pathogen! 
  execute pathogen#infect()

" Basic settings ---------------------------- {{{

  " Character encoding (if this is not set, all manner of hell breaks loose when
  " LC_CYTPE is set to anything unexpected.)
  setglobal encoding=utf-8

  " we're running vim, not vi
  setglobal nocompatible

  " always show the status line, which is made fancy by powerline
  setglobal laststatus=2
  setglobal statusline=%<%f\ %h%m%r%{fugitive#statusline()}%{SyntasticStatuslineFlag()}%=%-14.(%l,%c%V%)\ %P

  " don't show the intro message when starting vim
  " also, abbreviate a host of other messages that appear on the status line
  setglobal shortmess=atIT

  " use exuberant ctags
  let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
  let g:tagbar_compact = 1
  noremap <leader>b :TagbarOpenAutoClose<CR>

  " optimize for fast terminal connections
  setglobal ttyfast

  " don't add empty newlines at the end of binary files
  setglobal noendofline

  " allow mouse input
  setglobal mouse=a

  " use ag as search program
  " setglobal grepprg=ag

  " change tabs to two spaces
  set expandtab
  set tabstop=2

  " copy indent from current line when starting a new line
  " additionally, follow smart indentation rules for c-like languages
  " and for other stuff where cinwords is set
  set autoindent
  set smartindent
  set shiftwidth=2

  " indentation in ruby
  set cinoptions=:0,p0,t0
  set cinwords=if,else,while,do,for,switch,case

  " enhance command line completion
  set wildignore+=doc*,*.png,*.jpg,*.bmp,*.gif,*.jpeg
  set wildmenu

  " show the cursor position
  set ruler

  " show the (partial) command as it's being typed
  set showcmd

  " line numbers (and show/hide them with \n)
  set number

  " wrapping (off and on with \w; scroll off the window border if close and wrap
  " is disabled)
  set wrap
  set linebreak
  set sidescroll=1
  set sidescrolloff=20

  " Start scrolling three lines before the horizontal window border
  set scrolloff=3

  " make backspace delete over line breaks, auto indentation, and the place where insert mode began
  set backspace=2

  " make last line in a window display as much as possible, even if the whole
  " thing can't display at once.
  set showbreak=⧽
  set display=lastline

  " when switching betwen buffers, always switch to a preexisting window or tab
  " if it's already open
  setglobal switchbuf+=usetab

  " Don't reset cursor to the start of the line when moving around
  setglobal nostartofline

  " search stuff
  setglobal ignorecase " ignore case of searches
  setglobal smartcase " ... but don't ignore case if search has uppercase in it
  setglobal gdefault " adds the global flag to search/replace by default
  setglobal hlsearch " don't highlight search results
  setglobal incsearch " highlight dynamically as pattern is typed
  nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

  " allow cursor beyond last character
  setglobal virtualedit=onemore
  setglobal virtualedit+=block

  " history
  setglobal history=1000

  " syntax stuff
  syntax on " highlighting please

  " Syntax coloring
  setglobal t_Co=256
  setglobal background=dark
  let g:solarized_termcolors = 256
  let g:solarized_termtrans = 1
  colorscheme solarized

  " Highlight errors garishly
  highlight Error ctermbg=red ctermfg=white guibg=red guifg=white

  " Highlight current line
  setglobal cursorline
  highlight cursorline guibg=#333333
  highlight CursorColumn guibg=#333333

  " respect modeline in files
  setglobal modeline
  setglobal modelines=4

  " disable error bells
  setglobal noerrorbells
  setglobal visualbell

  " Use the same symbols as TextMate for tabstops and EOLs
  setglobal listchars=tab:▸\ ,eol:¬,trail:⋅

  " enable filetype detection
  filetype on
  filetype indent on
  filetype plugin on

  " syntastic error checking
  let g:syntastic_auto_loc_list=1 " auto open error window when errors are detected
  let g:syntastic_check_on_open=1 " check for errors on file open
  let g:syntastic_error_symbol='✗'
  let g:syntastic_warning_symbol='⚠'
  noremap <leader>e :SyntasticCheck<CR>:Errors<cr><C-w>j
  let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': ['ruby', 'php', 'coffee'],
      \ 'passive_filetypes': ['html'] }

  " hardmode by default -------- {{{
  " augroup default_hardmode
  "   autocmd!
  "   autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
  " augroup END
  " }}}

  " arrrgh -------- {{{
    augroup arrgh
    autocmd!
    autocmd VimLeave * if v:dying | echo "\nAAAAaaaarrrggghhhh!!!\n" | endif
    augroup END
  " }}}

" }}}

  autocmd FileType php :setlocal sw=4 ts=4 sts=4

" Global key mappings ---- {{{

  let mapleader = ","

  " Make 'kj' in insert mode bring you back to edit mode
  inoremap kj <Esc>

  " toggle paste mode
  setglobal pt=<C-q>

  " Echo Helpful Information ---- {{{

    " show the entire stack of syntax items affecting the current character
    nnoremap \ha :echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val,
    "name")'), ' => ')<CR>

    " show the syntax item that's resulting in the highlighting currently shown
    nnoremap \hn :echo synIDattr(synID(line("."), col("."), 1), "name")<CR>

  " }}}

  " Searching ---- {{{
  "nnoremap / /\v
  "nnoremap ? ?\v

  " grep for current operator ---- {{{
    nnoremap <leader>r :set operatorfunc=<SID>GrepOperator<cr>g@
    vnoremap <leader>r :<c-u>call <SID>GrepOperator(visualmode())<cr>

    function! s:GrepOperator(type)
      let saved_unnamed_register = @@

      if a:type ==# 'v'
        execute "normal! `<v`>y"
      elseif a:type ==# 'char'
        execute "normal! `[v`]y"
      else
        return
      endif

      silent! execute "grep! -Q " . shellescape(@@)
      redraw!
      copen

      let @@ = saved_unnamed_register
    endfunction
  " }}}

" }}}

" settings changing -------- {{{

  noremap \n :setlocal number!<CR>
  noremap \w :setlocal wrap!<CR>
  noremap \s :setlocal hlsearch!<CR>
  noremap \hm <Esc>:call ToggleHardMode()<CR>

  " show/hide invisibles and make trailing whitespace ugly as fuck
  noremap \i :setlocal list<CR>:2match Error /\v\s+$/<CR>
  noremap \I :setlocal nolist<CR>:2match<CR>

  " toggling foldcolumn (\f) -------- {{{
    nnoremap \f :call <sid>FoldColumnToggle()<cr>
    function! s:FoldColumnToggle()
      if &foldcolumn
        setlocal foldcolumn=0
      else
        setlocal foldcolumn=4
      endif
    endfunction
  " }}}

  " toggling quickfix (\q)  -------- {{{
  nnoremap \q :call <sid>QuickFixToggle()<cr>
  let s:quickfix_is_open = 0
  function! s:QuickFixToggle()
    if s:quickfix_is_open
      cclose
      let s:quickfix_is_open = 0
      execute s:quickfix_return_to_window . "wincmd w"
    else
      let s:quickfix_return_to_window = winnr()
      copen
      let s:quickfix_is_open = 1
    endif
  endfunction
  " }}}
  " }}}
" keys to move between tabs ---- {{{
  nnoremap <C-h> gT
  nnoremap <C-l> gt
" }}}

" keys to resize windows ---------- {{{
  noremap + <C-w>+
  noremap _ <C-w>-
  noremap ) <C-w>>
  noremap ( <C-w><
  setglobal equalalways
" }}}

" move between quickfix errors ------- {{{
  nnoremap <C-j> :cprevious<CR>
  nnoremap <C-k> :cnext<CR>
" " }}}

" fugitive mappings ----- {{{
  noremap <Leader>gg :Gstatus<CR>
  noremap <Leader>gc :Gcommit<CR>
  noremap <Leader>gb :Gblame<CR>
  noremap <Leader>gd :Gdiff<CR>
  noremap <Leader>gp :setlocal noconfirm<CR>:Git pull<CR>:bufdo e!<CR>:setlocal confirm<CR>
  noremap <Leader>gP :Git push<CR>
  noremap <Leader>gD :diffoff!<CR><c-w>h:bd<cr> 

" }}}

nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>

