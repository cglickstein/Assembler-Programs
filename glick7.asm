;step 1-modifiy the program that reads in an integer to use a macro GETNBR
;step2- PUTNBR in program but can't because numbers come out backwards. we want in the correct order
;step3- put them together 
;need an index which modifies the address ANS 

; Program6- outnumber (convert from hexadecimal to decimal) using macros

                     .model flat ;commands to the assembler program
					 .386
					 .stack 100h
					 
					 .data ;set up data


TESTNBR 			 DD 6271 ;data double
NBR DD 0
TEN DD 10
MSG1 DB 10,13,'digit='
NXTDIG DB ' ','$' ;don't know where we put it in memory could say +8 but complicated so just make this another variable




                     .Code
program5 Proc
WRITELINE            MACRO MSG
					 PUSHALL 
					 MOV DX,OFFSET MSG
					 MOV AH,9H
					 INT 21H
					 POPALL
					 ENDM
PUSHALL              MACRO
                     PUSH EAX
					 PUSH EBX
					 PUSH ECX
					 PUSH EDX
					 ENDM
POPALL               MACRO
                     POP EDX
					 POP ECX
					 POP EBX
					 POP EAX
					 ENDM
					 
                     MOV ax, @data ;sets up physical location of data
					 MOV ds, ax 
					 
;-------------------------------------------------------
;				 
					MOV EAX, TESTNBR
					MOV NBR, EAX
;-------------------------------------------------------	
;dividend- must be in EAX
;divisor- part of the instruction
;quot- eax
;remainder- edx - automatically puts here				
;---------------------------------------
LOOPBACK:            MOV EAX, NBR
					 CDQ
                     IDIV TEN
                     MOV NBR, EAX ;PUT BACK IN NUMBER
					 ADD EDX, 30H ;add 30h to make a printable character just like how 1+30h is character 1. won't print normally
                     MOV NXTDIG, DL
;PRINT

                     WRITELINE MSG1
					 
					 CMP NBR, 0
					 JE THEEND ;if zero then finishes otherwise loops
					 JMP LOOPBACK
					 
					 PUSHALL
					 POPALL
					
					
THEEND: 		    WRITELINE MSG2
				
					MOV al, 0 ;tells the OS to end the program, return code 0
					mov ah, 4ch
					INT 21h
					
					PUSHALL
					POPALL
					
					
program5		     ENDP
                     END program5