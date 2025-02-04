include 'emu8086.inc'

DATOS SEGMENT
    cont db 0 ;cont = contador
    MCM db 0 ;en esta variable se guarda el MCM
    MCD db 0 ;en esta variable se guarda el MCD
    nro1 db 1 ;numero1 decimal
    nro2 db 161 ;numero2 decimal
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
;-----------------------------------------------------------------------

    MOV cont,1          ;inicializar variable cont en 1
    
    bucle:
        MOV AH,0
        MOV AL,cont
        MOV BL,nro1
        DIV BL
        CMP AH,0        ;si el resto de la division del contador con el nro1 es iguAL 0
        JE parte1
    bc:
    	INC cont        ;incrementar el contador
    	JMP bucle       ;bucle hasta que encuentre el MCM
    
    parte1:             ;si nro1 es multiplo del contador
    	MOV AH,0
    	MOV AL,cont
    	MOV BL,nro2
    	DIV BL
    	CMP AH,0        ;compara si el resto de la division del contador con el nro2 es 0
    	JE parte2
    	JMP bc          ;si el nro2 no es multiplo del contador regresa a bucle1
    
    parte2:             ;si el nro1 y el nro2 son multiplos del contador
    	MOV AL,cont
    	MOV MCM,AL      ;guarda el MCM
    	JMP parte3      ;ir a finAL
    
    parte3:             ;una vez que tengamos el MCM primero multiplicar nro1 * nro 2
    	MOV AL, nro1    ;con ese resultado, DIVidir por el MCM de nro1 y nro2 y tenemos el MCD
    	MOV BL, nro2
    	MUL BL
    	MOV BL, MCM
    	DIV BL
    	MOV MCD, AL

;-----------------------------------------------------------------------

    RET
    INICIO ENDP
    CODIGO ENDS   

    DEFINE_CLEAR_SCREEN   
    DEFINE_PTHIS
    DEFINE_SCAN_NUM
    END INICIO