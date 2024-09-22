println: ; fn (si: char*) ->
    mov ah, 0x0E ; enter in TTY mode

    .loop:
        mov al, [si]
        int 0x10
        inc si

        cmp al, 0
        jnz .loop

    mov al, 0x0A ; \n
    int 0x10

    ; reading cursor position ???
    mov ah, 0x03
    mov bh, 0
    int 0x10

    ; moving the cursor to the beginning
    mov ah, 0x02
    mov dl, 0
    int 0x10

    ret