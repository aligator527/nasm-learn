;========================================
; OUTPUT REVERSED TEXT PROGRAM-INATOR
; 
; CASES OF USES:
; - SPECIAL URGENT TO OUTPUT YOUR REVERSED TEXT TO CONSOLE
;========================================

section .data
    prompt_a db "Enter any text: "
    prompt_a_len equ $ - prompt_a

    prompt_b db "Reversed text: "
    prompt_b_len equ $ - prompt_b

    nl db 10

section .bss
    buffer_a resb 32
    output   resb 32

section .text
    global _start

_start:
    ; print prompt_a
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_a
    mov rdx, prompt_a_len
    syscall

    ; read input
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer_a
    mov rdx, 32
    syscall

    ; reverse string
    mov rsi, buffer_a        ; input buffer
    mov rdi, output          ; output buffer
    call rvrs

    mov r14, rax             ; address of reversed string
    mov r15, rdx             ; length of reversed string

    ; print prompt_b
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_b
    mov rdx, prompt_b_len
    syscall

    ; print reversed text
    mov rax, 1
    mov rdi, 1
    mov rsi, r14
    mov rdx, r15
    syscall

    ; print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, nl
    mov rdx, 1
    syscall

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall


; ==========================================================
; rvrs
; Reverse input string into output buffer.
;
; Input:
;   RSI = address of input string
;   RDI = address of output buffer
;
; Output:
;   RAX = address of output buffer
;   RDX = length of reversed string
; ==========================================================

rvrs:
    xor rcx, rcx             ; length = 0
    mov r9, rdi              ; save output start

.find_end:
    mov bl, [rsi]            ; read current character

    cmp bl, 10               ; newline?
    je .copy_reverse

    cmp bl, 0                ; null byte?
    je .copy_reverse

    inc rsi                  ; move to next input character
    inc rcx                  ; length++
    jmp .find_end

.copy_reverse:
    ; now RSI points to '\n' or 0
    ; move one byte back to last real character
    dec rsi

    mov rdx, rcx             ; return length = rcx

.copy_loop:
    test rcx, rcx            ; length == 0?
    je .done

    mov bl, [rsi]            ; read character from end
    mov [rdi], bl            ; write character to output

    dec rsi                  ; move input pointer left
    inc rdi                  ; move output pointer right
    dec rcx                  ; remaining length--
    jmp .copy_loop

.done:
    mov rax, r9              ; return output buffer address
    ret