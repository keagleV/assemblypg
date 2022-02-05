
; This assembly code, demonstrates how
; we can change the CS register with
; assembly instructions.

; Possible ways are:
; 	1) JMP/CALL instructions
; 	2) Interrupts



; Setting stack segment register and stacj pointer
	mov ax,0x0000
	mov ss,ax
	mov sp,0x1000


; Push new values for IP and CS to the stack

push 0x1000	; Pushing CS
push 0x1234	; Pushing IP


; Loading new instructions in to the 
; memory at new address CS:IP we pushed
; to the stack

; Setting data segment register 
mov ax,0x1000
mov ds,ax	; Set ds as the new CS
mov bx,0x1234 ; Set bx as a pointer to memory equal to new IP

; Loading below instruction
;	jmp $    -> infinite loop
mov cl,0xeb
mov ch,0xfe
mov [bx],cl
mov [bx+0x01],ch


; Calling IRET will pop the new IP and CS to the appropriate 
; registers
iret

jmp $
