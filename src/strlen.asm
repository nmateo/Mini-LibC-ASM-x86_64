section .text
global strlen

strlen:
    mov rcx, 0                  ; set rcx to 0

    jmp loop                    ; jump to loop

incr:
    inc rcx                     ; increment rcx

loop:
    cmp byte [rdi + rcx], 0     ; sub byte [rdi + rcx], 0 without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    jne incr                    ; jump to incr if ZF = 0

    mov rax, rcx                ; set rax to rcx

    ret                         ; return rax
