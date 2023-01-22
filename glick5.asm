; Program5- outnumber (convert from hexadecimal to decimal)

                     .model flat ;commands to the assembler program
					 .386
					 .stack 100h
					 
					 .data ;set up data


TESTNBR DD 6271 ;data double
NBR DD 0
TEN DD 10
MSG1 DB 10,13,'digit='
NXTDIG DB ' ','$' ;don't know where we put it in memory could say +8 but complicated so just make this another variable




                     .Code
program5 Proc
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
                     IDIV TEN
                     MOV NBR, EAX ;PUT BACK IN NUMBER
					 ADD EDX, 30H ;add 30h to make a printable character just like how 1+30h is character 1. won't print normally
                     MOV NXTDIG, DL
;PRINT
                     
                     MOV DX, OFFSET MSG1
					 MOV AH,9H
					 INT 21H
					 
					 
					 CMP NBR, 0
					 JE THEEND ;if zero then finishes otherwise loops
					 JMP LOOPBACK
					
					
THEEND: 		    MOV DX, OFFSET MSG1
					MOV AH,9H
					INT 21H
				
					MOV al, 0 ;tells the OS to end the program, return code 0
					mov ah, 4ch
					INT 21h
					
					
program5		     ENDP
                     END program5