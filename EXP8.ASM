; Program to compute factorial of a number using FAR Procedure
DATA SEGMENT  
NUM1 DW 05H  
RESULT DW ? 
DATA ENDS 
MY SEGMENT 
FACT PROC FAR 
MUL CX 
RET 
ENDP 
MY ENDS 

CODE SEGMENT 
START: 
ASSUME CS:CODE , DS:DATA 
MOV AX,DATA 
MOV DS,AX
MOV CX,NUM1
MOV AX,0001H 

UP : CALL FACT 

LOOP UP 

MOV RESULT,AX 
MOV AH,4CH 
INT 21H 
CODE ENDS 
END START 