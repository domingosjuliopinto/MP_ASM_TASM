.MODEL SMALL 
.STACK 100H
.CODE

Data Segment
	msg db 0dh,0ah,"Enter a string: $"
	result db 0dh,0ah,"The Reverse is: $"
	newl db 0dh,0ah," $"
Data ends

MAIN PROC
	assume DS:Data
Start:
		 mov ax,Data
		 mov DS,ax

		 mov dx,offset msg;add16
		 mov ah,09h
		 int 21h

	 MOV CH,0
	 MOV CL,0
	 

INPUT: 
	 MOV AH,1
	 INT 21H 
	 CMP AL,13D
	 JE LINE
	 AND DX,0
	 MOV DL,AL
	 PUSH DX  
	 INC CL
	 JMP INPUT   
	 
LINE:
	 MOV AH,2
	 MOV DL,0AH
	 INT 21H
	 MOV DL,0DH
	 INT 21H
	 
	 
	 mov dx,offset result;display result
	 mov ah,09h
	 int 21h
	 
PRINT:
	 AND DX,0
	 POP DX
	 MOV AH,2 
	 INT 21H  
	 LOOP PRINT
	 
	 mov ax, 4c00h ;to come back to dos box
       int 21h
	
		MAIN ENDP
END MAIN