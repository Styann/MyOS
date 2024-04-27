; BIOS interrupt call
; 		interrupt vector	ah
; tty mode	0x10			0x0E
; read char	0x16			0x00

mov ah, 0x0E
mov bx, str ; pointer to str

print:
	mov al, [bx + 0x7C00]

	int 0x10
	inc bx

	cmp al, 0
	jnz print

read_keyboard_input:
	mov ah, 0
	int 0x16

	mov ah, 0x0E
	int 0x10
	jmp read_keyboard_input

jmp $

str:
	db "Hello, World!", 0

times 510-($-$$) db 0
dw 0xAA55
