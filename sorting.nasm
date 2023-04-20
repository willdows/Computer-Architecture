section .data
    filename db "random_bytes.bin", 0
    mode_read db "rb", 0
    mode_write db "ab", 0
    buffer db 1000

section .bss
    sorted_buffer resb 1000

section .text
    global _start

_start:
    ; Open the file for reading
    mov eax, filename
    mov ebx, mode_read
    xor ecx, ecx
    xor edx, edx
    mov al, 5
    int 0x80
    cmp eax, 0
    jl exit_program
    mov esi, eax ; esi contains the file descriptor

    ; Read the random bytes from the file
    mov eax, esi
    mov ebx, buffer
    mov ecx, 1000
    mov edx, 0
    mov al, 3
    int 0x80
    cmp eax, 0
    jl close_file
    mov edi, eax ; edi contains the number of bytes read

    ; Sort the bytes using selection sort
    mov ecx, edi
    mov esi, buffer
    mov edi, sorted_buffer
outer_loop:
    mov ebx, esi
    mov edx, esi
    add edx, 1
inner_loop:
    cmp edx, ecx
    jge outer_loop_done
    mov al, [edx]
    cmp al, [ebx]
    jl swap_bytes
    inc ebx
    inc edx
    jmp inner_loop
swap_bytes:
    mov al, [edx]
    mov bl, [ebx]
    mov [edx], bl
    mov [ebx], al
    inc ebx
    inc edx
    jmp inner_loop
outer_loop_done:
    mov esi, sorted_buffer

    ; Open the file for appending
    mov eax, filename
    mov ebx, mode_write
    xor ecx, ecx
    xor edx, edx
    mov al, 5
    int 0x80
    cmp eax, 0
    jl close_file
    mov edi, eax ; edi contains the file descriptor

    ; Append the sorted bytes to the file
    mov eax, edi
    mov ebx, esi
    mov ecx, edi
    mov edx, 0
    mov al, 4
    int 0x80

close_file:
    ; Close the file
    mov eax, esi
    mov al, 6
    int 0x80
    mov eax, edi
    mov al, 6
    int 0x80

exit_program:
    ; Exit the program
    xor eax, eax
    mov al, 1
    xor ebx, ebx
    int 0x80