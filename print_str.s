

; [Name]: print_str.s

; [Author]: Kiarash Sedghi

; [Description]: 
 		
; 		This file contains print functions.


print_str:

	mov bp , sp

	; Push registers we want to use in this function
	pusha

	; Setting video function as 0x0e to write char on screen
	mov ah,0x0e 

	; Moving the string base address into bx
	mov bx,[bp+0x02]


	_str_loop_:

		mov al,[bx]

		cmp al,0x00

		je _end_str_loop_

		inc bx

		int 0x10

		jmp _str_loop_



	_end_str_loop_:

		; Moving back all the registers
		popa

		ret


print_nl:

	; Push AX register

	push ax

	; Setting video function as 0x0e to write char on screen

	mov ah,0x0e

	; Print \n to the console
	mov al,0x0a

	int 0x10


	; Print \r to the console
	mov al,0x0d

	int 0x10

	pop ax

	ret


print_hex:

	mov bp , sp

	; Save all registers 
	pusha

	; Reading the wanted value into DX
	mov dx,[bp+0x02]
	mov ax,dx

	; Moving 4 bytes to DX and CX registers
	
	; right-first 4 bits
	and al,0x0f
	mov cl,al

	; right-second 4 bits
	mov al,dl
	and al,0xf0
	shr al,4
	mov ch,al


	; left-first 4 bits
	mov ah,dh
	and ah,0x0f
	mov dl,ah

	; left-second 4 bits
	mov ah,dh
	and ah,0xf0
	shr ah,4
	mov dh,ah

	call hex_to_char

	popa

	ret


hex_to_char:
	
	mov ah,0x0e

	add dh,0x30
	cmp dh,0x39

	jng h1
		add dh,0x07
	h1:
	mov al,dh
	int 0x10


	add dl,0x30
	cmp dl,0x39

	jng h2
		add dl,0x07
	h2:
	mov al,dl
	int 0x10



	add ch,0x30

	cmp ch,0x39

	jng h3
		add ch,0x07
	h3:
	mov al,ch
	int 0x10


	add cl,0x30
	cmp cl,0x39

	jng h4
		add cl,0x07
	h4:
	mov al,cl
	int 0x10


	ret 

