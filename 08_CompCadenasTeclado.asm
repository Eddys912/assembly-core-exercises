include 'emu8086.inc'

DATOS SEGMENT     
    saludo  DB 10,13,'COMPARACION DE CADENAS POR TECLADO',10,13,'$'
    ing1    DB 10,13,'Ingresa una cadena: $'
    ing2    DB 10,13,'Ingresa otra cadena: $'
    igual   DB 10,13,'Las cadenas son iguales',10,13,'$'
    nigual  DB 10,13,'Las cadenas no son iguales',10,13,'$'
    cad1   DB 10 DUP('$')
    cad2    DB 10 DUP('$')                             
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

    MOV AX,DATOS        ;obtiene la direccion todos los textos (Datos) de memoria
    MOV DS,AX         
    MOV SI,0            ;inicializa el indice de origen

    MOV AH,9h
    LEA DX,saludo       ;imprime el msj 'saludo'
    INT 21h    

    MOV AH,09h
    LEA DX,ing1         ;imprime el msj 'ing1'
    INT 21h
    
    Ing_Text:           ;ingreso del primer texto
    MOV AX,0000h
    MOV AH,01h          ;Le indica que va a leer un dato desde teclado con 'eco'   
    INT 21h            
    MOV cad1[SI],AL     ;se guardan los valores del teclado en el arreglo 'cad1'
    INC SI
    CMP AL,0dh          ;determina si ya se presiono 'enter' si no continua ingresando texto
    JA Ing_Text
     
    MOV AH,09h
    LEA DX,ing2         ;imprime el msj 'ing2'
    INT 21h
    
    MOV SI,000          ;se inicializa en null para evitar errores
    Ing_Text2:          ;ingreso del segundo texto
    MOV AX,0000h
    MOV AH,01h          ;Le indica que va a leer un dato desde teclado con 'eco'   
    INT 21h
    MOV cad2[SI],AL     ;se guardan los valores del teclado en el arreglo 'cad2'
    INC SI
    CMP AL,0dh          ;determina si ya se presiono 'enter' si no continua ingresando texto
    JA Ing_Text2
    
    MOV SI,000              ;se inicializa en null para evitar errores
    comp:
        CMP cad1[SI],'$'    ;comparamos si la cadena llego a su fin
        JE fincadena        ;si la cadena llego al fin salta a la condicion 'fincadena' y sigue la evaluacion
        MOV AL,cad1[SI]     ;si la cadena no esta vacia se mueve el valor de 'cad1' al registro AL
        CMP cad2[SI],AL     ;se compara el valor de 'cad2' con el que tiene AL de 'cad1'
        JNE noigual         ;si los valores no son iguales salta a la condicion 'noigual'
        INC SI              ;si son iguales incrementa SI y continua comparando con ayuda del 'JMP cmp'
        JMP comp

    fincadena:
        CMP cad2[SI],'$'    ;si 'cad1' esta vacia el programa va a la condicion 'fincadena' a comparar 'cad2'
        JNE noigual         ;si 'cad2' no esta vacia salta a la condicion 'noigual'
        JE esigual          ;si 'cad2' esta vacia salta a la condicion 'igual'

    esigual:
        MOV AH,09h
        LEA DX,igual         ;imprime el msj 'igual'
        INT 21h
        JMP fin

    noigual:
        MOV AH,09h
        LEA DX,nigual         ;imprime el msj 'nigual'
        INT 21h
        JMP fin
    
    fin:                ;finaliza el programa y uso del BIOS
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