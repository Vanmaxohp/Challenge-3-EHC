section .data

	ip db "Nhap so: "
	lenip equ $-ip

	op0 db "> This is even number!!"
	lenop0 equ $-op0

	op1 db "This is odd number!!"
	lenop1 equ $-op1

	nl db 0xa, 0xd
	lennl equ $-nl

section .bss

	so resb 10
section .text

global _start
_start:

	;Yeu cau nhap so
	mov eax, 4
	mov ebx, 1
	mov ecx, ip
	mov edx, lenip
	int 0x80

	;Nhap so
	mov eax, 3
	mov ebx, 0
	mov ecx, so
	mov edx, 10
	int 0x80

	;Check chan le
	mov al, [so]
	and al, 01h   ;dung phep and de check, neu so chan thif zf=1, neu so le thi zf=0
	jz sochan

	;Neu la so le
	mov eax, 4
	mov ebx, 1
	mov ecx, op1
	mov edx, lenop1
	int 0x80
	jmp exit

	;Neu la so chan
	sochan:
	mov eax, 4
	mov ebx, 1
	mov ecx, op0
	mov edx, lenop0
	int 0x80

	;Ket thuc
	exit:
	mov eax, 1
	int 0x80

