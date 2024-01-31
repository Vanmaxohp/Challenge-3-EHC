section .bss

	str1 resb 33
	num1 resb 33
	str2 resb 33
	num2 resb 33
	sum resb 33
	so_nho resb 2
	big_num resb 33

section .data

	msg1: db "Nhap so thu nhat: "
	len1 equ $ - msg1

	msg2: db "Nhap so thu hai: "
	len2 equ $ - msg2

	msg3: db "Tong cua 2 so la: "
	len3 equ $ - msg3

	msg4: db "Toi da 31 bit"
	len4 equ $ - msg4

    newline: db 0xa

section .text
	global _start
_start:

	mov word [str1], 0
	mov word [str2], 0
	mov word [sum], 0
	mov word [str1-8], 0
	mov word [str2-8], 0
	mov word [sum-8], 0
	mov word [str1-16], 0
	mov word [str2-16], 0
	mov word [sum-16], 0
	mov word [str1-24], 0
	mov word [str2-24], 0
	mov word [sum-24], 0

	mov rcx, msg1
	mov rdx, len1
	call in

	mov rcx, str1
	inc rcx
	mov rdx, 33
	call quet
	mov [num1], rax
	mov [big_num], rax
	cmp rax,31
	ja qualon

	mov rcx,msg2
	mov rdx,len2
	call in

	mov rcx,str2
	mov rdx,33
	call quet
	mov [num2], rax

	cmp rax,31
	ja qualon

	mov rax, [num1]
	mov rbx, [num2]
	cmp rax, rbx

	jb str1_big
	call addition_ok

xong:
	mov rcx,msg3
	mov rdx,len3
	call in

	mov rdi, sum
	inc rdi
	mov al, [edi]
	cmp al, '0'
	jne kq
	sub al, '0'
	mov [rdi], al
kq:
	mov rcx, sum
	add rcx, 1
	mov rdx, 33
	call in

	call thoat

str1_big:
	mov byte [big_num], 0
	mov [big_num], rbx

addition_ok:
	mov rax, str1
	mov rbx, str2
	add rax, [num1]
	dec rax
	add rbx, [num2]
	sub rbx, 2

cong:
	mov rdi, sum
	add rdi, [big_num]
	mov cl, [rax]
	cmp cl, 0
	je addcl

con1:
	mov dl, [rbx]
	cmp dl, 0
	jne con
	add dl, '0'

con:
	sub cl, '0'
	cmp cl, 20
	jb tren20
	mov cl, 0

tren20:
	sub dl, '0'
	add cl, dl
	add cl, [so_nho]

	mov byte [so_nho], 0
	cmp cl, 9
	ja tren9

nho:
	add cl, '0'
	mov [rdi], cl
	dec rax
	dec rbx
	dec rdi
	sub byte [big_num], 1
	mov rbp, [big_num]
	mov [big_num], rbp
	cmp rbp, 0
	je xong
	call cong

tren9:
	sub cl, 10
	mov byte [so_nho], 1
	call nho

qualon:
	mov rcx, msg4
	mov rdx, len4
	call in

	call thoat

quet:
	mov rax,3
	mov rbx,0
	int 80h
	ret

in:
	mov rax,4
	mov rbx,1
	int 80h
	ret

thoat:
	mov rax, 4
	mov rbx, 1
	mov rcx, newline
	mov rdx, 1
	int 80h
	mov rax,1
	int 80h

addcl:
	add cl, '0'
	jmp con1
