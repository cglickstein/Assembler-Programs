; Program2 - Read and write a character

                     .model flat ;commands to the assembler program
					 .386
					 .stack 100h
					 
					 .data ;set up data

Rqstchar DB 'Please enter one char:', '$' ;don't do 10,13 because you want character put in right after the line
outmsg DB 10,13, 'You entered: '
charin DB ' ', '$'
                     .Code
RWCHAR Proc
                     MOV ax, @data ;sets up physical location of data
					 MOV ds, ax 
					 
;-------------------------------------------------------		
;			 
					 mov dx, OFFSET Rqstchar ;tells OS to output string. DX has address of the message.
					 mov ah, 9h ;do command 9 which means write
					 INT 21h ;telling OS to do something
;------------------------------------------------------		
;character typed in goes to AL memory spot. Now get character with another OS command
                     mov ah, 1H,
                     int 21H
;-----------------------------------------------------
;now get character in and want to output message 
					 mov charin, al
					 mov dx, OFFSET outmsg
					 mov ah, 9h
					 int 21h
;------------------------------------------------------					 
					 MOV al, 0 ;tells the OS to end the program, return code 0
					 mov ah, 4ch
					 INT 21h
					 
RWCHAR ENDP
                     END RWCHAR