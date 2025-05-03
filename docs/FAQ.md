# hyprland使用问题记录

文件管理器:
- thunar
- dolphin
- nautilus

## 一些Hyprland的资源

- [awesome-hyprland](https://github.com/hyprland-community/awesome-hyprland)
- [支持Wayland应用列表](https://wearewaylandnow.com/)

## 应用软件使用问题记录

这里总结了一些使用hyprland的应用软件的使用问题。可能有些问题还没有解决，欢迎大家补充。



### HiDPI问题

Hyprland下的软件分几种情况调整HiDPI：

1. Wayland 原生应用: 正常情况下，通过 monitor scale 设置即可，但有时有些QT应用会出现像素化问题，这时可以尝试设置环境变量`QT_SCALE_FACTOR`。
2. XWayland 应用： 通过设置环境变量`GDK_SCALE`和`QT_SCALE_FACTOR`即可。

> 禁用 XWayland 缩放（避免模糊）： 如果 XWayland 应用模糊，可以禁用 Hyprland 的缩放并手动设置 DPI：
> ```conf
> xwayland:force_zero_scaling = true
> ```
> 然后结合 GDK_SCALE 设置 DPI。



对于使用QT库开发的支持wayland的软件，通过设置环境变量`QT_SCALE_FACTOR`即可支持HiDPI。



### 不支持wayland的应用如何启动？
有些应用并不支持wayland协议，只支持X11协议， 那么我们可以通过xwayland来启动这些应用。

#### Q: 如何启动xwayland应用？

A: 通过在 `~/.config/chrome-flags.conf`文件中增加`--ozone-platform=x11`参数即可。

#### Q: 不支持flags.conf的软件如何启动xwayland应用？

通常可以有如下方法：

1. 修改desktop文件来启动xwayland应用，例如：编辑 /usr/share/applications/wechat.desktop 文件，修改Exec内容如下：
```bash
Exec=env QT_QPA_PLATFORM=xcb QT_FONT_DPI=192 QT_IM_MODULE=fcitx /opt/wechat/wechat %U
```
重启微信即可支持fcitx5输入法。类似软件可通过相同方法启动。

2. 通过hyprland的快捷键配置启动参数，例如：
```conf
bindd = $mainMod SHIFT, C, Windsurf Code Editor, exec, env QT_QPA_PLATFORM=xcb QT_FONT_DPI=192 QT_IM_MODULE=fcitx /opt/wechat/wechat

```
通过hyprland的快捷键配置启动参数，可以避免修改desktop文件，更加方便。


### 输入法问题

- [Fcitx在Wayland使用帮助](https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland/zh-cn)
- [Ibus在Wayland使用帮助](https://github.com/ibus/ibus/wiki/WaylandDesktop)

#### Q: Hyprland如何使用ibus输入法？

A: 需要使用ibus 1.5.32 及以上版本，因为ibus 1.5.32 及以上版本已经支持了 wayland 协议，因此不需要使用 ibus-daemon 了。


#### Q: VSCode如何支持fcitx5输入法？

A: vscode启动参数需要添加`--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime` 参数，然后重启vscode即可支持fcitx5输入法。

> vscode 是Electron开发的软件，我们可以通过上面方法修改Electron的启动参数来支持fcitx5输入法。类似的软件也可以使用类似的方式支持fcitx5输入法,例如 Windsurf 、 Typora 等。

#### Q: 微信如何支持fcitx5输入法？

A: AUR安装的微信(wechat-bin)是通过XWayland启动的，所以需要修改启动变量来支持fcitx5输入法。
通常可以修改desktop文件来支持fcitx5输入法，例如：
编辑 /usr/share/applications/wechat.desktop 文件，修改Exec内容如下：
```bash
Exec=env QT_QPA_PLATFORM=xcb QT_FONT_DPI=192 QT_IM_MODULE=fcitx /opt/wechat/wechat %U
```
重启微信即可支持fcitx5输入法。


#### Q:达芬奇DavinciResolve如何支持fcitx5输入法？

A: 达芬奇DavinciResolve 是QT5开发的软件，并且使用自带的QT库文件，我们只能手动将fcitx5输入法依赖库添加到DavinciResolve自带的QT库中（路径为: /opt/resolve/libs/plugins )。
具体操作步骤如下：
```bash
sudo cp -rp /usr/lib/qt/plugins/platforminputcontexts/ /opt/resolve/libs/plugins
```
重启达芬奇DavinciResolve即可支持fcitx5输入法。

> 这里只是举个QT应用示例，类似的软件也可以使用类似的方式支持fcitx5输入法,例如 Calibre / 钉钉 等。

#### Q: 打开多个Chrome浏览器窗口，只有第一个窗口可以使用fcitx输入法，其他窗口无法使用fcitx输入法获取输入内容？

TODO:暂时没有找到解决办法， 这个问题似乎是Chrome对 text-input-v3 支持的问题，可以阅读[Chrome/Chromium 今日 Wayland 输入法支持现状]  (https://www.csslayer.info/wordpress/fcitx-dev/chrome-state-of-input-method-on-wayland/)了解详情。

目前解决办法是：
- 更换为 firefox 浏览器。
- 通过 xwayland 启动 Chrome 浏览器: 通过在 `~/.config/chrome-flags.conf`文件中增加`--ozone-platform=x11`参数即可。

#### Q: VSCode中打开终端使用fcitx输入法，输入中文后，会出现两次输入内容？

TODO: 暂时没有找到解决办法
