; Created by: William Lohmann
; Created for: Prof. Castillo, ITSC 204
; February 2023
; x86-64, NASM

section .data

	first: db 'William',0xa,'Lohmann',0xa ;0xa is newline
	length: equ $-first

section .text

	global _start

_start:
	mov rax,1 ;syscall for write
	mov rdi,1 ;stdout
	mov rsi, first
	mov rdx, length
	syscall

	mov rax,60
	mov rdi,1
	syscall

