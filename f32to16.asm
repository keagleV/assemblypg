# This code was written by Kiarash Sedghi on Aug 4 2021.
#
# Target: 
#       This code implements integer extension analyzer. f32to16 function
#       will check whether it is possible to convert a 32bit value
#       to 16bit value or not.

.file "f32to16.asm"





.section .text


f32to16:

    ## Help: push the 32 bit value that you want to check
    ## to the stack before calling the function.
    
    # saving eax register by pushing to the stack
    pushl %eax
    
    # load the 32 bit from the stack to eax which is the 32bit value
    # you wanted to check.
    movl 8(%esp),%eax
    
 
    # setting counter register (%edi register)
    pushl %edi
    
    # set the counter to 16 which is the number of bits to check
    # for converting from 32bit to 16bit
    movl $16,%edi
    
    # testing for positive or negative sign of the number.
    sal %eax
    
    # negative number since the shift instrction had carry.
    jc f32to16_checkN_loop
    
    # This loop checks the positive eligibility.
    f32to16_checkP_loop:
    
        sal %eax
        jc f32to16_check_endFail
        dec %edi
        jnz f32to16_checkP_loop
            
        # It is eligibile, so put 1 as yes to the place in the stack
        # where your number was pushed before calling the function    
        movl $1,12(%esp)

    
        jmp f32to16_success
    
    
    
    # This loop checks the negative eligibility.
    f32to16_checkN_loop:
        sal %eax
        jnc f32to16_check_endFail
        dec %edi
        jnz f32to16_checkN_loop
        
        movl $1,12(%esp)

        

f32to16_check_endFail:
    movl $0,4(%esp)
f32to16_success:

# pop all the previously pushed registers back
popl %edi
popl %eax
ret       
    
    
         
                               

 
    
    



.globl main
main:
    movl $0xffff6f00,%eax
    pushl %eax
    
    
    call f32to16
    
    
    # Show the result as the exit code of the program.
    # 1: yes is possible
    # 0: no is not possible
    popl %ebx
    movl $1,%eax
    int $0x80
    

