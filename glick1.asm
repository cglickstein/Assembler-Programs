; First program - Hello World
; Program write Hello, my name is Chava Glickstein

                     .model small ;commands to the assembler program
					 .386
					 .stack 100h
					 
					 .data ;set up data
Message DB "Hello, my name is <your name>" ,10,13, '$'

                     .Code
Hello Proc
                     MOV ax, @data ;sets up physical location of data
					 MOV ds, ax 
					 
					 
					 mov dx, OFFSET Message ;tells the OS to output a character string
					 mov ah, 9h
					 INT 21h
					 
					 MOV al, 0 ;tells the OS to end the program, return code 0
					 mov ah, 4ch
					 INT 21h
					 
Hello ENDP
                     END Hello