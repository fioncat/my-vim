# vim日记

作为一名Golang开发者，使用过各种编辑器/IDE，其中包括：

- GoLand：啥也不说了，做过Java的应该对jetbrains的IDE有深深的情感。GoLand有JetBrains家IDE的所有特色，它不使用gopls而是用自己的language server，因此很快速，并且有着一套异常强大的工具集，调试代码非常方便。唯一的问题就是它不是免费的。
- VsCode：目前最好用的开源编辑器之一，近几年有赶超SublimeText的趋势。插件库异常庞大，可以用无数插件堆砌成一个IDE，目前我同事最多的选择。缺点就是在使用大项目并且插件较多时会比较卡。
- Emacs：老牌编辑器。因为不习惯Emcas-mode，所以我用的是Spacemacs的vim-mode。是我在用vim之前用的最多的编辑器。

比起传统的编辑模式，vim-mode的编辑和文本处理效率是要高上不少的，因此上面的所有编辑器我无一例外都会使用vim插件。但是比起GoLand和VsCode，我还是喜欢纯Vim，Emcas这样的终端编辑器，因为它们可以让我随时快速地编辑文件和输入命令，并且可以在诸如服务器的无GUI环境运行。

其中，我很喜欢Spacemacs的快捷键模式，使用空格(SPC)作为leader键，快捷键采用容易记忆的简写方式配置，例如查看Git Blame使用SPC g b快捷键。我将这种快捷键配置习惯加到了vim中。

我放弃Spacemacs的原因是，它的加载速度太慢了，每次启动需要加载200多个layers，并且我不是很习惯Emacs-Lisp，相比于它，我认为vim-script要人性化太多。

因此我最终选择了纯vim作为我的生产工具。下面是最终效果图：

![vim-1](vim1.png)

![vim-2](vim2.png)

自从vim8引入异步等features之后，配合autoload，速度还是很不错的，所以我没有去用Neovim。如果你用的是vim8以下的版本，那么更应该去使用nvim而不是vim。

以下是我使用的所有插件列表：

