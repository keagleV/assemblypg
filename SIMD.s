# This code was written by Kiarash Sedghi on Aug 4 2021.
#
# Target: 
#       This code implements Intel SIMD technology
# Help:
#       Just push the 32 bit value to the stack and call the stack.
#       Desired value will bit 32 to bit which can be retrieved by
#       poping back to a register.



.file "SIMD.s"


# adding 4 * 8 bits
SIMD_f32sum4:
    
     # saving ebp register
    pushl %ebp
    
    # set ebp to stack pointer
    movl %esp,%ebp
    
    # saving eax register
    pushl %eax 
    
    # moving the desired number to eax
    movl 8(%ebp),%eax
    
    # pushing lower 16bit to the stack
    pushw %ax
    
    # shifting the higher 16bit to lower 16bit
    sar $16,%eax
    
    # adding the lower 16bits together
    addb %ah,%al
    
    # adding next byte from stack
    addb (%esp),%al
    
    # adding next byte from stack
    addb 1(%esp),%al
    
     # poping back the lower 16bit to NULL
    addl $2,%esp
    
    # setting the higher 24bit to 0 while preserving the 
    # lower 8bit
    andl $0x000000ff,%eax
    
    # moving the new value to the original value
    movl %eax,8(%ebp)
    
    
    popl %eax
    
    popl %ebp
    
    
    ret
    
    
    
# adding 2 * 16 bits       
SIMD_f32sum2:

    # saving ebp register
    pushl %ebp
    
    # set ebp to stack pointer
    movl %esp,%ebp
    
    # saving eax register
    pushl %eax 
    
    # moving the desired number to eax
    movl 8(%ebp),%eax
    
    # pushing lower 16bit to the stack
    pushw %ax
    
    # shifting the higher 16bit to lower 16bit
    sar $16,%eax
    
    # adding the lower 16bit to higher 16bit
    addw (%esp),%ax
    
    # poping back the lower 16bit to NULL
    addl $2,%esp
    
    # setting the higher 16bit to 0 while preserving the 
    # lower 16bit
    andl $0x0000ffff,%eax
    
    # moving the new value to the original value
    movl %eax,8(%ebp)
    
    
    popl %eax
    
    popl %ebp
    
    
    ret
    


.section .text


.globl main
main:
  movl $0x11020304,%eax    
  
  pushl %eax
  
  call SIMD_f32sum4
  
  popl %ebx
  
  movl $1,%eax
  
  int $0x80
    

