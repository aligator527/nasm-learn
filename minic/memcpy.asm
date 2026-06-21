section .text
    global my_memcpy

; void *my_memcpy(void *dest, const void *src, size_t n)
; rdi = dest
; rsi = src
; rdx = n

my_memcpy:
    xor rcx, rcx            ; i = 0
    mov rax, rdi            ; save original dest for return

.loop:
    cmp rcx, rdx            ; i == n ?
    je .done

    mov r8b, [rsi]           ; load byte from src
    mov [rdi], r8b           ; copy byte to dest

    inc rsi
    inc rdi
    inc rcx

    jmp .loop

.done:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits