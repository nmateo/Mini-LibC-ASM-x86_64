section .text
global strstr
strstr:
    mov rcx, 0                  ; set rcx to 0
    mov r8, 0
    cmp byte [rsi + r8], 0
    je null_ret
    mov al, byte [rsi + r8]
    jmp loop                    ; jump to loop

incr:
    inc rcx                     ; increment rcx

loop:
    mov r8, 0
    mov al, byte [rsi + r8]
    cmp byte [rdi + rcx], 0     ; sub [rdi + rcx], sil without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1
    je null_ret                 ; jump to null_ret if ZF = 1
    
    cmp byte [rdi + rcx], al    ; sub [rdi + rcx], sil without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    jne incr                    ; jump to incr if ZF = 0
    jmp start_sub_loop

start_sub_loop:
    mov r8, 0
    mov r9, rcx

sub_loop:
    inc r9
    inc r8
    mov al, byte[rsi + r8]
    cmp al, 0
    je end
    cmp byte [rdi + r9], 0
    je incr
    cmp byte [rdi + r9], al
    je sub_loop
    jne incr
end:
    lea rax, [rdi + rcx]
    ret
null_ret:
    mov rax, 0                  ; set rax to 0
    ret                         ; return rax
