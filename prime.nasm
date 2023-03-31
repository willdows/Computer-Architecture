

global _start
section .text

extern printf
extern malloc
_start:
	mov rdi, 9592*8		;9592 primes under 100000, multiplied by 4 bytes
	call malloc		;rax contains a pointer to the beginning of memory
	mov rbx, rax
	mov r9,3
	mov r13,listcount

	;Push the entire list onto the stack	
	storestack:
		push r9
		add r9, 2
		cmp r9, qword[len]
		jl storestack
	;Pop one element at a time and validate it.
	;Store a copy of the number in temp.
	;Remember: quotient goes in RAX, remainder goes in RDX.
	mov rcx, qword[len]
	iterateMultiples:
		xor rdx,rdx
		pop rax

		mov qword[temp], rax
		;Iterate through checkPrime up to n/2 times. 
		mov r15,0x2
		div r15
		mov qword[halfnum],rax	
		call checkPrime
		
		dec qword[len]
		loop iterateMultiples
	jmp exit


notPrime:
	;If you got here, you did not find a prime.
	ret	
definitelyPrime:
	mov rax,1
	mov rdi,1
	mov rsi,primemsg
	mov rdx,primemsglen
	syscall
	
	xor rax, rax
	mov rsi,qword[temp]
	mov rdi,printformat
	call printf
	
	xor r13,r13
	mov r13, qword[listcount]
	inc qword[listcount]
	mov rax, qword[temp]
	mov qword[rbx + r13 * 8],rax
	ret
	
checkPrime:
	mov rax, qword[temp]
	div r15
	;If remainder = 0; this is not a prime
	cmp rdx,0x0
		je notPrime	
	;If we iterate up to n/2, this is a prime
	cmp r15,qword[halfnum]
		je definitelyPrime
	inc r15
	;Be a good citizen.
	xor rax,rax
	xor rdx,rdx
	jmp checkPrime
	
exit:
	mov rsi, 0
	mov rax, 60
	syscall


section .data
	len: dq 100000
	primemsg: dq "Found a prime: ", 0x00
	primemsglen: equ $-primemsg
	printformat: db "%d",0xa,0x00
	listcount: dq 1
	
section .bss
	temp resb 8
	halfnum resb 2
	printnum resb 8
