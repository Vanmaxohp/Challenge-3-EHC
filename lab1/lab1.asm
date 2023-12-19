section .data
    ten db 'Your name: '
    ten_len equ $-ten
    hello db 'Hello '
    hello_len equ $-hello
    chamthan db ' !!', 0xa, 0xd
    chamthan_len equ $-chamthan
    welcome db 'Welcome, '
    welcome_len equ $-welcome
    toEHC db ' to EHC', 0xa, 0xd
    toEHC_len equ $-toEHC

section .bss
    name resb 10

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, ten
    mov edx, ten_len
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, name
    mov edx, 10
    int 0x80

    mov edx, name
    sub eax, 0x1
    mov word[edx + eax], 0x0

    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, hello_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, 10
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, chamthan
    mov edx, chamthan_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, welcome
    mov edx, welcome_len
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, 10
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, toEHC
    mov edx, toEHC_len
    int 0x80

    mov eax, 1
    int 0x80
