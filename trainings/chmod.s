
.section .data
filePath: .asciz "/home/keagle/Documents/assemblyProgs/NN"
pr: .int 511

# chmod
# 15-> eax
# path-> ebx
# pr -> ecx


.type main,@function
.globl main
main:

  
  movl $15,%eax
  movl $filePath,%ebx
  movl pr,%ecx

  int $128

  # syscall exit
  movl $1,%eax
  movl $22,%ebx
  int $0x80






