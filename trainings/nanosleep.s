.section .data
str: .ascii "this is kiarahs"

timespec: .int 5,0
r: .int 0,0



.type main,@function 
.globl main
main:   
  movl $timespec,%ebx
  movl $r,%ecx
  movl $162,%eax
  int $128

  movl $4,%eax
  movl $1,%ebx
  movl $str,%ecx
  movl $15,%edx
  int $0x80

  movl $0,%ebx
  movl $1,%eax
  int $0x80



