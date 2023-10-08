;Hello world program
data segment
s1 db "Hello World$"
data ends
code segment
assume cs:code, ds:data
begin:
        mov ax,data
        mov ds,ax
        ;lea dx,s1
        mov dx,offset s1
        mov ah,9
        int 21h

        mov ah,4ch
        int 21h
code ends
end begin
