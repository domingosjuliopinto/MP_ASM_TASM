.model small  
 .data                                                     
        a dw 0000  
        c db 0
        msg1 db 10,13,"Enter the 16 bit dividend: $"
        msg3 db 10,13,"Enter the 8 bit divisor: $"
            msgr db 10,13,"Remainder: $"
        msgq db 10,13,"Quotient: $"
.stack 100
       .code
.startup
     mov  ax, @data  ; Initialize data section  
     mov  ds, ax
     lea dx,msg1
     mov ah,09h
     int 21h
numh1:    mov ah,01h
          int 21h
          cmp al,'0'
          jb ENTER_DIVIDENDH
          CMP AL,'9'
          JA NUMH1
          SUB AL,48
          MOV BH,0
          MOV BL,AL
          MOV AX,[A]
          MOV CX,10
          MUL CX
          ADD AX,BX
          MOV [A],AX
          JMP NUMH1
ENTER_DIVIDENDH:
                CMP AL,13
                JNE NUMH1

                LEA DX,MSG3
                MOV AH,09H
                INT 21H

NUML2:
                MOV AH,01H
                INT 21H
                CMP AL,'0'
                JB ENTER_DIVIDENDL2
                CMP AL,'9'
                JA NUML2
                SUB AL,48
                MOV BL,AL
                MOV AL,[C]
                MOV CL,10
                MUL CL
                ADD AL,BL
                MOV [C],AL
                JMP NUML2
ENTER_DIVIDENDL2:
                 CMP AL,13
                 JNE NUML2

                 MOV DX,0
                 MOV AX,[A]
                 MOV BH,0
                 MOV BL,[C]
                 DIV BX
                 MOV CX,DX
                 PUSH CX
                 MOV [A],AX
                 POP AX
                 MOV BP,SP

DIVR:            MOV CL,10
                 DIV CL
                 MOV BH,AH
                 MOV BL,0
                 PUSH BX
                 MOV AH,0
                 CMP AL,0
                 JNE DIVR

DISP1:           CMP BP,SP
                 JE DIVE
                 POP DX
                 MOV DL,DH
                 ADD DL,48
                 MOV AH,02H
                 INT 21H
                 JMP DISP1
DIVE:            LEA DX,MSGQ
                 MOV AH,09H
                 INT 21H
                 MOV BP,SP
DIVQ:
                 MOV AX,[A]
                 MOV DX,0
                 MOV CX,10
                 DIV CX
                 PUSH DX
                 MOV [A],AX
                 CMP AX,0
                 JNE DIVQ
DISP2:
                 CMP BP,SP
                 JE DONE1
                 POP DX
                 ADD DX,48
                 MOV AH,02H
                 INT 21H
                 JMP DISP2

DONE1:
.EXIT


END


     mov  ax, a      ; Load number1 in ax  
     mov  bl, b      ; Load number2 in bl                           
     div   bl        ; divide numbers. Quotient in al and Rem in ah      
     mov  ch, 04h    ; Count of digits to be displayed  
     mov  cl, 04h    ; Count to roll by 4 bits  
     mov  bx, ax         ; Result in reg bh  
     rol    bx, cl     ; roll bl so that msb comes to lsb  
     mov  dl, bl      ; load dl with data to be displayed  
     and   dl, 0fH    ; get only lsb  
     cmp  dl, 09     ; check if digit is 0-9 or letter A-F  
     jbe   l4  
     add   dl, 07     ; if letter add 37H else only add 30H  
     add   dl, 30H  
     mov  ah, 02         ; Function 2 under INT 21H (Display character)  
     int    21H  
     dec   ch        ; Decrement Count  
     jnz   l2  
     mov  ah, 4cH    ; Terminate Program  
     int    21H  
  end 