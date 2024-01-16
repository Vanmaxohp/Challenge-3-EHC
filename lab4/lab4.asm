section .data

	ip db "Input: "
	lenip equ $-ip

	op db "Sum of n sequences is:  "
	lenop equ $-ip

	nl db 0xa, 0xd
	lennl equ nl

section .bss

	n resb 10
	tong resb 10

section .text

global _start
_start:

	;Input
	mov eax, 4
	mov ebx, 1
	mov ecx, ip
	mov edx, lenip
	int 0x80

	;Nhap so
	mov eax, 3
	mov ebx, 0
	mov ecx, n
	mov edx, 10
	int 0x80

	;In ra The sum of
	mov eax, 4
	mov ebx, 1
	mov ecx, op
	mov edx, lenop
	int 0x80

	mov edx, n
	sub eax, 1h
	mov byte [edx + eax], 0h

	sub byte [n], '0'

	mov byte [tong],0
	mov ebx, 0

	;Tinh ketqua
	sum:
	add eax, ecx
	inc ebx
	cmp ebx, n
	jbe sum

	;In ra ketqua
	mov eax, 4
	mov ebx, 1
	mov ecx, eax
	mov edx, 10
	int 0x80

	;Ket thuc
	mov eax, 1
	mov ebx, 0
	int 0x80

ascii_to_int:
    xor eax, eax
    mov edi, 10      ; Base 10
convert_loop:
    movzx edx, byte [ecx]  ; Load the next ASCII character
    cmp edx, 0            ; Check for null terminator
    je  convert_done      ; If null terminator, conversion is done
    sub edx, '0'          ; Convert ASCII to integer ('0' -> 0, '1' -> 1, ..., '9' -> 9)
    imul eax, edi         ; Multiply the current result by 10
    add eax, edx          ; Add the new digit
    inc ecx               ; Move to the next character
    jmp convert_loop
convert_done:
    ret
