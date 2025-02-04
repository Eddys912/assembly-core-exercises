include 'emu8086.inc'   

DATOS SEGMENT    
    NUMEROS DB 15 DUP (?)
    PRIMOS DB 15 DUP (?)
    NOPRIMOS DB 15 DUP (?)
    Y DB 0
    contA DB ?   
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
   
    MOV SI ,0
      
    CALL CLEAR_SCREEN
    GOTOXY  0,Y 

    Ingreso:
        INC   Y
        GOTOXY  20,Y
        CALL PTHIS
            DB 'Ingrese un numero: '  ,0    
        CALL SCAN_NUM       
        MOV NUMEROS [SI],cl
        INC SI
        CMP SI, 15
        jne Ingreso
        
        MOV SI,0
        MOV DI,0
        MOV AX,0
        
    Recorrido:
        CMP SI, 15
        JE  SALIDA_R 
        MOV BL, 1
        MOV AL, NUMEROS[SI]
        CMP AL, 3
        JE TPrimo
        CMP AL, 2
        JE PPrimo
        ja NPrimo
        JB GNoPrimo
        
    NPrimo:
        MOV AX, 0 
        MOV AL, NUMEROS[SI]
        INC BL
        div BL
        CMP AH, 0
        JE GNoPrimo
        ja Counter
        
    Counter:
        MOV CL, NUMEROS[SI]
        sub CX, 3
        JMP PrimoPrueba
        
    PrimoPrueba:
        MOV AX, 0
        MOV AL, NUMEROS[SI]
        INC BL
        div BL
        CMP AH, 0
        JE GNoPrimo 
        LOOP PrimoPrueba
        
    GPrimo:
        MOV AL, NUMEROS[SI]
        MOV PRIMOS[DI], AL
        INC SI
        INC DI
        INC contA 
        JMP Recorrido
        
    PPrimo:
        MOV PRIMOS[DI], AL
        INC SI
        INC DI       
        INC contA
        JMP Recorrido
        
    TPrimo:
        MOV PRIMOS[DI], AL
        INC SI
        INC DI
        INC contA
        JMP Recorrido
        
    GNoPrimo:
        MOV AL, NUMEROS[SI]
        MOV NOPRIMOS[DI], AL
        INC SI
        INC DI
        JMP Recorrido 
        
        
    SALIDA_R:
        MOV AX,0
        MOV SI, 0 
        MOV Y, 2  
        CALL CLEAR_SCREEN
        CALL PTHIS
             DB 'Cantidad de numeros primos:', 0
        MOV AL, contA     
        GOTOXY 30,0
        CALL PRINT_NUM
                 
        GOTOXY 0,2
        CALL PTHIS
            DB 'Los numeros primos son: '  ,0
        JMP IMPRIMIR
            
    IMPRIMIR:
        MOV AL, PRIMOS[SI]
        CMP AL, 0
        JE CEROS
        GOTOXY 30,Y
        CALL PRINT_NUM
        INC Y
        INC SI
        CMP SI,15
        JB IMPRIMIR
        JE SALIR    
        
    CEROS:
        INC SI
        CMP SI,15
        JB IMPRIMIR
        
    SALIR:                                                                       
                                                                                
;-----------------------------------------------------------------------

    RET    
    INICIO ENDP
    DEFINE_CLEAR_SCREEN   
    DEFINE_PTHIS
    DEFINE_SCAN_NUM
    DEFINE_PRINT_NUM
    DEFINE_PRINT_NUM_UNS
    END INICIO