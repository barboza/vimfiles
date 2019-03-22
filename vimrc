" Use Vim settings, rather then Vi settings (much better!).
set nocompatible

" Plugins
silent! runtime bundles.vim

" ---------------------------------------------------------------------------
" General
" ---------------------------------------------------------------------------

filetype plugin indent on
let mapleader = ","
let g:mapleader = ","
syntax enable
set autoread
set timeoutlen=500 ttimeoutlen=0 " Avoid delays

" do not create backup, swap file, use git for version management
set nobackup
set nowritebackup
set noswapfile

" This means that you can have unwritten changes to a file and open a new file
" using :e, without being forced to write or undo your changes first.
set hidden

set history=1000  "store lots of :cmdline history

" Set character encoding to use in vim
set encoding=utf-8
set termencoding=utf-8

" Add '-' as recognized word symbol. e.g dw delete all 'foo-bar' instead just 'foo'
set iskeyword+=-

" Show matching brackets
set showmatch
set matchpairs+=<:> " Make < and > to match

" Use 256 colors in vim
set t_Co=256

" Spell
autocmd FileType gitcommit setlocal spell
autocmd FileType markdown setlocal spell
set complete+=kspell

" Copy to osx clipboard
vnoremap <C-c> "*y<CR><Paste>
vnoremap <C-c> "*y<CR>
vnoremap y "*y<CR>
nnoremap Y "*Y<CR>

" ---------------------------------------------------------------------------
" UI
" ---------------------------------------------------------------------------

set title        " make your xterm inherit the title from Vim
set autoindent
set smartindent
set showmode     " show current mode down the bottom
set showcmd      " show incomplete cmds down the bottom
set hidden       " hides buffers instead of closing them
set wildmenu
set wildmode=list:longest
set wildcharm=<TAB> " Autocmpletion hotkey
set visualbell t_vb=
set cursorline   " highlight current line
set ttyfast
set backspace=indent,eol,start  "allow backspacing over everything in insert mode
set laststatus=2 " display the status line always
set nonumber
set relativenumber number " show relative numbers
set splitbelow
set splitright
set list
" set listchars=trail:·

" some stuff to get the mouse going in term
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif

" ---------------------------------------------------------------------------
" Text Formatting
" ---------------------------------------------------------------------------

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab!

set nowrap
set textwidth=79
set formatoptions=n

" ---------------------------------------------------------------------------
" Mappings
" ---------------------------------------------------------------------------

" Remap ; to :
nnoremap ; :

" Open new tab
nmap <silent><leader>t :tabnew<CR>

" Replace
nmap <leader>s :%s//<left>
vmap <leader>s :s//<left>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>

nmap :E :e
nmap :W :w

if exists(':tnoremap')
  tnoremap <C-H> <C-\><C-N><C-W>h
  tnoremap <C-J> <C-\><C-N><C-W>j
  tnoremap <C-K> <C-\><C-N><C-W>k
  tnoremap <C-L> <C-\><C-N><C-W>l

  " Use Esc to enter normal mode in term
  tnoremap <Esc> <C-\><C-n>
endif

" Workaround for Neovim
if has('nvim')
  nmap <BS> <C-W>h
endif

" bind K to grep word under cursor
nnoremap <silent> K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
vnoremap <silent> K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Show the path of the current file
nnoremap <Leader>e :echo expand('%')<CR>

" The Silver Searcher
if executable('ag')
  let $FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " \a to Silver Searcher
  nnoremap <leader>a :Ag!<space>
endif

" Map t to FZF
nnoremap <silent> t :FZF<cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

"Key mapping for textmate-like indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

" Align blocks of text and keep them selected
vmap < <gv
vmap > >gv

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" turn search highlight off
nnoremap <leader><space> :noh<cr>

" Format json strings
com! FormatJSON %!python -m json.tool

" ---------------------------------------------------------------------------
" Prettier
" ---------------------------------------------------------------------------
let g:prettier#exec_cmd_async = 1
let g:prettier#config#trailing_comma = 'none'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#parser = 'typescript'
let g:prettier#config#single_quote = 'true'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.ts,*.css,*.scss,*.less,*.graphql,*.gql PrettierAsync

" ---------------------------------------------------------------------------
" Elixir Mix Format (vim-mix-format)
" ---------------------------------------------------------------------------
let g:mix_format_on_save = 1


