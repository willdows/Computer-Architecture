; Created by: William Lohmann
; Created for: Prof. Castillo, ITSC 204
; February 2023
; x86-64, NASM

; This program will subtract two 16 bit binary numbers, storing the result in RBX

global _start


section .data
    num1 dw 10005
    num2 dw 10000

section .text

_start:

    mov ax, word [num1]
    sub ax, word [num2]
    mov bx, ax

    cqo

    jmp _exit

_exit:
    mov rax, 60
    mov rdi, 0
    syscall
