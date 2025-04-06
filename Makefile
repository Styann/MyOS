ASM = nasm
BOOTLOADER_FILE = boot.asm
KERNEL_FILE = kernel.asm
BUILD = kernel_build
IMG = $(BUILD)/kernel.img

build:
	$(ASM) -f bin $(BOOTLOADER_FILE) -o $(BUILD)/boot.o
	$(ASM) -f bin $(KERNEL_FILE) -o $(BUILD)/kernel.o

	dd if=$(BUILD)/boot.o of=$(IMG)
	dd seek=1 conv=sync if=$(BUILD)/kernel.o of=$(IMG) bs=512
	dd seek=2 conv=sync if=/dev/zero of=$(IMG) bs=512 count=15

run:
	qemu-system-x86_64 -s $(IMG)

debug:
	qemu-system-x86_64 -s $(IMG) -S

clean:
	rm -f $(BUILD)/*.o
	rm -f $(BUILD)/*.img
	rm -f $(BUILD)/*.elf
	rm -f $(BUILD)/*.bin
