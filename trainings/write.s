.section .data

file: .asciz "/root/testfile"

result: .asciz "result is : %d\n"

uid: .asciz "uid id %d\n"

.section .text

.type main,@function 
.globl main

main:

  # SET UID 
  movl $23,%eax
  movl $0,%ebx
  int $128
  pushl %eax
  pushl $result
  call printf

  movl $24,%eax
  int $128
  pushl %eax
  pushl $uid
  call printf
  addl $8,%esp



  # CHMOD 

  movl $15,%eax
  movl $file,%ebx
  movl $0,%ecx

  int $128

  # CHMOD RES
  pushl %eax
  pushl $result
  call printf
  addl $8,%esp
  
  
  # EXIT
  movl $1,%eax
  movl $0,%ebx
  int $0x80


