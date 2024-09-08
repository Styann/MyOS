; global_descriptor_table
gdt_data:
    ;                             limit,  base,   
    null_descriptor:           dw 0x0000, 0x0000, 0x0000, 0x0000
    kernel_code_descriptor:    dw 0xFFFF, 0x0000, 0x9A00, 0x00CF
    kernel_data_descriptor:    dw 0xFFFF, 0x0000, 0x9200, 0x00CF
    userspace_code_descriptor: dw 0xFFFF, 0x0000, 0xFA00, 0x00CF
    userspace_data_descriptor: dw 0xFFFF, 0x0000, 0xF200, 0x00CF

gdtr_data:
    gdt_byte_size: dw (5 * 8)
    gdt_base_addr: dd gdt_data
