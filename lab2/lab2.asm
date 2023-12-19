section .data
    msg1 db "Nhap vao chieu dai va chieu rong: ", 0xa, 0xd
    len1 equ $-msg1
    msg2 db "Dien tich cua hinh chu nhat: "
    len2 equ $-msg2
    msg3 db "Chu vi cua hinh chu nhat: "
    len3 equ $-msg3
    nl db 0xa, 0xd
    lennl equ $-nl

section .bss
    canh1 resb 10
    canh2 resb 10
    S resb 1
    P resb 1

section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, canh1
    mov edx, 10
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, canh2
    mov edx, 10
    int 0x80
 
    mov al, [canh1]
    sub al, '0'
    mov bl, [canh2]
    sub bl, '0'
    mul bl
    add al, '0'
    mov [S], al

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, S
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, lennl
    int 0x80

    mov al, [canh1]
    sub al, '0'
    mov bl, [canh2]
    sub bl, '0'
    add al, bl
    shl al, 1
    add al, '0'
    mov [P], al

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, P
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, lennl
    int 0x80

    mov eax, 1
    int 0x80
