.pos 0x100
                 ld   $i, r0              # r0 = %i
                 ld   0x0(r0), r0         # r0 = i
                 ld   $j, r1              # r1 = &j
                 ld   0x0(r1), r1         # r1 = j
                 ld   $val, r2            # r2 = &val
                 ld   (r2, r0, 4), r3     # r3 = val[i]
                 ld   (r2, r1, 4), r4     # r4 = val[j]
                 st   r3, (r2, r1, 4)     # r2 = val[j]
                 st   r4, (r2, r0, 4)     # r2 = val[i]
                 halt                     # stop
.pos 0x200
i:               .long 0x0                # MEM
j:               .long 0x2                
val:             .long 0x3                
                 .long 0x2                
                 .long 0x1                
                 .long 0x4                
