---
layout: kpost
title: Android安全评估工具
category: 移动安全
description:
---

# 安卓安全评估工具

## 移动安全评估操作系统Santoku

网址：https://santoku-linux.com

工具清单：

* [Development Tools]
 * Android SDK Manager
 * Android Studio
 * AXMLPrinter
 * Eclipse
 * Fastboot
 * GooglePlayAPI
 * Heimdall
 * SBF Flash

* [Device Forensics]
 * AF Logical OSE
 * Android Brute Force Encryption
 * ExifTool
 * iOS Backup Analyzer
 * libimobiledevice
 * scalpel
 * SleuthKit
 * Yaffey

* [Pentration Testing]
 * BurpSuite
 * Ettercap
 * nmap
 * SSLStrip
 * w3af
 * ZAP
 * Zenmap

* [Reverse Enginening]
 * Androguard
 * AntiLVL
 * Baksmali
 * Bulb Security SPF
 * dex2jar
 * Drozer
 * Jasmin
 * JD-GUI
 * Procyon
 * radare2
 * Smali

* [Wireless Analyzers]
 * Chaosreader
 * dnschef
 * DSniff
 * mitmproxy
 * tcpdump
 * Wifite
 * Wireshark



## 安全评估框架 Drozer

1.安装Drozer

```
# 生成一个agent.apk
drozer agent build

# 在手机上安装agent
adb install drozer.apk
```

2.运行Drozer

```
# 设置端口转发
adb forward tcp:31415 tcp:31415

# 打开安装好的App
点击启动 Embedded Server

# 连接手机agent端
drozer console connect

```

3.枚举package

```
# 打印所有的app包名 or 过滤app包名
dz> run app.package.list -f facebook

# 打印所有app的详细信息 or 指定包名
dz> run app.package.info -a com.android.browser

# 根据权限进行查询
dz> run app.package.info -p android.permission.INTERNET

```

4.枚举activity

```
# 查看设备上安装和导出的全部activity
dz> run app.activity.info

# 过滤名称 or 指定包名
dz> run app.activity.info -f facebook -a com.android.phone

```

5.枚举content provider

```
# 查看所有的provider
dz> run app.provider.info -a [包名] -p [权限]
```

6.枚举service

```
# 查看全部的 service
dz> run app.service.info -a [包名] -p [权限] -f [过滤]
# 列出 未导出的service
dz> run app.service.info --unexported
```

7.枚举broadcast receiver

```
# 查看全部的receiver
dz> run app.receiver.info -a [包名] -f [过滤] -u )未导出的) -i(显示intent)
```

8.枚举app的受攻击面 attack surface

```
# 一个app的攻击面，就是导出组件的数量
dz> run app.package.attacksurface [包名]
```

9.运行activity

```
# 首先列出app中的activity
dz> run app.activity.info -a [包名]

# 启动activity
dz> run app.activity.start
 --action [intent action]
 --category [intent category]
 --component [package name] [component name]
dz> run app.activity.start
--action android.intent.action.MAIN
 --category android.intent.category.LAUNCHER
 --component com.android.browser com.android.browser.BrowserActivity

# 根据指定的intent action和category 寻找模块
dz> run app.activity.forintent --action [intent action] --category [intent category]
dz> run app.activity.forintent
--action android.intent.action.VIEW
--category android.inent.category.DEFAULT
```

10.编写drozer模块

```
编写一个驱动枚举模块
编写一个app证书枚举器
```


