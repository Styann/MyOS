ASM = nasm
BOOTLOADER_FILE = boot.asm
KERNEL_FILE = kernel.asm

build:
	$(ASM) -f bin $(BOOTLOADER_FILE) -o boot.o
	$(ASM) -f bin $(KERNEL_FILE) -o kernel.o
	dd if=boot.o of=kernel.img
	dd seek=1 conv=sync if=kernel.o of=kernel.img bs=512
	dd seek=2 conv=sync if=/dev/zero of=kernel.img bs=512 count=15
	qemu-system-x86_64 -s kernel.img

clean:
	rm -f *.o
	rm -f *.img