; global_descriptor_table

; segment descriptor
;   ____________________________________________________________________________________________
;   |      limit      |           base           |1st flags|type flags|2nd flags|limit|  base  |
; 0b 00000000,00000000,00000000,00000000,00000000,  0000       0000,     0000    0000, 00000000

; * 1st flags
;   ┌── present: 1 (valid segment), 0 (?)
;   │┌── privilege level:
;   │├┐┌── system type: 1 (system segment), 0 (code or data segment)
; 0b0000

; * type flags
;   ┌── code(1) or data(0) segment
;   │┌── conforming: idk now, but 0
;   ││
;   ││┌── writable (for code segment, read access is always allowed): 0 (not allowed), 1 (allowed)
;   ││├── readable (for code segment, write access is never allowed): 0 (not allowed), 1 (allowed)
;   │││
;   │││┌── accessed: 0 (managed by CPU),
; 0b0000

; * 2nd flags
;   ┌── granularity: 1 (limit *= 0x1000)
;   │┌──   ze: 0 (16bits segment), 1 (32bits segment)
;   ││┌── long mode: 1 (64bits code segment, when set, size must be 0), 0 (must be 0 if not code segment)
;   │││┌── reserved: 0
; 0b0000
gdt_start:
    gdt_null_descriptor:    dw 0x0000, 0x0000, 0x0000, 0x0000
    gdt_code_descriptor:    dw 0xFFFF, 0x0000, 0x9A00, 0x00CF
    gdt_data_descriptor:    dw 0xFFFF, 0x0000, 0x9200, 0x00CF
    ; userspace_code_descriptor: dw 0xFFFF, 0x0000, 0xFA00, 0x00CF
    ; userspace_data_descriptor: dw 0xFFFF, 0x0000, 0xF200, 0x00CF
gdt_end:

gdt_descriptor:
    ; gdt_byte_size:
    dw (gdt_end - gdt_start - 1)
    ; gdt_base_addr:
    dd gdt_start

CODE_SEGMENT equ (gdt_code_descriptor - gdt_start)
DATA_SEGMENT equ (gdt_data_descriptor - gdt_start)
