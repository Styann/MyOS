; video services
%define BIOS_VIDEO_INT_VECTOR 0x10
    ; ah
    %define BIOS_SET_VIDEO_MODE 0x00
        ; al
        %define BIOS_16_COLORS_TEXT_MODE 0x03
    %define BIOS_SET_CURSOR_SHAPE 0x01
        ; cx
        %define BIOS_HIDE_CURSOR 0x2000
    %define BIOS_SET_CURSOR_POSITION 0x02
    %define BIOS_GET_CURSOR_POSITION 0x03
    %define BIOS_TTY_MODE 0x0E

; disk services
%define BIOS_DISK_INT_VECTOR 0x13
    ; ah
    %define BIOS_READ_SECTOR 0x02
