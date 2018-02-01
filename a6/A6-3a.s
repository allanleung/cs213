.pos 0x0
                 ld   $sb, r5             # load the address of sb
                 inca r5                  # setting the return address
                 gpc  $0x6, r6            # pc counter
                 j    0x300               
                 halt                     
.pos 0x100
                 .long 0x1000             
.pos 0x200
                 ld   0x0(r5), r0         # load from stack and store in r0
                 ld   0x4(r5), r1         # load from stack 4 offset down in r1
                 ld   $0x100, r2          # load address of the array into r2
                 ld   0x0(r2), r2         # load the value from that array 
                 ld   (r2, r1, 4), r3     # load the [4] from the array
                 add  r3, r0              # add r3 into r0
                 st   r0, (r2, r1, 4)     # store r0 into the [4] posotion in the array
                 j    0x0(r6)             # jump back to return value (ie main function)
.pos 0x300
                 ld   $0xfffffff4, r0     # make space for stack -12 (3 arg, 1 return, 2 arg)
                 add  r0, r5              # add whatever in stack to r5
                 st   r6, 0x8(r5)         # store the return pointer in stack
                 ld   $0x1, r0            # load 1 into r0
                 st   r0, 0x0(r5)         # store 1 into 0 offset from the stack
                 ld   $0x2, r0            # load 2 into r0
                 st   r0, 0x4(r5)         # store 2 into 4 offset from the stack
                 ld   $0xfffffff8, r0     # load -8 into r0
                 add  r0, r5              # deallocating the call stack
                 ld   $0x3, r0            # load 3 into r0
                 st   r0, 0x0(r5)         # store 3 into the stack
                 ld   $0x4, r0            # load 4 into r0
                 st   r0, 0x4(r5)         # store r into the stack, 4 offset down from previous spot
                 gpc  $0x6, r6            # store return address in r6
                 j    0x200               # jump to 0x200
                 ld   $0x8, r0            # load 8 into r0
                 add  r0, r5              # deallocating the call stack 
                 ld   0x0(r5), r1         # load value of r1 into bottom of the stack
                 ld   0x4(r5), r2         # load value of r2 into the second bottom of the stack
                 ld   $0xfffffff8, r0     # load value of -8 (total = 2 arg, 1 return, 1 arg)
                 add  r0, r5              # deallcating the call from stack
                 st   r1, 0x0(r5)         # store a arg to stack
                 st   r2, 0x4(r5)         # store b arg to stack
                 gpc  $0x6, r6            # store return address to r6 (come back later)
                 j    0x200               # jump to 0x200 (other method)
                 ld   $0x8, r0            # load 8 into r0
                 add  r0, r5              # deallocating the call from stack
                 ld   0x8(r5), r6         
                 ld   $0xc, r0            
                 add  r0, r5              
                 j    0x0(r6)             
.pos 0x1000
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
