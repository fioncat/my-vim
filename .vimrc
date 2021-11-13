" ============================= VIM CONFIG FILE =============================
" 仅适用于VIM8以及以上的版本
" Author: Lazycat
" {{{ GUI configuation
set guifont=Powerline\ Consolas:h15
set guifontwide=YaHei\ Consolas\ Hybrid:h15
set guicursor+=a:blinkon0

" 移除滚动条
set guioptions=
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
" 如果开启这个选项，那么会用space替代tab插入
" set expandtab
" 自动对齐
set autoindent

" vs分屏时默认在右边打开
set splitright

" split分屏默认在下方打开
set splitbelow

" 实时搜索，不必等按下<Enter>再进行搜索
set incsearch
" 搜索高亮
set hlsearch

" 搜索忽略大小写
set ignorecase

" 不允许生成swp文件，这些文件用于异常中断时的恢复
" 如果需要这个功能，注释掉这个配置即可
set noswapfile

" 启动语法高亮
syntax enable

" 命令行的高度高一些
set cmdheight=1

" vim自带的命令行补全
set wildmenu
set wildmode=longest,list

" 当buffer中的文件在磁盘有变更时，自动刷新buffer而不用
" 每次都询问一遍
set autoread

" 关闭响铃
set noeb vb t_vb=

" Ctrl-A 跳转到当前行首，就像Emacs那样
" 重新将Ctrl-S映射为数字加1
nnoremap <C-s> <C-a>
nnoremap <C-a> ^

" :w命令时常会误输入为:W，因此这里做一个映射
cnoreabbrev W w

" 启用tab的indentLine(如果使用的是space，需要indentLine插件)
" set list lcs=tab:\.\ 

" 部分文件使用marker折叠，方便快速定位
autocmd FileType vim set foldmethod=marker
autocmd FileType vim set foldlevel=0
autocmd FileType proto set foldmethod=marker
autocmd FileType proto set foldlevel=0

autocmd FileType json set filetype=json
autocmd FileType json set foldmethod=syntax
autocmd FileType json set foldlevel=99
" JSON 文件tab为2个空格
autocmd FileType json set tabstop=2
autocmd FileType json set shiftwidth=2
autocmd FileType json set expandtab

autocmd FileType javascript set tabstop=2
autocmd FileType javascript set shiftwidth=2
autocmd FileType javascript set expandtab

autocmd FileType typescriptreact set tabstop=2
autocmd FileType typescriptreact set shiftwidth=2
autocmd FileType typescriptreact set expandtab
" 解决按下ESC延时进入InsertMode的问题
set ttimeout
set ttimeoutlen=0

" 在css文件中，将'@'认为是关键词
autocmd FileType scss setl iskeyword+=@-@

