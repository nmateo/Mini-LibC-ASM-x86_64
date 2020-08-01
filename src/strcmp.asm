section .text
global strcmp

strcmp:
    mov rcx, 0                  ; set rcx to 0
    jmp loop                    ; unconditional jump to loop

loop:
    mov al, byte [rsi, rcx]     ; move a byte at adress [rsi + rcx] to al

    cmp byte[rdi + rcx], al     ; sub byte [rdi + rcx], al without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    jg sup                      ; conditional jump to sup none of the flags are set
    jl inf                      ; conditional jump to inf if CF = 1

    cmp byte[rdi + rcx], 0      ; sub byte [rdi + rcx], 0 without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    je equ                      ; conditional jump to equ if ZF = 1

    inc rcx                     ; increment rcx

    jmp loop                    ; unconditional jump to loop

inf:
    mov rax, -1                 ; set rax to -1
    ret                         ; return rax

sup:
    mov rax, 1                  ; set rax to 1
    ret                         ; return rax

equ:
    mov rax, 0                  ; set rax to 0
    ret                         ; return rax