" ---------------------------------------------------------------------------
" Tabularize
" ---------------------------------------------------------------------------

nmap <Leader>a& :Tabularize /&<CR>
vmap <Leader>a& :Tabularize /&<CR>
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:<CR>
vmap <Leader>a: :Tabularize /:<CR>
nmap <Leader>a:: :Tabularize /:\zs<CR>
vmap <Leader>a:: :Tabularize /:\zs<CR>
nmap <Leader>a, :Tabularize /,<CR>
vmap <Leader>a, :Tabularize /,<CR>
nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

" ---------------------------------------------------------------------------
" Ruby/Rails
" ---------------------------------------------------------------------------

" Execute current buffer as ruby
map <S-r> :w !ruby<CR>

" View routes or Gemfile in large split
map <leader>gr :topleft :split config/routes.rb<cr>
map <leader>gg :topleft :split Gemfile<cr>

" Rspec.vim mappings
map <Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>

" ---------------------------------------------------------------------------
" Ember
" ---------------------------------------------------------------------------

map <leader>ec :FZF app/components<cr>
map <leader>et :FZF app/templates<cr>
map <leader>em :FZF app/models<cr>
map <leader>eh :FZF app/helpers<cr>
map <leader>eo :FZF app/routes<cr>
map <leader>es :FZF app/services<cr>
map <leader>ep :topleft :split package.json<cr>

" ---------------------------------------------------------------------------
" Golang configs
" ---------------------------------------------------------------------------

" For .go files, use tabs instead of spaces
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2 nolist
au FileType go nmap gf <Plug>(go-def)
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "snakecase"
if exists("g:gui_oni") || exists("veonim")
  let g:go_auto_type_info = 0
else
  let g:go_auto_type_info = 1
endif

let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_string_spellcheck = 2
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

" ---------------------------------------------------------------------------
" Syntax highlight for unsual filetypes
" ---------------------------------------------------------------------------

au BufRead,BufNewFile nginx.conf if &ft == '' | setfiletype nginx | endif
au BufRead,BufNewFile Dockerfile.dev if &ft == '' | setfiletype Dockerfile | endif

" ---------------------------------------------------------------------------
" Plugins
" ---------------------------------------------------------------------------

" Polyglot
let g:polyglot_disabled = ['handlebars']

" Auto Pairs
let g:AutoPairsOnlyBeforeClose = 1

"-------------------------
" NERDTree
let NERDTreeShowBookmarks = 0
let NERDChristmasTree = 1
let NERDTreeWinPos = "left"
let NERDTreeHijackNetrw = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeWinSize = 30
let NERDTreeChDirMode = 2
let NERDTreeDirArrows = 1
let NERDTreeMinimalUI=1
silent! nmap <silent> <Leader>m :NERDTreeToggle<CR>
silent! nmap <silent> <leader>f :NERDTreeFind<cr>

"-------------------------
" NERDCommenter

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

if has("gui_macvim") && has("gui_running")
  map <D-/> <plug>NERDCommenterToggle<CR>
  imap <D-/> <Esc><plug>NERDCommenterToggle<CR>
else
  map <leader>/ <plug>NERDCommenterToggle<CR>
endif

"-------------------------
" Tagbar
map <leader>l :TagbarToggle <cr>
let g:tagbar_autofocus=1

