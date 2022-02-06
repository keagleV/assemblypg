

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