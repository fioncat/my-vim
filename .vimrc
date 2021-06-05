" ============================= VIM CONFIG FILE =============================
" 仅适用于VIM8以及以上的版本
" Author: Lazycat

" {{{ GUI configuation
set guifont=Powerline\ Consolas:h15
set guifontwide=YaHei\ Consolas\ Hybrid:h15
set guicursor+=a:blinkon0
" }}}

" ============================= 基础配置 =============================

" {{{ Basic Configuration
" 关闭兼容模式
set nocompatible

" 让退格符在插入模式下能够删除前一个字符，就像一般的编辑器那样
set backspace=indent,eol,start

" utf-8编码，在一些插件下要求这个配置
set encoding=UTF-8

" 显示相对行号
set number relativenumber

" 突出显示当前行
set cursorline

" 突出显示搜索匹配项
set showmatch

" tab相关配置 - tab占用4spaces
set ts=4
set shiftwidth=4
" 自动对齐
set autoindent

" vs分屏时默认在右边打开
set splitright

" 实时搜索，不必等按下<Enter>再进行搜索
set incsearch

" 搜索忽略大小写
set ignorecase

" 不允许生成swp文件，这些文件用于异常中断时的恢复
" 如果需要这个功能，注释掉这个配置即可
set noswapfile

" 启动语法高亮
syntax enable

" 命令行的高度高一些
set cmdheight=2

" vim自带的命令行补全
set wildmenu

" Ctrl-A 跳转到当前行首，就像Emacs那样
nnoremap <C-a> ^

" :w命令时常会误输入为:W，因此这里做一个映射
cnoreabbrev W w

" 部分文件使用marker折叠，方便快速定位
autocmd FileType vim set foldmethod=marker
autocmd FileType proto set foldmethod=marker
" }}}

" ============================= 基础快捷键 =============================

" {{{ Basic KeyMaps
" SPC(Space)作为Leader，就像Spacemacs默认那样
let mapleader=" "

" 打开内置终端
nnoremap <leader>' :vert ter<CR>

" 将在Visual Mode下选中的内容复制到系统剪切板
vmap <leader>yy "+yy
vmap <leader>xx "+xx

" 帮助文档
nnoremap <leader>h :vert help 

" 窗口控制快捷键
" 垂直分屏
nnoremap <leader>w/ :vs<CR>
" 水平分屏
nnoremap <leader>w- :sv<CR>
" 调整垂直分屏尺寸
nnoremap <leader>w[ :vertical resize+3<CR>
nnoremap <leader>w] :vertical resize-3<CR>
" }}}

" ============================= 插件列表 =============================

" {{{ plugs
call plug#begin('~/.vim/plugged')

  " 搜索插件
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " 文件树
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'jistr/vim-nerdtree-tabs'

  " 状态栏
  Plug 'vim-airline/vim-airline'

  " 编辑插件
  Plug 'jiangmiao/auto-pairs'
  Plug 'majutsushi/tagbar'
  Plug 'junegunn/vim-easy-align'

  " 快速注释
  Plug 'scrooloose/nerdcommenter'

  " 代码补全
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " Git
  Plug 'tpope/vim-fugitive'
 
  " 主题
  Plug 'fioncat/vim-oceanicnext'

  " 快速清除buffer
  Plug 'fioncat/vim-bufclean'

  " vim-go的极简版，去除了gopls，以及所有coc拥有的功能
  Plug 'fioncat/vim-minigo'

  " 在sign-line显示marks
  Plug 'kshenoy/vim-signature'

call plug#end()
" }}}

" ============================= 插件配置 =============================

" {{{ Theme
" 设置VIM主题
colorscheme OceanicNext
set background=dark
set termguicolors
" }}}

" {{{ plug 'Airline'
" 显示状态栏
set laststatus=2

" 开启上方的tabline功能
let g:airline#extensions#tabline#enabled = 1
" 只显示buffer编号，不显示bufno
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1

