;========================================
; NUMBERS ADDIFICATION PROGRMA-INATOR
; 
; CASES OF USES:
; - ADD NUMBERS OF TWO DIFFERENT NUMBERS
;========================================

section .data
    prompt_a db "Enter number for A: "
    prompt_a_len equ $ - prompt_a

    prompt_b db "Enter number for B: "
    prompt_b_len equ $ - prompt_b

    result_msg db "The sum of A and B: "
    result_msg_len equ $ - result_msg

    newline db 10

section .bss
    buffer_a resb 32
    buffer_b resb 32
    output   resb 32

section .text
    global _start

_start:
    ; print "Enter number for A: "
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_a
    mov rdx, prompt_a_len
    syscall

    ; read A
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer_a
    mov rdx, 32
    syscall

    ; convert A string -> number
    mov rsi, buffer_a
    call atoi
    mov r12, rax        ; save A in r12

    ; print "Enter number for B: "
    mov rax, 1
    mov rdi, 1
    mov rsi, prompt_b
    mov rdx, prompt_b_len
    syscall

    ; read B
    mov rax, 0
    mov rdi, 0
    mov rsi, buffer_b
    mov rdx, 32
    syscall

    ; convert B string -> number
    mov rsi, buffer_b
    call atoi
    mov r13, rax        ; save B in r13

    ; A + B
    mov rax, r12
    add rax, r13

    ; convert result number -> string
    mov rdi, output
    call itoa
    ; after itoa:
    ; rax = address of result string
    ; rdx = length of result string

    mov r14, rax        ; save address
    mov r15, rdx        ; save length

    ; print "The sum of A and B: "
    mov rax, 1
    mov rdi, 1
    mov rsi, result_msg
    mov rdx, result_msg_len
    syscall

    ; print result
    mov rax, 1
    mov rdi, 1
    mov rsi, r14
    mov rdx, r15
    syscall

    ; print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall


; ==========================================================
; atoi
; Converts ASCII string to integer
;
; input:
;   rsi = address of string
;
; output:
;   rax = number
;
; Example:
;   "123\n" -> 123
; ==========================================================

atoi:

    ; Set result to 0
    xor rax, rax

.atoi_loop:

    ; Load one byte from memory into BL
    ;
    ; Example:
    ; memory contains:
    ; '1' '2' '3' '\n'
    ; 49  50  51   10
    ;
    ; BL = current character
    mov bl, [rsi]

    ; Check if we reached newline (\n = ASCII 10)
    cmp bl, 10
    je .atoi_done

    ; Check for null terminator (C-style string)
    cmp bl, 0
    je .atoi_done

    ; Convert ASCII digit to actual number
    ;
    ; '0' = 48
    ; '1' = 49
    ; '5' = 53
    ;
    ; Example:
    ; BL = 53 ('5')
    ; BL = 53 - 48 = 5
    sub bl, '0'

    ; Multiply current result by 10
    ;
    ; Example:
    ; result = 12
    ; result = 12 * 10 = 120
    imul rax, rax, 10

    ; Add the new digit
    ;
    ; Example:
    ; result = 120
    ; digit = 5
    ; result = 125
    movzx rbx, bl
    add rax, rbx

    ; Move pointer to next character
    ;
    ; RSI now points to the next byte in memory
    inc rsi

    ; Repeat loop
    jmp .atoi_loop

.atoi_done:

    ; Return to caller
    ; RAX already contains the result
    ret


; ==========================================================
; itoa
; Converts integer to ASCII string
;
; input:
;   rax = number
;   rdi = output buffer
;
; output:
;   rax = address of string
;   rdx = length of string
; ==========================================================

itoa:

    ; Store divisor 10
    ; Every decimal digit is extracted by dividing by 10
    mov rcx, 10

    ; Save the beginning of the buffer
    ; (not actually used later, but useful for debugging)
    mov r8, rdi

    ; Move pointer to the end of the buffer
    ;
    ; We build the string backwards:
    ;
    ; [...............]
    ;                 ^
    ;                RDI
    add rdi, 31

    ; Write null terminator at the end
    ;
    ; Buffer becomes:
    ;
    ; [...............][0]
    mov byte [rdi], 0

    ; Move one position left
    ; Next digit will be written here
    dec rdi

    ; Initialize string length = 0
    xor r9, r9

.itoa_loop:

    ; DIV uses RDX:RAX as one 128-bit number
    ; Therefore RDX must be cleared before division
    xor rdx, rdx

    ; Divide RAX by 10
    ;
    ; After division:
    ;
    ; RAX = quotient
    ; RDX = remainder
    ;
    ; Example:
    ; 123 / 10
    ;
    ; RAX = 12
    ; RDX = 3
    div rcx

    ; Convert remainder into ASCII digit
    ;
    ; Example:
    ; 3 -> '3'
    add dl, '0'

    ; Store digit into memory
    mov [rdi], dl

    ; Move left for the next digit
    dec rdi

    ; Increase string length
    inc r9

    ; Check if quotient became zero
    ;
    ; If not, continue extracting digits
    test rax, rax
    jnz .itoa_loop

    ; We moved one byte too far left
    ; Move back to the first digit
    inc rdi

    ; Return pointer to the resulting string
    mov rax, rdi

    ; Return string length
    mov rdx, r9

    ret