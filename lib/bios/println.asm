%include "lib/bios/interrupts.asm"

[bits 16]
bios_println: ; fn (char *si) -> void
    mov ah, BIOS_TTY_MODE ; enter in TTY mode

    .loop:
        lodsb

        cmp al, 0
        je .done

        int BIOS_VIDEO_INT_VECTOR
        jmp .loop

    .done:
        mov al, 0x0A ; \n
        int BIOS_VIDEO_INT_VECTOR

        ; reading cursor position ???
        mov ah, BIOS_GET_CURSOR_POSITION
        mov bh, 0
        int BIOS_VIDEO_INT_VECTOR

        ; moving the cursor to the beginning
        mov ah, BIOS_SET_CURSOR_POSITION
        mov dl, 0
        int BIOS_VIDEO_INT_VECTOR

        ret
