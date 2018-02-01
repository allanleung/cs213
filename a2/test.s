ld $0x2000, r0
ld 4(r0), r1
ld 8(r0), r2
ld 12(r0), r3
ld 16(r0), r4
ld 20(r0), r5
ld 24(r0), r6
ld 28(r0), r7

ld $0x0A, r2
ld (r0,r2,4), r3
st r4,4(r1)
st r2, (r0,r2,4)

mov r2, r5
add r5, r1
and r5, r3
inc r5
inca r3
dec r2
deca r2
not r5

shl $0x2, r6
shr $0x2, r7


halt
nop

.pos 0x2000
a: .long 0x00000001
b: .long 0x00000002
c: .long 0x00000004
d: .long 0x00000008
e: .long 0x00000010
f: .long 0x00000020
g: .long 0x00000040
h: .long 0x00000080
i: .long 0x00000100
j: .long 0x00000200
k: .long 0x00000400

