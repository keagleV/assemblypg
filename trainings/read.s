# This code was written by Kiarash Sedghi on Aug 9 2021

# This file shows how to read file based on a specic byte per loop

.file "read.s"


.section .data
fileName:	.asciz "test"
openSuccess: .asciz "success\n"
openFail: .asciz "fail\n"

.section .bss
.lcomm buffer,50
.lcomm fd,4


.section .text	
.type main,@function
.globl main
main:	
	
	# opening file
	movl $5,%eax
	movl $fileName,%ebx
	movl $00,%ecx
	int $128

	# check for opening situation
	test %eax,%eax
	
	js openFailed

	# saving file descriptor
	movl %eax,fd


	readingLoop:	
		movl $3,%eax
		movl fd,%ebx
		movl $buffer,%ecx
		movl $50,%edx

		int $0x80

		cmpl $0,%eax
		movl $0,%ebx
		jz endProcess

		

		# showing buffer
		movl $4,%eax
		movl $1,%ebx
		movl $buffer,%ecx
		movl $50,%edx
		int $0x80


		# clear the previous buffer
		pushl %ecx
		movl %eax,%ecx
		inc %ecx
		memsetLoop:
			movb $0,buffer(,%ecx,1)
			dec %ecx
			jnz memsetLoop

		popl %ecx


		jmp readingLoop


openFailed:
	# exiting the process
	movl $4,%eax
	movl $1,%ebx
	movl $openFail,%ecx
	movl $5,%edx
	int $0x80

	movl $1,%ebx

endProcess:
	movl $1,%eax
	int $0x80

















