# wayland-config

这里配置了 wayland 的一些东西， 方便快速切换为 wayland 桌面环境。

## wayland 环境配置

| 模块 | 方案 |  备注   |
| :----: | :----- | :----- |
| Linux发行版 |  [ArchLinux](https://archlinux.org/) | 高度可定制化Linux发行版 ，文档丰富 |
|   WM   |      [hyprland](https://wiki.hyprland.org/) |  平铺窗口管理器 ,基于Wayland实现。|
|   DM   |   sddm |   用于启动Hyprland和登录管理，支持X11 和 Wayland ，搭配主题可以配置出精美的登录窗口 |
|  Bar   |  [waybar](https://github.com/Alexays/Waybar/wiki)  |   一个高度可定制化的状态栏   |
|  Menu  | [wofi](https://hg.sr.ht/~scoopta/wofi) |  一个高度可定制化的菜单程序   |
| Clipboard | [cliphist](https://github.com/sentriz/cliphist)  |  剪切板历史记录程序   |
| notify |  mako |  通知程序   |
| wallpaper| hyprpaper |  壁纸程序   |
|  lock |  hyprlock |  锁屏程序   |
|  terminal | xfce4-terminal  |  终端程序   |
| bluetooth |  blueman |  蓝牙程序   |
|  editor |  neovim |  一个高度可定制化的编辑器程序   |
|  browser |  firefox |  可定制化的浏览器程序,[推荐配置参考ShyFox](https://github.com/Naezr/ShyFox)  |
|  media player |  mpv |  一个高度可定制化的媒体播放器程序   |
|  file manager |  thunar |  一个高度可定制化的文件管理器程序   |
|Terminal File Manager|[yazi](https://github.com/sxyazi/yazi) written in Rust.| 高效的非阻塞文件管理器 |
|  screenshot |  flameshot |  截图程序, flameshot可能不支持Hyprland，需要更改一下环境变量才能支持`env XDG_CURRENT_DESKTOP=Sway flameshot`   |
|  audio |  pipewire |  音频程序   |
|  password manager |  keepassxc |  密码管理器程序   |


## 常见问题及说明文档

wayland框架协议的问题还是有很多的，所以这里列出一些常见的问题和解决办法。


- 查看TODO及功能文档，请点击阅读[TODO文档](docs/TODO.md)。
- 遇到问题，请先查看[FAQ文档](docs/FAQ.md)。

