# hyprland使用问题记录

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

### 截图软件

#### Q: flameshot 无法截图？


A: 重置截屏权限: 对于flameshot 启动正常，但是不显示截图界面，可以尝试重置截屏权限。
```bash
dbus-send --session  --print-reply=literal --dest=org.freedesktop.impl.portal.PermissionStore /org/freedesktop/impl/portal/PermissionStore org.freedesktop.impl.portal.PermissionStore.DeletePermission string:'screenshot' string:'screenshot' string:''
```



## 关于显卡驱动

以英伟达显卡显卡驱动安装说明。

Arch Linux系统的Nvidia显卡驱动应该选择哪个呢？

1. Arch软件源提供的`nvidia`驱动软件包。
2. 从Nvidia官方下载的闭源驱动软件包。

我的建议是： **安装Nvidia官方的闭源驱动**

因为： 官方闭源驱动更能发挥Nvidia显卡的全部性能，并且闭源驱动是Nvidia官方维护的，稳定性更高。
但是，使用官方闭源驱动有一个缺点：
- 需要手动安装和更新驱动。

### 为什么需要手动安装NVIDIA显卡驱动？

NVIDIA 的闭源驱动不是内核自带的模块，它必须针对当前的 Linux 内核版本重新编译出匹配的 nvidia.ko 模块。

    内核升级后，原有的 NVIDIA 驱动模块将不再兼容。

    所以每次内核升级时，你需要同时更新（或重建） NVIDIA 驱动。

### 如何安装Nvidia显卡驱动？

从[Nvidia官方下载](https://www.nvidia.cn/drivers/lookup/) 最新版的 `NVIDIA-Linux-x86_64-575.64.run` 安装包，手动安装驱动。

```bash
sudo ./NVIDIA-Linux-x86_64-575.64.run

```
安装完成后，重启系统。

如果你没有遇到任何安装问题还好，没必要看下面的说明了。

在执行 `sudo ./NVIDIA-Linux-x86_64-575.64.run` 安装包时，你可能遇到以下问题：
- 编译过程失败了： 日志记录的很多错误，你可能也看不懂，但大概率是内核版本和Nvidia驱动包版本不匹配导致的。**解决办法：**下载最新版本(或者测试版本)的Nvidia驱动包尝试安装。
- 无法进行安装(这种情况现在很少发生了): 执行安装时显示了Error错误提示，你提供了退出按钮。 你可以在命令行执行`systemctl set-default multi-user.target` 命令来切换到多用户模式，然后执行 `sudo ./NVIDIA-Linux-x86_64-575.64.run` 安装包。 安装完成后，执行 `sudo systemctl set-default graphical.target` 命令来切换回图形界面模式。




### 输入法引发的SUPER键未释放问题

**现象描述：**在使用Fcitx5输入法时，如果在 Configure > Addons 页面的 **Wayland Input method frontend** 配置对话框中启用了 **Keep virtual keyboard object for V2 Protocol(Need restart)** 选项后，会出现 Super按键一直被按住的问题。

比如，打开Terminal的快捷键为*Super+Enter*，如果触发了SUPER按键被锁住问题，则只需要按 Enter 键 即可打开 Terminal 终端。

**可能原因分析：**

**V2 Protocol 和虚拟键盘冲突**： 启用 **Keep virtual keyboard object for V2 Protocol** 后，Fcitx5 会尝试保持虚拟键盘对象，这可能会干扰键盘事件的正常传递，导致 **Super** 键被误判为持续按下。


**解决方案**

**禁用 "Keep virtual keyboard object for V2 Protocol"**： 禁用它来解决按键锁住的问题，具体操作如下：

- 打开 **Fcitx5** 的配置界面，进入 **Configure > Addons** 页。
- 取消选中 **Keep virtual keyboard object for V2 Protocol(Need restart)** 选项。
- 重启 **Fcitx5**（或者直接重启系统）以使设置生效。



### 如何解决应用软件缩放导致文字的像素化问题

当某些软件的文字或图标在适配显示器显示时被缩放后引起的像素化现象，解决的办法大致如下：

1. 禁止默认的缩放。
2. 尽可能在应用软件的内部完成缩放设置。



大部分不支持 Wayland 的应用（比如一些老旧的 GTK+ 或 Qt 应用）都可以通过 **XWayland** 来运行。**XWayland** 是一个兼容层，允许 X11 应用在 Wayland 环境中运行。在使用xwayland时，会导致文字的像素化问题。

解决方案可以是这样的：
1. 先禁止xwayland的缩放，然后再启动xwayland应用后只是界面的文字显示很小。
2. 然后再启动xwayland应用后，再修改应用内部的缩放比例，让应用内部的文字显示正常。

具体的操作步骤如下：
1. [禁止xwayland的缩放](https://wiki.hyprland.org/Configuring/XWayland/)，在hyprland的配置文件中添加以下内容：
  ```
  # unscale XWayland # 防止缩放导致文字的像素化问题
  xwayland {
    force_zero_scaling = true
  }
  ```
2. 启动xwayland应用后，再修改应用内部的缩放比例，让应用内部的文字显示正常。

