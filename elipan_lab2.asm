%include "asm_io.inc"

segment .data
Message         db      "Enter a year: ", 0
leapyear		db		" is a leap year", 0
notleapyear		db		" is not a leap year", 0

; should satisfy
; (year % 4 == 0)&&(year % 100 != 0)) || (year % 400==0)

segment .bss
year           resd    1               ; Reserve 4 bytes in year input

 

segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
        pusha

       mov eax, Message				;store the message text in eax
	   call print_string			; call display of the text

	   call read_int 				; get the input
	   mov [year], eax

	   mov eax, 0	; Clear the data 
	   mov edx, 0	
	   

	   mov eax, [year]	;Load eax with the year input
	   mov ebx, 400	
	   div ebx		;Divide the input with the year, thus the remainder is stored in edx

	   cmp edx, 0	; if year/400 modulo is 0 go to accept block
	   jz accept	

	   mov eax, 0	; Clear the data 
	   mov edx, 0	


	   mov eax, [year] 
	   mov ebx, 100
	   div ebx

	   cmp edx, 0 ;if year/100 modulo is 0 go to fail block
	   jz fail

	   mov eax, 0	; Clear the data 
	   mov edx, 0	

	   mov eax, [year]	
	   mov ebx, 4
	   div ebx

	   cmp edx, 0	;if year/4 modulo is 0 go to accept block
	   jz accept

	   jmp fail		;else go to fail block


	fail:

		
		mov eax, [year]				;store input year in eax
		call print_int				; display input
		mov eax, notleapyear		;store notleapyear text in eax
		call print_string			;display the text of notleapyear

		jmp exit_program			;go to exit_program block

	accept:

		mov eax, [year]				;store eax year in eax
		call print_int				;display input
		mov eax, leapyear			;store notleapyear in eax
		call print_string			;display the text of leapyear

		jmp exit_program			;exit program block
		
	exit_program:

		call print_nl			;new line

		;exit
		
		popa
		mov     eax, 0            ; return 0
		leave 
		ret
