.pos 0x100
  ld $i, r0 #
  ld (r0), r0
  ld $j, r1
  ld (r1), r1
  ld $val, r2
  ld (r2), r2
  ld (r2, r0, 4), r3
  ld (r2, r1, 4), r4
  st r3, (r2, r1, 4)
  st r4, (r2, r0, 4)
  halt

#MEM
.pos 0x200
i:   .long 0

.pos 0x300
j:   .long 5

.pos 0x400
val: .long 0x500

#MALLOC AREA DYNAMIC 
.pos 0x500
      .long 0
      .long 1
      .long 2
      .long 3
      .long 4
      .long 5
      .long 6
      .long 7
      .long 8
      .long 9