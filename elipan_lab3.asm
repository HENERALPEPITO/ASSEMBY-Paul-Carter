%include "asm_io.inc"

section .data
	prompt1 db "Enter the first integer: ", 0
    prompt2 db "Enter the second integer: ", 0
	prompt3 db "Greatest common divisor of ", 0
	prompt4 db " and ", 0
	prompt5 db " is ", 0

    num1 dd 0           ; First number
    num2 dd 0           ; Second number

section .bss
    result resd 1       ; Variable to store the result (GCD)

section .text
    global asm_main

asm_main:
  
    mov eax, prompt1    ; Load the address of "Enter the first number: " into eax
    call print_string   ; Call the print_string function to print the prompt
    call read_int       ; Call the read_int function to read an integer from the user
    mov [num1], eax     ; Store the input integer in the num1 variable

    mov eax, prompt2    ; Load the address of "Enter the second number: " into eax
    call print_string   ; Call the print_string function to print the prompt
    call read_int       ; Call the read_int function to read another integer
    mov [num2], eax     ; Store the input integer in the num2 variable

    mov eax, [num1]     ; Load the value of num1 into eax
    mov ebx, [num2]     ; Load the value of num2 into ebx
    call gcd            ; Call the gcd function to calculate the GCD

    ; Output the result
	mov eax, prompt3
	call print_string
	
	mov eax, [num1]
	call print_int

	mov eax, prompt4
	call print_string

	mov eax, [num2]
	call print_int

	mov eax, prompt5
	call print_string

    mov eax, [result]   ; Load the GCD result into eax
    call print_int      ; Call the print_int function to print the GCD

    ; Exit the program
    call print_nl       ; Call the print_nl function to print a newline
    jmp exit_program            ; Jump to the exit_program label to exit the program
gcd:
    ; Check if num2 is zero (base case)
    cmp ebx, 0          ; Compare ebx (num2) to zero
    je exit_program             ; If num2 is zero, jump to the exit_program label (base case)

	jmp gcd_loop

gcd_loop:
    ; Calculate remainder (num1 % num2) and store it in edx
    xor edx, edx        ; Clear edx (remainder)
    div ebx             ; Divide eax (num1) by ebx (num2); remainder in edx

    ; Update num1 with num2 and num2 with the remainder
    mov eax, ebx        ; Move ebx (num2) into eax (num1)
    mov ebx, edx        ; Move edx (remainder) into ebx (num2)

    ; Repeat the loop until num2 becomes zero
    cmp ebx, 0          ; Compare ebx (num2) to zero
    jne gcd_loop        ; If ebx is not zero, repeat the loop

exit_program:
    ; The GCD is stored in eax, store it in result
    mov [result], eax  ; Store the GCD in the result variable
    ret                ; Return from the gcd function


