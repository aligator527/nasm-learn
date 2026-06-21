;========================================
; STRING COMPARE PROGRAM-INATOR
; 
; CASES OF USES:
; - SPECIAL URGENT TO COMPARE STRINGS BY ASCII VALUES
;========================================

section .data
    prompt_a db "Enter text A: "
    prompt_a_len equ $ - prompt_a

    prompt_b db "Enter text B: "
    prompt_b_len equ $ - prompt_b

    result_equal db "Text A and Text B are equal", 10
    result_equal_len equ $ - result_equal

    result_greater db "Text A is greater than Text B", 10
    result_greater_len equ $ - result_greater

    result_less db "Text A is less than Text B", 10
    result_less_len equ $ - result_less

section .bss
    buffer_a resb 255
    buffer_b resb 255

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
    mov rdx, 255
    syscall

    ; print prompt_b
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_b
    mov rdx, prompt_b_len
    syscall

    ; read input
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer_b
    mov rdx, 255
    syscall

    mov rsi, buffer_a
    mov rdi, buffer_b
    call strcmp

    cmp rax, 0
    je .print_equal
    jg .print_greater
    jl .print_less

    mov rax, 60
    xor rdi, rdi
    syscall

.print_equal:
    mov rsi, result_equal
    mov rdx, result_equal_len
    jmp .print_result

.print_greater:
    mov rsi, result_greater
    mov rdx, result_greater_len
    jmp .print_result

.print_less:
    mov rsi, result_less
    mov rdx, result_less_len
    jmp .print_result

.print_result:
    mov rax, 1
    mov rdi, 1
    syscall

strcmp:
    movzx  rdx, byte [rsi]
    movzx  rax, byte [rdi]
    cmp    rdx, rax             ; while (*p1 == *p2)
    jne    .strcmp_done

    mov    bl, [rsi]            ; read current character

    cmp    bl, 10               ; newline?
    je     .strcmp_done

    cmp    bl, 0                ; null byte?
    je     .strcmp_done

    mov    bl, [rdi]            ; read current character

    cmp    bl, 10               ; newline?
    je     .strcmp_done

    cmp    bl, 0                ; null byte?
    je     .strcmp_done

    inc    rsi                  ; move to next input character
    inc    rdi

    jmp    strcmp

.strcmp_done:
    sub rdx, rax    ; rdx = c1 - c2
    mov rax, rdx    ; return in rax

    ret