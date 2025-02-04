DATOS SEGMENT  
    n1 DW 0
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
      
    MOV CX, 4
    MOV BX, 0
    MOV DX, 1
    MOV n1, DX 
    FB:
        ADD BX, DX  
        MOV n1, BX
        ADD DX, BX
        MOV n1, DX
        LOOP FB
                                        
;-----------------------------------------------------------------------

    RET
    INICIO ENDP
    CODIGO ENDS 
    END INICIO 