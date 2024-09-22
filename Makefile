ASM = nasm
CC = gcc
BOOTLOADER_FILE = boot.asm
KERNEL_ASM_FILE = kernel.asm
KERNEL_FILE = kernel.c
BUILD = kernel_build

build:
	$(ASM) -f bin $(BOOTLOADER_FILE) -o $(BUILD)/boot.o
	$(ASM) -f bin $(KERNEL_ASM_FILE) -o $(BUILD)/kernel.o
	dd if=$(BUILD)/boot.o of=$(BUILD)/kernel.img
	dd seek=1 conv=sync if=$(BUILD)/kernel.o of=$(BUILD)/kernel.img bs=512
	dd seek=2 conv=sync if=/dev/zero of=$(BUILD)/kernel.img bs=512 count=15

# $(ASM) -f bin $(BOOTLOADER_FILE) -o $(BUILD)/boot.o
# $(ASM) -f elf32 $(KERNEL_ASM_FILE) -o $(BUILD)/kernel_asm.o
# $(CC) -Wall -m32 -c -ffreestanding -fno-asynchronous-unwind-tables -fno-pie $(KERNEL_FILE) -o $(BUILD)/kernel.elf
# ld -m elf_i386 -T linker.ld -o $(BUILD)/kernel_asm.o $(BUILD)/kernel.elf -o $(BUILD)/pip.elf
# objcopy -O binary $(BUILD)/pip.elf $(BUILD)/pip.bin
# dd if=$(BUILD)/boot.o of=$(BUILD)/kernel.img
# dd seek=1 conv=sync if=$(BUILD)/pip.bin of=$(BUILD)/kernel.img bs=512 count=5
# dd seek=2 conv=sync if=/dev/zero of=$(BUILD)/kernel.img bs=512 count=15

	qemu-system-x86_64 -s $(BUILD)/kernel.img

clean:
	rm -f $(BUILD)/*.o
	rm -f $(BUILD)/*.img
	rm -f $(BUILD)/*.elf