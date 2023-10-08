Data segment
	blk1 db 90h,18h,54h,45h,36h,09h,27h,63h,72h,81h
	blk2 db 10 dup(?)
Data ends
Code segment
start : assume CS:Code, DS:Data
		mov ax,data
		mov ds,ax
		lea si,blk1
		lea di,blk2
		mov cl,0ah
up:mov al,[si]
	mov [di],al
	inc di
	inc si
	dec cl
	jnz up
	mov ah,4ch
	int 21h
code ends
end start