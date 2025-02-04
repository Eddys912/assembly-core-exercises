include 'emu8086.inc'

DATOS SEGMENT   
    saludo  DB 10,13,'COMPARACION DE CADENAS POR TECLADO',10,13,'$'
    ing1    DB 10,13,'Ingresa una cadena: $'
    ing2    DB 10,13,'Ingresa otra cadena: $'
    igual   DB 10,13,'Texto 2 es subcadena de texto 1',10,13,'$'
    nigual  DB 10,13,'Texto 2 no es subcadena de texto 1',10,13,'$'
    cad1 DB 15 DUP('$')
    cad2 DB 15 DUP('$')    
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
    MOV SI,0            ;inicializa el indice de origen  
    MOV DI,0

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
    
    MOV SI,000 
    MOV DI,000             ;se inicializa en null para evitar errores   
    
    comp:
        CMP cad1[SI],'$'    ;comparamos si la cadena 1 llego a su fin
        JE fincadena        ;si la cadena llego al fin salta a la condicion 'fincadena' y sigue la evaluacion
        MOV AL,cad1[SI]     ;si la cadena no esta vacia se mueve el valor de 'cad1' al registro AL
        CMP cad2[DI],AL     ;se compara el valor inicial de 'cad2' con el que tiene AL de 'cad1'  
        JE  compRep
        INC SI                                             
        JMP comp
        
    compRep:         
        INC SI
        INC DI 
        MOV AL, cad1[SI]
        CMP cad2[DI], AL                
        JE compara  
        DEC DI
        MOV AL, cad1[SI]
        CMP cad2[DI], AL
        JE compara       
        JMP fincadena     
        
    compara:  
    INC DI 
    INC SI 
    CMP cad1[SI],'$'    ;comparamos si la cadena 2 llego a su fin
    JE fincadena
    CMP cad2[DI],'$'    ;comparamos si la cadena 2 llego a su fin
    JE esigual        ;si la cadena llego al fin salta a la condicion 'fincadena' y sigue la evaluacion
    MOV AL,cad2[DI]     ;si la cadena no esta vacia se mueve el valor de 'cad1' al registro AL
    CMP cad1[SI],AL     ;se compara el valor de 'cad2' con 'cad1'
    JNE fincadena    
    JMP compara
    
    fincadena:  
        inc di
        CMP cad2[DI],'$'   
        JE esigual         ;si 'cad2' se recorrio por completo salta a la condicion 'esigual'
        JMP noigual        ;si 'cad2' no se recorrio por completo salta a la condicion 'noigual'
         
    noigual:
        MOV AH,09h
        LEA DX,nigual         ;imprime el msj 'nigual'
        INT 21h
        JMP fin 

    esigual:
        MOV AH,09h
        LEA DX,igual         ;imprime el msj 'igual'
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