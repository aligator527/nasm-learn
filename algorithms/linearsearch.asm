section .text
    global linearSearch

; ==========================================================
; int linearSearch(int arr[], int n, int x)
;
; Parameters (System V ABI):
;   rdi = pointer to array
;   rsi = number of elements
;   edx = value to search for
;
; Return value:
;   rax = index of x if found
;   rax = -1 if x does not exist
; ==========================================================

linearSearch:

    xor rcx, rcx                ; i = 0

.loop:
    cmp rcx, rsi                ; compare i and n
    jge .not_found              ; if greater or equal = not found  

    cmp dword [rdi + rcx*4], edx 
    je .found

    inc rcx
    jmp .loop

.found:
    mov rax, rcx        ; return mid
    jmp .done

.not_found:
    mov eax, -1         ; return -1

.done:
    ret

section .note.GNU-stack noalloc noexec nowrite progbits