.section .data






.type main,@function
.globl main
main:
  movl $109 , %eax
  movl $uname,%ebx
  int $0x80

  pushl %eax
  pushl $result
  call printf

  pushl $nodename
  pushl $q
  call printf










