section .text
    global binarySearch

; ==========================================================
; int binarySearch(int arr[], int n, int x)
;
; Parameters (System V ABI):
;   rdi = pointer to array
;   rsi = number of elements
;   rdx = value to search for
;
; Return value:
;   rax = index of x if found
;   rax = -1 if x does not exist
; ==========================================================

binarySearch:
    ; Preserve callee-saved registers
    push r12
    push r13
    push r14
    push r15

    ; Save arguments into preserved registers
    mov r12, rdi                ; r12 = arr
    mov r13, rsi                ; r13 = n
    mov r14, rdx                ; r14 = x

    ; Initialize search bounds
    xor rcx, rcx                ; low = 0
    
    mov r15, rsi                ; r15 = n
    dec r15                     ; r15 = n - 1 (high)

.loop:
    ; If low > high, the element does not exist
    cmp rcx, r15                ; low > high ?
    jg .not_found

    ; Compute:
    ; mid = low + (high - low) / 2
    mov rax, r15                ; rax = high
    sub rax, rcx                ; high - low
    sar rax, 1                  ; (high - low) / 2
    lea rdx, [rcx + rax]        ; mid = low + (high - low) / 2

    ; Compare arr[mid] with x
    cmp dword [r12 + rdx*4], r14d

    ; Found the value
    je .found

    ; If arr[mid] < x,
    ; search the right half
    jl .ignore_left             ; arr[mid] < x

; Otherwise arr[mid] > x,
; search the left half
.ignore_right:
    mov r15, rdx
    dec r15             ; high = mid - 1
    jmp .loop


.ignore_left:
    mov rcx, rdx
    inc rcx             ; low = mid + 1
    jmp .loop

.found:
    mov rax, rdx        ; return mid
    jmp .done

.not_found:
    mov eax, -1         ; return -1

.done:
    pop r15
    pop r14
    pop r13
    pop r12

    ret

section .note.GNU-stack noalloc noexec nowrite progbits