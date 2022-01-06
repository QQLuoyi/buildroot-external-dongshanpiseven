# STM32MP1 Buildroot External Tree

这个Git仓库专门支持ST的平台。由于Buildroot主线已经支持了stm32mp1系列，这个是针对 东山PI柒号 开发板专门支持的 `BR2_EXTERNAL` 外部扩展支持。

## 支持的配置文件

这个 `BR2_EXTERNAL` 扩展支持了如下配置文件：

1. `dongshanpiserven_core_defconfig`, 这是一个最小配置文件，支持了 TF-A 固件 U-boot Linux Kernel ，以及最小的busybox用户空间。
  

| Feature |     |
| --- | --- |
| TF-A | v2.2-stm32mp-r1 |
| U-Boot | v2020.10-stm32mp-r1.1 |
| Linux | v5.4-stm32mp-r1 |
| OP-TEE | No  |
| Qt5 | No  |
| OpenGL | No  |
| WiFi | N/A |
| Bluetooth | N/A |
| Audio | No  |
| CubeMX Device Tree | No  |
| Cortex M4 Firmware examples | No  |

## 快速开始

### 环境配置

 为了使用 [Buildroot](https://www.builroot.org)，您需要在您的工作站上安装 Linux 发行版。 任何最新的 Linux 发行版（Ubuntu、Debian、Fedora、Redhat、OpenSuse 等）都可以正常工作。
但是你需要安装一些必要软件包至您的Linux工作站才可以使用[Buildroot manual System requirements section](https://buildroot.org/downloads/manual/manual.html#requirement). 对于 Debian/Ubuntu发行版系统，需要参考下述命令安装列出来的软件包。

```bash
$ sudo apt install debianutils sed make binutils build-essential gcc g++ bash patch gzip bzip2 perl tar cpio unzip rsync file bc git
```

### 获取代码

 这个 `BR2_EXTERNAL`会配合着最新的LTS版本一起使用，所以版本会随着 上游的更新而建立新的分支进行更新，目前Buildroot最新 `BR2_EXTERNAL`最新LTS版本是 2021-02 。

首先我们获取 buildroot最新lts版本源码。

- 使用git clone
  

```bash
$ git clone -b st/2021.02 https://github.com/bootlin/buildroot.git
```

- 直接下载
  

```bash
wget  https://buildroot.org/downloads/buildroot-2021.02.8.tar.bz2
```

 获取buildroot源码后，可以单独获取我们支持 `东山PI柒号` 的 `BR2_EXTERNAL` 源码。

```bash
$ git clone -b main https://github.com/bootlin/buildroot-external-dongshanpiseven.git
```

获取完成后，可以看到 一个 `buildroot`目录和一个 `buildroot-external-dongshanpiseven`目录。

## 配置并构建

 首先进入到buildroot目录

```bash
$ cd buildroot/
```

 接下来执行配置命令，来使用 `dongshanpiserven_core_defconfig`配置文件进行配置。

```bash
buildrot/ $ make BR2_EXTERNAL=../buildroot-external-dongshanpiseven dongshanpiserven_core_defconfig
```

 指定配置文件后，可以使用 `make menuconfig` 命令来增加自己需要的包。

 增加完成软件包后，就可以直接执行 `make `命令开始编译了。

```bash
buildroot/ $ make
```

 编译时会自动下载所需的软件包，进行配置编译最后打包成一个完成的系统镜像，整个时间受网络环境而定，一般情况下 只需要60分钟。

## 烧写并启动系统

 编译完成后，会生成一个`sdcard.img `系统镜像，镜像文件存放在 `output/images/`目录下。

 执行如下命令讲镜像烧录进 tf卡即可，注意 `/dev/sdX` sdX 指的是tf卡设备的主分区。

```bash
buildroot/ $ dd if=output/images/sdcard.img of=/dev/sdX bs=1M
```

 烧写完成后，将卡插入至开发板，连接电源线，设置为 tf卡启动，即可启动开发板，之后连接串口，等待进入终端命令行，系统默认的登录用户名是 `root ` 。

# References

- [Buildroot](https://buildroot.org/)
- [Buildroot reference manual](https://buildroot.org/downloads/manual/manual.html)
- [Buildroot system development training
  course](https://bootlin.com/training/buildroot/), with freely
  available training materials

# Support
