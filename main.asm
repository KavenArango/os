org 0x7c00

mov si, HELLO			; Gets the mem address of STR and sets si to it
call printf			; Calls printf label

mov al, 1
mov cl, 2
call readDisk

jmp test


jmp $ 				; Jumps to current location



printf:
	pusha			; Can only be used in 16bit real mode pushes everything to the stack

	str_loop: 		; This will run no mater what since assimbaly runs everything unless told not to by a jump to skip over the code so after the pusha it will run this label 
		mov al, [si]	; [si] loads address of si
		cmp al, 0	; Compare al to 0 if there is a 0 then the next instruction will varify and continue
		jne print_char	; Goes to print_char // jump if not equal to
		popa		; Brings back everything from the stack
		ret		; Return to where it was called

	print_char:
		mov ah, 0x0e 	; Bios command the moves cursor forward to allow to latteral printing of chars
		int 0x10	; Bios inturpt to print to screen
		add si, 1	; Add 1 to si to shift it over one
		jmp str_loop	; Jumpt back to string loop


readDisk:
	pusha
	mov ah, 0x02		; Preps for reading to the drive moves ah to 0x02
	mov dl, 0x0 		; If booting from a HD this should be 0x80 if booting from a CD/Flash Drive/Floppy Drive then this should be 0x0 dl is the starting sector if being run in a vm or hardware this needs to be 0x0
	mov ch, 0		; Selects the starting cylinder which is the first one
	mov dh, 0 		; Selects the first head which is the first one
	;mov al, 1		; Selects the number of sectors we want to read which will just be the next sector
	;mov cl, 2		; Selects the sector to start reading we want the second one the first one is the boot sector which is already being read
				
				; Need to move segment register to Zero
	
	push bx			; pushs all items in bx to stack
	mov bx, 0		; sets bx to 0 removing the buffer
	mov es, bx		; sets bx to es
	pop bx			; pops bx from the stack
	mov bx, 0x7c00 + 512	; moves bx to after the boot sector
	int 0x13	
	
	jc disk_err		; checks for errors in while reading the disk
	popa
	ret

	disk_err:
		mov si, DISK_ERR_MSG
		call printf
		jmp $



HELLO: db "Hello World",0x0a, 0x0d, 0 	; String
DISK_ERR_MSG: db "Error Loading Disk", 0x0a, 0x0d, 0
TESTSTR: db "Reading from the second sector.", 0x0a, 0x0d, 0


;mov ah, 0x0e   		; Bios command the moves cursor forward to allow to latteral printing of chars
;mov al, 'X'    		; Moves X into al reg
;int 0x10       		; Bios inturpt to print to screen



; padding and magic number

times 510-($-$$) db 0		; This padds out the file size to 512 bytes 
				; ($-$$) current location - the starting location will give us the length we need to padd out the file to get 510
dw 0xaa55			; This finishes adding the final 2 bytes and tells the computer this is a boot sector aka the magic number



test:
	mov si, TESTSTR
	call printf
times 512 db 0
