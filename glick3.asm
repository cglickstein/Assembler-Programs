; Program2 - Read and write a character

                     .model flat ;commands to the assembler program
					 .386
					 .stack 100h
					 
					 .data ;set up data


thatsall DB 'that is it', '$'
Rqstchar DB 'Please enter one char:', '$' ;don't do 10,13 because you want character put in right after the line
outmsg DB 10,13, 'You entered: '
charin DB ' ', 10,13,'$'
                     .Code
program3 Proc
                     MOV ax, @data ;sets up physical location of data
					 MOV ds, ax 
					 
;-------------------------------------------------------		
;			 
RQST:			     mov dx, OFFSET Rqstchar
					 mov ah, 9h ;do command 9 which means write
					 INT 21h ;telling OS to do something. Transfer to operating system
;------------------------------------------------------		
;character typed in goes to AL memory spot. Now get character with another OS command
                     mov ah, 1H ;char will be put in AL
                     int 21H
;-----------------------------------------------------
;compare to see if it's right character
					 CMP AL, 13 ;compare subtracts one from the other
					 JE DONE ;jump equal. JNE is for jump not equal, JGE is jump greater than or equal, JLE is jump less than or equal, JL is jump less than
;-------------------------------------------------------
;output message 
					 mov charin, al
					 mov dx, OFFSET outmsg
					 mov ah, 9h
					 int 21h
					 JMP RQST
;------------------------------------------------------	
DONE:                MOV dx,OFFSET thatsall
					 mov AH, 9h
					 INT 21H
				 
					 MOV al, 0 ;tells the OS to end the program, return code 0
					 mov ah, 4ch
					 INT 21h
					 
program3				 ENDP
                     END program3