" Generate ctags for all bundled gems as well
map <leader>rtg :!ctags --extra=+f --languages=-javascript --exclude=.git --exclude=log -R * `rvm gemdir`/gems/* `rvm gemdir`/bundler/gems/*<CR><C-M>

" Use only current file to autocomplete from tags
" set complete=.,t
set complete=.,w,b,u,t,i

"-------------------------
" Airline
set laststatus=2
let g:airline_theme = 'base16'
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols = { 'linenr': '␤ ', 'branch': '⎇ ' }
let g:airline#extensions#branch#enabled = 1
let g:airline_mode_map = {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'REPLACE',
      \ 'v' : 'VISUAL',
      \ 'V' : 'V-LINE',
      \ 'c' : 'CMD   ',
      \ '': 'V-BLCK',
      \ }

" Tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#fnamemod = ':~:.'
let g:airline#extensions#tabline#fnamecollapse = 0
let g:airline#extensions#tabline#fnametruncate = 0
let g:airline#extensions#tabline#formatter = 'folder'
let g:airline#extensions#tabline#show_buffers = 0

let g:airline#extensions#tabline#buffer_idx_mode = 1
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTabs#tabline#enabled = 1

" Sparkup
" Enable sparkup in handlebars files
autocmd FileType handlebars runtime! ftplugin/html/sparkup.vim

"-------------------------
" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_fenced_languages = [
  \ 'js=javascript',
  \ 'ts=typescript=ts',
  \ 'rb=ruby',
  \ 'hbs=html']



let g:mix_format_on_save = 1
"-------------------------
" ALE Linting
let g:ale_sign_column_always = 1

"-------------------------
" Closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.jsx,*.hbs"

if !has('nvim')
  "-------------------------
  " Neocomplete
  " Disable AutoComplPop.

  let g:acp_enableAtStartup = 0
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1

  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
endif

if has('nvim') && !exists("g:gui_oni")
  let g:deoplete#enable_at_startup = 1
   " Disable deoplete when in multi cursor mode
  function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
  endfunction

  function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
  endfunction
endif


if !exists("g:gui_oni") && !exists("veonim")
  " go back on one item with Shift-Tab <S-TAB>
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

  "-------------------------
  " UltiSnips

  let g:UltiSnipsExpandTrigger="<C-k>"
  let g:UltiSnipsJumpForwardTrigger="<TAB>"
  let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
  let g:ulti_expand_or_jump_res = 0

  inoremap <silent> <CR> <C-r>=<SID>expand_snippet_or_return()<CR>
  function! s:expand_snippet_or_return()
    if pumvisible()
      let snippet = UltiSnips#ExpandSnippetOrJump()
      if g:ulti_expand_or_jump_res > 0
        return snippet
      endif
      return "\<C-y>"
    else
      return "\<CR>"
    endif
  endfunction

  inoremap <silent> <TAB> <C-r>=<SID>expand_snippet_or_tab()<CR>
  function! s:expand_snippet_or_tab()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
      return snippet
    endif

    if pumvisible()
      return "\<C-n>"
    else
      return "\<TAB>"
    endif
  endfunction
endif

"-------------------------
" vim-multiple-cursors
map <leader>d :call multiple_cursors#quit()<CR>

" ---------------------------------------------------------------------------
" Strip trailing whitespace
" ---------------------------------------------------------------------------
function! <SID>StripTrailingWhitespaces()
  " Don't try to strip whitespace in non buffers
  if (!empty(&buftype))
    return
  endif

  " Only strip whitespace if isn't a slim, haml or emblem file
  if &filetype =~ 'slim' || &filetype =~ 'haml' || &filetype =~ 'emblem'
    return
  endif
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" ---------------------------------------------------------------------------
" Add support to go to file in JS without file extention
" ---------------------------------------------------------------------------
augroup suffixes
  autocmd!
  let associations = [
    \ ["javascript", ".js,.ts,.json,.jsx,.graphql"],
    \ ["typescript", ".js,.ts,.json,.jsx,.graphql"]]

  for ft in associations
    execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
augroup END

" ---------------------------------------------------------------------------
" Autosave
" ---------------------------------------------------------------------------

" Strip trailing whitespaces then save all files on focus lost
autocmd FocusLost * :call <SID>StripTrailingWhitespaces() | silent! wa

" ---------------------------------------------------------------------------
" GUI
" ---------------------------------------------------------------------------

if has("termguicolors") && !($TERM_PROGRAM == "Apple_Terminal")
  set termguicolors
endif

" colorscheme
if !exists("g:gui_oni")
  if has('nvim')
    " color OceanicNext
    color potpourri
  else
    " color onedark
    color OceanicNext
  endif
endif

if has("gui_running")
  set guioptions-=T " no toolbar set guioptions-=m " no menus
  set guioptions-=r " no scrollbar on the right
  set guioptions-=R " no scrollbar on the right
  set guioptions-=l " no scrollbar on the left
  set guioptions-=b " no scrollbar on the bottom
  set guioptions-=L "no scrollbar on the nerdtree"

  set guitablabel=%M%t

  if has("gui_gnome")
    set term=gnome-256color
    set guifont=Ubuntu\ Mono\ 12
  endif

  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
  endif

  if has("gui_win32") || has("gui_win32s")
    set guifont=Consolas:h12
  endif
else
  set novisualbell " Mute error bell

  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
endif

" listchars only for slim and haml files
autocmd BufNewFile,BufRead *.slim,*.haml,*.emblem setlocal list listchars=extends:>,precedes:<,eol:¬

" ---------------------------------------------------------------------------
" Column color
" ---------------------------------------------------------------------------

set colorcolumn=80
highlight ColorColumn guibg=#1e1e1e
highlight clear SignColumn

set fillchars+=vert:│

" Override color scheme
autocmd ColorScheme * highlight VertSplit guibg=NONE
autocmd ColorScheme * highlight NonText guifg=bg

if exists('veonim')
" extensions for web dev
VeonimExt 'veonim/ext-css'
VeonimExt 'veonim/ext-json'
VeonimExt 'veonim/ext-html'
" VeonimExt 'vscode:extension/sourcegraph.javascript-typescript'
VeonimExt 'veonim/ext-typescript-javascript'


"ctrl/cmd + v
" call VK('D-v', 'normal', {->execute(':put +')})
" call VK('D-v', 'insert', {->execute(':put +')})
" call VK('S-D-V', 'insert', {->execute(':put +')})
" call VK('S-D-V', 'normal', {->execute(':put +')})

nmap <silent> <leader>v :put +<cr>


let g:vn_font = 'Fira Code'
let g:vn_font_size = 16
let g:vn_line_height = '1.5'

set guicursor=n:block-CursorNormal,i:hor10-CursorInsert,v:block-CursorVisual
hi! CursorNormal guibg=#f3a082
hi! CursorInsert guibg=#f3a082
hi! CursorVisual guibg=#6d33ff


" workspace management
let g:vn_project_root = '~/code/neighborly'
nno <silent> <c-t>p :call Veonim('vim-create-dir', g:vn_project_root)<cr>
nno <silent> ,r :call Veonim('change-dir', g:vn_project_root)<cr>

" multiplexed vim instance management
nno <silent> <c-t>c :Veonim vim-create<cr>
nno <silent> <c-g> :Veonim vim-switch<cr>
nno <silent> <c-t>, :Veonim vim-rename<cr>

" workspace functions
nno <silent> ,f :Veonim files<cr>
nno <silent> ,e :Veonim explorer<cr>
nno <silent> ,b :Veonim buffers<cr>
nno <silent> ,d :Veonim change-dir<cr>

" searching text
nno <silent> <space>fw :Veonim grep-word<cr>
vno <silent> <space>fw :Veonim grep-selection<cr>
nno <silent> <space>fa :Veonim grep<cr>
nno <silent> <space>ff :Veonim grep-resume<cr>
nno <silent> <space>fb :Veonim buffer-search<cr>

" color picker
nno <silent> sc :Veonim pick-color<cr>

" language server functions
nno <silent> sr :Veonim rename<cr>
nno <silent> sd :Veonim definition<cr>
nno <silent> st :Veonim type-definition<cr>
nno <silent> si :Veonim implementation<cr>
nno <silent> sf :Veonim references<cr>
nno <silent> sh :Veonim hover<cr>
nno <silent> sl :Veonim symbols<cr>
nno <silent> so :Veonim workspace-symbols<cr>
nno <silent> sq :Veonim code-action<cr>
nno <silent> sp :Veonim show-problem<cr>
nno <silent> sk :Veonim highlight<cr>
nno <silent> sK :Veonim highlight-clear<cr>
nno <silent> <c-n> :Veonim next-problem<cr>
nno <silent> <c-p> :Veonim prev-problem<cr>
nno <silent> ,n :Veonim next-usage<cr>
nno <silent> ,p :Veonim prev-usage<cr>
nno <silent> <space>pt :Veonim problems-toggle<cr>
nno <silent> <space>pf :Veonim problems-focus<cr>
nno <silent> <d-o> :Veonim buffer-prev<cr>
nno <silent> <d-i> :Veonim buffer-next<cr>
endif

" ---------------------------------------------------------------------------
" Load custom configs
" ---------------------------------------------------------------------------

if filereadable(expand("$HOME/") . '.vimrc.local')
  source ~/.vimrc.local
endif

" ---------------------------------------------------------------------------
" Load folder specific settings and disable unsafe commands
" ---------------------------------------------------------------------------
set exrc
set secure
