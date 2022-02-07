

load_from_disk:
	
	pusha

	mov ah,0x02
	mov al,0x01
	mov bx,0x9000
	mov es,bx
	mov bx,0x0000

	mov ch,0x01
	mov cl,0x02

	mov dh,0x00

	; mov dl,0x80


	int 0x13
	; jmp $

	jc error_loading
	mov bx,SUCCESS
	
	push bx
	call print_str
	pop bx
	
	jmp end



error_loading:
	
	mov bx,ERROR
	
	push bx
	call print_str
	pop bx

end:
	popa
	ret


ERROR: db 'Error loading from disk',0x00
SUCCESS: db 'Success',0x00




