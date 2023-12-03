" General
set expandtab
set tabstop=2
set shiftwidth=4
set softtabstop=2
set autoindent
set nonumber

set title

" Encoding
set encoding=utf-8
scriptencoding utf-8

" Search
set noignorecase
set wrapscan

" Keybind
inoremap <silent> jj <ESC>

" quick fix
" nnoremap <silent> <C-p> :<C-u>cp<CR>
" nnoremap <silent> <C-n> :<C-u>cn<CR>
" function! OpenQuickfixWindow()
"   cw
"   set modifiable
"   vertical resize 70
" endfunction

" autocmd QuickfixCmdPost vimgrep call OpenQuickfixWindow()

" fern keybind
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>

filetype on
filetype plugin indent on

" File Types
augroup fileTypeIndent
  autocmd!
  autocmd FileType make setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.rb setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.rs setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.c setlocal tabstop=8 softtabstop=8 shiftwidth=8
  autocmd BufNewFile,BufRead *.cc setlocal tabstop=8 softtabstop=8 shiftwidth=8
  autocmd BufNewFile,BufRead *.h setlocal tabstop=8 softtabstop=8 shiftwidth=8
  autocmd BufNewFile,BufRead *.html setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.js setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.jsx setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.ts setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.tsx setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.vue setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd BufRead,BufNewFile * nested if @% !~ '\.' && getline(1) == '^#!/bin/bash.*' | set filetype=bash | endif
  autocmd BufRead,BufNewFile * nested if @% == '\.' | set filetype=bash | endif
  autocmd BufRead,BufNewFile * nested if @% !~ '\.' && getline(1) == '^#!.*python.*' | set filetype=python | endif
  autocmd BufRead,BufNewFile * nested if @% !~ '\.' && getline(1) == '^#!.*ruby.*' | set filetype=ruby | endif
  autocmd BufRead,BufNewFile * nested if @% !~ '\.' && getline(1) == '^#!/bin/zsh.*' | set filetype=bash | endif
augroup END


" paste config
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'haishanh/night-owl.vim'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
"Plug 'airblade/vim-gitgutter'
Plug 'yuki-yano/fern-preview.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'puremourning/vimspector'
call plug#end()

" night-owl/vim Scheme {{{
syntax enable
colorscheme night-owl
" }}}

" puremouring/vimspector {{{
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]
let g:vimspector_enable_mappings = 'HUMAN'
" }}}

" vim-airline/vim-airline {{{
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_theme = 'wombat'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" }}}

" fern {{{
let g:fern#renderer = "nerdfont"
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END
" }}}

" fern config {{{
let g:fern#default_hidden=1
"}}}

" junegunn/fzf.vim {{{

fun! FzfOmniFiles()
  let is_git = system('git status')
  if v:shell_error
    :Files
  else
    :GFiles
  endif
endfun
nnoremap <C-p> :call FzfOmniFiles()<CR>

command! -bang -nargs=* Rg
\ call fzf#vim#grep(
\ "rg -g '!.git/' -g '!node_modules/' --column --line-number --hidden --ignore-case --no-heading --color=always ".shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 3..'}, 'up:60%')
\ : fzf#vim#with_preview({'options': '--exact --delimiter : --nth 3..'}, 'right:50%:hidden', '?'),
\ <bang>0)
nnoremap <C-g> :Rg<CR>

" }}}

"" git操作
" g]で前の変更箇所へ移動する
" nnoremap g[ :GitGutterPrevHunk<CR>
" g[で次の変更箇所へ移動する
" nnoremap g] :GitGutterNextHunk<CR>
" ghでdiffをハイライトする
" nnoremap gh :GitGutterLineHighlightsToggle<CR>
" gpでカーソル行のdiffを表示する
" nnoremap gp :GitGutterPreviewHunk<CR>
" 記号の色を変更する
" highlight GitGutterAdd ctermfg=green
" highlight GitGutterChange ctermfg=blue
" highlight GitGutterDelete ctermfg=red

"" 反映時間を短くする(デフォルトは4000ms)
set updatetime=250
" }}}

" fern preview
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END
" }}}

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