" 图表替换，这样底层状态栏error/warning那里可以好看一些
let g:airline#extensions#coc#error_symbol = '✗ '
let g:airline#extensions#coc#warning_symbol = '⚡ '

nnoremap <leader>bn :bn<CR>
nnoremap <leader>bp :bp<CR>
" }}}

" {{{ Plug 'NERDTree'
let g:NERDSpaceDelims=1
let g:NERDTreeMinimalUI=1

" 打开文件树
nnoremap <leader>tt :NERDTreeToggle<CR>
" 在文件树打开当前文件
nnoremap <leader>ff :NERDTreeFind<CR>
" }}}

" {{{ Plug 'Tag Bar'
" tagbar Golang支持
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
" 打开tagbar
nnoremap <leader>tb :TagbarToggle<CR>
" }}}

" {{{ Plug 'Coc'
" 代码补全样式，详见:help completeopt
set completeopt=menu,menuone

set hidden

" 如果支持，将diagnostic signs放到原生行号中，这样就不必再显示sign
" colume以节约空间
if has("nvim-0.5.0") || has("patch-8.1.1564")
  set signcolumn=number
else
  set signcolumn=yes
endif

" 代码补全时使用TAB和s-TAB进行快速补全
" 这个行为和ycm的默认行为一样
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <Enter> 选择补全项
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 高亮展示光标悬浮的引用
autocmd CursorHold * silent call CocActionAsync('highlight')

" GD - 代码跳转
nmap <silent> gd <Plug>(coc-definition)
" GR - 显示变量引用
nmap <silent> gr <Plug>(coc-references)
" K：展示文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
" 变量改名
nmap <leader>rn <Plug>(coc-rename)
" 将选中的代码格式化
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" 上一个/下一个错误
nnoremap <leader>en :call CocAction('diagnosticNext')<CR>
nnoremap <leader>ep :call CocAction('diagnosticPrevious')<CR>
" 打开错误列表
nnoremap <leader>ee :CocList diagnostics<CR>
" 代码折叠
nnoremap <leader>fd :call CocAction('fold')<CR>
" }}}

" {{{ Plug 'mini-go'
" Go语法高亮
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

" 在:w时自动进行GoImports并重新执行ALE
function! GoReformat()
	call go#fmt#Format(1)
endfunction
autocmd BufWriteCmd *.go call GoReformat()

" 一些Go Tools
nnoremap gat :GoAddTags<CR>
nnoremap grt :GoRemoveTags<CR>
nnoremap gi  :GoImports<CR>
nnoremap gfs :GoFillStruct<CR>
" }}}

" {{{ Plug 'fzf'
" 全屏展示搜索
let g:fzf_layout = { 'down': '~100%' }
let g:fzf_preview_window = ['down:50%']

" fzf搜索框colors配置，让其符合当前主题
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Function'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Visual', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" RG搜索, filename表示对什么文件进行搜索
function! RGSearch(filename)
	let command_fmt = 'rg --with-filename --column --line-number' 
		\ . ' --no-heading --color=always --smart-case -- %s ' 
		\ . a:filename . ' || true'
    let initial_command = printf(command_fmt, shellescape(''))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', '', '--bind', 
		\ 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), 0)
endfunction

" 搜索文件
nnoremap <leader>sf :Files<CR>
" 搜索全局内容
nnoremap <leader>sg :call RGSearch('')<CR>
" 搜索当前文件内容
nnoremap <leader>sl :call RGSearch(fnameescape(expand('%')))<CR>
" 搜索buffer
nnoremap <leader>sb :Buffers<CR>
" }}}

" {{{ Plug 'Git'
" 打开Git Blame
nnoremap <leader>gb :Git blame<CR>
" }}}

" {{{ Plug 'BufClean'
nnoremap <leader>bc :BufClean<CR>
" }}}

