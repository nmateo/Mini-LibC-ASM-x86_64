section .text
global strcasecmp

strcasecmp:
    mov rcx, 0                  ; set rcx to 0
    jmp start_loop                    ; unconditional jump to loop

start_loop:
    jmp to_lower_al             ; unconditional jump to to_lower_al
loop:
    cmp r10b, al                ; sub byte r10b, al without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    jg sup                      ; conditional jump to sup none of the flags are set
    jl inf                      ; conditional jump to inf if CF = 1

    cmp r10b, 0                 ; sub byte r10b, 0 without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    je equ                      ; conditional jump to equ if ZF = 1

    inc rcx                     ; increment rcx

    jmp start_loop                    ; unconditional jump to loop

to_lower_al:
    mov al, byte [rsi, rcx]     ; move a byte at adress [rsi + rcx] to al
    mov r10b, byte [rdi + rcx]  ; move a byte at adress [rdi + rcx] to r10b

    cmp al, 'A'                 ; sub al, 65 without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    jl to_lower_r10b            ; conditional jump to to_lower_r10b if CF = 1

    cmp al, 'Z'                 ; sub al, 'Z' without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    jg to_lower_r10b            ; conditional jump to to_lower_r10b if none of the flags are set
    add al, 32                  ; add 32 to al if none of the previous conditions was met

to_lower_r10b:

    cmp r10b, 'A'               ; sub r10b, 'A' without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    jl loop                     ; conditional jump to loop if CF = 1

    cmp r10b, 'Z'               ; sub r10b, 'Z' without altering the operands,
                                ; if dst = src ZF set to 1, if dst < src CF set to 1
                                ; and if dst > src none of the Zero Flags and Carry Flags are set to 1

    jg loop                     ; conditional jump to loop if none of the flags are set
    add r10b, 32                ; add 32 to r10b if none of the previous conditions was met
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

