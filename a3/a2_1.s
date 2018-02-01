.pos 0x0
                 ld   $0x5, r0            # load 5 into r0
                 ld   $c, r1              # &c
                 st   r0, 0x0(r1)         # r1 = 5

                 ld   0x0(r1), r1         # load value of c into r1
                 ld   $0xa, r3            # load 10 into r3
                 add  r1, r3              # r3 = r1 +  r3
                 ld   $b, r2              # &b
                 st   r3, 0x0(r2)         # store r2 into memory

                 ld   $a, r4              # &a (load a)
                 ld   $0x8, r5            # r5 = 8
                 st   r5, (r4, r5, 4)     # a[8] = 8

                 ld   $0x4, r6            # r6 = 4
                 ld   (r4, r6, 4), r7     # r7 = a[4]
                 add  r6, r7              # a[4] + 4
                 st   r7, (r4, r6, 4)     # a[4] = a[4] + 4

                 ld (r4, r5, 4), r6       # r6 = a[8] use 8 and a from above
                 ld (r2), r7              # b
                 add r6, r7               #add a[8] + b
                 ld $0x7,r0               # r0 = 1
                 and r0, r7               # b & 0x7 or 7
                 ld (r4, r7, 4), r2       # a[b & 0x7]
                 add r2, r7               #a[8] + b   +   a[b & 0x7]
                 st r7, (r4, r1, 4)       #a[c] = a[8] + b + a[b & 0x7];





                 halt 

.pos 0x200
b:               .long 0xf                # int b
c:               .long 0x5                # int c
a:               .long 0x0                # int a
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x4                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x8                
                 .long 0x0                
