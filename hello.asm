;========================================
; HELLO ASSEMBLY PROGRAM-INATOR
; 
; CASES OF USES:
; - SPECIAL URGENT TO OUTPUT "HELLO, ASSEMBLY!" TO CONSOLE
;========================================

; ==========================================================
; section .data
; Program data lives here: strings, arrays, and similar values.
; ==========================================================

section .data

    ; db = Define Byte
    ; The following bytes will be stored in memory:
    ;
    ; H e l l o ,   A s s e m b l y ! \n
    ;
    ; 10 = ASCII code for line feed (\n)

    msg db "Hello, Assembly!", 10

    ; $ = current address in memory
    ;
    ; len = (current address) - (address of msg)
    ;
    ; NASM calculates the string length at assembly time.
    ;
    ; Example:
    ;
    ; msg starts at address 1000
    ; current address after the string = 1017
    ;
    ; len = 1017 - 1000 = 17

    len equ $ - msg



; ==========================================================
; section .text
; Executable program code lives here.
; ==========================================================

section .text

    ; Tell the linker:
    ; "the program entry point is named _start"

    global _start



; ==========================================================
; The program starts here.
; ==========================================================

_start:

    ; ------------------------------------------------------
    ; Linux syscall write()
    ;
    ; write(fd, buffer, size)
    ;
    ; fd     = where to write
    ; buffer = address of the data
    ; size   = number of bytes to output
    ; ------------------------------------------------------


    ; rax = syscall number
    ;
    ; write() has number 1

    mov rax, 1


    ; rdi = first argument
    ;
    ; 1 = stdout (console)

    mov rdi, 1


    ; rsi = second argument
    ;
    ; msg = address of the string

    mov rsi, msg


    ; rdx = third argument
    ;
    ; number of bytes to output

    mov rdx, len


    ; ------------------------------------------------------
    ; Enter kernel mode
    ;
    ; The CPU switches from User Mode to Kernel Mode.
    ;
    ; The kernel reads:
    ;
    ; rax = 1
    ; rdi = 1
    ; rsi = string address
    ; rdx = length
    ;
    ; and executes:
    ;
    ; write(1, msg, len)
    ; ------------------------------------------------------

    syscall



    ; ======================================================
    ; Program exit
    ; ======================================================


    ; syscall number 60 = exit()

    mov rax, 60


    ; program exit code
    ;
    ; exit(0)

    xor rdi, rdi

    ; same as:
    ;
    ; mov rdi, 0
    ;
    ; but xor is shorter and faster

    syscall

;========================================
; C equivalent
; #include <unistd.h>
;
; int main()
;{
;    write(1, "Hello, Assembly!\n", 17);
;    return 0;
;}
;========================================

; | Register | Purpose        |
; | -------- | -------------- |
; | RAX      | syscall number |
; | RDI      | argument 1     |
; | RSI      | argument 2     |
; | RDX      | argument 3     |
; | R10      | argument 4     |
; | R8       | argument 5     |
; | R9       | argument 6     |
