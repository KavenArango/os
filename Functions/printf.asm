printf:
	pusha				; Can only be used in 16bit real mode pushes everything to the stack

	str_loop: 			; This will run no mater what since assimbaly runs everything unless told not to by a jump to skip over the code so after the pusha it will run this label 
		mov al, [si]	; [si] loads address of si
		cmp al, 0	    ; Compare al to 0 if there is a 0 then the next instruction will varify and continue
		jne print_char	; Goes to print_char // jump if not equal to
		popa			; Brings back everything from the stack
		ret				; Return to where it was called

	print_char:
		mov ah, 0x0e 	; Bios command the moves cursor forward to allow to latteral printing of chars
		int 0x10		; Bios inturpt to print to screen
		add si, 1		; Add 1 to si to shift it over one
		jmp str_loop	; Jumpt back to string loop
