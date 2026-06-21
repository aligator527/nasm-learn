section .text
    global quickSort

; void quickSort(int arr[], int low, int high)
; rdi = arr
; rsi = low
; rdx = high

quickSort:
    push rbx
    push r12
    push r13
    push r14
    push r15

    ; rdi = arr
    ; rsi = low
    ; rdx = high

    cmp rsi, rdx
    jge .done

    mov r12, rdi        ; r12 = arr
    mov r13, rsi        ; r13 = low
    mov r14, rdx        ; r14 = high

    ; pi = partition(arr, low, high)
    mov rdi, r12
    mov rsi, r13
    mov rdx, r14
    call .partition

    mov r15, rax        ; r15 = pi

    ; quickSort(arr, low, pi - 1)
    mov rdi, r12        ; arr
    mov rsi, r13        ; low
    mov rdx, r15        ; pi
    dec rdx             ; pi - 1
    call quickSort

    ; quickSort(arr, pi + 1, high)
    mov rdi, r12        ; arr
    mov rsi, r15        ; pi
    inc rsi             ; pi + 1
    mov rdx, r14        ; high
    call quickSort

    jmp .done

; INPUT
; rdi = arr
; rsi = low
; rdx = high
; OUTPUT
; rax = pi

.partition:
    mov r8, rdi               ; r8 = arr
    mov r10, rdx              ; r10 = high

    mov r11d, [r8 + r10*4]    ; pivot = arr[high]

    mov rcx, rsi              ; i = low
    dec rcx                   ; i = low - 1

    mov r9, rsi               ; j = low

.partition_loop:
    cmp r9, r10               ; j < high ?
    jge .partition_end

    mov eax, [r8 + r9*4]      ; eax = arr[j]
    cmp eax, r11d             ; arr[j] < pivot ?
    jge .no_partition_swap

    inc rcx                   ; i++

    lea rdi, [r8 + rcx*4]     ; &arr[i]
    lea rsi, [r8 + r9*4]      ; &arr[j]
    call .swap


.no_partition_swap:
    inc r9                    ; j++
    jmp .partition_loop

.partition_end:
    inc rcx                   ; i + 1

    lea rdi, [r8 + rcx*4]     ; &arr[i + 1]
    lea rsi, [r8 + r10*4]     ; &arr[high]
    call .swap

    mov rax, rcx              ; return i + 1
    ret

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
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    ret

section .note.GNU-stack noalloc noexec nowrite progbits