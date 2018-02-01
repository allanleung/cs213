.pos 0x1000
    ld $s, r0      # load address of s in r0
    ld (r0), r0    # load value of s in r0, address of d1
    ld (r0), r1    # load value of s in r1, address of d2
    ld 4(r0), r2   # load address d1 into r2
    ld 4(r1), r3   # load address d2(value 2) into r3 
    st r3, (r2)    # store value of r3 into r2, which is the address of d1
    ld 4(r2), r3   # load address of d1, offset 4 and put in r3, address of d2
    st r3, (r1)    # store value of r3 into r1, r1 is address of d2
    halt                     

.pos 0x2000
s:  .long d0 # int * s = d0
# END OF STATIC ALLOCATION

# DYNAMICALLY ALLOCATED HEAP SNAPSHOT
# (malloc'ed and dynamically initialized in c version)
d0: .long d1 # int * d0 = d1
    .long d2 
d1: .long 1 
    .long 2
d2: .long 3
    .long 4
