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
|  browser |  firefox |  一个高度可定制化的浏览器程序   |
|  media player |  mpv |  一个高度可定制化的媒体播放器程序   |
|  file manager |  thunar |  一个高度可定制化的文件管理器程序   |
|Terminal File Manager|[yazi](https://github.com/sxyazi/yazi) written in Rust.| 高效的非阻塞文件管理器 |
|  screenshot |  flameshot |  截图程序, flameshot可能不支持Hyprland，需要更改一下环境变量才能支持`env XDG_CURRENT_DESKTOP=Sway flameshot`   |
|  audio |  pipewire |  音频程序   |
|  password manager |  keepassxc |  密码管理器程序   |


## TODO
- [x] 基础Hyprland配置，包括快捷键、窗口管理、屏幕布局等。
- [x] SDDM主题配置.
- [x] hyprcursor主题配置.
- [x] mako通知配置.
- [x]  hyprlock锁屏配置.
- [x]  wofi菜单配置.
- [x]  cliphist剪切板历史记录配置.   
- [x]  waybar状态栏基础配置.
- [x] waybar多种主题实现切换选择: 主题/样式/布局切换，并且支持自动切换颜色搭配。
- [ ] 支持更丰富的waybar主题:


## SDDM主题

[sugar-candy](https://github.com/ToppDev/sddm-sugar-candy)


## hyprcursor主题

- 配置hyprcursor主题[文档](https://wiki.hyprland.org/Hypr-Ecosystem/hyprcursor/)。
- [hyprcursor](https://standards.hyprland.org/hyprcursor/) 主题标准参考文档。

