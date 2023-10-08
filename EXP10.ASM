stack segment stack
 db 64 dup (?)
stack ends
data segment
 buff db 50,?, 50 dup (?)
 nam0 db "what is your name?$"
 bkc0 db "what is your background color?$"
 bkc1 db "->(input rgb:0-7):$"
 fc0 db "what is your font color?$"
 fc1 db "->(input rgb:0-7):$"
 tw0 db "do you like twinkle?$"
 tw1 db "->(like:1 dislike:0):$"
 hel0 db "hello! $"
 hel1 db "welcome to masm! $"
 arro db "->$"
data ends
code segment
assume cs:code, ds:data, ss:stack
start:mov ax, data
  mov ds, ax;make ds point to the data segment
  mov ah, 6;initialize screen
  mov al, 0
  mov ch, 0
  mov cl, 0
  mov dh, 24
  mov dl, 79
  mov bh, 7
  int 10h
  mov bh, 00001111b;white on black
  call scroll
  call cursor
  mov dx, offset nam0
  mov ah, 9
  int 21h;output string,Prompt for name
  mov bh, 10001111b
  call scroll
  call cursor
  mov dx, offset buff
  mov ah, 10
  int 21h;input string to buffer
  call scroll
  mov bh, 00001111b;flash white text on black background
  call scroll
  call cursor
  mov dx, offset bkc0
  mov ah, 9
  int 21h;output string,Ask background color
  call scroll
  call cursor
  mov dx, offset bkc1
  mov ah, 9
  int 21h;output string,Prompt for input format
  mov bh, 10001111b
  call scroll
  call cursor
  mov dx, offset arro
  mov ah, 9
  int 21h;output arrow
  mov ah, 1
  int 21h;input background color
  sub al, 30h
  call scroll
  mov cl, 4
  shl al, cl
  mov bh, 00001000b
  add bh, al;change the 4-6 bits of bh to the background color of the input
  call scroll
  call cursor
  mov dx, offset fc0
  mov ah, 9
  int 21h;output string,Ask the font color
  call scroll
  call cursor
  mov dx, offset fc1
  mov ah, 9
  int 21h;output string,Prompt for input format
  or bh, 10000000b
  call scroll
  call cursor
  mov dx, offset arro
  mov ah, 9
  int 21h;output arrow
  mov ah, 1
  int 21h;input font color
  sub al, 30h
  call scroll
  add bh, al;change the 0-2 bits of bh to the input font color
  and bh, 01111111b
  call scroll
  call cursor
  mov dx, offset tw0
  mov ah, 9
  int 21h;output string,Ask if it flashes
  call scroll
  call cursor
  mov dx, offset tw1
  mov ah, 9
  int 21h;output string,Prompt for input format
  or bh, 10000000b
  call scroll
  call cursor
  mov dx, offset arro
  mov ah, 9
  int 21h;output arrow
  mov ah, 1
  int 21h;input flashes
  sub al, 30h
  call scroll
  cmp al, 1
  je twin
  and bh, 01111111b;if flashing, change 7 bits of bh to 1
  jmp a
twin:or bh, 10000000b;if not blinking,Change 7 bits of bh to 0
a:call scroll
  call cursormid
  mov dx, offset hel0
  mov ah, 9
  int 21h;output greeting
  push bx
  call scroll
  call cursormid
  mov bl, buff + 1;store the number of characters entered in bl
  add bl, 2;add 2 to bl to point to the next character of the last character
  mov bh, 0;set bh to zero
  add bx, offset buff;add the offset address of buff to bx
  mov byte ptr [bx], "!";write "!" at the end of the string

 
  add bx, 1;increase bx by 1 to point to the next character
  mov byte ptr [bx], "$";write "$" at the end of the string
  mov dx, offset buff + 2
  mov ah, 9
  int 21h;output string (name stored, "!")
  pop bx
  call scroll
  call cursormid
  mov dx, offset hel1
  mov ah, 9
  int 21h;output string,Greetings
  mov ah, 4ch
  int 21h;end program
scroll proc near
  push ax
  push bx
  push cx
  push dx
  mov ah, 6
  mov al, 1
  mov ch, 8
  mov cl, 30
  mov dh, 16
  mov dl, 60
  int 10h;scroll down one line
  pop dx
  pop cx
  pop bx
  pop ax
  ret
scroll endp
cursor proc near
  push ax
  push bx
  push dx
  mov ah, 2
  mov dh, 16
  mov dl, 30;move cursor
  mov bh, 0
  int 10h
  pop dx
  pop bx
  pop ax
  ret
cursor endp
cursormid proc near
  push ax
  push bx
  push dx
  mov ah, 2
  mov dh, 16
  mov dl, 38;move cursor
  mov bh, 0
  int 10h
  pop dx
  pop bx
  pop ax
  ret
cursormid endp
code ends
end start
