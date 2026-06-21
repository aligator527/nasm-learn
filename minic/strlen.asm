section .text
    global my_strlen

; size_t my_strlen(const char *str)
; rdi = str
; rax = result

my_strlen:
.loop:
    cmp byte [rdi + rax], 0   ; str[length] == '\0' ?
    je .done

    inc rax                   ; length++
    jmp .loop

.done:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits