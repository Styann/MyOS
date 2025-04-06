%define VIDEO_MEM_ADDR 0xB8000
%define WHITE_TEXT 0x0F

; @param {char *} esi
[bits 32]
println:
    mov ebx, esi
    mov edx, VIDEO_MEM_ADDR

    .loop:
        mov al, [ebx]

        cmp al, 0
        jz .end

        mov ah, WHITE_TEXT
        mov [edx], ax

        add edx, 2
        inc ebx

        jmp .loop

    .end:
        ret
