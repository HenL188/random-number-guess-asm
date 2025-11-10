%include 'helpers.asm'

extern time
extern srand
extern rand

SECTION .data
        upper db 10
        lower db 1
        input db 'Enter guess: ', 0h
        high db 'Too high', 0h
        low db 'Too low', 0h
        correct db 'Correct!', 0h
        answer db 'Number: ', 0h
        
SECTION .bss
        guess resb 255

SECTION .text
global main

main:
        ; Call srand(time(NULL))
        xor rdi, rdi
        call time
        mov rdi, rax
        call srand

        ; Call rand() % 10 + 1
        call rand
        xor rdx, rdx
        mov rsi, 10
        div rsi
        add rdx, 1

        ; Save rand number
         push rdx

        cmp rdx, guess
        je equal
        jg greater
        jl less

user_input:
        mov rdx, 255
        mov rsi, guess
        mov rdi, 0
        mov rax, 0
        syscall

        mov rax, guess
        call print

        ret        

greater:
        mov rax, high
        call print
        mov rax, input
        call print

        ; call user_input

        ; cmp [rsp], guess
        ; je equal
        ; jg greater
        ; jl less

less:
        mov rax, less
        call print
        mov rax, input
        call print

        ; call user_input

        ; cmp [rsp], guess
        ; je equal
        ; jg greater
        ; jl less
        

equal:
        mov rax, correct
        call print
        call quit
        
