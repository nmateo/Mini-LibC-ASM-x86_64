section .text
global memmove

memmove:
    mov rcx, 0                  ; set rcx to 0
    cmp rdx, 0                  ; sub rdx, 0 without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    je end                      ; conditional jump to end if ZF = 1
    jmp get_mem                 ; unconditional jump to get_mem

get_mem:
    cmp rdx, rcx                ; sub rdx, rcx without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    je cpy_mem                  ; conditional jump to cpy_mem if ZF = 1
    mov al, byte[rsi + rcx]     ; set al to byte [rsi + rcx]
    push rax                    ; push rax into the stack
    inc rcx                     ; increment rcx
    jmp get_mem                 ; unconditional jump to get_mem

cpy_mem:
    pop rax                     ; pop last value from the stack into rax
    dec rcx                     ; decrement rcx
    mov byte [rdi + rcx], al    ; set byte [rdi + rcx] to al
    cmp rcx, 0                  ; sub rcx, 0 without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    jne cpy_mem                 ; conditional jump to cpy_mem if ZF = 0

end:
    lea rax, [rdi]              ; load effective adress of [rdi] into rax
    ret                         ; return rax
    
    
