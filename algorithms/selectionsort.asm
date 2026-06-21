section .text
    global selectionSort

; ==========================================================
; int selectionSort(int arr[], int n)
;
; Parameters (System V ABI):
;   rdi = pointer to array
;   rsi = number of elements
; ==========================================================

selectionSort:
    push r11
    push r12
    push r13

    mov r12, rdi                ; r12 = arr
    mov r13, rsi                ; r13 = n

    xor rcx, rcx                ; i = 0
    
    mov r11, r13                ; r11 = n
    dec r11                     ; n - 1

.loop:
    cmp rcx, r11                ; i and n - 1
    jge .done                   ; i >= n - 1

    mov r9, rcx                 ; min_idx = i

    mov r10, rcx                ; r10 = j
    inc r10                     ; r10 = j + 1

.inner_loop:
    cmp r10, r13                ; j and n
    jge .swap                   ; j >= n

    mov r8d, [r12 + r10*4]      ; r8 = arr[j]
    cmp r8d, [r12 + r9*4]       ; arr[j] and arr[min_idx]
    jge .no_arr_comp            ; arr[j] >= arr[min_idx]

    mov r9, r10                 ; min_idx = j

.no_arr_comp:
    inc r10                     ; j++
    jmp .inner_loop

.swap:
    lea rdi, [r12 + rcx*4]    ; arr[i]
    lea rsi, [r12 + r9*4]     ; arr[min_idx]

    mov eax, [rdi]      ; eax = arr[i]
    mov edx, [rsi]      ; edx = arr[min_idx]

    mov [rdi], edx      ; arr[i] = arr[min_idx]
    mov [rsi], eax      ; arr[min_idx] = arr[i]

    inc rcx

    jmp .loop

.done:
    pop r13
    pop r12
    pop r11

    ret

section .note.GNU-stack noalloc noexec nowrite progbits