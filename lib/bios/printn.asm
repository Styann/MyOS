%include "lib/bios/interrupts.asm"

; @param ax - 16 bits number
[bits 16]
bios_printn:
    mov bl, 10

    div bl

    mov al, ah
    add al, 48

    mov ah, BIOS_TTY_MODE
    int BIOS_VIDEO_INT_VECTOR

    ret
