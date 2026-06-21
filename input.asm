;========================================
; INPUT-OUTPUT CONSOLE PROGRAM-INATOR
; 
; CASES OF USES:
; - SPECIAL URGENT TO OUTPUT YOUR TEXT TO CONSOLE
;========================================


; read(stdin, buffer, size)

section .data:
    request db 'Press Enter to input text', 10
    request_len equ $ - request
    prompt db 'Enter text: ', 0
    prompt_len equ $ - prompt
    msg db 'You entered: ', 0
    msg_len equ $ - msg


section .bss
    buffer resb 64  ; Space to hold 64 bytes

section .text

    global _start

_start: 
    mov rax, 1
    mov rdi, 1
    mov rsi, request
    mov rdx, request_len
    syscall

    je read_char

read_char:

    mov rax, 0           ; syscall number for sys_read
    mov rdi, 0           ; file descriptor 0 (stdin)
    mov rsi, buffer      ; pointer to buffer
    mov rdx, 1           ; read 1 byte
    syscall              ; call kernel

    ; Check if the character is the Enter key (LF = 10)
    mov al, [buffer]
    cmp al, 10                   ; Compare input character with 10 (0x0A)
    je enter_pressed             ; If equal, jump to the handler

    jmp read_char                ; Otherwise, keep reading loop

enter_pressed:
    lea rdi, [buffer]       ; RDI points to the start of the buffer
    xor eax, EAX            ; EAX = 0 (the byte value we want to write)
    mov ecx, 64             ; RCX/ECX = number of bytes to clear
    cld                     ; Clear direction flag (so we increment forward)
    rep stosb               ; Clear the buffer!

    mov rax, 1
    mov rdi, 1
    mov rsi, prompt 
    mov rdx, prompt_len
    syscall

    mov rax, 0
    mov rdi, 0
    mov rsi, buffer
    mov rdx, 64
    syscall 

    mov r12, rax            ; save number of bytes read

    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, buffer
    mov rdx, r12
    syscall

    mov rax, 60
    mov rdi, 0
    syscall