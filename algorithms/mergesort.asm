section .text
    global mergeSort

; ==========================================================
; void mergeSort(int arr[], int l, int r){
;
; Parameters (System V ABI):
;   rdi = pointer to array
;   rsi = left index
;   rdx = right index
; ==========================================================

mergeSort:
    push rbx
    push r12
    push r13
    push r14
    push r15

    movsxd rsi, esi
    movsxd rdx, edx

    cmp rsi, rdx                ; l and r
    jge .done                   ; l >= r

    mov r12, rdi                ; r12 = arr (!NO CHANGE)
    mov r13, rsi                ; r13 = l   (!NO CHANGE)
    mov r14, rdx                ; r14 = r   (!NO CHANGE)

    mov rax, r14                ; rax = r
    sub rax, r13                ; (r - l)
    sar rax, 1                  ; (r - l) / 2
    lea r15, [rax + r13]        ; m = l + (r - 1) / 2 (!NO CHANGE)

    mov rdi, r12                ; arg1 = arr
    mov rsi, r13                ; arg2 = l
    mov rdx, r15                ; arg3 = m
    call mergeSort

    mov rdi, r12                ; arg1 = arr
    mov rsi, r15                ; arg2 = m
    inc rsi                     ; arg2 = m + 1
    mov rdx, r14                ; arg3 = r
    call mergeSort

    mov rdi, r12                ; arg1 = arr
    mov rsi, r13                ; arg2 = l
    mov rdx, r15                ; arg3 = m
    mov r10, r14                ; arg4 = r
    call .merge
    
    jmp .done

; void merge(int arr[], int l, int m, int r)
; Merges two subarrays of arr[].
; First subarray is arr[l..m]
; Second subarray is arr[m+1..r]

; int arr[] = rdi
; int l = rsi
; int m = rdx
; int r = r10

; arr[] used in whole function
; l = used for k and L
; m = used for R
; r = used for n2
; n1, n2, L_ptr, R_ptr, i, j, k = used in loops

; CURRENTLY USED R10 R12, R13, R14, R15, rdi, rsi, rdx
; NOT USED: R8, R9, R11, rbx, rcx, rax

.merge:
    mov r8, rdx     ; r8 = m
    sub r8, rsi     ; r8 = m - l
    inc r8          ; r8 = m - l + 1 (n1)

    mov r9, r10     ; r9 = r
    sub r9, rdx     ; r9 = r - m (n2)

    ; total_size = (n1 + n2) * 4
    mov rbx, r8     ; rbx = n1
    add rbx, r9     ; rbx = n1 + n2
    shl rbx, 2      ; rbx = (n1 + n2) * 4 = total bytes for L + R

    ; allocate L[n1]
    mov rax, r8     ; rax = n1
    shl rax, 2      ; rax = n1 * 4 bytes
    sub rsp, rax    ; allocate L[n1]
    mov r11, rsp    ; r12 = L base address

    ; allocate R[n2]
    mov rax, r9     ; rax = n2
    shl rax, 2      ; rax = n2 * 4 bytes
    sub rsp, rax    ; allocate R[n2]
    mov r10, rsp    ; r10 = R base address

    ; ==========================================================
    ; for (i = 0; i < n1; i++)
    ;     L[i] = arr[l + i];
    ; ==========================================================

    xor rcx, rcx    ; i = 0

.copy_L:
    cmp rcx, r8            ; i and n1
    jge .copy_L_done       ; i >= n1

    mov rax, rsi           ; rax = l
    add rax, rcx           ; rax = l + i

    mov eax, [rdi + rax*4] ; eax = arr[l + i]
    mov [r11 + rcx*4], eax ; L[i] = eax

    inc rcx                ; i++
    jmp .copy_L

; ==========================================================
; for (j = 0; j < n2; j++)
;     R[j] = arr[m + 1 + j];
; ==========================================================

.copy_L_done:
    xor rcx, rcx           ; j = 0

.copy_R:
    cmp rcx, r9            ; j and n2
    jge .copy_R_done       ; j >= n2

    mov rax, rdx           ; rax = m
    add rax, rcx           ; rax = m + j
    inc rax                ; rax = m + j + 1

    mov eax, [rdi + rax*4] ; eax = arr[m + j + 1]
    mov [r10 + rcx*4], eax ; R[j] = eax

    inc rcx                ; j++
    jmp .copy_R

; ==========================================================
; i = 0;
; j = 0;
; k = l;
;
; while (i < n1 && j < n2)
; ==========================================================

; Therefore rax, edx, rcx, rdx are not used
.copy_R_done:
    xor rcx, rcx    ; i = 0
    xor rdx, rdx    ; j = 0
    ; rsi still contains l, so:
    ; rsi = k = l

.merge_loop:
    cmp rcx, r8                         ; i and n1
    jge .merge_loop_done                ; i >= n1

    cmp rdx, r9                         ; j and n2
    jge .merge_loop_done                ; j >= n2

    mov eax, [r11 + rcx*4]              ; eax = L[i]
    cmp eax, [r10 + rdx*4]              ; L[i] and R[j]
    jg  .L_greater                      ; L[i] > R[j]

    ; arr[k] = L[i]
    mov [rdi + rsi*4], eax

    inc rcx                             ; i++
    inc rsi                             ; k++

    jmp .merge_loop

.L_greater:
    ; arr[k] = R[j]
    mov eax, [r10 + rdx*4]              ; eax = R[j]
    mov [rdi + rsi*4], eax              ; arr[k] = R[j]

    inc rdx                             ; j++
    inc rsi                             ; k++

    jmp .merge_loop

; ==========================================================
; Copy remaining elements
;
; if i >= n1, then L is finished, copy remaining R
; if j >= n2, then R is finished, copy remaining L
; ==========================================================
.merge_loop_done:
    cmp rcx, r8                         ; i and n1
    jge .copy_remaining_R               ; i >= n1

    cmp rdx, r9                         ; j and n2
    jge .copy_remaining_L               ; j >= n2

    jmp .merge_done

; while (i < n1) {
;     arr[k] = L[i];
;     i++;
;     k++;
; }
.copy_remaining_L:
    cmp rcx, r8                         ; i and n1
    jge .merge_done                     ; i >= n1

    mov eax, [r11 + rcx*4]              ; eax = L[i]
    mov [rdi + rsi*4], eax              ; arr[i] = L[i]

    inc rcx                             ; i++
    inc rsi                             ; k++
    jmp .copy_remaining_L

; while (j < n2) {
;     arr[k] = R[j];
;     j++;
;     k++;
; }
.copy_remaining_R:
    cmp rdx, r9                         ; j and n2
    jge .merge_done                     ; j >= n2

    mov eax, [r10 + rdx*4]              ; eax = R[j]
    mov [rdi + rsi*4], eax              ; arr[i] = R[j]

    inc rdx                             ; j++
    inc rsi                             ; k++

    jmp .copy_remaining_R

.merge_done:
    add rsp, rbx
    ret

.done:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx

    ret

section .note.GNU-stack noalloc noexec nowrite progbits