section .text
    global my_strcmp

; int my_strcmp(const char *s1, const char *s2)
; rdi = s1
; rsi = s2
; rax = result

my_strcmp:
.loop:
    movzx eax, byte [rdi]    ; c1 = *s1
    movzx edx, byte [rsi]    ; c2 = *s2

    cmp eax, edx
    jne .done

    cmp eax, 0
    je .done

    inc rdi
    inc rsi
    jmp .loop

.done:
    sub eax, edx             ; return c1 - c2
    ret

section .note.GNU-stack noalloc noexec nowrite progbits