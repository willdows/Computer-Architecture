; Created by: William Lohmann
; Created for: Prof. Castillo, ITSC 204
; February 2023
; x86-64, NASM

; This program will add two 8-bit hex numbers

global _start


section .data
    num1 db 0x1B
    num2 db 0x3D


section .text

_start:

    mov al, byte [num1]
    add al, byte [num2]

    mov dl, al

    jmp _exit

_exit:
    mov rax, 60
    mov rdi, 0
    syscall