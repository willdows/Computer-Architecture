global _start   ;Linker info

section .text   ; Contains the maincode (image)

_start:

    mov al, 0xab ; moves hex number 0xab into the register al (lower part)
    mov bh, 0x12 ; moves hex number 0x12 (immediate value) into the register bh (upper part)
    mov cx, 1234 ; moves decimal 1234 into cx register (16 bits)
    mov eax, 0x1234 ; moves hex number 0x1234
    mov rax, 0x1234567890abcdef
    add edx,cx ; adds edx and cx, storing the result in edx

    mov rax, 60
    mov rsi, 0
    syscall

section .data
    mesg: db "Will", 0xa

