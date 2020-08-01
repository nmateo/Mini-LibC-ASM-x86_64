section .text
global memset

memset:
    mov rcx, 0                  ; set rcx to 0

    cmp rdx, 0                  ; sub rdx, 0 without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1 

    je end                      ; jump to end if ZF = 1

loop:
    cmp rcx, rdx                ; sub rcx, rdx without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    je end                      ; jump to end if ZF = 1

    mov byte [rdi + rcx], sil   ; set byte [rdi + rcx] to sil

    inc rcx                     ; increment rcx

    jmp loop                    ; jump to loop

end:
    mov rax, rdi                ; set rax to rdi

    ret                         ; return rax
    
