// RAM[4] = (RAM[0] * 3 + (RAM[1] | RAM[2])) & !RAM[3] + 11


@1
D = A
@2
D = D | A

@0
D = D + A
D = D + A
D = D + A

@3
D = !D
D = D | A
D = !D

@4
A = 11
A = D + A