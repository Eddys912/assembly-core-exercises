include 'emu8086.inc'

DATOS SEGMENT
    Muestra  DB 10,13,'INGRESA TU NOMBRE: ',10,13,'$'
    Nombre   DB 'Su nombre es: $' 
    texto    DB 100 DUP('$')                              
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

; INT   Permite solicitar operaciones de entrada y salida por medio de interrupciones
;      INT 10H                           INT 21H
;      06h Fija el curso                 02H  Despliega en pantalla
;      06h Recorre la pantalla           09h  Despliega en pantalla
;                                        0Ah  Entrada desde teclado
;                                        3fh  Entrada desde teclado

    MOV AX,DATOS       ;Obtiene la direccion todos los textos (Datos) de memoria
    MOV DS,AX          ;El registro de AX se pasa a DS
    MOV SI,0
    MOV CX,2
               
    LEA DX,Muestra     ;Muestra el texto que indica que ingrese el nombre
    MOV AH,09h
    INT 21h
    
    M_Texto:
        MOV AX,0000h
        MOV AH,01h          ;Le indica que va a leer un dato desde teclado con 'eco'   
        INT 21h
                            ;Se guardan los valores del teclado en el arreglo
        MOV texto[SI],AL
        INC SI
        CMP AL,0dh          ;Determina si ya se presiono 'enter'
        JA  M_texto
        JB  M_texto
        LEA DX,Nombre       ;Muestra el texto donde le indica la leyenda 'su nombre es:'
        MOV AH,09h
        INT 21h
                
    M:
        LEA DX, texto       ;indica direccion del arreglo donde se almaceno el
        MOV AH,09h          ;nombre y lo muestra en pantalla
        INT 21h
    
    termi:
        MOV AH,4Ch         
        INT 21h
        
;-----------------------------------------------------------------------

    RET
    INICIO ENDP
    CODIGO ENDS   

    DEFINE_CLEAR_SCREEN   
    DEFINE_PTHIS
    DEFINE_SCAN_NUM
    END INICIO