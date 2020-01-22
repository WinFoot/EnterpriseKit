# CentOS 6.5 作为宿主机A1
http://archive.kernel.org/centos-vault/6.5/isos/x86_64/CentOS-6.5-x86_64-LiveCD.iso

```
grep vmx /proc/cpuinfo
```

# 宿主机A1 安装KVM

```
yum install -y qemu-kvm
lsmod | grep kvm
```

# 宿主机A1 安装QEMU 2.5
https://download.qemu.org/qemu-2.5.0.tar.bz2

```
yum install gcc
yum install gcc-c++
yum install libtool
yum install zlib-devel
yum install glib2-devel
cd qeme-2.5.0
./configure --enable-kvm --enable-debug --target-list=x86_64-softmmu
make -j 4
sudo make install
```

# 宿主机A1 上创建 CentOS6.5虚拟机B2

```
qemu-img create -f qcow2 centos.img 10g
qemu-system-x86_64 -m 1024 -hda cento.img -cdrom a.iso -enable-kvm
sudo apt-get install vncviewer
vncviewer localhost:5900
```

# 在虚拟机B2中编译源码并安装linux 2.6.39
https://mirrors.edge.kernel.org/pub/linux/kernel/v2.6/linux-2.6.39.tar.gz

```
cd linux-2.6.39
make menuconfig
make
make modules
make modules_install
make install
gedit /boot/grub/grub.conf
reboot
```