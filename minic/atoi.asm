section .text
    global my_atoi

; int my_atoi(const char *nptr)
; rdi = nptr
; return eax = result

my_atoi:
    xor eax, eax            ; result = 0

.loop:
    movzx ecx, byte [rdi]   ; ecx = *rdi

    cmp ecx, 10             ; newline
    je .done

    cmp ecx, 0              ; '\0'
    je .done

    cmp ecx, '0'            ; if char < '0', stop
    jl .done

    cmp ecx, '9'            ; if char > '9', stop
    jg .done

    sub ecx, '0'            ; digit = char - '0'

    imul eax, eax, 10       ; result *= 10
    add eax, ecx            ; result += digit

    inc rdi
    jmp .loop

.done:
    ret