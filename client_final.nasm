;*****************************

struc sockaddr_in_type

; defined in man ip(7) because it's dependent on the type of address

    .sin_family:        resw 1

    .sin_port:          resw 1

    .sin_addr:          resd 1

    .sin_zero:          resd 2          ; padding       

endstruc



;*****************************



section .data



    server_ip   db '127.0.0.1', 0

    server_port dw 8080

    request     db '2FF', 0 ; request for 0x2FF random bytes from server

	

	output_file db 'output.txt', 0 ; name of output file

    socket_f_msg:   db "Socket failed to be created.", 0xA, 0x0

    socket_f_msg_l: equ $ - socket_f_msg

    connect_f_msg: db "Connection failed.", 0xa,0x00

    connect_f_msg_l equ $-connect_f_msg



    sockaddr_in: 

        istruc sockaddr_in_type 



            at sockaddr_in_type.sin_family,  dw 0x02            ;AF_INET -> 2 

            at sockaddr_in_type.sin_port,    dw 0x901F          ;(DEFAULT, passed on stack) port in hex and big endian order, 8080 -> 0x901F

            at sockaddr_in_type.sin_addr,    dd 0x00            ;(DEFAULT) 00 -> any address, address 127.0.0.1 -> 0x0100007F



        iend

    sockaddr_in_l: equ $ - sockaddr_in
    len dq 0x5fe
    

	newline db 10



section .bss

    socket_fd: resb 4
    file_descript: resb 4
    buffer: resb 0x5FF ; buffer to store data received from server
    ;bufferlen equ 0x5FF
    msg_buffer: resq 0x5FF   ; buffer to store received data
    user_input : resb 4
    




section .text

global _start

_start:

    ; create socket

    mov rax, 41		 ; socket syscall number

    mov rdi, 2		 ; AF_INET

    mov rsi, 1		 ; SOCK_STREAM

    xor rdx, rdx	 ; protocol (0 for TCP)

    syscall

	mov r11, rax							; r11 is socket fd
    cmp rax, 0x00

    
    mov [socket_fd], rax
    

    mov rax, 42				; connect syscall number

    mov rdi, [socket_fd]

    mov rsi, sockaddr_in	; pointer to sockaddr_in struct on stack

    mov rdx, sockaddr_in_l	; sizeof(sockaddr_in)

    syscall

	cmp rax, 0

    jl connect_error
    	
    	;send user input to server
	mov rax, 44   
	mov rdi, [socket_fd]
	mov r8, sockaddr_in
	mov r9, sockaddr_in_l
	mov rsi, 0xa
	mov rdx, 0x4
	mov r10, 0
	syscall
    	
    mov rax, 45
   	mov rdi, [socket_fd]
   	mov rsi, buffer
   	mov rdx, 0x5FF
   	mov r8, sockaddr_in
   	mov r9, sockaddr_in_l
   	syscall
   	
   	mov rax, 1    ; print
	mov rdi, 1
	mov rsi, buffer
	mov rdx, 0x5ff
	syscall
    	
	mov rax, 0    ; read user input
	mov rdi, 0
	mov rsi, user_input
	mov rdx, 0x5ff
	syscall

	xor r10, r10
	
	;send user input to server
	mov rax, 44   
	mov rdi, [socket_fd]
	mov r8, sockaddr_in
	mov r9, sockaddr_in_l
	mov rsi, user_input
	mov rdx, 0x4
	mov r10, 0
	syscall

	 ; received data


   	mov rax, 45
   	mov rdi, [socket_fd]
   	mov rsi, msg_buffer
   	add rsi,0x64
   	mov rdx, 0x5FF
   	mov r8, 0
   	mov r9, 0
   	syscall
	
   
    write_file:

    mov rax, 0x2         ; open syscall number

    mov rdi, output_file    ; address of output file name

    mov rsi, 0x441       ; flags for opening file (O_CREAT | O_WRONLY)

    mov rdx, 0q666        ; mode for opening file (rw-r--r--)

    syscall


    mov [file_descript], rax        ; save file descriptor for later use

    mov rax, 1          ; write syscall number

    mov rdi, [file_descript]        ; file descriptor

    mov rsi, msg_buffer ; data to write

    mov rdx, 0x5FF        ; number of bytes to write

    syscall


    _begin_sorting:
    ; outer loop
    mov edi,0
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
        mov al, [msg_buffer + edi]
        cmp byte [msg_buffer + esi], al
        ja swap
        
        inc edi
        jmp inner_loop
        
        ; swap elements
    swap:
        mov bl, [msg_buffer + esi]
        mov cl, [msg_buffer + edi]
        mov [msg_buffer + esi], cl
        mov [msg_buffer + edi], bl
        
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
    ;Writing to the file
    end_program:
	mov rax,1
	mov rdi, qword[file_descript]
	mov rsi, msg_buffer
	mov rdx, len
	syscall

    mov rax, 3          ; close syscall number

    mov rdi, rsi        ; file descriptor

    syscall



    ; exit program

_exit:

    mov rax, 60         ; exit syscall number

    xor rdi, rdi        ; return value (0 = success)

    syscall



socket_error:

    mov rdi, socket_f_msg

    mov rsi, socket_f_msg_l


connect_error:

    mov rdi, socket_f_msg

    mov rsi, socket_f_msg_l
