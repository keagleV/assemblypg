# This code was written by Kiarash Sedghi on Aug 4 2021.
#
# Target: 
#       This code implements integer extension analyzer. f16to32 function
#       will convert 16 bit interger to 32 bit integer value.


.file "f16to32.s"


.section .text


f16to32:
    ## Help: push the 16 bit value to the stack before calling
    ## this function.
    
    # saving cx regiger
    pushw %cx
    
    # move the 16bit value from stack to the register
    movw 6(%esp),%cx
    
    # saving eax register to the stack
    pushl %eax
    movl $0,%eax
    
    # moving the 16 bit of cx to ax register
    movw %cx,%ax

    
    # check the most significant bit to find out the sign.
    shl %cx
    
    # if it has carry then we should load with 1s
    jc f16to32_load_negative
    
    jmp f16to32_end
    
f16to32_load_negative:
# using or to set the higher 16bit to 1 and leave the lower 16bit
# unchanged
or $0xffff0000,%eax
       
f16to32_end:
     # poping back the registers.
     
     # since the goal is to put the result in to the stack, the 
     # following codes will change the stack a little bit to form
     # it eventually to the following:
        #      ----------
        #     |  Result  | bottom of the stack
        #     |----------|
        #     |    IP    | top of the stack
        #
        #
     pushl %eax
     # moving IP to eax
     movl 10(%esp),%eax
     
     pushl %eax
     
     # the 32 bit answer value on the bottom of the stack
     movl 8(%esp),%eax
     movl %eax,16(%esp)
    
     # returning cx back
     movw 12(%esp),%cx
    
    
     # returning the Instruction pointer to the top of the stack
     popl %eax
     movl %eax,8(%esp)
    
     # returning eax
     popl %eax
     
     subl $4,%esp
     
     ret


.globl main
main:
    movw $-157,%cx
    pushw %cx
    
    
    call f16to32
    
    popl %eax
    
 
    