| 插件            | 用途                                                         | 自定义快捷键                                                 |
| --------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| fzf             | 搜索插件<br>可以代替ctrlp插件进行文件搜索<br>自带了ACK命令用于内容搜索<br>并且支持诸如Git搜索等各种强大功能 | 文件搜索：SPC s f<br>ACK搜索：SPC s g<br>行搜索：SPC s s<br>buffer搜索：SPC s b |
| nerdtree        | vim必装的文件树插件                                          | 打开/关闭文件树：SPC t t<br>在文件树打开当前文件：SPC f f    |
| airline         | 漂亮的vim状态栏                                              | 无                                                           |
| auto-pairs      | 自动补全括号                                                 | 无                                                           |
| tagbar          | 显示代码结构，需要ctags支持                                  | 打开tagbar：SPC t b                                          |
| easy-align      | 自动对齐                                                     | 无                                                           |
| nerdcommenter   | 快速注释/取消注释插件<br>可以在visual模式选中多行进行注释    | 注释/取消注释：SPC c i                                       |
| coc.nvim        | 超好用的补全插件<br>需要node.js的支持<br>拥有自己独立的插件库<br>使用比YouCompleteMe方便很多 | 代码跳转：g d<br>显示变量引用：g r<br>显示文档：K<br>批量修改变量名：SPC r n<br>选中代码格式化：SPC f |
| vim-minigo      | 我自己写的插件😀<br>基于[vim-go](https://github.com/fatih/vim-go)的mini版<br>删除和coc重复的功能<br>删除gopls，防止和coc一起时启动多个gopls<br>保留coc没有的go工具集 | 增加Tag：g a t<br>删除Tag：g r t<br>执行goimports：g i<br>执行fillstruct：g f s<br>待补充更多... |
| vim-fugitive    | vim Git支持<br>支持各种Git命令                               | 显示Git Blame：SPC g b                                       |
| vim-markdown    | Markdown支持                                                 | 无                                                           |
| vim-bufclean    | 我自己写的插件😀<br>快速删除那些非活跃的buffer                | 清理buffer：SPC b c                                          |
| ale             | 代码检查插件<br>快速检查error和warning<br>和airline联动在状态栏显示错误数量 | 下一个错误：SPC e n<br>上一个错误：SPC e p<br>下一个warning：SPC  w n<br>上一个warning：SPC  w p<br>显示错误列表：SPC e e<br>关闭错误列表：SPC e q |
| vim-signature   | 在状态行显示marks                                            | 无                                                           |
| vim-oceanicnext | 我自己写的插件😀<br/>一个好看的主题<br>基于[oceanic-next](https://github.com/mhartington/oceanic-next)的改进版<br>加入了ALE支持，优化了一些细节 | 无                                                           |

以及一些配置的其它基础快捷键：

| 操作                           | 快捷键             |
| ------------------------------ | ------------------ |
| 打开内置终端                   | SPC '              |
| 在Visual下复制内容到系统剪切板 | SPC y y            |
| 在Visual下剪切内容到系统剪切板 | SPC x x            |
| 快速呼出帮助文档               | SPC h              |
| 垂直分屏                       | SPC w /            |
| 水平分屏                       | SPC w -            |
| 跳转垂直分屏尺寸               | SPC w ]<br>SPC w [ |

所有插件的详细配置会在下面给出。

## 基础配置

以下是一些基本的配置。

```vim-script
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

" Ctrl-A 跳转到当前行首，就像Emacs那样
nnoremap <C-a> ^

" :w命令时常会误输入为:W，因此这里做一个映射
cnoreabbrev W w

" 使用mark折叠，折叠功能我一般在配置文件中使用
" 如果需要更加强大的折叠，可以安装插件
set foldmethod=marker
```

## 快捷键基础配置

以下快捷键不依赖任何插件，所以我单独拿出来进行配置：

```vim-script
" SPC(Space)作为Leader，就像Spacemacs默认那样
let mapleader=" "

" 打开内置终端
nnoremap <leader>' :vert ter<CR>

" 将在Visual Mode下选中的内容复制到系统剪切板
vmap <leader>yy "+yy
vmap <leader>xx "+xx

" 帮助文档
nnoremap <leader>h :vert help 

" 打开/关闭 location list以查看ale的错误列表
nnoremap <leader>ee :lopen<CR>
nnoremap <leader>eq :lclose<CR>

" 窗口控制快捷键
" 垂直分屏
nnoremap <leader>w/ :vs<CR>
" 水平分屏
nnoremap <leader>w- :sv<CR>
" 调整垂直分屏尺寸
nnoremap <leader>w[ :vertical resize+3<CR>
nnoremap <leader>w] :vertical resize-3<CR>
```

## vim-plug安装

[vim-plug](https://github.com/junegunn/vim-plug)是一个高效的vim插件管理器。很多人喜欢Vundle，但是vim-plug更加轻量，迅速。它利用了vim8的autoload，能实现异步加载插件，大大提高了vim的启动速度。

使用以下命令安装：

```text
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

在Linux下，可能因为DNS的原因导致`raw.githubusercontent.com`这个域名访问不了。可以直接将文件复制下来放到`~/.vim/autoload/plug.vim`即可。

## 插件配置

安装好vim-plug之后，将所有插件列表加到配置中：

```vim-script
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
 
  " Markdown支持
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'

  " 主题
  Plug 'fioncat/vim-oceanicnext'

  " 快速清除buffer
  Plug 'fioncat/vim-bufclean'

  " vim-go的极简版，去除了gopls，以及所有coc拥有的功能
  Plug 'fioncat/vim-minigo'

  " 语法检查, 没有用coc自带的是因为我觉得它更好用
  " 并且coc支持以ale作为diagnostic组件
  Plug 'w0rp/ale'

  " 在sign-line显示marks
  Plug 'kshenoy/vim-signature'

call plug#end()
```

随后重启vim，输入`:PlugInstall`即可进行安装。

随后，针对不同的插件有一些不同的个性化配置，需要在插件列表的后面加上。

### oceanicnext主题

使用以下配置设置vim主题：

```vim-script
" 设置VIM主题
colorscheme OceanicNext
set background=dark
set termguicolors
```

### Airline

一个状态栏插件，可以和ALE联动实现在状态栏实时展示代码的error和warning数量。

oceanicnext主题里面自带了airline插件，因此vim启动时airline会自动使用oceanicnext的主题。

```vim-script
" 显示状态栏
set laststatus=2

" ALE 显示error/warning数量
let g:airline#extensions#ale#enabled = 1

" 图表替换，这样底层状态栏error/warning那里可以好看一些
let g:airline#extensions#ale#error_symbol = '✗ '
let g:airline#extensions#ale#warning_symbol = '⚡ '
```

### NERDTree

一个vim必装的文件树插件。配置如下：

```vim-script
let g:NERDSpaceDelims=1
let g:NERDTreeMinimalUI=1

" 打开文件树
nnoremap <leader>tt :NERDTreeToggle<CR>
" 在文件树打开当前文件
nnoremap <leader>ff :NERDTreeFind<CR>
```

### tagbar

这个插件可以展示当前代码的整体结构，并进行快速跳转。需要ctags的支持：

```text
$ brew install ctags
```

配置如下：

```vim-script
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
```

### coc.nvim

一个比较新的补全插件，我曾经也是使用YouCompleteMe的，但是coc的功能和使用实在比ycm好很多。coc有自己的插件库，采用类似VsCode的插件管理方式，在独立的json文件中配置插件，并使用`:CocInstall`单独安装插件。

coc需要node.js的支持，可以到官网下载对应系统的安装包进行安装，安装后输入以下命令查看版本：

```text
$ node -v
v14.17.0
```

coc需要10.12以上的node版本。

在`.vimrc`中，coc的配置如下：

```vim-script
" 代码补全样式，详见:help completeopt
set completeopt=menu,menuone

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
```

除此之外，coc还需要单独配置，输入`:CocConfig`打开配置文件，输入：

```json
{
  "diagnostic.displayByAle": true,

  "languageserver": {
    "go": {
      "command": "gopls",
      "rootPatterns": ["go.mod"],
      "trace.server": "verbose",
      "filetypes": ["go"]
    }
  }
}
```

因为日常开发还用到了Python，所以还需要安装Python的插件：`:CocInstall coc-python`。

coc内部使用LSP作为languageserver，所以不同语言都需要安装自己的LSP支持：

Go语言(gopls)：

```text
$ go get -u golang.org/x/tools/gopls@latest
```

python语言(jedi)：

```vim-script
$ pip3 install jedi
```

其它语言需要自行参照文档。

### ALE

ALE是一个用于代码检查的插件。coc可以使用ALE作为代码检查器（我在coc中已经配置好了）。

ALE的配置如下：

```vim-script
" 错误高亮
let g:ale_set_highlights = 1
" 始终显示sign行
let g:ale_sign_column_always = 1

" sign行error/warning的标识字符
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>>'

" 设置protobuf的根路径
let g:ale_proto_protoc_gen_lint_options = '-I apidoc/proto'

" 使用go build进行语法检查，以更加及时
" 使用golint进行代码格式检查
let g:ale_linters = {
\   'go': ['go build', 'golint'],
\}

" 跳转到 下一个/上一个 错误
nnoremap <leader>en :ALENext -error<CR>
nnoremap <leader>ep :ALEPrevious -error<CR>

" 跳转到 下一个/上一个 警告
nnoremap <leader>wn :ALENext -warning<CR>
nnoremap <leader>wp :ALEPrevious -warning<CR>
```

### mini-go

本来我是直接用[vim-go](https://github.com/fatih/vim-go)。后来发现这个插件和coc一起使用时存在一些问题：

- vim-go和coc都会启动自己的gopls，导致有多个gopls同时运行，vim资源占用高。
- vim-go有一些功能，例如代码检查，跳转等在coc中已经提供了，二者一起使用时显得有点多余。

因此我基于原来的vim-go进行了很多删改，删去了大量gopls相关脚本，仅保留了一些coc缺失的功能，例如`GoAddTag`，`GoFillStruct`等。并且保留了Go语言语法高亮。

配置如下：

```vim-script
" Go语法高亮
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

" 一些Go Tools
nnoremap gat :GoAddTags<CR>
nnoremap grt :GoRemoveTags<CR>
nnoremap gi  :GoImports<CR>
nnoremap gfs :GoFillStruct<CR>
```

Go tools需要单独安装一些二进制程序：

```text
go install github.com/klauspost/asmfmt/cmd/asmfmt@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install github.com/kisielk/errcheck@latest
go install github.com/davidrjenni/reftools/cmd/fillstruct@latest
go install github.com/rogpeppe/godef@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/lint/golint@latest
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install github.com/fatih/gomodifytags@latest
go install golang.org/x/tools/cmd/gorename@latest
go install github.com/jstemmer/gotags@latest
go install golang.org/x/tools/cmd/guru@latest
go install github.com/josharian/impl@latest
go install honnef.co/go/tools/cmd/keyify@latest
go install github.com/fatih/motion@latest
go install github.com/koron/iferr@latest
```

### fzf

fzf是一个强大的搜索插件，可以替代`ctrlp`使用。并且支持各种维度的搜索。

fzf本身是一个用Go写的命令行程序，官方做了一个vim插件以方便在vim内部执行各种搜索命令。在mac/Linux下可以先单独安装fzf命令：

```text
$ brew install fzf
```

可以让fzf命令配合vim以实现快速搜索并打开文件：

```bash
alias fvim='vim $(fzf --bind=tab:preview-down,btab:preview-up)'
```

将这个语句加到shell profile（例如`.bashrc`， `.zshrc`）中，可以使用fvim实现搜索并用vim打开文件。

在vim中，对fzf进行如下配置：

```vim-script
" 在下方显示搜索框
let g:fzf_layout = { 'down': '~40%' }
" 不显示preview
let g:fzf_preview_window = []

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

" 搜索文件
nnoremap <leader>sf :Files<CR>
" 搜索全局内容
nnoremap <leader>sg :Ag<CR>
" 搜索当前文件内容
nnoremap <leader>ss :Lines<CR>
" 搜索buffer
nnoremap <leader>sb :Buffers<CR>
```

