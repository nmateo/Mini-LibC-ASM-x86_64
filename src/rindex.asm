section .text
global rindex

rindex:
    mov rcx, 0                  ; set rcx to 0
    mov r10, 0                  ; set rax to 0
    jmp loop                    ; jump to loop

add_occur:

    lea r10, [rdi + rcx]        ; load effective adress of [rdi + rcx] into r10
    jmp loop2                   ; unconditional jump to loop2
incr:

    inc rcx                     ; increment rcx

loop:

    cmp byte [rdi + rcx], sil   ; sub byte [rdi + rcx], sil without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    je add_occur                ; conditional jump to add_occur if ZF = 1
 
loop2:
    cmp byte [rdi + rcx], 0     ; sub byte [rdi + rcx], 0 without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1
    
    jne incr                    ; conditional jump to incr if ZF = 0

    lea rax, [r10]              ; load effective adress of [r10] into rax
    ret                         ; return rax
