section .text
global strchr

strchr:

	mov rcx, 0
	jmp loop

incr:

	inc rcx

loop:

	mov al, byte [rdi+rcx]
	cmp al, 0
	je null_ret
	cmp al, sil
	jne incr
	lea rax, [rdi + rcx]
	ret

null_ret:

	mov rax, 0
