#!/bin/sh

#内核补丁
#Red Hat Enterprise Linux 7 	kernel	RHSA-2019:1168
#Red Hat Enterprise Linux 7	microcode_ctl	RHEA-2019:1210
#KVM补丁
#Red Hat Enterprise Linux 7	qemu-kvm	RHSA-2019:1178
#Red Hat Enterprise Linux 7	libvirt	RHSA-2019:1177

#https://mirrors.aliyun.com/centos/7/updates/x86_64/Packages/qemu-img-1.5.3-160.el7_6.2.x86_64.rpm
#https://mirrors.aliyun.com/centos/7/updates/x86_64/Packages/qemu-kvm-1.5.3-160.el7_6.2.x86_64.rpm
#https://mirrors.aliyun.com/centos/7/updates/x86_64/Packages/microcode_ctl-2.1-47.2.el7_6.x86_64.rpm
#https://mirrors.aliyun.com/centos/7/updates/x86_64/Packages/libvirt-4.5.0-10.el7_6.9.x86_64.rpm


echo '================Kernel Check==================='
rpm -q kernel
if [ "$?" -eq 0 ]; then
  rpm -q --changelog kernel | grep 'CVE-2018-12126 CVE-2018-12127 CVE-2018-12130'
fi

echo '================Microcode Check==================='
rpm -q microcode_ctl
if [ "$?" -eq 0 ]; then
  rpm -q --changelog microcode_ctl | grep 'Intel CPU microcode update to 20190507_Public_DEMO'
fi

echo '================Libvirt Check==================='
rpm -q libvirt
if [ "$?" -eq 0 ]; then
  echo libvirt installed
fi

echo '================Qemu-kvm Check==================='
rpm -q qemu-kvm
if [ "$?" -eq 0 ]; then
  echo qemu-kvm installed
fi
