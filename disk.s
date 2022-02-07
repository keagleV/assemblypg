

load_from_disk:
	
	pusha

	mov ah,0x02
	mov al,0x01
	mov bx,0x9000
	mov es,bx
	mov bx,0x0000

	mov ch,0x01
	mov cl,0x01

	mov dh,0x00

	mov dl,0x80


	int 0x13

	jc error_loading

	jmp end



error_loading:
	
	mov bx,ERROR

	call print_str
	

end:
	popa
	ret


ERROR: db 'Error loading from disk',0x00
SUCCESS: db 'Success'




