print macro msg
	lea dx,msg
	mov ah,09h
	int 21h
endm

read macro n,j1,j2
	mov cx,0ah
j1:mov ah,01h
	int 21h
	cmp al,0dh
	je j2
	sub al,30h
	mov bl,al
	mov ax,n

	mul cx
	xor bh,bh
	add ax,bx
	mov n,ax
	jmp j1
j2 :nop
endm

.model small
.stack 100h

.data
	msg1 db 10,13,'Enter the 1st number: $'
	msg2 db 10,13,'Enter the 2nd number: $'
	msg3 db 10,13,'The LCM of the two numbers are $'
	data1 dw 0
	data2 dw 0
	d1 dw 0
	d2 dw 0

.code
main proc

mov ax,@data
mov ds,ax
print msg1

;reading 1st multidigit number
read data1,jump1,jump2

print msg2
;reading 2nd multidigit number
read data2,jump3,jump4

;copy the data1 and data2 to d1& d2
mov bx,data1
mov d1,bx

mov cx,data2
mov d2,cx

;Algorithm for finding lcm
;if(d1=d2) then finish, lcm=d1 or d2
;elseif(d1<d2) then d1=d1+data1
;else d2=d2+data2
;repeat
loop1:mov ax,d1
	cmp ax,d2
	je jump5
	jc jump6

	mov ax,d2
	add ax,cx
	mov d2,ax
	jmp loop1

jump6:mov ax,d1
	add ax,bx
	mov d1,ax
	jmp loop1

;printing LCM
jump5:mov bx,0ah
	xor cx,cx

;push into stack
p1:xor dx,dx
	div bx

	push dx
	inc cx
	cmp ax,00h
	jne p1

print msg3
;pop from stack
disp:pop dx
	add dl,30h
	mov ah,02h
	int 21h
	loop disp
	mov ah,4ch
	int 21h

main endp
end