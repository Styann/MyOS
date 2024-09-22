bits 16
; extern kernel_main

start:
    mov ax, cs
    mov ds, ax

    mov si, hello_world
    call println

    jmp $

;     cli
;     lgdt [gdtr - start] ; start:gdtr - start
;     sti

;     call enter_protected_mode
;     call init_video_mode
;     call 0x08:start_kernel

; enter_protected_mode:
;     mov eax, cr0
;     or eax, 1
;     mov cr0, eax
;     ret

; init_video_mode:
;     mov ah, 0x00
;     mov al, 0x03
;     int 0x10

;     mov ah, 0x01
;     mov cx, 0x2000
;     int 0x10

;     ret

%include "println.asm"
hello_world: db "Hello, World!", 0

; bits 32
; start_kernel:
;     cli
;     ; setting segment registers
;     mov eax, 0x10
;     mov ds, eax
;     mov ss, eax

;     mov eax, 0
;     mov es, eax

;     ; setting gp segment registers
;     mov fs, eax
;     mov gs, eax
;     sti

;     call kernel_main

; %include "gdt.asm"
