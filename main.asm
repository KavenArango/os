org 0x7c00
mov si, STR			; gets the mem address of STR and sets si to it
call printf			; calls printf label

jmp $ 				; jumps to current location



printf:
	pusha			; can only be used in 16bit real mode pushes everything to the stack


	str_loop: 		; this will run no mater what since assimbaly runs everything unless told not to by a jump to skip over the code so after the pusha it will run this label 
		mov al, [si]	; [si] loads address of si
		cmp al, 0	; compare al to 0 if there is a 0 then the next instruction will varify and continue
		jne print_char	; goes to print_char // jump if not equal to
		popa		; brings back everything from the stack
		ret		; return to where it was called
		


	print_char:
		mov ah, 0x0e 	; bios command the moves cursor forward to allow to latteral printing of chars
		int 0x10	; bios inturpt to print to screen
		add si, 1	; add 1 to si to shift it over one
		jmp str_loop	; jumpt back to string loop



STR: db "Hello World", 0 	; string




;mov ah, 0x0e   		; bios command the moves cursor forward to allow to latteral printing of chars
;mov al, 'X'    		; moves X into al reg
;int 0x10       		; bios inturpt to print to screen




; padding and magic number

times 510-($-$$) db 0		; this padds out the file size to 512 bytes 
				; ($-$$) current location - the starting location will give us the length we need to padd out the file to get 510
dw 0xaa55			; this finishes adding the final 2 bytes and tells the computer this is a boot sector aka the magic number
