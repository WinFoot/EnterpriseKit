# 遍历ELF

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <elf.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <stdint.h>
#include <fcntl.h>

int main(void)
{
    int fd, i;
    uint8_t *mem;

    struct stat st;

    Elf64_Ehdr * ehdr;

    printf("hello world");

    if((fd = open("./ls", O_RDONLY)) < 0) {
      perror("open");
      exit(-1);
    }

    if(fstat(fd, &st) < 0){
      perror("stat");
      exit(-1);
    }
    
    mem = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
    if(mem == MAP_FAILED){
      perror("mmap");
      exit(-1);

    }

    ehdr = (Elf64_Ehdr *)mem;
    printf("Entry Point: 0x%x\n", ehdr->e_entry);

    return 0;
} 
