.pos 0x0
                 ld   $0x1028, r5         # load         
                 ld   $0xfffffff4, r0     # load making 3 space    
                 add  r0, r5              # allocating 3 space       
                 ld   $0x200, r0          # load adress of x
                 ld   0x0(r0), r0         # getting value of x
                 st   r0, 0x0(r5)         # store x into stack
                 ld   $0x204, r0          # load address y
                 ld   0x0(r0), r0         # get the value of y
                 st   r0, 0x4(r5)         # store y into stack
                 ld   $0x208, r0          # load z into r0
                 ld   0x0(r0), r0         # get value of z
                 st   r0, 0x8(r5)         # store z into stack
                 gpc  $6, r6              # store return value 
                 j    0x300               # jump to 300
                 ld   $0x20c, r1          # get the value of d
                 st   r0, 0x0(r1)         # store r
                 halt                     
.pos 0x200
 x:                .long 0x00000001         
 y:                .long 0x00000002         
 z:                .long 0x00000003         
 w:                .long 0x00000000         
.pos 0x300
                 ld   0x0(r5), r0         # load x into r0
                 ld   0x4(r5), r1         # load y into r1
                 ld   0x8(r5), r2         # load z into r2
                 ld   $0xfffffff6, r3     # load -10 into r3
                 add  r3, r0              # add r0 = x - 10
                 mov  r0, r3              # move r3 = x -10
                 not  r3                  # not !r3
                 inc  r3                  # r3 = -(x-10) = -x + 10 = 10 - x
                 bgt  r3, L6              # if (10 - x) > 0, then go to L6 
                                          #(OR if (-x > -10) then go to L6 OR if (x < 10) then go to L6)
                 mov  r0, r3              # r3 = x - 10
                 ld   $0xfffffff8, r4     # load r4 = -8
                 add  r4, r3              # add r3 = r4 + r3 OR r3 = - 8 + (x - 10) OR r3 = x - 18
                 bgt  r3, L6              # if (x - 18) > 0 OR if (x > 18), then go to L6 
                 ld   $0x400, r3          # load address of JUMPTABLE into r3 
                 j    *(r3, r0, 4)        # jump to index (x - 10) of the table
.pos 0x330
                 add  r1, r2              # add y = x + y
                 br   L7                  # branch to L7
                 not  r2                  # not r2 !r2 
                 inc  r2                  # add 1 to r2 (two comp)
                 add  r1, r2              # y = (new x) + y 
                 br   L7                  # branch to L7
                 not  r2                  # !r2
                 inc  r2                  # y + 1
                 add  r1, r2              # y = x + y
                 bgt  r2, L0              # if (y > 0), then go to L0
                 ld   $0x0, r2            # load r2 = 0 OR z = 0
                 br   L1                  # branch to L2
L0:              ld   $0x1, r2            # load r2 = 1
L1:              br   L7                  # branch to L7
                 not  r1                  # r1 = !y
                 inc  r1                  # r1 = (!y) + 1
                 add  r2, r1              # r1 = y = ((!y) + 1) + z
                 bgt  r1, L2              # if (((!y) + 1) + z > 0), then go to L2
                 ld   $0x0, r2            # load r2 = 0 OR z = 0
                 br   L3                  # branch to L3
L2:              ld   $0x1, r2            # load r2 = 1 OR z = 1
L3:              br   L7                  # branch to L7
                 not  r2                  # r2 = !z
                 inc  r2                  # r2 = (!z) + 1
                 add  r1, r2              # r2 = z = (!z) + 1 + y
                 beq  r2, L4              # if ((!z) + 1 + y == 0), then go to L4 
                 ld   $0x0, r2            # r2 = z = 0
                 br   L5                  # branch to L5
L4:              ld   $0x1, r2            # r2 = z = 1
L5:              br   L7                  # branch to L7
L6:              ld   $0x0, r2            # r2 = 0 or z = 0
                 br   L7                  # branch to L7
L7:              mov  r2, r0              # move r2 to r0 or move z to x
                 j    0x0(r6)             # return r2 OR return z
.pos 0x400
                 .long 0x00000330  # case 10        
                 .long 0x00000384  # case 11 = default        
                 .long 0x00000334  # case 12       
                 .long 0x00000384  # case 13 = default       
                 .long 0x0000033c  # case 14      
                 .long 0x00000384  # case 15 = default      
                 .long 0x00000354  # case 16    
                 .long 0x00000384  # case 17 = default
                 .long 0x0000036c  # case 18 
.pos 0x1000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         