mov ah, 0x0e	; bios command the moves cursor forward to allow to latteral printing of chars
mov al, 'X'	; moves X into al reg
int 0x10	; bios inturpt to print to screen

jmp $ 		;jumps to current location





; padding and magic number

times 510-($-$$) db 0	; this padds out the file size to 512 bytes 
			; ($-$$) current location - the starting location will give us the length we need to padd out the file to get 510
dw 0xaa55	; this finishes adding the final 2 bytes and tells the computer this is a boot sector aka the magic number
