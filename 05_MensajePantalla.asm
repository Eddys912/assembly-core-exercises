include 'emu8086.inc'

DATOS SEGMENT
    Inicial db 8 DUP (?)
    Final db 8 DUP(?)
    Y db 20
    saludo db "Hola a todos","$"
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

; INT   Permite solicitar operaciones de entrada y salida por medio de
;        interrupciones
;      INT 10H                           INT 21H
;      06h Fija el curso                 02H  Despliega en pantalla
;      06h Recorre la pantalla           09h  Despliega en pantalla
;                                        0Ah  Entrada desde teclado
;                                        3fh  Entrada desde teclado
; http://ict.udlap.mx/people/oleg/docencia/ASSEMBLER/asm_interrup_21.html

    MOV AH,09h        ;Valor que es la peticion para desplegar datos en pantall
    LEA DX, saludo    ;Esta linea pasa el dato (direccion) del primer caracter
    INT 21h
    
    MOV AH, 4ch       ;Almacena el valor la cual le indica que finalizo el programa
    INT 21h	
      
;-----------------------------------------------------------------------

    RET
    INICIO ENDP
    CODIGO ENDS   

    DEFINE_CLEAR_SCREEN   
    DEFINE_PTHIS
    DEFINE_SCAN_NUM
    END INICIO