section .text
    global insertionSort

; ==========================================================
; int insertionSort(int arr[], int n)
;
; Parameters (System V ABI):
;   rdi = pointer to array
;   rsi = number of elements
; ==========================================================

insertionSort:
    push r12
    push r13

    mov r12, rdi                    ; r12 = arr[]
    mov r13, rsi                    ; r13 = n

    mov rcx, 1                      ; i = 1

.loop:
    cmp rcx, r13                ; i and n
    jge .done                   ; i >= n

    mov r8d, [r12 + rcx*4]      ; key = arr[i]

    mov r10, rcx                ; j = i
    dec r10                     ; j = i - 1

.inner_loop:
    cmp r10, 0                  ; j and 0
    jl .inner_loop_done         ; j < 0

    mov eax, [r12 + r10*4]      ; eax = arr[j]

    cmp eax, r8d      ; arr[j] and key
    jle .inner_loop_done        ; key < arr[j]

    mov [r12 + r10*4 + 4], eax  ;arr[j + 1] = arr[j]
    dec r10                     ;j = j - 1

    jmp .inner_loop

.inner_loop_done:
    mov [r12 + r10*4 + 4], r8d      ;arr[j + 1] = key;

    inc rcx
    jmp .loop

.done:
    pop r13
    pop r12

    ret

section .note.GNU-stack noalloc noexec nowrite progbits