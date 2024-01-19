section .data

	ip db 'Input anythings here: ', 0
	lenip equ $-ip

	op db 'Your string entered: ', 0
	lenop equ $-op

	er db 'Your strings entered is not contain lower case.'
	lener equ $-er

	nl db 0xa, 0xd, 0
	lennl equ $-nl

section .bss

	input resb 32
	output resb 32

section .text

global _start
_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, ip
	mov edx, lenip
	int 0x80

	mov eax, 3
	mov ebx, 0
	mov ecx, input
	mov edx, 32
	int 0x80

	;Kiem tra chu thuong trong input
        mov edi, input
        call chuthg
        cmp al, 0     ;Neu thanh ghi al co gia tri la 0 thi nhay den kocochuthg
        jz kocochuthg

	;Nhap chuoi ki tu va chuyen doi
	mov edi, input
	mov esi, output
	call chuyendoi

	mov eax, 4
	mov ebx, 1
	mov ecx, op
	mov edx, lenop
	int 0x80

	;In ra output
	mov eax, 4
	mov ebx, 1
	mov ecx, output
	mov edx, 32
	int 0x80
	jmp ketthuc

kocochuthg:
	mov eax, 4
	mov ebx, 1
	mov ecx, er
	mov edx, lener
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, nl
	mov edx, lennl
	int 0x80
	jmp ketthuc

chuyendoi:
	;vong lap cac ky tu trong day input (thanh ghi edi) va xuat ra thanh ghi esi
	mov eax, 0
	vonglap:
	movzx ecx, byte [edi + eax] ;Nhap chu tiep theo
	test ecx, ecx		;Kiem tra ky tu \0
	jz xong
	cmp ecx, 'a'		;So sanh voi chu a
	jl tiep
	cmp ecx, 'z'		;So sanh voi chu z
	jg tiep
	sub ecx, 32		;Tru di 32 de chuyen doi thanh chu hoa
	mov [esi + eax], cl	;Luu ket qua
	tiep:
	inc eax 		;rax += 1
	mov [esi + eax], cl
	jmp vonglap
	xong:
	ret

chuthg:
	;Kiem tra xem trong chuoi ky tu co chu thg hay ko voi dau vao la thanh rdi
        ;Xoa gia tri cu trong thanh ghi
	mov al, 0
vonglapchuthg:
	movzx ecx, byte [edi]	;Chu tiep theo
	test  ecx, ecx		;Kiem tra ky tu \0
	jz    cochuthg
	cmp   ecx, 'a'		;So sanh voi ky tu a
	jl    chuthgtiep
	cmp   ecx, 'z'		;So sanh voi ky tu z
	jg    chuthgtiep
	inc   al		;Neu cos chu thg thi tang gia tri thanh al len 1
	jmp   cochuthg
chuthgtiep:
	inc   edi
	jmp   vonglapchuthg
cochuthg:
	ret

ketthuc:
	mov eax, 1
	mov ebx, 0
	int 0x80
