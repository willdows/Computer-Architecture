section .data
array db "jfdkslafiowafdsafls",00
len equ $-array
filename: db "output.txt",0	;output file

section .bss
    file_desc resq 1

section .text
global _start

_begin_sorting:
    ; outer loop
    mov esi, 0
    outer_loop:
        cmp esi, len
        jge end_program
        
        ; inner loop
        mov edi, esi
    inner_loop:
        cmp edi, len
        jge cmp_loop
        
        ; compare elements
        mov al, [array + edi]
        cmp byte [array + esi], al
        ja swap
        
        inc edi
        jmp inner_loop
        
        ; swap elements
    swap:
        mov bl, [array + esi]
        mov cl, [array + edi]
        mov [array + esi], cl
        mov [array + edi], bl
        
        mov ebx, 1 ; set flag to indicate swap
        jmp no_swap

        ; move to next iteration of outer loop
    cmp_loop:
        inc esi
        jmp outer_loop
        
        ; end program
        
        ; no swap in current iteration of inner loop
    no_swap:
        cmp ebx, 0
        jne inner_loop
        
        jmp cmp_loop
    end_program:

	open_file:
	mov rax, 2		;2 for OPEN
	mov rdi, filename	;filename
	mov rsi, 0x441		;400 for appending, 40 for creating, 1 for writing
				;1024	+	64	+	1 = 1089
	mov rdx,0q666		;With your permission...
	syscall	
	mov qword[file_desc],rax	;Save the file desc for later

	;Writing to the file
	mov rax,1
	mov rdi, qword[file_desc]
	mov rsi, array
	mov rdx, len
	syscall
	
		;Cleaning up afterward
	mov rax,3
	mov rdi,qword[file_desc]
	syscall

	call _exit
	

.write_stuff:
	pop rbx		;Store return addr in RBX
	pop rdx		;Pop length to RDX
	pop rsi		;Pop string to RSI
	mov rax, 1
	mov rdi,qword[file_desc]
	syscall
	push rbx	;Push RBX back onto stack
	ret
_exit:
	mov rax, 60
	mov rdi,0
	syscall

        mov eax, 1
        mov ebx, 0
        int 0x80