ASM_DIR=src/asm
C_DIR=src/c
CPP_DIR=src/cpp
CROSS=$(HOME)/opt/cross/bin
CXX=$(CROSS)/i686-elf-g++
CC=$(CROSS)/i686-elf-gcc

myos.bin: kernel.o boot.o linker.ld 
	$(CC) -T linker.ld -o bin/myos.bin -ffreestanding -O2 -nostdlib obj/boot.o obj/kernel.o -lgcc

boot.o:
	nasm -felf32 $(ASM_DIR)/boot.asm -o obj/boot.o

kernel.o:
	$(CC) -c $(C_DIR)/kernel.c -o obj/kernel.o -std=gnu2x -ffreestanding -O2 -Wall -Wextra -pedantic

clean:
	rm *.o
	rm *.bin

run: myos.bin
	qemu-system-i386 -kernel bin/myos.bin
