" this is an nvim config not a vi one
set nocompatible

filetype plugin indent on


" keep buffers in memory
" set hidden
" !(was disabled because unsaved buffers
"  asked to be saved even when closed)

" enable me to search local dir
set path+=**  " the python config overrides this setting
" tab completion menu
set wildmenu

" make vim consider .h files as c files and not cpp
autocmd BufReadPre,BufNewFile *.h,*.c set filetype=c

" add a command to generate tags
" to jump to tag ^] and to jump back ^t
command MakeTags !ctags -R .

" template insertion
function! InsertTemplate(template)
    exec "0r ~/Templates/" . a:template
endfunction

function! InsertTemplate_if_empty(template)
    if filereadable(expand("~/Templates/".a:template))
        if line('$') == 1 && getline(1) == ''
            call InsertTemplate(a:template)
            " call a replacement with \%:[something in he filename-modifiers]
            %s/\\\(%\(:.\)\+\)/\=expand(''.submatch(1))/ge
            " \:eval replacement
            silent! %s/\\:eval(\(.*\))/\=eval(''.submatch(1))/ge
        endif
    else
        echom a:template
        " echom 'No template present in ~/Templates/ for' . a:template
    endif
endfunction

" add a command to insert a template
command -nargs=1 LoadTemplate call InsertTemplate(<f-args>)
" if the file is a c header inser the h template otherwise
" insert the template corresponding to the detected file extension
autocmd BufNewFile * if expand('%:e') == "h" | call InsertTemplate_if_empty("h") | else | call InsertTemplate_if_empty(&filetype) | endif

" render whitespaces, usefull for make files and python files
set list
set listchars=tab:>-,nbsp:~,trail:~,extends:>,precedes:<

" auto-complete prep
set completeopt=menuone
set complete=k,.,w,b,u,t,d,i,U
set omnifunc=syntaxcomplete#Complete
inoremap <C-Space> <C-x><C-n>

function! Smart_TabComplete()
  " current line
  let line = getline('.')

  " from the start of the current
  let substr = strpart(line, -1, col('.'))
  " line to one character right
  " of the cursor
  " word till cursor
  let substr = matchstr(substr, "[^ \t]*$")
  " nothing to match on empty string
  if (strlen(substr)==0)
    " insert tab
    return "\<C-i>"
  endif
  " position of period, if any
  let has_period = match(substr, '\.') != -1
  " position of slash, if any
  let has_slash = match(substr, '\/') != -1
  if (!has_period && !has_slash)
    " existing text matching
    return "\<C-X>\<C-N>"
  elseif ( has_slash )
    " file matching
    return "\<C-X>\<C-F>"
  else
    " omnicompletion
    return "\<C-X>\<C-O>"
  endif
endfunction

" bind smart tab to tab key
inoremap <C-i> <C-r>=Smart_TabComplete()<CR>

" quickfix window movements
nnoremap <C-j> :cn<CR>
nnoremap <C-k> :cp<CR>

" Python specific modifications
" call flake8 and mypy in the quickfix buffer using :make
autocmd Filetype python setlocal makeprg=(flake8\ %\ &&\ mypy\ %)
autocmd Filetype python nnoremap <F7> :!mypy "%"<CR>
autocmd Filetype python nnoremap <F8> :!flake8 "%"<CR>
" custom dictionary completion for python keywords
" for dictionary completion <C-x><C-k>
autocmd Filetype python setlocal dictionary+=/usr/share/dict/py_kw
" custom definition completion regex
" for definition completion <C-x><C-d>
autocmd Filetype python let &l:define = '^\s*\(async\s\)\?def'
" custom include completion regex <C-x><C-i>
" for definition completion and regular completion <C-x><C-p>
autocmd Filetype python let &l:include = '^\s*import'

" set python path as vim path for K and omnicompletion
autocmd Filetype python let &l:path = execute('python3 import sys, vim; print(".,**,"+"".join(","+x for x in sys.path))')
" change K to behave like help
" TODO: make it so that using K on a fn from a
" module will call pydoc with <current keyword>.<cword>
autocmd Filetype python let &l:keywordprg = ':new | setlocal buftype=nofile noswapfile bufhidden=delete nonumber nolist | 0read !pydoc'
" remove the junk from definition completion
" ie: stuff that omnicompletion already does
autocmd Filetype python setlocal wildignore+=*/lib/python3*

" C specific modifications
autocmd Filetype c setlocal makeprg=make
" inserts /* */ and puts the cursor in between
autocmd Filetype c iabbrev <buffer> ccom /**/<Esc>hi <Esc>ha
" typing (void*) is long
autocmd Filetype c iabbrev <buffer> vp (void*)

" insert mode automatically when opening a vim terminal
" TODO TermEnter does not work
autocmd TermOpen,TermEnter * setlocal nonumber | silent! normal i
" add custom command to open a terminal in a new tab
command Termn :tabnew +term

" arrow keys are evil
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" highlight characters after 80th column
match Error /\%81v.\+/
" wrap cursor atfter 80th char automatically when inserting
set textwidth=80
" make the clipboard play along nicely with X
set clipboard=unnamedplus
" use 4 spaces as tabs because tabs are evil
set tabstop=4
set shiftwidth=4
set expandtab
" see linenumber
set number
" give me colours
syntax enable
