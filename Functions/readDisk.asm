readDisk:
	pusha
	mov ah, 0x02		; Preps for reading to the drive moves ah to 0x02
	mov dl, 0x80 		; If booting from a HD this should be 0x80 if booting from a CD/Flash Drive/Floppy Drive then this should be 0x0 dl is the starting sector if being run in a vm or hardware this needs to be 0x0
	mov ch, 0			; Selects the starting cylinder which is the first one
	mov dh, 0 			; Selects the first head which is the first one
	;mov al, 1			; Selects the number of sectors we want to read which will just be the next sector
	;mov cl, 2			; Selects the sector to start reading we want the second one the first one is the boot sector which is already being read
	
						; Need to move segment register to Zero
	
	push bx				; pushs all items in bx to stack
	mov bx, 0			; sets bx to 0 removing the buffer
	mov es, bx			; sets bx to es
	pop bx				; pops bx from the stack
	mov bx, 0x7c00 + 512	; moves bx to after the boot sector
	int 0x13	
	
	jc disk_err			; checks for errors in while reading the disk
	popa
	ret

	disk_err:
		mov si, DISK_ERR_MSG
		call printf
		jmp $