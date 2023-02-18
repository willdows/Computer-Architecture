; Created by: William Lohmann
; Created for: Prof. Castillo, ITSC 204
; February 2023
; x86-64, NASM

; This program will preform two operations:
;   Loading 32-bit binary into register C
;   Loading 64-bit decimal into register C

global _start

section .data
    num1 dq 1928374655647382 
    num2 dd 0b10101010101010101010101010101010

section .text

_start:

    mov rcx, qword [num1]
    mov ebx, dword [num2]
    jmp _exit

_exit:
    mov rax, 60
    mov rdi, 0
    syscall