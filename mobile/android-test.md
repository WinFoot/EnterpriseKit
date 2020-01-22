---
layout: kpost
title: Android安全攻防实战
category: 移动安全
description:
---

# 安卓安全攻防实战（一）

## 第一章 Android开发工具

1.开发环境 ADT JDK API NDK

2.虚拟设备 AVD

```
# 查看系统镜像列表：
$ tools/android list targets
# 命令行创建AVD
$ tools/android create avd -n AVD设备名 -t 镜像ID -c 扩展存储 -partition-size 内部存储
# 运行AVD
$ tools/emulator -avd AVD名称
```

3.调试桥 ADB

```
# 调试桥查看已经连接的安卓设备
$ platform-tools/adb devices

# 连接安卓设备的shell
$ platform-tools/adb shell -s 设备名称

# 复制文件
$ platform-tools/adb [pull|push] 路径 路径

# 安卓设备安装APP
$ platform-tools/adb install a.apk
```

## 第二章 实践App安全

1.检查App的证书和签名

```
# 提取一个App,并解压
$ adb pull /system/app/Contacts.apk && unzip Contacts.apk

# 查看CERT.RSA 公钥证书的自签名
$ keytool -printcert -file META-INF/CERT.RSA
$ openssl pkcs7 -inform DER -in META-INF/CERT.RSA -noout -print_certs -text

# 查看App内各个资源的签名
$ cat META-INF/CERT.SF
```

2.对 Android App签名 和 验证

```
# 创建密钥存储器，包含新的私钥、公钥、自签名证书，被加密保存到密钥存储器
$ keytool -genkey -v -keystore [创建文件密钥存储器] \
 -alias [密钥别名] -keyalg RSA -keysize 2048 -validity [有效天数]

# 对App进行签名
$ jarsigner -verbose -sigalg MD5withRSA \
 -digestalg SHA1 -keystore 存储器 [apk名称] [密钥别名]

# 验证App签名
$ jarsigner -verify -verbose [apk文件路径]
```

3.探索AndroidManifest.xml文件

```
# 安装 apktool 工具，反编译AndroidManifest.xml文件
$ apktool d -f -s apk文件 decoded-data/
```

4.ADB与activity管理器交互

```
# 包管理器
$ pm list packages

# 运行activity
$ am start 包名
$ am start -n com.android.MyPackage/com.android.MyPackageLaunchMeActivity 组件名
 -e MyInput HelloWorld (扩展数据)
 -a android.intent.MyPackageIntentAction （Action标识字符，指明Intent用途）
 -c android.intent.catagory.MyPackageIntentCategory (指定Intent的分类)

# 运行服务
$ am startservice <package name>/<component name> <INTENT>
$ am startservice com.android.app/com.android.app.service.ServiceComponent INTENT
```

5.ADB提取App里的资源

```
# App的数据摘要存在于 /data/data/ 目录
# 不同的app，依靠Linux权限作隔离，有独立的拥有者和组
# 每个包的目录下，存放着app的资源和元数据
$ ls -alR */databases/
$ ls -alR */files/
```
