include 'emu8086.inc'

DATOS SEGMENT     
    saludo  DB 10,13,'SABER SI LAS CADENAS TIENEN LOS MISMOS CARACTERES',10,13,'$'
    ing1    DB 10,13,'Ingresa una cadena: $'
    ing2    DB 10,13,'Ingresa otra cadena: $'
    txtSi  DB 10,13,'Si tiene los mismos caracteres',10,13,'$'
    txtNo  DB 10,13,'No tiene los mismos caracteres',10,13,'$'
    cad1   DB 100 DUP('$')
    cad2    DB 100 DUP('$')
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
    
    MOV SI,000          ;se inicializa en null para evitar errores     
    
    comp:
    CMP cad1[SI], 0dh   ; ve si se recorrio la cadena uno                              
    JE tNo              ; si se recorrio toda la cadena significa que no esta un 
                        ; caracter de la cadena dos en la cadena uno                 
                            
    MOV AL, cad1[SI]
    CMP AL, cad2[DI]    ; Compara si son iguales
    JE con          
    INC SI
    JMP comp            ; si no son iguales recorre la cadena uno y lo vuelve a intentar

    con:         
    INC DI 
    MOV SI, 0
    CMP cad2[DI], 0dh  ; compara si coincidio toda la cadena dos 
    JE tSi 
    JMP comp 
  
    tSi:
     LEA  DX, txtSi
     MOV  AH,09h
     INT  21h  
     JMP fin   
    tNo:
     LEA  DX, txtNo
     MOV  AH,09h
     INT  21h 
    
    fin:                ;finaliza el programa y uso del BIOS
    
;---------------------------------------------------------------------------- 

    RET
    INICIO ENDP
    CODIGO ENDS   
    END INICIO