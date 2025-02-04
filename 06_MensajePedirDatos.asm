include 'emu8086.inc'

DATOS SEGMENT
    Inicial db 8 DUP (?)
    Final db 8 DUP(?)
    Y db 10
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
;https://www.alpertron.com.ar/INST8088.HTM

    MOV	CX,7
    MOV	SI,0
    MOV	DI,0
    
    CALL CLEAR_SCREEN
    GOTOXY  20,Y
    CALL PTHIS
        DB 'HOLA MUNDO',0      
    
    CICLO:
        INC Y
        GOTOXY 20,Y
        CALL PTHIS
        DB 'VALOR: ',0
        CALL SCAN_NUM
        MOV Inicial[SI],CL
        INC SI
        CMP SI,8
        JNE CICLO

;-----------------------------------------------------------------------

    RET
    INICIO ENDP
    CODIGO ENDS   

    DEFINE_CLEAR_SCREEN   
    DEFINE_PTHIS
    DEFINE_SCAN_NUM
    END INICIO