" 在Insert模式下，光标显示为长条
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" augroup myCmds
" au!
" autocmd VimEnter * silent !echo -ne "\e[2 q"
" augroup END

" }}}
" ============================= 基础快捷键 =============================
" {{{ Basic KeyMaps
" SPC(Space)作为Leader，就像Spacemacs默认那样
let mapleader=" "

" 将在Visual Mode下选中的内容复制到系统剪切板
" vmap <leader>yy "+yy
vmap <leader>xx "+xx
vmap cy "+yy

" 帮助文档
" nnoremap <leader>h :vert help 

" 窗口控制快捷键
" 垂直分屏
nnoremap <leader>w/ :vs<CR>
" 水平分屏
nnoremap <leader>w- :sv<CR>
" 调整垂直分屏尺寸
nnoremap <C-w>[ :vertical resize+3<CR>
nnoremap <C-w>] :vertical resize-3<CR>

" 打开内置终端
nnoremap <leader>' :ter<CR>
nnoremap <leader>" :vert ter<CR>
" 在内置Terminal中，按下C-N进入普通模式，以滚动或复制文本
tnoremap <C-N> <C-\><C-N>
" 在内置Ternimal按下C-Q直接退出
tnoremap <C-Q> exit<CR>

nnoremap <leader>h :noh<CR>
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
  Plug 'vim-airline/vim-airline-themes'

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

  " 翻译插件
  Plug 'voldikss/vim-translator'

  " 快速给内容增加成对的surroundings字符
  Plug 'tpope/vim-surround'

  " Golang 调试插件 - Delve
  Plug 'sebdah/vim-delve'

  " YAML 折叠
  Plug 'fioncat/vim-yaml-folds'

  " 像vscode那样实时展示git blamer信息
  Plug 'APZelos/blamer.nvim'

  " 展示搜索index
  Plug 'google/vim-searchindex'

  Plug 'yuezk/vim-js'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'

call plug#end()
" }}}
" ============================= 插件配置 =============================
" {{{ Theme
" 设置VIM主题
colorscheme OceanicNext
set background=dark
set termguicolors
" 如果你需要vim透明背景，加入以下配置
hi Normal guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
" }}}
" {{{ Airline
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

let g:airline_powerline_fonts = 1

nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>b1 :b1<CR>
nnoremap <leader>b2 :b2<CR>
nnoremap <leader>b3 :b3<CR>
nnoremap <leader>b4 :b4<CR>
nnoremap <leader>b5 :b5<CR>
nnoremap <leader>b6 :b6<CR>
nnoremap <leader>b7 :b7<CR>
nnoremap <leader>b8 :b8<CR>
" }}}
" {{{ NERDTree
let g:NERDSpaceDelims=1
let g:NERDTreeMinimalUI=1

let g:nerdtree_tabs_open_on_gui_startup = 0

" 打开文件树
nnoremap <leader>tt :NERDTreeToggle<CR>
" 在文件树打开当前文件
nnoremap <leader>ff :NERDTreeFind<CR>
" }}}
" {{{ Tag Bar
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
" {{{ Coc
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

" <Enter> 快速选择补全项
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 展示光标所在处的文档
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" 在显示文档的时候，使用<C-j>, <C-k>来上下滚动
nnoremap <nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

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
" {{{ mini-go
" Go语法高亮
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

" 在:w时自动进行GoImports并重新执行GoFmt
autocmd BufWriteCmd *.go call go#fmt#Format(1)
" 在GoFmt失败时，忽略掉错误以避免文件无法正常写入
autocmd FileType go call go#config#FmtFailSilently()

" 对于go.mod文件使用gomod高亮
au BufReadPost go.mod set syntax=gomod
au BufReadPost go.sum set syntax=gosum

" 代码块折叠功能
autocmd FileType go call go#config#FoldEnable()
autocmd FileType go setlocal foldmethod=syntax
autocmd FileType go setlocal foldlevel=99  " 启动时不进行折叠，需要手动触发

" 将高亮设置为GoTemplate
nnoremap gtl :set syntax=gotexttmpl<CR>

" 一些Go Tools
autocmd FileType go nnoremap gat :GoAddTags 
autocmd FileType go nnoremap grt :GoRemoveTags 
autocmd FileType go nnoremap gi  :GoImports<CR>
autocmd FileType go nnoremap gfs :GoFillStruct<CR>
" }}}
" {{{ fzf
let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.6, 'relative': v:false, 'yoffset': 1.0 } }

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
" 搜索当前buffer目录下的文件
nnoremap <leader>ss :call fzf#vim#files(expand('%:p:h'), fzf#vim#with_preview(), 0)<CR>
" 搜索全局内容
nnoremap <leader>sg :call RGSearch('')<CR>
" 搜索当前文件内容
nnoremap <leader>sl :call RGSearch(fnameescape(expand('%')))<CR>
" 搜索buffer
nnoremap <leader>sb :Buffers<CR>
" }}}
" {{{ Git
" 打开Git Blame
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
" }}}
" {{{ BufClean
nnoremap <leader>bc :BufClean<CR>
" }}}
" {{{ translator
vmap <silent> <leader>tw <Plug>TranslateWV
" }}}
" {{{ Delve-go
autocmd FileType go nnoremap <leader>db :DlvToggleBreakpoint<CR>
autocmd FileType go nnoremap <leader>dr :DlvToggleTracepoint<CR>
autocmd FileType go nnoremap <leader>dc :DlvClearAll<CR>
autocmd FileType go nnoremap <leader>dd :DlvDebug -- 
autocmd FileType go nnoremap <leader>dt :DlvTest -- -test.run  
" }}}
" {{{ balmer
let g:blamer_enabled = 1
let g:blamer_delay = 3000
let g:blamer_date_format = '%Y-%m-%d'
let g:blamer_template = '<committer> • <committer-time>'
let g:blamer_show_in_visual_modes = 0
let g:blamer_show_in_insert_modes = 0
" }}}
