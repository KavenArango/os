printh:

mov si, HEX_PATTERN         ; moves HEX_PATTERN for printing

mov bx, dx
shr bx 12                   ; takes the first char and puts it in the ones spot
mov [HEX_PATTERN + 2], bl   




call printf

ret

HEX_PATTERN: db '0x****', 0x0a, 0x0d, 0