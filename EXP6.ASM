Data Segment
 msg db 0dh,0ah,"-- -- -- -- OF DF IF TF SF ZF -- AF -- PF -- CF $"
 newl db 0dh,0ah,"$"
 flag dw ?
Data ends
Code Segment
assume CS:Code,DS:Data
start:
 mov ax,Data
 mov DS,ax

 mov dx,offset msg
 mov ah,09h
 int 21h

 mov dx,offset newl
 mov ah,09h
 int 21h

 cli
 stc
 std
 
 pushf
 
 pop bx
 
 mov flag,bx

 mov cx,16
 mov bx,8000h

loops:
 mov ax,flag
 and ax,bx
 jz zero
 mov dl,31h
 mov ah,02h
 int 21h
 jmp space

zero: mov dl,30h
 mov ah,02h
 int 21h

space: mov dl,' '
 mov ah,02h
 int 21h

 mov ah,02h
 int 21h
 ror bx,1

 loop loops

 mov ah,4ch
 int 21h
Code ends
end start  