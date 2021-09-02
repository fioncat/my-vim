# My vim profile

适用于日常Go开发的vim，支持自动补全，语法检查，跳转，文档查看，调试等功能。

**仅适用于vim8以及以上的版本，下面的版本请去用neovim**

## Plugins

使用[vim-plug](https://github.com/junegunn/vim-plug)管理插件，它比Vundle更快，更轻量。

以下是所有的插件列表

插件|说明|依赖
----|----|----
[fzf](https://github.com/junegunn/fzf.vim)|强大的搜索插件，可以完全替代ctrlp|fzf和rg命令
[nerdtree](https://github.com/scrooloose/nerdtree)|文件树|
[vim-airline](https://github.com/vim-airline/vim-airline)|强大的状态栏|需要Patched字体，我用的是：[Source Code Pro](https://github.com/powerline/fonts/tree/master/SourceCodePro)
[auto-pairs](https://github.com/jiangmiao/auto-pairs)|自动补全/删除括号|
[tagbar](https://github.com/majutsushi/tagbar)|显示代码结构|需要安装ctags
[vim-easy-align](https://github.com/junegunn/vim-easy-align)|快速对齐
[nerdcommenter](https://github.com/scrooloose/nerdcommenter)|快速注释
[coc.nvim](https://github.com/neoclide/coc.nvim)|强大的语言插件，可以完全替代烦人的ycm|需要安装[nodejs](https://nodejs.org/en/download/)
[vim-fugitive](https://github.com/tpope/vim-fugitive)|Git支持|
[vim-oceanicnext](https://github.com/fioncat/vim-oceanicnext)|颜色主题|
[vim-bufclean](https://github.com/fioncat/vim-bufclean)|快速清除buffers|
[vim-minigo](https://github.com/fioncat/vim-minigo)|Golang支持，[vim-go](https://github.com/fatih/vim-go)的极简版|需要go tools
[vim-signature](https://github.com/kshenoy/vim-signature)|可视化mark|
[vim-translator](https://github.com/voldikss/vim-translator)|即时翻译，英语渣阅读英文文档必备|
[vim-surround](https://github.com/tpope/vim-surround)|快速增加围绕字符，例如括号或xml tag
[vim-delve](https://github.com/sebdah/vim-delve)|Golang调试插件|需要[delve](https://github.com/go-delve/delve)
[vim-yaml-folds](https://github.com/fioncat/vim-yaml-folds)|yaml文件折叠

## Hot keys

以下不包括vim本身的快捷键，如果我对vim自带快捷键做了魔改，则会列出。下表中{leader}表示Leader Key，{C}表示Ctrl键位，其余表示正常键位，区分大小写。

我用空格(Space)作为Leader Key，类似于[SpaceVim](https://github.com/SpaceVim/SpaceVim)和[SpaceEmacs](https://github.com/syl20bnr/spacemacs)。

快捷键|Mode|说明
-----|-----|---
{leader}yy|Visual|将选中内容复制到系统剪切板
{leader}xx|Visual|将选中内容剪切到系统剪切板
{leader}h|Normal|查看vim帮助文档
{leader}w/|Normal|垂直拆分窗口
{leader}w-|Normal|水平拆分窗口
{leader}w[|Normal|微调垂直窗口尺寸
{leader}w]|Normal|微调垂直窗口尺寸(反方向)
{leader}'|Normal|在下方打开内置终端
{leader}"|Normal|在右方打开内置终端
{C}n|Terminal|在内置终端中进入普通模式，以滚动或复制文本
{C}q|Terminal|退出内置终端
{C}s|Normal|光标所在数字加1(原来是{C}a)
{C}a|Normal|回到行首，等同于按下^
{leader}bn|Normal|跳转到下一个buffer
{leader}bp|Normal|跳转到上一个buffer
{leader}tt|Normal|打开/关闭文件树
{leader}ff|Normal|在文件树打开当前文件
{leader}tb|Normal|打开代码结构(tagbar)
gd|Normal|跳转到定义
gr|Normal|显示引用
K|Normal|查看文档(如果有)
{leader}rn|Normal|批量改名
{leader}f|Visual|选中代码格式化
{leader}en|Normal|跳转到下一个错误
{leader}ep|Normal|跳转到上一个错误
{leader}fd|Normal|启用代码折叠
gat|Normal|Go快速增加tags
grt|Normal|Go快速移除tags
gfs|Normal|Go快速补全结构体
{leader}sf|Normal|搜索文件
{leader}ss|Normal|搜索当前目录下的文件
{leader}sg|Normal|Rg搜索全局内容
{leader}sl|Normal|Rg搜索当前文件内容
{leader}sb|Normal|搜索buffers
{leader}gb|Normal|打开Git Blame
{leader}gd|Normal|打开Git Diff
{leader}bc|Normal|快速清理不用的buffer
{leader}tw|Visual|翻译选中的英文为中文
{leader}db|Normal|Go增加/移除调试断点
{leader}dr|Normal|Go增加/移除调试tracepoint
{leader}dc|Normal|Go移除所有调试断点
{leader}dd|Normal|Go开始debug
{leader}dt|Normal|Go test debug

## Languages

对于vim支持的所有编程语言功能，全部由coc.nvim实现好了，我们只需要简单配置以下即可使用。在[coc.nvim language servers](https://github.com/neoclide/coc.nvim/wiki/Language-servers)下有完整的语言支持和配置说明。下面是我用到的一些语言的配置过程。

在`CocConig`中加入以下配置：

```json
{
  "diagnostic.warningSign": ">>",
  "diagnostic.refreshOnInsertMode": true,
  "diagnostic.virtualText": true
}
```

### Golang

需要gopls的支持，安装gopls：

```bash
$ go install golang.org/x/tools/gopls@latest
```

在coc.nvim中安装插件：

```text
:CocInstall coc-go
```

一些功能需要go tools的支持，完整列表如下：

```bash
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

### Python

需要jedi的支持，直接用pip安装即可：

```bash
$ pip3 install jedi
```

在coc.nvim中安装插件：

```text
:CocInstall coc-python
```

### Rust

需要安装rust-src：

```bash
$ rustup component add rust-src
```

另外要安装Rust对于LSP的支持，即rust-analyzer。这个可以手动安装，或是由coc.nvim自动完成安装。

我们先安装coc.nvim插件：

```text
:CocInstall coc-rust-analyzer
```

随后，随意打开一个rust文件(以".rs"作为后缀)，coc.nvim会问你是否要安装rust-analyzer，选择Yes即可自动完成安装。

安装好之后需要一定时间构建索引，补全才能正常使用。

### Lua

直接安装插件：

```text
:CocInstall coc-lua
```

这里安装过程比较长，用到的是[lua-language-server](https://github.com/sumneko/lua-language-server)。
