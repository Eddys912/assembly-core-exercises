include 'emu8086.inc'

DATOS SEGMENT     
    saludo  DB 10,13,'PALABRAS QUE TERMINEN CON a',10,13,'$'
    ing1    DB 10,13,'Ingresa una cadena: $'                
    ing2    DB 10,13,'Al finalizar la oracion o palabra dar 1 espacio',10,13,'$'
    msj1    DB 10,13,'Cantidad de palabras con terminacion a: 0','$'
    cad1    DB 15 DUP('$')
    cad2    DB 15 DUP('$')                 
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

    MOV AX,DATOS        
    MOV DS,AX         
    MOV SI,0            
    MOV CL,0

    MOV AH,9h
    LEA DX,saludo       
    INT 21h    
                            
    MOV AH,9h
    LEA DX,ing2       
    INT 21h    

    MOV AH,09h
    LEA DX,ing1       
    INT 21h
    
;LO QUE ESTA ENTE ESTOS COMENTARIOS EN DONDE SE REALIZARAN LOS PROGRAMAS
;-----------------------------------------------------------------------
    
    MOV SI,0            ;se inicializa en null para evitar errores
    Ing_Text:           ;ingreso del primer texto
    MOV AX,0000h
    MOV AH,01h          ;Le indica que va a leer un dato desde teclado con 'eco'   
    INT 21h            
    MOV cad1[SI],AL     ;se guardan los valores del teclado en el arreglo 'cad1'
    INC SI
    CMP AL,0dh          ;determina si ya se presiono 'enter' si no continua ingresando texto
    JA Ing_Text
     
    MOV SI,0                ;se inicializa en null para evitar errores
    comp:
        CMP cad1[SI],'$'    ;comparamos si la cadena llego a su fin 
        JZ valor
        CMP cad1[SI],'a'
        JE cmas           
        INC SI              
        JNE comp 
    
    cmas:     
        INC SI
        CMP cad1[SI],32
        JA comp 
        INC CL
        JMP comp
   
    valor:
        CMP CL,0
        JE msj
        JNE sms

    msj:                                          
        MOV AH,09h
        LEA DX,msj1         ;imprime el msj 'msj1'
        INT 21h 
        JMP fin
    
    sms: 
        MOV cad2[0],CL
        ADD cad2[0],48 

        MOV AH,09h
        LEA DX,msj1         ;imprime el msj 'msj1'
        INT 21h 
  
        MOV AH,09h
        LEA DX,cad2         ;imprime el msj 'cad2'
        INT 21h                                    
    
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