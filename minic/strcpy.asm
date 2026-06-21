section .text
    global my_strcpy

; char my_strcpy(char *dest, const char *src)
; rdi = dest
; rsi = src

my_strcpy:
    mov rax, rdi            ; save original dest for return

.loop:
    mov dl, [rsi]           ; load byte from src
    mov [rdi], dl           ; copy byte to dest

    inc rsi
    inc rdi

    test dl, dl             ; was it null byte?
    jne .loop

.done:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits