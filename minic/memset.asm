section .text
    global my_memset

; void *memset(void *s, int c, size_t n);
; rdi = s
; rsi = c
; rdx = n

my_memset:
    xor rcx, rcx             ; i = 0
    mov rax, rdi             ; save original pointer

.loop:
    cmp rcx, rdx             ; i == n ?
    je .done

    mov [rdi], sil           ; least significant byte of rsi

    inc rdi
    inc rcx

    jmp .loop

.done:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits