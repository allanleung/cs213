.pos 0x100
                 ld   $i, r0              # r0 = i pointer POINTING AT C YO!
                 ld   0x0(r0), r0         # r0 = 5
                 mov  r0, r1              # r1 = 5
                 mov  r0, r2              # r2 = 5
                 ld   $0x2, r3            # r3 = 2
                 ld   $0x1, r4            # r4 = 1
                 add  r3, r1              # r1 = i + 2
                 add  r4, r2              # r2 = i + 1
                 ld   $a, r3              # r3 = &a
                 ld   $b, r4              # r4 = &b
                 ld   (r3, r2, 4), r5     # r5 = a[i + 1]
                 ld   (r4, r1, 4), r6     # r6 = b[i + 2]
                 add  r5, r6              # add a[i + 1] + b[i + 2]
                 st   r6, (r3, r0, 4)     # a[i] =  a[i + 1] + b[i + 2]

                 
                 ld   (r3, r0, 4), r1     # r1 = a[i]
                 ld   (r4, r0, 4), r2     # r2 = b[i]
                 add  r1, r2              # r2 = a[i] + b[i]
                 ld   $d, r3              # &d
                 st   r2, (r3, r0, 4)     # d[i] = a[i] + b[i] into mem

                 ld   $a, r3              # r3 = & a
                 ld   (r3, r0, 4), r1     # r1 = a[i]
                 ld   (r4, r0, 4), r2     # r2 = b[i]
                 ld   (r3, r2, 4), r2     # a[b[i]]
                 ld   (r4, r1, 4), r1     # b[a[i]]
                 add  r1, r2              # r2 = a[b[i]] + b[a[i]]
                 ld   $d, r3              # r3 = & d
                 st   r2, (r3, r0, 4)     # d[i] = a[b[i]] + b[a[i]];

                 mov  r0, r1               
                 ld   $0x3, r2            # r2 = 3
                 and  r2, r1              # r1 = i & 3
                 ld   (r4, r1, 4), r5     # r5 = b[i & 3]
                 and  r2, r5              
                 ld   $a, r3              # r3 = &a
                 ld   (r3, r5, 4), r5     # r5 = a[b[i & 3] & 3]
                 ld   (r3, r1, 4), r6     # r6 = a[i & 3]
                 and  r2, r6              # r6 = [a[i & 3] & 3]
                 ld   (r4, r6, 4), r6     
                 ld   $0x1, r7            
                 not  r5                  # two comp (flip it)
                 add  r7, r5              # add 1
                 add  r6, r5              # r5 = b[a[i & 3] & 3] - a[b[i & 3] & 3]
                 ld   $d, r2              # r2 = %d
                 ld   (r2, r0, 4), r1     # r1 = d[i]
                 add  r1, r5              # r5 = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i];
                 ld   (r4, r0, 4), r3     # r3 = b[i]
                 st   r5, (r2, r3, 4)     # store to memory d[b[i]] = b[a[i & 3] & 3] - a[b[i & 3] & 3] + d[i]
                 halt                     # stop
.pos 0x200
a:               .long 0x0                # 0x200
                 .long 0xb                # 0x204
                 .long 0x2                # 0x208
                 .long 0x0                # 0x20c
                 .long 0x1                # 0x210
                 .long 0x1                # 0x214
                 .long 0x0                # 0x218
                 .long 0x1                # 0x21c
b:               .long 0x2                # 0x220
                 .long 0xc                # 0x224
                 .long 0x0                # 0x228
                 .long 0x2                # 0x22c
                 .long 0x1                # 0x230
                 .long 0x0                # 0x234
                 .long 0x2                # 0x238
                 .long 0x1                # 0x23c
c:               .long 0x63               # 0x240
                 .long 0x6                # 0x244
                 .long 0x2                # 0x248
                 .long 0x1                
                 .long 0x0                
                 .long 0x2               
                 .long 0x1                
                 .long 0x0                
i:               .long 0x5                # 0x260
d:               .long 0x240              # 0x264
