%include "lib/bios/interrupts.asm"
%define MAGIC_BOOT_ADDR 0x7C00
%define KERNEL_LOAD_SEGMENT 0x1000
%define KERNEL_LOAD_OFFSET 0x0000
%define KERNEL_SECTORS_LENGTH 1

[org MAGIC_BOOT_ADDR]
[bits 16]
start: ; fn (void) -> void
    ; setup segment registers
    xor ax, ax
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    ; setup stack
    mov bp, 0x7000
    mov sp, bp

    mov si, hello_msg
    call bios_println

    call load_kernel
    jc kernel_loading_error

    kernel_loading_success:
        mov si, kernel_loading_success_msg
        call bios_println
        jmp KERNEL_LOAD_SEGMENT:KERNEL_LOAD_OFFSET
    kernel_loading_error:
        mov si, kernel_loading_failed_msg
        call bios_println
        jmp $

%include "gdt.asm"
%include "lib/bios/println.asm"

load_kernel: ; fn (void) -> cf:bool
    ; set the address we want the kernel to be loaded
    mov ax, KERNEL_LOAD_SEGMENT
    mov es, ax

    mov ah, BIOS_READ_SECTOR ; BIOS load sector mode
    mov al, KERNEL_SECTORS_LENGTH ; number of sectors to load
    mov ch, 0 ; cylinder number
    mov cl, 2 ; start reading from 2nd sector
    mov dh, 0 ; head number
    mov dl, 0x80 ; type of disk (hard disk #0)
    mov bx, KERNEL_LOAD_OFFSET

    int BIOS_DISK_INT_VECTOR

    ret

hello_msg: db "Hello, World! Loading kernel...", 0
kernel_loading_success_msg: db "Kernel successfully loaded.", 0
kernel_loading_failed_msg: db "Error, kernel loading failed.", 0

; fill bootsector remaining space
times 510 - ($ - $$) db 0x00
dw 0xAA55
