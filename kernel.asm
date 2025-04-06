[bits 16]
kernel_entry:
    mov ax, cs
    mov ds, ax

    mov si, kernel_entry_msg
    call bios_println

    mov ax, 87
    call bios_printn

    cli
    lgdt [gdt_descriptor]
    ; enter protected mode
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp CODE_SEGMENT:protected_mode_entry

%include "gdt.asm"
%include "lib/bios/println.asm"
%include "lib/bios/printn.asm"

kernel_entry_msg: db "Hello, World! From the kernel entry", 0

[bits 32]
protected_mode_entry:
    mov ax, DATA_SEGMENT
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000
    mov esp, esp

    jmp $

    ; jmp $