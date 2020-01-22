
1. Demo A

```
// target: components 第一行表示的是依赖关系
// TAB rule 第二行是规则

main:main.o mytool1.o mytool2.o
    gcc -o main main.o mytool1.o mytool2.o
main.o:main.c mytool1.h mytool2.h
    gcc -c main.c
mytool1.o:mytool1.c mytool1.h
    gcc -c mytool1.c
mytool2.o:mytool2.c mytool2.h
    gcc -c mytool2.c
```

2. Demo B

```
// Makefile 有三个非常有用的变量.分别是$@,$^,$<代表的意义分别是：   
// $@--目标文件，$^--所有的依赖文件，$<--第一个依赖文件。
// 如果我们使用上面三个变量,那么我们可以简化我们的 Makefile 文件为：

main:main.o mytool1.o mytool2.o
    gcc -o $@ $^
main.o:main.c mytool1.h mytool2.h
    gcc -c $<
mytool1.o:mytool1.c mytool1.h
    gcc -c $<
mytool2.o:mytool2.c mytool2.h
    gcc -c $<
```

3. Demo C

```
// 经过简化后我们的Makefile 是简单了一点，不过人们有时候还想简单一点，这里我们学习 一个 Makefile 的缺省规则
// 这个规则表示所有的.o 文件都是依赖与相应的.c 文件的，例如mytool.o 依赖于mytool.c 这 样 Makefile 还可以变为:
main:main.o mytool1.o mytool2.o
    gcc -o $@ $^
.c.o:
    gcc -c $<
```
