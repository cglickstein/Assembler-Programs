; Program4- enter a multidigit number and print out a multidigit number

                     .model flat ;commands to the assembler program
					 .386
					 .stack 100h
					 
					 .data ;set up data


TESTNBR DD 7 ;data double
MSG DB 'Please enter a number:', '$' ;don't do 10,13 because you want character put in right after the line
NBR DD 0
MSG2 DB 'ERROR', '$'
MSG3 DB 'CORRECT','$'
TEN DD 10

                     .Code
program4 Proc
                     MOV ax, @data ;sets up physical location of data
					 MOV ds, ax 
					 
;-------------------------------------------------------				 
					 mov dx, OFFSET MSG
					 mov ah, 9h ;do command 9 which means write
					 INT 21h ;telling OS to do something. Transfer to operating system
;------------------------------------------------------	
					SUB EAX,EAX
					MOV NBR, EAX
;-------------------------------------------------------					
;character typed in goes to AL memory spot. Now get character with another OS command
LOOPBACK:            mov ah, 1H ;char will be put in AL
                     int 21H
;-----------------------------------------------------
;compare to see if it's right character
					 CMP AL, 13 ;compare subtracts one from the other
					 JE DONE ;jump equal. JNE is for jump not equal, JGE is jump greater than or equal, JLE is jump less than or equal, JL is jump less than
;-------------------------------------------------------
					SUB EBX, EBX
					MOV BL, AL
					SUB EBX,30h ;EBX contains digit
					
					MOV EAX, NBR ;take whatever is in EAX and multiply by the multiplier (immediate, register, memory) 
					IMUL TEN
					ADD EAX,EBX
					MOV NBR,EAX
					
					JMP LOOPBACK
					
;-----------------------------------------------------
DONE:               MOV ecx, NBR
					CMP ECX, TESTNBR
					JE GOTIT
					MOV DX, OFFSET MSG2
					MOV AH,9H
					INT 21H
					JMP THEEND
					
GOTIT: 		        MOV DX, OFFSET MSG3
					MOV AH,9H
					INT 21H

THEEND:					
					MOV al, 0 ;tells the OS to end the program, return code 0
					mov ah, 4ch
					INT 21h
					
					
program4				 ENDP
                     END program4