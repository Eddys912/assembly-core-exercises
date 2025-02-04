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

;SUMA
   ;MOV AX,65535    ;AX --->Utiliza un registro de 16 bits
   ;MOV AL 99       ;cambiar ahora por 255 y 256
   ;ADD AX,65535    ;(AX=AL+AH) Esta sumando AX y por lo tanto seria 11 pero almacenado en AL (parte baja)    
                                         
;RESTA
   ;MOV AL,9  
   ;SUB AL,3            

;MULTIPLICA POR CONTADOR
    MOV CX, 2       ;al hacer la operacion se decrementa el contador
    MOV AX, 2       ;Se almacena el 2 en AX
    P:              ;Etiqueta
        MOV BX, 2   ;El valor de 2 se almacena en BX
        MUL BX
        LOOP P  

;-----------------------------------------------------------------------
    RET
    INICIO ENDP
    CODIGO ENDS
    END INICIO