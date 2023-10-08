Data segment

 msg db 0dh,0ah,"Enter first number: $"
 msg1 db 0dh,0ah,"Enter second number: $"
 result db 0dh,0ah,"The Result is: $"

Data ends
Code segment
 assume CS:Code,DS:Data
start:
 mov ax,Data ; Move Data to Data Segment
 mov DS,ax

 mov dx,offset msg ; Display contents of variable msg mul8
 mov ah,09h
 int 21h

 mov ah,01h ; To accept input and store ASCII value into al
 int 21h

 call AsciitoHex

 mov bl,al ; Accept 10's place of the Number
 rol bl,4

 mov ah,01h ; To accept input and store ASCII value into al
 int 21h

 call AsciitoHex ; Accept unit's place of Number

 add bl,al ; Get the number by adding 10's and unit's place

 mov dx,offset msg1 ; Display contents of variable msg1
 mov ah,09h
 int 21h

 mov ah,01h ; To accept input and store ASCII value into al
 int 21h

 call AsciitoHex ; Accept 10's place of the Number
 mov cl,al
 rol cl,4

 mov ah,01h ; To accept input and store ASCII value into al
 int 21h

 call AsciitoHex ; Accept unit's place of Number

 add cl,al ; Get the number by adding 10's and unit's place

 mov al,bl ; Multiply the two accepted Number's
 mov bl,cl
 mul bl

 mov cx,ax ; Store the value of the Result

 mov dx,offset result ; Display contents of string result
 mov ah,09h
 int 21h

 and ax,0f000h ; Isolate 1000's place of Result
 ror ax,12

 mov bl,al ; Convert to ASCII to display
 call AsciiConv 

 mov dl,bl ; Display a Number/Alphabet
 mov ah,02h
 int 21h

 mov ax,cx ; Retrieve original Result

 and ax,0f00h ; Isolate 100's place of Result
 ror ax,8

 mov bl,al ; Convert to ASCII to display
 call AsciiConv 

 mov dl,bl ; Display a Number/Alphabet
 mov ah,02h
 int 21h

 mov ax,cx ; Retrieve original Result

 and ax,00f0h ; Isolate 10's place of Result
 ror ax,4

 mov bl,al ; Convert to ASCII to display
 call AsciiConv 

 mov dl,bl ; Display a Number/Alphabet
 mov ah,02h
 int 21h

 mov ax,cx ; Retrieve original Result

 and ax,000fh ; Isolate unit's place of Result

 mov bl,al ; Convert to ASCII to display
 call AsciiConv 

 mov dl,bl ; Display a Number/Alphabet
 mov ah,02h
 int 21h

 mov ah,4ch ; Terminate the program
 int 21h

 AsciiConv proc ; Compare to 0a if it is less than A then we need to add only 30
  cmp bl,0ah ; If it is greater than or equal to 0a then we also need to add 07
  jc skip
  add bl,07h
  skip: add bl,30h
  ret
  endp

 AsciitoHex proc ; Compare to 41 if it is less than A then we need to sub only 30
  cmp al,41h ; If it is greater than or equal to 41 then we also need to sub 07
  jc skippy
  sub al,07h
  skippy: sub al,30h
  ret
  endp
Code ends
end start