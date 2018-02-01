.pos 0x100
start:           ld   $sb, r5             # load the stack
                 inca r5                  # load the
                 gpc  $0x6, r6            # store return address into r6
                 j    main                # jump to main function
                 halt                     # stop
f:               deca r5                  # make stack space argument
                 ld   $0x0, r0            # load 0 into r0
                 ld   0x4(r5), r1         # load the second value from the stack into r1
                 ld   $0x80000000, r2     # load that 0x80000000 into r2
f_loop:          beq  r1, f_end           # if r1 = value from stack, end
                 mov  r1, r3              # move
                 and  r2, r3              
                 beq  r3, f_if1           
                 inc  r0                  
f_if1:           shl  $1, r1              
                 br   f_loop              
f_end:           inca r5                  
                 j    0x0(r6)             
main:            deca r5                  # make stack space
                 deca r5                  # make stack space
                 st   r6, 0x4(r5)         # puts return value in the bottom of the stack
                 ld   $0x8, r4            # load 8 into r4
main_loop:       beq  r4, main_end        # if r4 = 0, go to end
                 dec  r4                  # r4 -1 or i-- starting at 8
                 ld   $x, r0              # load address of x into r0
                 ld   (r0, r4, 4), r0     # accessing the r4's (index)element in the array // some kind array load
                 deca r5                  # making space for argument
                 st   r0, 0x0(r5)         # storing argument from r0 into the stack
                 gpc  $0x6, r6            # store return address to r6
                 j    f                   # function call to f (results from function always store in r0)
                 inca r5                  # deallocating space for arg
                 ld   $y, r1              
                 st   r0, (r1, r4, 4)     # index store into y at r4
                 br   main_loop           # for loop of some kind
main_end:        ld   0x4(r5), r6         
                 inca r5                  
                 inca r5                  
                 j    0x0(r6)             
.pos 0x2000
x:               .long 0x1                
                 .long 0x2                
                 .long 0x3                
                 .long 0xffffffff         
                 .long 0xfffffffe         
                 .long 0x0                
                 .long 0xb8               
                 .long 0x1444dbe2         
y:               .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
.pos 0x8000
                 .long 0x0                # These are here so you can see (some of) the stack contents.
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
sb:              .long 0x0                
