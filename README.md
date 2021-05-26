# vim日记

## 主题

我使用的是[OceanicNext](https://github.com/mhartington/oceanic-next)这个主题，在上面做了一些魔改。因为原主题的GitDiff上不好看，并且没有ALE高亮的相关设置。

魔改的主题在[oceanicnext.vim](oceanicnext.vim)下，将这个文件复制到`~/.vim/colors`下。

然后在`.vimrc`中加入：

```vim-script
" 设置主题
colorscheme OceanicNext
set background=dark
" 适用于gvim
set termguicolors
```

## vim-plug安装

[vim-plug](https://github.com/junegunn/vim-plug)是一个高效的vim插件管理器。很多人喜欢Vundle，但是vim-plug更加高效，并且它利用了vim8的autoload，能实现异步加载插件，大大提高了vim的启动速度。

使用以下命令安装：

```text
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

在Linux下，DNS可能遭到污染，导致`raw.githubusercontent.com`这个域名访问不了。可以直接将文件复制下来放到`~/.vim/autoload/plug.vim`即可。