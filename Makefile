ASM_DIR=src/asm
C_DIR=src/c
CPP_DIR=src/cpp
OBJ_DIR=obj

myos.bin: kernel.o boot.o linker.ld
	i686-elf-gcc -T linker.ld -o bin/myos.bin -ffreestanding -O2 -nostdlib obj/boot.o obj/kernel.o -lgcc

boot.o:
	nasm -felf32 $(ASM_DIR)/boot.asm -o obj/boot.o

kernel.o:
	i686-elf-gcc -c $(CPP_DIR)/kernel.cpp -o obj/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

clean:
	rm *.o
	rm *.bin

run: myos.bin
	qemu-system-i386 -kernel bin/myos.bin