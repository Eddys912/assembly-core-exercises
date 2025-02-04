DATOS SEGMENT            
    P1  db 100 DUP('$')  
DATOS ENDS  
            
PILA SEGMENT
    DB 64 DUP(0)
PILA ENDS 

CODIGO SEGMENT
INICIO PROC FAR
    ASSUME DS:DATOS,CS:CODIGO,SS:PILA
    
    PUSH DS
    MOV AX,0
    PUSH AX

    MOV AX,DATOS
    MOV DS,AX
    MOV ES,AX 
    
;LO QUE ESTA ENTE ESTOS COMENTARIOS EN DONDE SE REALIZARAN LOS PROGRAMAS
;--------------------------------------------------------------------------------
      
    MOV SI,0
    lee:
        MOV AH,1
        INT 21h
    
    CMP AL,13
    JZ resultado:
    	CMP AL,58
    	JL ne
        MOV P1[SI],AL
        INC SI
    
    ne: 
    	JMP lee
    
    resultado:
    	MOV AH,0
    	MOV AL,03h
    	INT 10h
    	MOV P1[SI],"$"
    	LEA DX, P1
    	MOV AH, 9
    	INT 21h
   
;-------------------------------------------------------------------------------- 

    RET
    INICIO ENDP
    CODIGO ENDS
    END INICIO