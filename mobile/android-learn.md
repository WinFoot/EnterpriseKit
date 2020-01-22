---
layout: kpost
title: Android知识学习
category: 移动安全
description:
---

## Android安全机制

1. Andriod基础
```
1.1 Android系统架构
 Linux内核层 硬件抽象层 系统运行库层 应用程序框架层 应用层
1.2 应用程序组件
1.3 Android 系统启动
 Linux系统启动 Android应用系统启动
1.4 Android 系统升级
 数据线 SD卡 在线
```

2. Android 安全模型
```
2.1 Linux 安全模型
 用户与权限 进程与内存空间
2.2 Android 安全机制
 进程沙箱 应用权限 进程通信 内存管理 系统分区加载 应用签名
```

3. Android 安全机制分析
```
3.1 文件系统权限
3.2 进程通讯机制
3.3 Android应用程序安全机制
```

4. Android 安全性分析
```
4.1 系统安全分析
 Linux内核 系统库 虚拟机
4.2 Android 应用安全分析
 应用权限 应用安装 网络浏览器 数据库注入 软件更新
4.3 硬件安全分析
4.4 恶意软件
 Linux 恶意软件 Android 恶意软件
4.5 安全风险与漏洞
 已知安全风险 潜在安全漏洞
```

5. Android 安全分析工具
```
5.1 分析方法
Linux系统信息分析 Android应用信息分析
5.2 分析工具
logcat adb sumpsys IntentFuzz IntentSniffer
Manifest Explorer Package Play
```

6. SE_Android

7. Android加密文件系统

8. Android应用安全解决方案
```
8.1 安全风险控制策略
8.2 应用权限控制
8.3 应用程序签名
8.4 静态代码分析
8.5 防火墙
8.6 数据存储加密
8.7 应用程序组件开发安全要点
```

9. Android无线通讯安全

## Android开发入门视频教程

```
链接：http://v.dxsbb.com/jisuanji/811/

学习目标：把多个课程的功能集成到一个app中，首页是目录，点击目录进入不同课程的功能页面。

1. 安卓一日游

2. 搭建Android开发环境
SDK安装
ADT安装
模拟器安装

3. 创建一个Android程序步骤
Android程序目录结构
AndroidManifest.xml文件作用
Android相关资源文件的作用
4. Activity初步
Activity的主要作用
创建一个Activity方法
AndroidManifest.xml文件注册应用Activity方法
在Activity中添加控件的方法

5. Activity和Intent
多个Activity之间的关系
Intent的基本作用
在一个Activity启动另一个Activity
使用Intent在Activity间传递数据

6. 常见控件的使用方法
TextView
EditView
Button
Menu

7. Activity生命周期（一）
Activity个周期回调函数 onCreate onStart等

8. Activity生命周期（二）
Task基本概念
Task与Activity的关系
对话框风格Activity

9. Activity布局初步（一）
LinearLayout
TableLayout

10. Activity布局初步（二）
Linear 和 Table 相互嵌套

11. Activity布局初步（三）
相对布局的基本概念
相对布局与其他布局的区别
相对布局的常用属性

12. 常用控件（二）
RadioGroup 和 RadioButton 使用方法
CheckBox 的使用方法
Toast 的基本用法
13. 常用控件（二）
ProgressBar 的使用方法
ListView 的使用方法

14. Handler 的使用方法（一）
Handler 概念

```