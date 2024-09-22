%define MAGIC_BOOT_ADDR 0x7C00
%define KERNEL_SEGMENT_ADDR 0x0900
%define KERNEL_OFFSET_ADDR 0x0000
%define KERNEL_SECTORS_SIZE 15

; org MAGIC_BOOT_ADDR
bits 16

start: ; fn (void) -> void
    mov ax, 0x07C0
    mov ds, ax

    mov si, hello_msg
    call println

    mov si, kernel_loading_msg
    call println

    call load_kernel
    jc kernel_loading_error

    kernel_loading_success:
        mov si, kernel_loading_success_msg
        call println
        jmp KERNEL_SEGMENT_ADDR:KERNEL_OFFSET_ADDR

    kernel_loading_error:
        mov si, kernel_loading_failed_msg
        call println
        jmp $

%include "println.asm"
; constant strings
hello_msg: db "Hello, World! From the bootloader.", 0
kernel_loading_msg: db "Loading kernel...", 0
kernel_loading_success_msg: db "Kernel successfully loaded.", 0
kernel_loading_failed_msg: db "Error, kernel loading failed.", 0

load_kernel: ; fn (void) -> cf:bool
    ; set kernel segment through ax
    mov ax, KERNEL_SEGMENT_ADDR
    mov es, ax

    mov ah, 0x02 ; BIOS load sector mode
    mov al, KERNEL_SECTORS_SIZE ; number of sectors
    mov ch, 0 ; cylinder number
    mov cl, 2 ; sector number
    mov dh, 0 ; head number
    mov dl, 0x80 ; type of disk (hard disk #0)
    mov bx, KERNEL_OFFSET_ADDR ; memory addr offset where the kernel will be loaded

    int 0x13
    ret

; fill bootsector remaining space
times 510 - ($ - $$) db 0x00
dw 0xAA55
