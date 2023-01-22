
;step 1-modifiy the program that reads in an integer to use a macro GETNBR
;step2- PUTNBR in program but can't because numbers come out backwards. we want in the correct order
;step3- put them together 
;need an index which modifies the address ANS 
;geometric sequence that number times r then number times r squared. as many times as user inputs

.model     FLAT     ;commands to the assembler program
.386
.stack     100h

.data                ;set up data

NBR    DD 0
MAXDGTS   DD 5
ZERO  DD 0
TEN  DD 10
MSG  DB     'Please enter a multi-digit number:','$'
MSG1  DB 10,13,'Digit = '
MSG3 DB 10,13,'Enter first term: ','$'
MSG4 DB 10,13,'Enter ratio: ','$'
MSG5 DB 10,13,'Enter number of terms: ','$'
ANS  DB '=====','$'
term DD 0 ;TERM
ratio DD 0 ;RATIO
numberTerms DD 0 ;NUMBER TERMS
MSG6 DB 10,13, 'Term: ', '$'


     .Code
OUTNBR Proc                ;beginning of the program

				    MOV     ax, @data    ;sets up physical location of data
					MOV     ds, ax

WRITELINE           MACRO MESSAGE
					PUSHALL
					MOV dx, OFFSET MESSAGE
					MOV ah, 9h
					INT 21h
					POPALL
					ENDM
PUSHALL             MACRO
					PUSH eax
					PUSH ebx
					PUSH ecx
					PUSH edx
					ENDM
POPALL              MACRO
					POP edx
					POP ecx
					POP ebx
					POP eax
					ENDM
GETNBR 				MACRO MSG, NBR ;using three times. substitution.
					local  DONE,LOOPSUB ;changes done to done by itself. treats it as if only in this macro because macro makes copy
					PUSHALL
					WRITELINE MSG ;if send message 3 then also substitutes

					SUB EAX, EAX
					MOV NBR, EAX

LOOPSUB:             MOV   ah,1h ;if it's not a 13 it'll read in another character
					INT     21h ;get char that you type

					CMP al, 13
					JE DONE

					SUB EBX, EBX ;must = 0 which is what we want. or else can do mov ebx, 0 but subtraction is faster
					MOV BL, AL
					SUB EBX,30h ;EBX contains digit
					MOV EAX, NBR
					IMUL TEN ;take whatever is in EAX and multiplies by the muilpler (immediate, register, memory)
					ADD EAX, EBX
					MOV NBR, EAX
					JMP LOOPSUB
DONE:				POPALL ;THIS WAS MY sample. so gonna copy that 3 times in program for term and number terms etc
					ENDM
; well go over
PUTNUM              MACRO MSG,NBR
					local LOOPSUB
					MOV EAX, NBR
					MOV ECX, MAXDGTS ;MAKE MAX 6
LOOPSUB:            SUB ECX, 1
					CDQ
					IDIV TEN
					ADD DL, 30H
					MOV ANS+[ECX], DL ;puts it in right spot of ecx according to max numbers
					CMP EAX, ZERO ;compare quotient to 0 
					JNE LOOPSUB
					WRITELINE MSG
					WRITELINE ANS
					ENDM

;******************************************************* sep between macros and program
					GETNBR MSG3, term
					GETNBR MSG4, ratio
					GETNBR MSG5, numberTerms ;3 copies with substitution
					
				    MOV EAX, term
					PUTNUM MSG6, term

					MOV ECX, numberTerms
					MOV EBX, 1 ;number you're up to. have to subtract. count at number of terms in ecx. decrease count
GEOMLOOP:
					IMUL ratio
					MOV term, EAX
					PUTNUM MSG6, term
					ADD EBX, 1
					CMP EBX, ECX
					JNE GEOMLOOP ;if equal just keep going on 
					
					
			
THEEND:             

					MOV   al,0
					MOV   ah, 4ch
					INT   21h

					OUTNBR ENDP
						 END     OUTNBR
						 
