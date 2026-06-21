section .text
    global bubbleSort

; void bubbleSort(int arr[], int n)
; rdi = arr
; rsi = n

bubbleSort:
    push r12

    mov r12, rdi                 ; r12 = arr

    mov r8, rsi                  ; r8 = n
    dec r8                       ; r8 = n - 1

    xor rcx, rcx                 ; i = 0

.loop:
    
    cmp rcx, r8                  ; i >= n - 1 ?
    jge .done

    xor r9, r9                   ; j = 0

.inner_loop:
    mov r10, r8                  ; r10 = n - 1
    sub r10, rcx                 ; r10 = n - 1 - i

    cmp r9, r10                  ; j >= n - 1 - i ?
    jge .inner_done

    mov eax, [r12 + r9*4]        ; eax = arr[j]
    cmp eax, [r12 + r9*4 + 4]    ; compare arr[j] and arr[j + 1]
    jle .no_swap

    lea rdi, [r12 + r9*4]        ; rdi = &arr[j]
    lea rsi, [r12 + r9*4 + 4]    ; rsi = &arr[j + 1]
    call .swap

.no_swap:
    inc r9                   ; j++
    jmp .inner_loop

.inner_done:
    inc rcx                  ; i++
    jmp .loop

; void swap(int* xp, int* yp)
; rdi = xp = &arr[j]
; rsi = yp = &arr[j + 1]

.swap:
    mov eax, [rdi]      ; eax = *xp
    mov edx, [rsi]      ; edx = *yp

    mov [rdi], edx      ; *xp = *yp
    mov [rsi], eax      ; *yp = temp

    ret

.done:
    pop r12
    ret

section .note.GNU-stack noalloc noexec nowrite progbits