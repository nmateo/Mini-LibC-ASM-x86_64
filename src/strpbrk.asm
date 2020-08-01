section .text
global strpbrk

strpbrk:
    mov rcx, 0                  ; set rcx to 0

    cmp byte [rsi], 0
    je null_ret
    jmp loop

incr:
    inc rcx                     ; increment rcx

loop:
    cmp byte [rdi + rcx], 0     ; sub [rdi + rcx], sil without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    je null_ret                 ; jump to null_ret if ZF = 1
    mov r8, 0
    jmp sub_loop

incr_sub_loop:
    inc r8

sub_loop:
    mov al, byte [rsi + r8]
    cmp al, 0
    je incr

    cmp byte [rdi + rcx], al    ; sub [rdi + rcx], sil without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1
    
    
    jne incr_sub_loop           ; jump to incr if ZF = 0

    lea rax, [rdi + rcx]        ; load effective adress of [rdi + rcx bytes] into rax
    ret                         ; return rax

null_ret:
    mov rax, 0                  ; set rax to 0
    ret                         ; return rax
