Data segment
	str1 db "hello$"
	mlength db 10,13, "Length is: $"
	len db ?
Data ends
Code segment
start : assume  cs :code,  ds :data
	mov ax , data
	mov ds ,ax
	LEA si ,str1
up: mov al, [si]
	cmp al , "$"
	jz exit1
	inc si
	inc len
	jmp up
	
exit1:
	mov dx,offset mlength; Display contents of variable msg1
	mov ah,09h
	int 21h
	
	call AsciiConv ; Convert to ASCII to display

	mov dl,len ; Display a Number/Alphabet
	mov ah,02h
	int 21h

	mov ah,4ch ; Terminate the program
	int 21h

 AsciiConv proc ; Compare to 0a if it is less than A then we need to add only 30
	cmp len,0ah ; If it is greater than or equal to 0a then we also need to add 07
	jc skip
	add bl,07h
	skip: add len,30h
	ret
	endp
Code ends
end start