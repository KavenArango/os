[org 0x7c00]					; [] is a segment of memory 
[bits 16]					

section .text					;Main code indrigates entery point for code
	global main

main:
	mov si, LOADING
	call printf

	cli							; Removes interupts
	jmp 0x0000:ZeroSeg 			; Makes sure bios is clear and not doing anything

ZeroSeg:
	
	xor ax, ax 					; Takes up less space and sets ax to 0
	mov ss, ax
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov sp, main
	cld							; Clears directions flags
sti								; Reinstate interupts

push ax
xor ax, ax
mov dl, 0x80
int 0x13
pop ax 							; May need to be deleted unsure as of now


	mov al, 1
	mov cl, 2 
	call readDisk
	call printh
	jmp test
	jmp $ 					; Jumps to current location


	%include "Functions/printf.asm"
	%include "Functions/readDisk.asm"
	%include "Functions/printh.asm"



	;HELLO: db "Hello World",0x0a, 0x0d, 0 	; String
	LOADING: db "Loading...", 0x0a, 0x0d, 0
	DISK_ERR_MSG: db "Error Loading Disk", 0x0a, 0x0d, 0
	TESTSTR: db "Reading from the second sector.", 0x0a, 0x0d, 0


	;mov ah, 0x0e   		; Bios command the moves cursor forward to allow to latteral printing of chars
	;mov al, 'X'    		; Moves X into al reg
	;int 0x10       		; Bios inturpt to print to screen


							; padding and magic number

	times 510-($-$$) db 0		; This padds out the file size to 512 bytes 
							; ($-$$) current location - the starting location will give us the length we need to padd out the file to get 510
	dw 0xaa55					; This finishes adding the final 2 bytes and tells the computer this is a boot sector aka the magic number



test:
	mov si, TESTSTR
	call printf
times 512 db 0


	;section .data				; For constant variables
	;section .bss				; For variables that can be changed


	;mov si, HELLO				; Gets the mem address of STR and sets si to it
	;call printf				; Calls printf label