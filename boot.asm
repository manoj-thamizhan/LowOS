org 0x7c00         ; BIOS loads boot sector to 0x7c00
bits 16
cli                ; Clear interrupts

start:
    mov si, msg    ; Point to the string

print_loop:
    lodsb          ; Load byte at [SI] into AL, and increment SI
    or al, al      ; Check for null terminator
    jz halt        ; If zero, end of string

    mov ah, 0x0e   ; BIOS teletype function
    int 0x10       ; Call BIOS interrupt to print character
    jmp print_loop

halt:
    hlt            ; Halt CPU
    jmp halt       ; Infinite loop

msg db 'hi', 0     ; Null-terminated message

times 510 - ($ - $$) db 0 ; Pad to 510 bytes
dw 0xAA55                ; Boot signature
