section .text
global strcspn

strcspn:
    mov rcx, 0                  ; set rcx to 0
    jmp loop                    ; jump to loop

end:
    lea rax, [rcx]              ; set rax to the content of rcx
    ret  

incr:
    inc rcx                     ; increment rcx

loop:
    cmp byte [rdi + rcx], 0     ; sub [rdi + rcx], 0 without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    je end                    
    mov r8, -1

reject_incr:
    inc r8

reject_loop:
    mov al, byte [rsi + r8]
    cmp al, 0
    je incr                     ; conditional jump to incr if ZF = 1

    cmp byte [rdi + rcx], al    ; sub [rdi + rcx], al without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1
    
    
    je end                      ; jump to incr if ZF = 0

                                
    jmp reject_incr             ; un
