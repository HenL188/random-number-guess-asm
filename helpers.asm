slen:
    push    rdi
    mov     rdi, rax
 
nextchar:
    cmp     byte [rax], 0
    jz      finished
    inc     rax
    jmp     nextchar
 
finished:
    sub     rax, rdi
    pop     rdi
    ret
 
 
;------------------------------------------
; void sprint(String message)
; String printing function
print:
    push    rdx
    push    rsi
    push    rdi
    push    rax
    call    slen
 
    mov     rdx, rax
    pop     rax
 
    mov     rsi, rax
    mov     rdi, 1
    mov     rax, 1
    syscall
 
    pop     rdi
    pop     rsi
    pop     rdx
    ret

println:
    call    print
 
    push    rax         ; push eax onto the stack to preserve it while we use the eax register in this function
    mov     rax, 0Ah    ; move 0Ah into eax - 0Ah is the ascii character for a linefeed
                        ; as eax is 4 bytes wide, it now contains 0000000Ah
    push    rax         ; push the linefeed onto the stack so we can get the address
                        ; given that we have a little-endian architecture, eax register bytes are stored in reverse order,
                        ; this corresponds to stack memory contents of 0Ah, 0h, 0h, 0h,
                        ; giving us a linefeed followed by a NULL terminating byte
    mov     rax, rsp    ; move the address of the current stack pointer into eax for sprint
    call    print      ; call our sprint function
    pop     rax         ; remove our linefeed character from the stack
    pop     rax         ; restore the original value of eax before our function was called
    ret                 ; return to our program

 
 
;------------------------------------------
; void exit()
; Exit program and restore resources
quit:
    mov     rdi, 0
    mov     rax, 60
    syscall
    ret
