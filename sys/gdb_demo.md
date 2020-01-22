
### GCC 编译

```
$ gcc -g3 -Wall -Wextra -c main.c swapper.c
$ gcc -o swap main.o swapper.o
```

### GDB 命令

```
断点 break
监视点 watch 
捕获点 catch
临时断点 tbreak
断点列表 info breakpoints

删除断点 
delete 1 2 3
delete 删除所有断点
clear 清除当前断点
clear function
clear filename:function
clear line_number
clear filename:line_number

禁用断点
disable breakpoint-list
disable 3
disable # 禁用全部
enable breakpoint-list
enable 1 5
enable # 启用全部
enable once breakpoint-list  # 启用一次

设置断点
break function
break main
break line_number
break 35
break filename:line_number
break source/bed.c:35
beak filename:function
break bed.c:main
break + offset
break - offset
bread *address

硬件辅助断点 hbreak thbreak
正则表达断点 rbreak

切换焦点
list main
list swap

恢复执行
step next 单步调试
continue
finish until

# 远程调试
$ gdbserver 127.0.0.1:6666 ./swap
$ gdb > target remote 127.0.0.1:6666
```

### GDB 快捷方式

```
i frame
i registers
disassemble func
b -> break
c -> continue
d -> delete
f -> frame
i -> info
j -> jump
l -> list
n -> next
p -> print
r -> run
s -> step
u -> until
aw -> awatch
bt -> backtrace
dir -> directory
disas -> disassemble
fin -> finish
ig -> ignore
ni -> nexti
rw -> rwatch
si -> stepi
tb -> tbreak
wa -> watch
win -> winheight
```