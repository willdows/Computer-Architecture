section .data
array db 1, 8, 3, 2, 6
len equ $-array

section .text
global _start

_start:
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
end_program:
    mov eax, 1
    mov ebx, 0
    int 0x80
    
    ; no swap in current iteration of inner loop
no_swap:
    cmp ebx, 0
    jne inner_loop
    
    jmp cmp_loop
