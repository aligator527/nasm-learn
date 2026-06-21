section .text
    global my_itoa

; char *my_itoa(unsigned long value, char *buf)
;
; input:
;   rax = value
;   rdi = buffer, at least 32 bytes
;
; output:
;   rax = pointer to resulting string inside buffer
;   rdx = string length

my_itoa:
    mov rcx, 10             ; divisor = 10

    mov r8, rdi             ; save original buffer pointer, optional

    add rdi, 31             ; move to end of 32-byte buffer
    mov byte [rdi], 0       ; null terminator
    dec rdi                 ; position for last digit

    xor r9, r9              ; length = 0

.itoa_loop:
    xor rdx, rdx            ; clear high part before div

    div rcx                 ; rax = rax / 10, rdx = rax % 10

    add dl, '0'             ; remainder -> ASCII digit
    mov [rdi], dl           ; store digit

    dec rdi                 ; move left
    inc r9                  ; length++

    test rax, rax           ; quotient == 0?
    jnz .itoa_loop

    inc rdi                 ; move back to first digit

    mov rax, rdi            ; return pointer to string
    mov rdx, r9             ; return length

    ret